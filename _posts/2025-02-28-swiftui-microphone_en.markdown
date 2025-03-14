---
layout: post
title:  "[en] Microphone access in a SwiftUI app"
date:   2025-02-28 11:02:15 +0100
---

I run an online store for LEGO parts on the BrickLink platform, and I'm developing a macOS application in SwiftUI to help manage my sales.

For the picking assistance module, I envisioned a hands-free feature based on voice commands. To this end, I started experimenting with Apple’s speech recognition framework. However, first, we need to access the audio data from the microphone.

In this article, I’ll discuss how I implemented microphone access in a SwiftUI application.


## Preparation

To allow the app to access the microphone, you need to check **Audio Input** in **Signing & Capabilities** and add the **NSMicrophoneUsageDescription** key in the **Info** tab.


## Basic Structure

My test app consists of a single view, with a button to start/stop listening to the microphone. The microphone access functionalities are managed in an `@Observable` controller used as `@State` in the view. The controller exposes `start()` and `stop()` functions, and an observable property `listening`, which is `true` when the microphone is listening and `false` otherwise.

```swift
import SwiftUI

@main
struct SpeechRecognitionApp: App {
    var body: some Scene {
        WindowGroup {
            SpeechRecognitionRootView()
        }
    }
}

struct SpeechRecognitionRootView: View {    
    @State var controller = SpeechRecognitionController()
    var body: some View {      
        HStack {    
            if !controller.listening {
                Button("Start") { controller.start() }
            } else {
                Button("Stop") { controller.stop() }
            }
            if controller.listening {
                Text("Listening")
            }
        }
    }
}

@Observable
class SpeechRecognitionController {
    var listening = false
    func start() {
        // TODO
    }
    func stop() {
        // TODO
    }
}
```


## Checking Microphone Access Permission

Microphone access can be authorized, denied/restricted, or undetermined:

- The *authorized* case corresponds to when the user has explicitly granted access.
- The *denied* case corresponds to when the user has explicitly denied access.
- The *restricted* case corresponds to when the system imposes restrictions, such as in the case of parental controls. Here we consider this case equivalent to *denied*.
- The *undetermined* case corresponds to the situation where the app has never asked for permission.

In the controller, I add an optional boolean that will reflect the microphone access authorization status. A `nil` value corresponds to an undetermined status, `true` if authorized, and `false` in other cases.

In the view, I display the authorization status. I also create a computed property `ready` that adjusts the interface in case microphone permission is denied, specifically disabling the **Start** button.

Subsequently, we will request permission when the user clicks the **Start** button. Therefore, this button should be active when the permission is still undetermined. Generally, when the permission is still undetermined, it is more engaging for the user to present the interface as if it were authorized, disabling it only when permission is explicitly denied. This is why `ready` only returns `false` when the permission is known and denied, and `true` in all other cases.

```swift
struct SpeechRecognitionRootView: View {
    @State var controller = SpeechRecognitionController()
    var body: some View {
        Grid(alignment: .leading) {
            GridRow {
                Text("Microphone authorization")
                if let authorized = controller.microphoneAuthorized {
                    Text(authorized ? "Granted" : "Denied")
                } else {
                    Text("undetermined")
                }
            }
            HStack {    
                if !controller.listening {
                    Button("Start") { controller.start() }
                    .disabled(!ready)
                } else {
                    // ...
                }
                // ...
            }  
        }
    }
    var ready: Bool {   
        if let authorized = controller.microphoneAuthorized, authorized == false {
            return false
        }
        return true
    }
}

@Observable
class SpeechRecognitionController {    
    // ...
    var microphoneAuthorized: Bool?
}
```

Next, in the controller, I create a computed property to encapsulate the call to the system function `AVCaptureDevice.authorizationStatus(for:)`, indicating that we want to access audio.

```swift
import AVFoundation

class SpeechRecognitionController {
    // ...
    var microphoneAuthorizationStatus: AVAuthorizationStatus {
        AVCaptureDevice.authorizationStatus(for: .audio)
    }
}
```

I then create a function that updates the observable property based on the raw value of the permission.

```swift
class SpeechRecognitionController {
    // ...
    func updateMicrophoneAuthorizationStatus() {   
        microphoneAuthorized = {
            switch microphoneAuthorizationStatus {
            case .notDetermined: nil
            case .authorized: true
            default: false
            }
        }()
    }
}
```

`microphoneAuthorized` could be a computed property, but then we wouldn’t have a way to communicate changes to the view. Observability requires a stored property. It’s the explicit update of the property that triggers the view update. The trade-off is that we need to remember to call `updateMicrophoneAuthorizationStatus()` at the appropriate times.

An appropriate moment to update the value is at startup, so I add an initializer in the controller that performs an initial update.

```swift
class SpeechRecognitionController {
    // ...
    override init() {
        super.init()
        updateMicrophoneAuthorizationStatus()
    }
}
```

Thus, when the app starts, the view shows the correct authorization value.


## Requesting Microphone Access Permission

Now we need to request permission to access the microphone.

I create another function to encapsulate the call to the system function. The function is `AVCaptureDevice.requestAccess(for:)`, which returns a boolean `true` if authorized, `false` otherwise. My method returns the complete authorization status after updating the property.

```swift
class SpeechRecognitionController {
    // ...
    func requestMicrophoneAuthorization() async -> AVAuthorizationStatus {
        await AVCaptureDevice.requestAccess(for: .audio)
        updateMicrophoneAuthorizationStatus()
        return microphoneAuthorizationStatus
    }
}
```

Note that if the app has already requested permission and the authorization status is known, `AVCaptureDevice.requestAccess(for:)` does nothing at all. In the opposite case, a dialog box will ask the user whether they want to grant access or not. Therefore, we can systematically call the `requestMicrophoneAuthorization()` method to retrieve the authorization status, asking the question to the user if necessary.

Technically, requesting permission to access the microphone and using the microphone are two different things that can happen at different times. We could very well ask for permission at app startup or when arriving on the screen. However, asking the user for permission gives the impression that we will use the microphone immediately. It is therefore preferable to make the request at the moment we will actually use it.

That’s why I call the `requestMicrophoneAuthorization()` method in the `start()` function and not in the `init()`. Since `requestMicrophoneAuthorization()` is `async`, I also modify `start()` to be `async` and change the action of the **Start** button accordingly.

```swift
struct SpeechRecognitionRootView: View {
    @State var controller = SpeechRecognitionController()
    var body: some View {
        Grid(alignment: .leading) {
            // ...
            HStack {    
                if !controller.listening {
                    Button("Start") { Task { await controller.start() }}
                    .disabled(!ready)
                } else {
                    // ...
                }
                // ...
            }  
        }
    }
    // ...
}

@Observable
class SpeechRecognitionController {    
    // ...
    func start() async {
        // check permission, ask if needed
        let microphoneStatus = await requestMicrophoneAuthorization()
        guard microphoneStatus == .authorized else {
            print("Microphone not authorized")
            return
        }
        // next steps will follow here
    }
}
```

Once the app has requested permission for the first time, an entry is created in the **Privacy** settings in **System Preferences**. The user can then modify the permission at will.

Once the entry exists in the **Privacy** settings, the authorization dialog no longer appears to the user. This can be troublesome during development, as you might want to return to an undetermined permission state.

The following command allows you to delete the entry in the **Privacy** settings:

    tccutil reset Microphone <bundle.id>

Be careful; if `<bundle.id>` is not specified, the permission is reset for **all** apps on the system.


## Accessing Audio Data

Everything is finally ready to receive audio data! We use `AVAudioEngine` for this.

I create a new function `startAudio()` that initializes an instance of `AVAudioEngine` and retrieves the input node. We then configure a "tap" on the input node that allows us to retrieve raw audio data in a buffer. The callback is called multiple times with the data stream. Finally, we call `.prepare()` and `.start()` on `audioEngine` to start listening.

I also create a `stopAudio()` function that stops the `audioEngine` and removes the tap. We call `startAudio()` in `start()` and `stopAudio()` in `stop()`, and we can update the `listening` flag.

```swift
class SpeechRecognitionController {
    // ...
    var audioEngine: AVAudioEngine!
    var inputNode: AVAudioInputNode!

    func start() async {
        // ...
        do {
            try startAudio()
        } catch {
            print("Failed to start audio: \(error)")
            return
        }
        listening = true
    }

    func stop() {   
        stopAudio()
        listening = false
    }
    
    func startAudio() throws {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
            // receive audio data from buffer
        }
        
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    func stopAudio() {   
        audioEngine.stop()
        inputNode.removeTap(onBus: 0)
    }
}
```

And there you go, everything is ready to transmit audio data to the speech recognition module.