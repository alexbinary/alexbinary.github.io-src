---
layout: post
title:  "[fr] Swift Observation: étude approfondie"
date:   2025-03-06 11:23:15 +0100
---

Introduit en 2023, le framework [Observation](https://developer.apple.com/documentation/observation)
vise à simplifier les mécanismes existant en matière de réactivité tout en améliorant les performances des applications.

Cette nouvelle approche repose sur le tracking automatique des accès aux données
via la méthode [`withObservationTracking(_:onChange:)`](https://developer.apple.com/documentation/observation/withobservationtracking(_:onchange:)).

Dans cet article nous allons jouer avec cette méthode pour en comprendre le fonctionnement et les limitations.

## Fonctionnement général

Le framework Observation repose sur l'utilisation de types de référence. La macro [`@Observable`](https://developer.apple.com/documentation/observation/observable()) ne peut être appliquée qu'aux classes, excluant ainsi les structures. Par conséquent, les applications s'appuyant sur une sémantique de valeur devront d'abord effectuer une transition vers une sémantique de référence, une tâche qui peut s'avérer complexe selon les contextes.

Une classe annotée avec `@Observable` détecte et mémorise les accès à ses propriétés.
Seuls les accès aux propriétés stockées sont pris en compte.
Cependant, l'accès peut-être indirect, par exemple via une fonction ou une propriété calculée.
Si une chaine d'appels résulte *in fine* en en accès à une propriété stockée, Observation le détecte.

Les accès en lecture et écriture sont détectés.
Les accès en lecture servent à identifier les dépendances,
les accès en écriture à envoyer les notifications de changement.

## Un exemple simple

Remarque : Tous les codes présentés fonctionnent tel quel dans une *playground*.

```swift
import SwiftUI

@Observable
class TestClass {
    var str = "test"
}
var test = TestClass()

withObservationTracking {
    let _ = test.str
} onChange: {
    print("str changed")
}

print("Changing str")
test.str = "new"
```

Résultat :

```
Changing str
str changed 
```

Dans cet exemple, nous déclarons une classe observable avec une propriété simple et créons une instance de celle-ci. Nous accédons à la propriété de l'objet dans le bloc `apply` de `withObservationTracking(_:onChange:)`.
L'accès en lecture est détecté et mémorisé. Enfin, en modifiant la valeur de la propriété à l'extérieur, l'accès en écriture est également détecté, entraînant l'appel du bloc `onChange`.

## C'est l'accès en lecture qui attache l'observation

Si nous modifions le code pour effectuer un accès en écriture plutôt qu'en lecture dans le bloc `apply`, nous constatons que le changement n'est pas détecté :

```swift
import SwiftUI

@Observable
class TestClass {
    var str = "test"
}
var test = TestClass()

withObservationTracking {
    test.str = "write"
} onChange: {
    print("str changed")
}

print("Changing str")
test.str = "new"
```

Résultat :

```
Changing str
```

Il s'avère donc que seuls les accès en lecture permettent de connecter l'observation. Cette logique est cohérente : un composant qui ne fait qu'écrire n'a pas besoin d'être informé des changements de valeur.

## L'accès en écriture déclenche *toujours* la notification

Si nous accédons en écriture à la propriété en passant une valeur identique à la valeur existante, la notification de changement est toujours envoyée :

```swift
import SwiftUI

@Observable
class TestClass {
    var str = "test"
}
var test = TestClass()

withObservationTracking {
    let _ = test.str
} onChange: {
    print("str changed")
}

print("Changing str")
test.str = "test"
```

Résultat :

```
Changing str
str changed 
```

Les accès en écriture déclenchent donc toujours un événement de changement, même si la valeur ne change pas dans la pratique. Si nous voulons déclencher l'événement seulement si la valeur change réellement, charge à nous de nous assurer d'écrire la variable seulement si la nouvelle valeur est différente.

## Seules les propriétées lues sont observées

En ajoutant une seconde propriété, nous constatons que seul un changement à la propriété lue dans `apply` déclenche un changement :

```swift
import SwiftUI

@Observable
class TestClass {
    var str1 = "test1"
    var str2 = "test2"
}
var test = TestClass()

withObservationTracking {
    let _ = test.str1
} onChange: {
    print("str1 changed")
}
withObservationTracking {
    let _ = test.str2
} onChange: {
    print("str2 changed")
}

print("Changing str2")
test.str2 = "new"
```

Résultat :

```
Changing str2
str2 changed
```

Seuls les blocs attachés aux propriétés qui changent sont appelés. Cela constitue une amélioration majeure par rapport aux techniques précédentes, où l'objet dans son ensemble était observé. Cette granularité accrue peut améliorer les performances en limitant les mises à jour aux parties réellement concernées.

## Étude approfondie : sémantique de valeur

Pour les types avec une sémantique de valeur, ce qui comprend notamment tous types les primitifs, ainsi que les tableaux et les dictionnaires, mais aussi les structures, la notification de changement est envoyée dès que la valeur change. 

Nous avons déjà vu des exemples plus haut pour les types primitifs comme `String`.
Le cas des tableaux, dictionnaires et structures et intéressant, bien que tout à fait logique.

### Tableaux

Dans le cas d'un tableau, changer une valeur dans le tableau change la valeur totale du tableau, et envoie donc un changement à tout observateur attaché à tout ou partie du tableau :

```swift
import SwiftUI

@Observable
class TestClass {
    var arr = ["test1","test2"]
}
var test = TestClass()

withObservationTracking {
    let _ = test.arr
} onChange: {
    print("arr changed")
}
withObservationTracking {
    let _ = test.arr[0]
} onChange: {
    print("arr[0] changed")
}
withObservationTracking {
    let _ = test.arr[1]
} onChange: {
    print("arr[1] changed")
}

print("Changing arr[0]")
test.arr[0] = "new"
```

Résultat :

```
Changing arr[1]
arr changed
arr[0] changed
arr[1] changed
```

### Dictionnaires

Le même principe s'applique aux dictionnaires :

```swift
import SwiftUI

@Observable
class TestClass {
    var dict = ["1":"test1","2":"test2"]
}
var test = TestClass()

withObservationTracking {
    let _ = test.dict
} onChange: {
    print("dict changed")
}
withObservationTracking {
    let _ = test.dict["1"]
} onChange: {
    print("dict['1'] changed")
}
withObservationTracking {
    let _ = test.dict["2"]
} onChange: {
    print("dict['2'] changed")
}

print("Changing dict['1']")
test.dict["1"] = "new"
```

Résultat :

```
Changing dict['2']
dict changed
dict['1'] changed
dict['2'] changed
```

### Structures

Idem pour les structures, pour lesquelles changer un membre change la valeur totale de celle-ci :

```swift
import SwiftUI

@Observable
class TestClass {
    var value = TestValue()
}
struct TestValue {
    var str1 = "test"
    var str2 = "test"
}
var test = TestClass()

withObservationTracking {
    let _ = test.value
} onChange: {
    print("value changed")
}
withObservationTracking {
    let _ = test.value.str1
} onChange: {
    print("value.str1 changed")
}
withObservationTracking {
    let _ = test.value.str2
} onChange: {
    print("value.str2 changed")
}

print("Changing value.str1")
test.value.str1 = "new"
```

Résultat :

```
Changing value.str1
value changed
value.str1 changed
value.str2 changed
```

## Étude approfondie : sémantique de référence

Pour les type avec une sémantique de référence, la notification de changement est envoyée dès lors que la référence change.
Par voie de conséquence, tous les accès aux propriétés des objets référencés reçoivent également la mise à jour :

```swift
import SwiftUI

@Observable
class TestClass {
    var ref = TestRef()
}
class TestRef {
    var str = "test"
}
var test = TestClass()

withObservationTracking {
    let _ = test.ref
} onChange: {
    print("ref changed")
}
withObservationTracking {
    let _ = test.ref.str
} onChange: {
    print("ref.str changed")
}

print("Changing ref")
test.ref = TestRef()
```

Résultat :

```
Changing ref
ref changed
ref.str changed
```

Noter que, comme vu plus haut, le changement est déclenché même si concrètement aucune valeur ne change
(`ref.str` vaut toujours `"test"` avant et après, et on aurait le même résultat si on avait fait `test.ref = test.ref`).

### Changements dans un objet par référence

Contrairement aux structures vues plus haut, par défaut, accéder en écriture à une propriété dans un objet par référence ne déclenche pas de changement :

```swift
import SwiftUI

@Observable
class TestClass {
    var ref = TestRef()
}
class TestRef {
    var str = "test"
}
var test = TestClass()

withObservationTracking {
    let _ = test.ref
} onChange: {
    print("ref changed")
}
withObservationTracking {
    let _ = test.ref.str
} onChange: {
    print("ref.str changed")
}

print("Changing ref.str")
test.ref.str = "new"
```

Résultat :

```
Changing ref.str
```

Pour que ce soit le cas il suffit de rendre la classe `@Observable` :

```swift
import SwiftUI

@Observable
class TestClass {
    var ref = TestRef()
}
@Observable
class TestRef {
    var str = "test"
}
var test = TestClass()

withObservationTracking {
    let _ = test.ref
} onChange: {
    print("ref changed")
}
withObservationTracking {
    let _ = test.ref.str
} onChange: {
    print("ref.str changed")
}

print("Changing ref.str")
test.ref.str = "new"
```

Résultat :

```
Changing ref.str
ref.str changed
```

Noter que dans ce cas, contrairement à la structure, aucun changement n'est déclenché sur `ref`, car c'est la référence qui compte, et ici celle-ci n'est pas touchée.

## Reduction des changements

Lorsque plusieurs accès en écriture provoquent le même changement, un seul événement est déclenché :

```swift
import SwiftUI

@Observable
class TestClass {
    var ref = TestRef()
}
@Observable
class TestRef {
    var str1 = "test1"
    var str2 = "test2"
}
var test = TestClass()

withObservationTracking {
    let _ = test.ref.str1
    let _ = test.ref.str2
} onChange: {
    Task { @MainActor in
        print("ref.str1 and/or ref.str2 changed")
        print("str1: \(test.ref.str1)")
        print("str2: \(test.ref.str2)")
    }
}

print("Original values")
print("str1: \(test.ref.str1)")
print("str2: \(test.ref.str2)")

print("Changing ref.str1")
test.ref.str1 = "new1"
print("Changing ref.str2")
test.ref.str2 = "new2"
```

Résultat :

```
Original values
str1: test1
str2: test2
Changing ref.str1
Changing ref.str2
ref.str1 and/or ref.str2 changed
str1: new1
str2: new2
```

Cet exemple est un peu complexe.
Un exemple dans une app SwiftUI est plus parlant :

*Ce code ne fonctionne pas dans une playground. Il faut créer une app.*

```swift
import SwiftUI

@Observable
class TestClass {
    var str1 = "test1"
    var str2 = "test2"
}

@main
struct TestApp: App {
    @State var test = TestClass()
    var body: some Scene {
        WindowGroup {  
            let _ = print("View update")
            Text(test.str1)
            Text(test.str2)
            Button("Change str1") {
                print("Changing str1")
                test.str1 = "\(Date())"
            }
            Button("Change str2") {
                print("Changing str2")
                test.str2 = "\(Date())"
            }
            Button("Change both") {
                print("Changing both")
                test.str1 = "\(Date())"
                test.str2 = "\(Date())"
            }
        }
    }
}
```

Résultat :

![](/assets/2025-03-06-swift-observation.gif)

Lorsqu'on clique sur **Change both**, nous remarquons qu'un seul `View update` est émis, même si les deux valeurs sont mises à jour simultanément. Cela témoigne d'une performance optimisée, où les vues ne se recalculent qu'une seule fois, indépendamment du nombre de modifications apportées à l'objet.

## Changement d'un objet par référence, exemple dans une app SwiftUI

Si nous remplaçons un objet au lieu de modifier uniquement les propriétés changeantes, nous déclenchons un changement au niveau de l'objet, ce qui entraîne une mise à jour de toutes les vues qui dépendent de ses propriétés, même si ces dernières ne changent pas :

```swift
import SwiftUI

@Observable
class TestClass {
    var ref = TestRef()
}
@Observable
class TestRef {
    var str1 = "test1"
    var str2 = "test2"
}

@main
struct TestApp: App {
    @State var test = TestClass()
    var body: some Scene {
        WindowGroup {
            View1()
            View2()
            Button("Change ref") {
                test.ref = test.ref
            }
        }
        .environment(test)
    }
}
struct View1: View {
    @Environment(TestClass.self) var test
    var body: some View {
        let _ = print("View1 update")
        Text(test.ref.str1)
    }
}
struct View2: View {
    @Environment(TestClass.self) var test
    var body: some View {
        let _ = print("View2 update")
        Text(test.ref.str2)
    }
}
```

Résultat :

![](/assets/2025-03-06-swift-observation2.gif)

En cliquant sur **Change ref**, nous constatons que les deux vues se mettent à jour, même si les données affichées n'ont pas changé. Pour optimiser les performances, il est donc préférable de ne modifier que les propriétés réellement modifiées.


## Conclusion

Le framework Observation représente une avancée significative dans la gestion de la réactivité au sein des applications Swift. En offrant une granularité fine dans le suivi des changements, il permet d'optimiser les performances tout en simplifiant la gestion des dépendances. Les développeurs doivent cependant garder à l'esprit la nécessité de transitionner vers une sémantique de référence et de gérer judicieusement les accès en lecture et en écriture. 