---
layout: post
title:  "(fr) Projet: tiroirs connectés"
date:   2025-03-28 09:17:53 +0100
---

![](/assets/2025-03-28-smart-drawers/0.jpg){: style="padding-bottom: 1rem"}

Dans cet article je présente l'idée générale et le choix des composants.
Plus tard je présenterai les avancées du projet.

## Introduction

Dans un article précédent, j'ai présenté la solution que j'ai conçue et fabriquée pour ranger les pièces de LEGO que je vends sur ma boutique en ligne.
Je cherche toujours à optimiser le travail de gestion du stock,
que ce soit lorsque je prélève des pièces pour la préparation de commande (picking)
ou lorsque je rentre de nouvelles pièces.
Parallèlement, ces derniers temps j'avais envie de me remettre à l'électronique.

La première idée qui m'est venue consistait à implémenter un système d'indicateurs lumineux
pour mettre en valeur le tiroir dans lequel se trouvent les pièces recherchées.
Mais intégrer les composants sur un tiroir qui doit rester mobile ma paraissait complexe.
Par ailleurs, je pense qu'une seule LED n'aurait pas été assez voyante.
Il aurait peut-être fallu mettre toute une bande de LED, ou ajouter un bip.

L'idée suivante était l'ouverture automatique du tiroir.
Une mécanisation complète me paraissait complexe et couteuse,
et aurait probablement occupé un espace précieux.
Je suis donc plutôt parti sur juste une impulsion, un peu comme les tiroirs de caisses enregistreuses.
Le mouvement et le bruit sont efficaces pour attirer l'attention sur le tiroir.
Au début j'avais pensé à un système qui placerait les tiroirs sur ressorts,
et un système de vérouillage mécanique qui pourrait être libéré électroniquement.
Ça me semblait complexe à mettre au point et intégrer,
et en plus ça aurait empêché l'ouverture manuelle, ce qui n'est pas ce que je voulais.

Et puis j'ai eu une idée toute simple :
utiliser des électroaimants pour repousser des aimants permanants
attachés sur les tiroirs.
Le tout pourrait être intégré dans le fond du meuble, sans prendre beaucoup de place,
et n'empêcherait pas l'ouverture manuelle des tiroirs.
C'est une solution extrêmement simple et élégante !


### Architecture générale

Le système serait piloté par mon logiciel de picking qui commanderait l'ouverture du tiroir approprié au moment où j'ai besoin de prélever les pièces.

Premièrement, il faut une carte de contrôle pour orchestrer les aimants et communiquer avec le PC.
Le plus simple est sûrement un Rasperry Pi, avec lequel j'ai déjà une bonne expérience.
Mais je voulais apprendre quelque chose de nouveau.
J'ai beaucoup entendu parlé d'Arduino mais je n'ai encore jamais testé par moi-même.
C'est l'occasion d'y remédier.
Par ailleurs, j'ai envie de travailler à plus bas niveau, notamment au niveau de la communication sans fil.
Sur le plan logiciel, travailler sur un Rasperry Pi revient à travailler sur un PC Linux, je n'ai pas envie de ça.

Pour la liaison sans fil avec le PC,
j'opte pour Bluetooth, qui me parait une solution simple en plus d'être très répandue.

Les aimants seront montés dans le fond du meuble, et câblés jusqu'à la carte et le reste du circuit
qui seront intégrés quelque part sur l'arrière du meuble.


### Recherche des composants

Comme dans tout projet qui implique beaucoup de nouveautés,
je commence par viser quelque chose qui soit le plus simple possible.
Le but est de réduire au minimum les sources de complications
pour obtenir quelque chose qui fonctionne.
Ça permet déjà de valider le principe de base, et de prendre en main les choses.
Ensuite on peut itérer pour améliorer et aller vers quelque chose de plus abouti.

J'ai commencé mes recherches sur Amazon par habitude,
mais je suis vite passé sur AliExpress car les prix sont largement inférieurs.
Le projet est une expérimentation, je cherche avant tout à apprendre et tester des idées.
Des composants d'entrée de gamme suffisent.
Certains resteront peut-être inutilisés, d'autres peuvent être endomagés,
inutile donc d'investir dans de la qualité.

Si le projet est concluant, je pourrais "mettre au propre"
en affinant le choix des composants pour l'efficacité et la durabilité.

Dans la même logique, quand c'est pertient je parts sur des composants de prototypage
plutôt que des composants finaux.
La mise au propre remplacera ces composants par des version finales
et libérera les composants de prototypage pour de futurs projets.


## Carte de contrôle

J'opte pour l'Arduino UNO R4 Wifi.
C'est le modèle classique, équipé de connectivité sans fil Bluetooth et Wi-Fi.
Le Wi-Fi est intéressant, ça laisse l'option de l'utiliser pour la liaison PC
en complément ou en remplacement du Bluetooth.

![Arduino UNO R4 Wifi sur l'Arduino store](https://store.arduino.cc/cdn/shop/files/ABX00087_01.iso_65d9153b-9fe3-4d51-8f0a-750fcca31c5e_509x382.jpg)

[Arduino UNO R4 Wifi sur l'Arduino store](https://store.arduino.cc/en-fr/products/uno-r4-wifi)


## Electroaimants

Avant toute chose il faut avoir une idée de la force nécessaire pour ouvrir un tiroir.
L'idéal aurait été d'utiliser un dynamomètre, mais je n'en ai pas.
Après quelques réflexions, j'ai attaché un fil à une poignée,
tendu le fil sur la table devant le tiroir, et suspendu divers objets au fil
jusqu'à ce que le tiroir s'ouvre sous l'effet de la gravité agissant sur l'objet et via le fil.
En pesant ensuite l'objet, j'ai une idée de la force nécessaire.
En l'occurence un objet d'à peine 100g a suffit.

Il existe apparamment un modèle standard d'électroaimants,
qui existe en différentes tailles et forces.
Les forces classiques sont de l'ordre du kilogramme, c'est largement suffisant dans mon cas.
Les aimants sont alimentés en 12 ou 24V continu,
et possèdent un filetage à l'arrière pour la fixation.

![Electroaimants sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sb93cfd04f3e84579b00a24a26e19ce7fg.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Electroaimants sur AliExpress](https://fr.aliexpress.com/item/1005005712625900.html)


## Pilotage des aimants

Une fois les aimants trouvé, reste à voir comment les piloter avec l'Arduino,
sachant que celle-ci fonctionne en 5V.
Une recherche me donne
[ce tuto](https://deepbluembedded.com/arduino-electromagnet-control-circuit-code-example/)
qui fait exactement ce que je cherche à faire.

### Transistor

Le principe est d'utiliser un transistor pour faire comme un interrupteur
qui ouvre ou ferme le circuit d'alimentation de l'aimant.
Le tuto utilise un transistor bipolaire de type NPN, référence TIP120.
C'est une référence courante, je n'ai pas de mal à la trouver.

![Transistor TIP120 sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S39a89f0f8b0246e38bbc624e360ee1f19.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Transistor TIP120 sur AliExpress](https://fr.aliexpress.com/item/1005007657188686.html)

### Résistances

Il faut prévoir une résistance pour la commande du transistor.
La valeur de la résistance dépend des caractéristiques du transistor et de l'aimant.
Dans mon cas je n'ai pas beaucoup d'infos sur l'électroaimant que j'ai repéré.
Pour fixer les idées en attendant mieux, je me base sur la résistance utilisée dans le tuto.
Une fois l'aimant en main je pourrais mesurer les données dont j'ai besoin.
En attendant, pour avoir de quoi avancer,
je trouve sur AliExpress un lot de 300 résistances de différentes valeurs pour moins de 2€.

![Résitances sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S5afe69af1b43434f91b42a4f37a3b4c0Q.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Résitances sur AliExpress](https://fr.aliexpress.com/item/1005005855324735.html)

### Diode

Enfin, l'électroaimant étant un solénoïde, il faut prévoir une *diode de roue libre*.
Un solénoïde s'oppose aux changements brusques de courant,
et a besoin de pouvoir dissiper son énergie lorsqu'on coupe son alimentation.
C'est le rôle de la diode de roue libre, qu'on monte en parallèle dans le sens opposé
et qui vient ainsi former un circuit secondaire dans lequel l'energie va pouvoir se dissiper
sans endommager le reste du cricuit principal.
La diode doit être dimensionnée pour supporter la tension et le courant.
La référence classique est 1N4001 qui supporte 1A et 50V, c'est largement suffisant.
Je trouve cette référence sans problème sur AliExpress.

![Diodes 1N4001 sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S372589c6b14d453290d0a126206a4b6c3.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Diodes 1N4001 sur AliExpress](https://fr.aliexpress.com/item/1005001552094086.html)


## Piloter de nombreux aimants

J'ai une trentaine de tiroirs en tout, et j'envisage de mettre au moins deux aimants par tiroir.
L'Arduino n'ayant qu'une dizaine de ports de sortie, il faut une solution pour ajouter plus de sorties.

En faisant des recherches, je tombe d'abord sur des circuits I2C qui ajoutent des GPIO complets,
c'est-à-dire des ports qui peuvent être configurés en entrée ou en sortie, avec ou sans pullup, etc.
Il y a 16 ports par puce, et il est possible de mettre jusqu'à 8 puces sur le meme bus I2C en jouant avec les adresses, pour un total de 128 pins.
C'est suffisant dans mon cas,
mais j'ai pour projet de toujours étendre ma capacité de rangement de LEGO,
et l'idée qu'il existe une limite au nombre d'aimants que je pourrais contrôler me gêne.

Je poursuis mes recherches et tombe sur les registres à décalage.
Ce sont des circuits très simples qui transforment une sortie série en parallèle.
Les pins ne fonctionnent qu'en sortie, ce qui n'est pas gênant dans mon cas.
Il est possible de les connecter les uns à la suite des autres (*daisy chaining*) sans limite théorique.
C'est parfait pour moi.
Le circuit classique est le 74HC595.
Je trouve la ref sans problème sur AliExpress.

![Registre à décalage 74HC595 sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sf000bea0f39043eeba141d929dc9001et.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Registre à décalage 74HC595 sur AliExpress](https://fr.aliexpress.com/item/1005004856540723.html)


## Alimentation

Dernier sujet majeur.
Il faut alimenter l'Arduino et les aimants.
L'Arduino fonctionne en 5V.
Les aimants doivent être alimentés en 12V.
Je pense que les aimants peuvent fonctionner en 5V. La force sera réduite mais ça peut être suffisant dans mon cas.
Cependant je préfère assurer le coup, quitte à ajuster ensuite.

La doc indique que l'Arduino peut prendre en entrée jusqu'à 24V grâce à un régulateur interne qui abaisse la tension à 5V.
Ça simplifie les choses puisque je peux donc utiliser une alimentation commune à 12V.

Même si ce serait tout à fait possible, je n'ai pas envie d'utiliser des piles ou des batterie,
rechargeable ou non.
Je cherche donc des alimentations à brancher sur secteur.

Je n'ai pas envie de m'embêter à trouver le bon connecteur.
L'Arduino possède un connecteur *barrel jack* classique,
mais la doc indique qu'il peut aussi être alimenté via des pins.
Je trouve plusieurs modèles d'alimentations fournies avec un adaptateur qui permet de connecter des fils.
Voilà qui sera plus simple.
En bonus, je trouve sur AliExpress un modèle réglable 3-24V.
Ça me permettra de régler la force des aimants,
et ce sera sûrement très utiles pour de futurs projets.

![Alimentation réglable 3-24V sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sd13fa0cffb734b0c834870c1d11174d9e.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Alimentation réglable 3-24V sur AliExpress](https://fr.aliexpress.com/item/1005005638098269.html)


## Aimants permanents

La dernière pièce du puzzle.
J'avais déjà acheté des aimants sur AliExpress pour un précédent projet,
et je sais qu'il en existe de toute sorte.
Je cherche des aimants qui soient à la fois assez plats pour ne pas prendre trop de place,
et assez larges pour maximiser l'interraction avec l'électroaimant.
Même si à terme j'envisage de les incruster dans le bois du tiroir,
dans un premier temps je pense simplement les fixer en surface.
Les meubles n'étant pas prévus pour accueillir des choses dans le fond,
plus les aimants sont compacts et mieux ce sera.
Je choisie une référence en 20x2mm avec adhésif fourni.

![Aimants permanents sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sfcbed82347c64b00a45a704217c2df3a7.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Aimants permanents sur AliExpress](https://fr.aliexpress.com/item/1005008096510030.html)


## Matériel divers

L'essentiel est là. Voyons maintenant si j'ai tout ce qu'il faut pour travailler efficacement.

J'ai encore en stock une breadboard quasi neuve.
Je vais commencer avec ça et voir déjà jusqu'où je peux aller.
Elle sera trop petite pour implémenter les circuits pour tous les tiroirs,
mais je pense pouvoir en faire déjà quelques uns pour valider le principe.
A terme je pourrais mettre au propre avec une carte à souder.
Je peux même envisager de concevoir et (faire) fabriquer un circuit imprimé sur mesure,
et faire un boitier en impression 3D.

J'ai aussi en stock quelques jumpers et quelques LEDs.
Ce sera bien pour expérimenter et prendre en main les composants.

Il faudra de la longueur de fil pour câbler les aimants des tiroirs jusqu'à la carte centrale.
Il faut 2 fils par aimants, il faut donc assez de longueur totale.
J'achète donc quelques petites bobines de fil.

Je commande aussi un multimètre premier prix.
Et voilà qui conclut la liste des composants.

![Fil sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S225cab5c7b6747cebf09016371dcfcceo.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Fil sur AliExpress](https://fr.aliexpress.com/item/1005007256968315.html)

![Multimètre sur AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S2a0fe6eaf6814accb0536a4c467851e75.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Multimètre sur AliExpress](https://fr.aliexpress.com/item/1005005981700177.html)