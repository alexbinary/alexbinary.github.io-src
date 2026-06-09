---
layout: post_project
project_id: a10edb47-8a09-4f84-9f5d-214ac597b2ad
title: Programmation de la ROM
topics: [6502, arduino, electronique, programmation]
image: /assets/projects/emulation/IMG_7377.JPG
githubs: [
  https://github.com/alexbinary/arduino-6502,
  https://github.com/alexbinary/arduino-eeprom-programmer,
]
lang: fr
lang_en: 
---


Tout est désormais prêt pour pouvoir programmer la ROM. Je place celle-ci sur la breadboard à la place des LEDs. Je connecte l'alimentation et je force `/CE` à `0`. Je connecte ensuite les 15 lignes d'adresse aux sorties des registres, dans l'ordre en commençant par les poids faibles. Sur la dernière ligne du dernier registre, je connecte `/OE`. Ce qui donne ceci :

|Registre|Sortie|Entrée ROM|
|-|-|-|
| R1 | QA | A0  |
| R1 | QB | A1  |
| R1 | QC | A2  |
| R1 | QD | A3  |
| R1 | QE | A4  |
| R1 | QF | A5  |
| R1 | QG | A6  |
| R1 | QH | A7  |
| R2 | QA | A8  |
| R2 | QB | A9  |
| R2 | QC | A10 |
| R2 | QD | A11 |
| R2 | QE | A12 |
| R2 | QF | A13 |
| R2 | QG | A14 |
| R2 | QH | /OE |

Je connecte `/WE` et les lignes de données directement à l'Arduino comme avant, et je suis prêt à passer au codage. Je prends la [vidéo de Ben Eater](https://www.youtube.com/watch?v=K88pgWhEb1M) comme référence, mais j'essaie de faire le plus possible par moi-même et d'expérimenter à ma manière. Je reprends le code précédemment utilisé pour programmer la ROM, et je modifie la fonction `setAddr()` pour utiliser désormais les registres à décalage. Je lui ajoute un paramètre qui permettra d'envoyer la bonne valeur de `/OE`.

La logique de shifting est un peu technique. Le but est de pousser les bits de l'adresse dans les registres dans le bon ordre pour qu'au final on ait les bons bits sur les bonnes lignes d'adresses de la ROM + le bit correspondant à `/OE`. J'utilise la fonction Arduino `shiftOut()`, et même si on peut lui passer un nombre qui s'écrit sur plus de 8 bits, elle ne pousse que les 8 premiers bits. Il faut donc découper notre adresse en deux paquets de 8 bits et faire deux appels à la fonction. Un paramètre supplémentaire permet de dire dans quel ordre on veut pousser les données :

| Option | Signification
|-|-|
| `MSBFIRST` | Bits de poids fort en premier
| `LSBFIRST` | Bits de poids faible en premier

Si on pousse `1110 1010` (`0xEA`) :
- Avec `MSBFIRST`, les bits sont poussés dans cet ordre : `1,1,1,0,1,0,1,0`
- Avec `LSBFIRST`, les bits sont poussés dans cet ordre : `0,1,0,1,0,1,1,1`

Si on pousse 16 bits, le premier bit qu'on pousse va se retrouver sur la dernière ligne de données, et le dernier bit poussé finira sur la première. Dans notre cas il faut donc pousser les poids forts en premier.

Voici ce que j'ai écrit initialement :

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/shift1.png"
            legend=""
        %}

    </div>

</div>

### Lecture

J'essaie de lire les données depuis la ROM mais ça ne fonctionne pas, je ne retrouve pas les données programmées précédemment. Tout est faux. Je soupçonne immédiatement une erreur dans le code précédent vu que c'est la parte la plus complexe mais rien ne me saute aux yeux. J'extrais donc la logique dans une fonction de test et affiche le résultat dans la console en forçant les valeurs d'entrée. Je constate qu'effectivement ça fait n'importe quoi 🤦‍♂️. D'abord il y a une faute de frappe dans la deuxième ligne, il faut un seul `&` et pas deux car on veut faire un `ET` binaire et non pas un `ET` logique. Ensuite pour que le bit `/OE` soit en position 8, en partant de la position 1, il faut le décaler de 7 bits et non de 8. Au final j'ai fait comme Ben Eater et j'ai utilisé directement la valeur `0x80`. Ça rend le code un peu plus lisible.

Voici la version corrigée qui fonctionne :

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/shift2.png"
            legend=""
        %}

    </div>

</div>

Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-eeprom-programmer).

### Écriture

Je teste maintenant l'écriture, et ça ne fonctionne pas bien. Je teste d'écrire un octets, plusieurs, je teste plusieurs fois chaque code, ça semble fonctionner parfois, et parfois non. Je relis attentivement le code et tout me semble correct. Perplexe, je fais appel à ChatGPT. Je lui copie colle mon code sans rien dire d'autre pour ne pas l'influencer et voir ce qu'il dit spontanément.

Il mentionne un délai manquant après le pulse `/WE`. C'est intéressant car je n'y avais pas pensé. L'écriture ne se fait pas lorsque `/WE` passe à `0` mais lorsqu'il repasse à `1`, et il faut laisser un peu de temps pour que la ROM écrive la donnée dans la mémoire. J'ajoute donc un `delay()` après `digitalWrite(WEB, HIGH)` et sur le coup ça semble fonctionner, mais ensuite ça ne marche de nouveau plus.

J'écris un programme de test qui écrit et relit en boucle en défilant les valeurs et/ou les adresses, et je constate que certaines écritures passent et d'autres pas, sans logique visible. Je laisse tourner le programme et inspecte les connexions. Je détecte que le résultat semble impacté par le fait que j'ajuste le fil qui porte `/WE`. Je soupçonne donc un mauvais contact. Je remplace le fil et ça semble mieux fonctionner.

Je relance des tests et ça fonctionne effectivement mieux. Cependant un problème subsiste. Quand j'écris une séquence, à chaque fois le premier octet ne s'écrit pas correctement. Dans les remarques de ChatGPT du début, il y avait une note sur l'ordre des appels à `pinMode()` et `digitalWrite()`. Je n'avais pas prêté attention à cette remarque parce que j'avais suivi les conseils de Ben Eater et placé `digitalWrite()` en premier pour garantir que la pin ne passe jamais à `0`, ce qui pourrait déclencher des écritures non désirées. Ben explique que même si ça parait contre intuitif, en fait ça fonctionne et c'est la bonne manière de faire.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/pinMode1.png"
            legend="D'après la vidéo de Ben Eater, ce code devrait laisser WEB à 1"
            width="50%"
        %}

    </div>

</div>

Comme dans mon cas vu que c'est systématiquement la première écriture qui ne passe pas, je soupçonne fortement que `/WE` n'est pas à `1` au début comme prévu. Je rajoute donc un `digitalWrite()` après le `pinMode()`, et ça fonctionne.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/pinMode2.png"
            legend="Dans mon cas il est nécessaire de rappeler digitalWrite() après pinMode() pour laisser WEB à 1"
            width="50%"
        %}

    </div>

</div>

Je rajoute aussi un `digitalWrite()` au moment où je fais le pulse pour être sûr qu'on part bien de `1`.

Pour bien valider mes observations, je branche rapidement le signal `/WE` sur une LED, et je constate effectivement qu'après `digitalWrite()` et `pinMode()` dans cet ordre, la LED ne s'allume pas. Elle s'allume seulement après un nouveau `digitalWrite()`.

<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-video-item.html
            url="/assets/projects/emulation/pinMode3.mp4"
            legend="digitalWrite() avant pinMode() laisse la pin à 0"
            width="50%"
        %}

    </div>

</div>


Je n'ai pas d'explications sur le fait que ça fonctionnait chez Ben Eater et pas chez moi. Peut-être des variations selon les modèles d'Arduino.

Au passage je note également que le signal passe à `0` quand je reset ou programme l'Arduino, et je me demande si ça peut déclencher des écritures non désirées, vu que la ROM reste active pendant ce temps là. Si on part du principe que toutes les pins passent à `0`, alors ça inclue `/OE`, et aucune écriture n'est possible s'il est à `0`, donc ça devrait être bon. Peut-être que pour être sûr on pourrait connecter le signal `/CE` à l'Arduino via un inverseur au lieu de le forcer physiquement à `0` sur la board, ce qui permettrait de n'activer la ROM que lorsque l'Arduino est prêt. Ça fonctionne bien comme ça donc je ne touche à rien pour l'instant, mais c'est le genre de choses qui peut venir causer des problèmes à un moment où n'y pense pas.


### Optimisation

Maintenant que tout fonctionne correctement, je peux essayer d'accélérer les opérations. Jusque là j'avais mis des `delay(100)` pour être sûr que ça fonctionne et avoir le temps de voir ce qui se passe, mais si on veut lire ou écrire des quantités de données non triviales ça prend beaucoup trop de temps pour rien.

Pour essayer de faire les choses correctement, je parcours les datasheet des différents composants pour déterminer les délais minimaux à respecter. Pour l'EEPROM [AT28C256](https://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf), le délai maximum entre le changement d'adresse et la disponibilité de la donnée en sortie est indiqué à 150 ns. Je fais un calcul rapide en fonction de la fréquence de travail de l'Arduino. Mon modèle [Uno R4 WiFi](https://docs.arduino.cc/resources/datasheets/ABX00087-datasheet.pdf) fonctionne à 48 MHz, ce qui correspond à une durée d'environ 20 ns par cycle. Je mets donc un `delayMicroseconds(1)`, je teste et ça fonctionne. En y repensant après coup, une fonction haut niveau du type `digitalWrite()` prend certainement de nombreux cycles d'horloge donc ça devrait marcher sans mettre aucun délai. À tester la prochaine fois. De la même manière, je remplace le `delay(100)` par `delayMicroseconds(1)` dans le pulse de `/WE` sans soucis.

<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/delay.png"
            width="70%"
        %}

    </div>

</div>

Pour le  registres à décalage [74HC595](https://www.ti.com/lit/ds/symlink/sn74hc595.pdf), la doc indique que pour le latch une durée d'impulsion d'environ 1µs devrait largement suffire. Pourtant ici ça ne fonctionne pas. Je teste différentes valeurs et détermine que 10ms est le minimum qui fonctionne. Ça me laisse perplexe. À cette vitesse, programmer toute la ROM, soit 32000 adresses, prendrait au moins 320s, soit plus de 5 minutes.

J'interroge ChatGPT qui n'est pas d'une grande aide, mais me permet quand même de déterminer que le problème n'est pas la durée du pulse mais le délai qui le précède. Voici le meilleur code que je peux obtenir :

<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/delay2.png"
            width="70%"
        %}

    </div>

</div>

Je me dis que c'est peut-être un problème du à la breadboard, mais pourtant chez Ben Eater ça fonctionne parfaitement sans délai. Peut-être que c'est la qualité de mes breadboard premier prix d'Aliexpress qui est mauvaise, ou alors les contacts ne sont pas bons. Je n'y crois pas tellement et même ChatGPT semble septique.

> Even a terrible breadboarded HC595 setup should not require that.

Et puis en y réfléchissant, le délai est entre le moment où on pousse les données dans les registres à décalage et le moment où on demande de mettre à jour la sortie des registres avec les données poussées. Il n'y a aucune transmission longue distance en jeu, tout se passe dans les registres, donc la breadboard ne devrait pas avoir d'impact. Je n'ai pas d'explication.


### Nettoyage et améliorations

Maintenant que la lecture et l'écriture fonctionnent (au délai près), je remet un peu d'ordre dans le code. Je réécris une fonction `print()` qui affiche des lignes de 16 octets plutôt qu'une seule adresse à la fois, et je fais en sorte de pouvoir lui passer une adresse arbitraire même si elle n'est pas un multiple de 16.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/readROM.png"
            legend="La fonction de lecture qui affiche des lignes de 16 octets"
        %}

    </div>

</div>

J'ajoute aussi une fonction pour écrire une valeur sur deux octets. Grâce à ces changements je peux désormais écrire ce genre de choses :

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/asm.png"
            legend="Prémisce d'un assembleur !"
            width="50%"
        %}

    </div>

</div>


Pour l'instant le code laisse un délai fixe entre chaque écriture, mais la ROM fournit un moyen de détecter la fin de l'opération d'écriture. Ça permettrai d'envoyer la donnée suivante dès que la mémoire est prête à la recevoir. Implémenter cette fonction serait un bon exercice technique, mais dans mon cas ça n'améliorerait pas la vitesse d'écriture puisque pour l'instant c'est le délai dans les registres à décalage qui limite la vitesse globale, et de très loin. Une idée à garder en tête si je trouve une solution pour ça.

Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-eeprom-programmer).




## La suite

Maintenant que je peux écrire dans la mémoire des programmes arbitrairement longs, je peux commencer à installer la puce d'entrées-sorties qui permettra de connecter des périphériques au 6502 et de visualiser enfin l'activité du CPU sans instruments.
