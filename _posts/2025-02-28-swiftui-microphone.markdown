---
layout: post
title:  "[fr] Comment j'ai implémenté l'accès au micro dans une app SwiftUI"
date:   2025-02-28 11:02:15 +0100
---

J'ai une activité de vente en ligne de pièces de LEGO sur la plateforme BrickLink,
et je développe une application mac en SwiftUI pour m'aider à gérer mes ventes.

Pour le module d'aide au picking, j'ai imaginé une fonctionnalité mains libre basée sur des commandes vocales.
Dans cette optique, j'ai commencé par expérimenter avec le module de reconnaissance vocale d’Apple.
Mais au préalable, il faut accéder aux données audio du micro.

Dans cet article je reviens sur comment j'ai implémenté l'accès au micro dans une application Swift UI.


# Préparation

Pour que l'app puisse avoir accès au micro, il faut cocher **Audio Input** dans **Signing & Capabilities**, et ajouter la clé **NSMicrophoneUsageDescription** dans l'onglet **Info**.


# Structure de base

Mon app de test comprend une seule vue, avec un bouton pour lancer/arrêter l'écoute du micro.
Les fonctionnalités d'accès au micro sont gérées dans un objet contrôleur `@Observable` utilisé comme `@State` dans la vue. Le contrôleur expose des fonctions `start()` et `stop()`, et une propriété observable `listening`, à `true` quand le micro est en cours d'écoute, `false` sinon.

{% highlight swift %}
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
{% endhighlight %}


# Vérifier si on a la permission d'accès au micro

L’accès au micro peut être autorisé, refusé/restreint ou indéterminé :

- Le cas *autorisé* correspond au cas où l'utilisateur a explicitement autorisé l'accès.

- Le cas *refusé* correspond au cas où l'utilisateur a explicitement refusé l'accès.

- Le cas *restreint* correspond au cas où le système impose des restrictions, comme dans le cas d’un contrôle parental par exemple. Ici on considère ce cas équivalent à *refusé*.

- Le cas indéterminé correspond à la situation dans laquelle l’app n’a encore jamais demandé la permission.

Dans le contrôleur j'ajoute un un booléen optionnel qui reflètera l'état de l'autorisation d'accès au micro.
Une valeur `nil` correspond à un état indéterminé, `true` si autorisé, et `false` dans les autres cas.

Dans la vue j'affiche la valeur de l'autorisation.
Je crée aussi une propriété calculée `ready` qui permet d'ajuster l'interface dans le cas où la permission micro est refusée. En l'occurence on désactive le bouton **Start**.

Par la suite on demandera l'autorisation au moment où l'utilisateur•ice clic sur le bouton **Start**.
Il faut donc que celui-ci soit actif dans le cas où la permission est encore indéterminée.
De manière générale, quand la permission est encore indéterminée, il est plus engagent pour l'utilisateur•ice de présenter l'interface comme si elle était autorisée, et de ne la désactiver que lorsque la premission est explicitement refusée.
C'est pour cette raison que `ready` ne renvoit `false` que dans le cas où la premission est connue et refusée, et `true` dans tous les autres cas.

{% highlight swift %}
struct SpeechRecognitionRootView: View {
    @State var controller = SpeechRecognitionController()
    var body: some View {
        Grid(alignment: .leading) {
            GridRow {
                Text("Microphone authorisation")
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
{% endhighlight %}

Ensuite dans le contrôleur je crée une propriété calculée pour encapsuler l’appel à la fonction système `AVCaptureDevice.authorizationStatus(for:)`, en indiquant qu'on souhaite accéder à l'audio.

{% highlight swift %}
import AVFoundation

class SpeechRecognitionController {
    // ...
    var microphoneAuthorisationStatus: AVAuthorizationStatus {
        AVCaptureDevice.authorizationStatus(for: .audio)
    }
}
{% endhighlight %}

Je crée ensuite une fonction qui met à jour la propriété observable en fonction de la valeur brute de la permission.

{% highlight swift %}
class SpeechRecognitionController {
    // ...
    func updateMicrophoneAuthorisationStatus() {   
        microphoneAuthorized = {
            switch microphoneAuthorisationStatus {
            case .notDetermined: nil
            case .authorized: true
            default: false
            }
        }()
    }
}
{% endhighlight %}

`microphoneAuthorized` pourrait être une propriété calculée, mais on n'aurait alors aucun moyen de communiquer les changements à la vue. L’observation nécessite une propriété stockée. C’est la mise à jour explicite de la propriété qui va déclencher la mise à jour de la vue. La contrepartie est qu'il faut penser à appeler `updateMicrophoneAuthorisationStatus()` aux moments opportuns.

Un moment opportun pour mettre à jour la valeur est au démarrage, j'ajoute donc un initialiseur dans le contrôleur qui fait une première mise à jour.

{% highlight swift %}
class SpeechRecognitionController {
    // ...
    init() {
        updateMicrophoneAuthorisationStatus()
    }
}
{% endhighlight %}

Ainsi quand l'app démarre l'affichage reflète la bonne valeur de l'autorisation.

# Demander la permission d'accès au micro

Il faut maintenant demander la permission d'accès au micro.

Je crée encore une fois une fonction pour encapsuler l'appel à la fonction système. La fonction est `AVCaptureDevice.requestAccess(for:)`, elle renvoie un booléen à `true` si autorisé, `false` sinon.
Ma méthode renvoie plutôt la valeur complète de l’autorisation, après avoir mis à jour la propriété.

{% highlight swift %}
class SpeechRecognitionController {
    // ...
    func requestMicrophoneAuthorisation() async -> AVAuthorizationStatus {
        await AVCaptureDevice.requestAccess(for: .audio)
        updateMicrophoneAuthorisationStatus()
        return microphoneAuthorisationStatus
    }
}
{% endhighlight %}

A noter que si l'app a déjà demandé la permission et que l'état d'autorisation est donc connu, `AVCaptureDevice.requestAccess(for:)` ne fait rien du tout.
Dans le cas contraire une boîte de dialogue demande à l'utilisateur s'il souhaite autoriser l'accès ou non.
On peut donc appeler la méthode `requestMicrophoneAuthorisation()` de manière systématique pour récupérer l'état de l'autorisation, la question étant préalablement posée à l'utilisateur si nécessaire.

Techniquement, demander la permission d'accès au micro et utiliser le micro sont deux choses différentes qui peuvent se produire à des moments différents. Et on pourrait tout à fait demander la permission au démarrage de l'application ou à l'arrivée sur l'écran. Cependant, demander la permission à l’utilisateur•ice lui donne l’impression qu’on va utiliser le micro immédiatement. Il est donc préférable de faire la demande au moment où on va réellement l'utiliser.

C'est pourquoi j'appelle la méthode `requestMicrophoneAuthorisation()` dans la fonction `start()` et non dans l'`init()`.
Comme `requestMicrophoneAuthorisation()` est `async`, je modifie `start()` pour l'être également, et je modifie l'action du bouton **Start** en conséquence.

{% highlight swift %}
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
        let microphoneStatus = await requestMicrophoneAuthorisation()
        guard microphoneStatus == .authorized else {
            print("Microphone not authorized")
            return
        }
        // next steps will follow here
    }
}
{% endhighlight %}

Une fois que l'app a demandé une première fois la permission, une entrée est créé dans les réglages de **Confidentialité** dans les **Réglages système**.
L'utilisateur•ice peut ensuite modifier à loisir la permission.

Une fois que l'entrée existe dans les réglages de **Confidentialité**, la boîte de dialogue d'autorisation ne s'affiche plus à l'utilisateur•ice.
C'est embêtant pour le développement, où on aimerait pouvoir revenir dans un état de permission indéterminée.

La commande suivante permet de supprimer l'entrée dans les réglages de **Confidentialité**:

    tccutil reset Microphone <bundle.id>

Attention si `<bundle id>` n’est pas précisé, la permission est réinitialisée pour **toutes** les apps du système.

# Accéder aux données audio

Tout est enfin prêt pour recevoir les données audio !
Pour ça on utilise `AVAudioEngine`.

Je crée une nouvelle fonction `startAudio()` qui initialise une instance de `AVAudioEngine` dans et récupère le noeud d'entrée.
On configure ensuite un "tap" sur le noeud d'entrée qui nous permet de récupérer les données audio brute dans un buffer. La callback est appelée à de multiples reprises avec le flux de données.
Enfin on appelle `.prepare()` et `.start()` sur `audioEngine` pour lancer l'écoute.

Je crée aussi une fonction `stopAudio()` qui arrête l'`audioEngine` et supprime le tap.
On appelle `startAudio()` dans `start()` et `stopAudio()` dans `stop()`, et on peut mettre à jour le flag `listening`.

{% highlight swift %}
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
{% endhighlight %}

Et voilà, tout est prêt pour transmettre les données audio au module de reconnaissance vocale.