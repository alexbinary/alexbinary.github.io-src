---
layout: post
title:  "(fr) Reconnaissance vocale dans une app SwiftUI"
date:   2025-03-14 10:23:06 +0100
---

Dans un précédent article, nous avons vu l'accès au microphone dans une application SwiftUI sur macOS.
Dans cet article nous allons ajouter la reconnaissance vocale avec le framework [Speech](https://developer.apple.com/documentation/speech).


## Vérifier la permission

Comme pour l'accès au micro, l'utilisateur•ice doit autoriser notre app à utiliser la reconnaissance vocale.
Le principe est similaire à la permission micro,
les cas possibles sont: autorisé, refusé/restreint ou indéterminé.

Comme pour le micro, je commence par ajouter dans le contrôleur un un booléen optionnel qui reflètera l'état de l'autorisation d'accès à la reconnaissance vocale, j'affiche la valeur de l'autorisation dans la vue, et je modifie la propriété `ready` pour prendre en compte la reconnaissance vocale.

```swift
struct SpeechRecognitionRootView: View {
    @State var controller = SpeechRecognitionController()
    var body: some View {
        Grid(alignment: .leading, verticalSpacing: 12) {
            // ...
            GridRow {
                Text("Speech recognition authorisation")
                if let authorized = controller.speechRecognitionAuthorized {
                    Text(authorized ? "Granted" : "Denied")
                } else {
                    Text("undetermined")
                }
            }
            HStack {
                // ...
            }
        }
    }
    var ready: Bool {
        // ...
        if let authorized = controller.speechRecognitionAuthorized, authorized == false {
            return false
        }
        // ...
    }
}

@Observable
class SpeechRecognitionController {   
    //...
    public var speechRecognitionAuthorized: Bool?
}
```

La fonction système qui indique l'autorisation de la reconnaissance vocale est `SFSpeechRecognizer.authorizationStatus()`.
Comme pour le micro, je crée une propriété calculée dans le contrôleur pour encapsuler l’appel à la fonction système, et une fonction qui met à jour la propriété observable en fonction de la valeur brute de la permission, et je fais une première mise à jour dans l'initialiseur.

```swift
import Speech

class SpeechRecognitionController {   
    //...
    private var speechRecognitionAuthorisationStatus: SFSpeechRecognizerAuthorizationStatus {
        SFSpeechRecognizer.authorizationStatus()
    }
    private func updateSpeechRecognitionAuthorisationStatus() {
        speechRecognitionAuthorized = {
            switch speechRecognitionAuthorisationStatus {
            case .notDetermined: nil
            case .authorized: true
            default: false
            }
        }()
    }
    override init() {
        //...
        updateSpeechRecognitionAuthorisationStatus()
    }
}
```
    
## Demander la permission

La fonction système pour demander la permission est `SFSpeechRecognizer.requestAuthorization(:)`.
Elle renvoie la valeur de l'autorisation dans une closure.
Comme pour le micro, je crée une fonction qui encapsule l'appel à la fonction système et renvoie la valeur de l'autorisation.
J'utilise `withCheckedContinuation(:)` pour utiliser `async/await`.

```swift
class SpeechRecognitionController {
    //...
    private func requestSpeechRecognitionAuthorisation() async -> SFSpeechRecognizerAuthorizationStatus {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { _ in
                self.updateSpeechRecognitionAuthorisationStatus()
                continuation.resume(returning: self.speechRecognitionAuthorisationStatus)
            }
        }
    }
}
```

Comme pour le micro, on peut appeler la méthode `requestSpeechRecognitionAuthorisation()` de manière systématique pour récupérer l'état de l'autorisation, la question n'est posée à l'utilisateur que si nécessaire.

J'appelle cette fonction dans `start()`.

```swift
class SpeechRecognitionController {
    //...
    public func start() async {
        //...
        let speechRecognitonStatus = await requestSpeechRecognitionAuthorisation()
        guard speechRecognitonStatus == .authorized else {
            print("Speech recognition not authorized (\(speechRecognitonStatus))")
            return
        }
    }
}
```

La commande suivante permet de réinitialiser la demande de permission, utile en développement.

    tccutil reset SpeechRecognition <bundle.id>


## Initialisation et vérification de la disponibilité

Tout est désormais prêt pour démarrer la reconnaissance vocale.
La classe principale est `SFSpeechRecognizer`.
Dans le contrôleur j'ajoute une propriété qui permettra de stocker une instance de cette classe.
Bien que le contrôleur pourra démarrer et arrêter la reconnaissance vocale à loisir,
une seule instance de `SFSpeechRecognizer` est nécessaire.

Par défaut la reconnaissance vocale reconnait la langue configurée sur l'appareil,
mais il est possible de passer une locale spécifique.
Ici je force la langue française dans sa variante de France.

La reconnaissance vocale peut ne pas être disponible sur un appareil donné à un instant donné,
notamment par rapport à l'état de la connexion Internet.
La disponibilité en temps réel est donnée par la fonction `SFSpeechRecognizerDelegate.speechRecognizer(_:availabilityDidChange:)`.
J'implémente cette fonction sur le contrôleur et configure le `delegate` de l'objet `SFSpeechRecognizer`.
À noter qu'il existe aussi la propriété `SFSpeechRecognizer.isAvailable` qui permet d'interroger directement la disponibilité.

Pour une expérience utilisateur optimale, il est préférable d'ajuster l'affichage et le comportement de l'application selon la possibilité d'utiliser ou non la reconnaissance vocale dès le démarrage.
Si on attend que l'utilisateur•ice essaie d'accéder aux fonctionnalités associées pour le vérifier,
on risque de créer de la frustration si ces fonctionnalités s'avèrent indisponibles.
J'initialise donc l'instance `SFSpeechRecognizer` dans l'initialiseur.

Dans la vue j'affiche la disponibilité de la reconnaissance vocale, et je modifie `ready` pour prendre en compte cette nouvelle donnée.
Dans ce cas, on n'autorise que si on est sûr que la fonctionnalité est disponible.

```swift
struct SpeechRecognitionRootView: View {
    @State var controller = SpeechRecognitionController()
    var body: some View {
        Grid(alignment: .leading, verticalSpacing: 12) {
            // ...
            GridRow {
                Text("Speech recognition availability")
                if let available = controller.speechRecognitionAvailable {
                    Text(available ? "Available" : "Unavailable")
                } else {
                    Text("undetermined")
                }
            }
            HStack {
                // ...
            }
        }
    }
    var ready: Bool {
        // ...
        if controller.speechRecognitionAvailable != true {
            return false
        }
        // ...
    }
}

@Observable
class SpeechRecognitionController: NSObject, SFSpeechRecognizerDelegate {
    // ...
    var speechRecognizer: SFSpeechRecognizer!
    var speechRecognitionAvailable: Bool?
    // ...
    override init() {
        super.init()
        // ...
        // init speech recognizer with forced locale
        let locale = Locale(identifier: "fr_FR")
        guard let recognizer = SFSpeechRecognizer(locale: locale) else { fatalError("Unable to create a SFSpeechRecognizer object with locale \(locale)") }
        speechRecognizer = recognizer
        speechRecognizer.delegate = self
        print("Speech recognition ready, using locale \(locale)")
    }
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        self.speechRecognitionAvailable = available
    }
```


## Démarrage de la reconnaissance et traitement des résultats

On peut maintenant lancer la reconnaissance vocale à proprement parler lorsque l'utilisateur•ice clique sur **Start**.
Je commence par créer des fonctions `startRecognition()` et `stopRecognition()`, que j'appelle respectivement dans `start()` et `stop()`.

```swift
class SpeechRecognitionController {
    // ...
    public func start() async {
        // ... (check permissions)
        // ... (start audio)
        
        startRecognition()
        print("Recognition active")
        
        listening = true
    }

    public func stop() {
        stopRecognition()
        stopAudio()
        listening = false
    }

    private func startRecognition() {
        // TODO
    }
    
    private func stopRecognition() {
        // TODO
    }
}
```

Pour une session de reconnaissance nous avons besoin d'une instance de `SFSpeechAudioBufferRecognitionRequest` et `SFSpeechRecognitionTask`.
J'ajoute deux propriétés correspondantes dans le contrôleur.

```swift
class SpeechRecognitionController {
    // ...
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    private var recognitionTask: SFSpeechRecognitionTask!
    // ...
}
````

On commence par initialiser une requête.
Ensuite il faut alimenter la requête avec les données audio issues du micro.
Pour cela on utilise le "tap" mis en place précédement.
Enfin, on lance une tâche de reconnaissance vocale à partir de la requête.
Les résultats sont envoyés à une closure au fur et à mesure que la personne parle.
`result.bestTranscription` contient la transcription des paroles prononcées.


```swift
class SpeechRecognitionController {
    // ...
    private func startRecognition() {
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
            self.recognitionRequest.append(buffer)
        }

        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let error = error {
                print("Recognition error: \(error)")
            } else if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
            }
        }
    }
}
```

Pour l'arrêt de la reconnaissance, on peut appeler `recognitionTask.finish()` et `recognitionRequest.endAudio()`, et enlever le tap.

```swift
class SpeechRecognitionController {
    // ...
    private func stopRecognition() {
        
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        
        recognitionTask?.finish()
        recognitionTask = nil
        
        inputNode.removeTap(onBus: 0)
    }
}
```

Et voilà, tout est fonctionnel.

![](/assets/2025-03-14-swiftui-speech.gif)