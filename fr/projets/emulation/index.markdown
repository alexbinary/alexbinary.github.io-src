---
layout: project
project_id: a10edb47-8a09-4f84-9f5d-214ac597b2ad
title: Émulation matérielle
topics: [6502, arduino, electronique, programmation, emulation]
image: /assets/projects/emulation/IMG_7377.JPG
githubs: [
  https://github.com/alexbinary/arduino-6502,
  https://github.com/alexbinary/arduino-eeprom-programmer,
]
last_updated: 2026-06-09
lang: fr
lang_en: /en/projects/emulation
---

Je joue régulièrement à des jeux vidéo sur émulateur et je comprends dans les grandes lignes le principe de l’émulation mais j'ai envie d'en apprendre plus et de "mettre les mains dedans". J'aimerais bien savoir écrire un émulateur de GameBoy, et c'est probablement faisable avec suffisamment de patience, mais j'aime comprendre les choses en partant de la base. C'est pour cette raison que je me suis donné pour projet de construire un système électronique simple et d'écrire ensuite l'émulateur correspondant. Ainsi je peux commencer en douceur avec les principes fondamentaux de l'émulation, et complexifier progressivement par la suite selon mes envies.

J'ai choisi de me baser sur le processeur [6502](https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf) et son interface [6522](https://eater.net/datasheets/w65c22.pdf) et la [série de vidéos de Ben Eater](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH) qui leur est consacrée. Le 6502 était le CPU utilisé par de nombreux appareils grand public des années 1980 notamment l’Apple II, le Commodore 64 et l'Atari 2600. C'est un microprocesseur relativement simple et donc idéal pour débuter. Des versions modernisées sont toujours en production aujourd'hui et il existe une large communauté de passionnés.

L'interface utilisateur de mon système sera minimale au début avec juste des boutons et des LEDs, et peut-être un petit écran OLED. Ce projet est avant tout une exploration. C'est l'occasion pour moi de prendre en main des concepts hardware bas niveau et de pendre de l'expérience dans l'interaction entre matériel et logiciel.

Dans ce genre de projets découverte j'aime partir de la base et expérimenter petit à petit avec les composants pour valider le fonctionnement supposé étape par étape, confronter mes prédictions à la réalité, et développer une compréhension solide des choses. Ainsi j'ai commencé par prendre en main le 6502 et jouer avec les bus d'adresse et de données, le vecteur reset, etc. J'ai ensuite utilisé une EEPROM que j'ai commencé par programmer à la main sur breadboard en jouant directement avec les signaux de contrôle, avant de mettre au point un circuit de programmation automatique piloté par Arduino.

Je rencontre désormais des difficultés avec l'interface 6522, et ça m'a amené à créer de zéro des bascules D que j'ai ensuite interfacé directement avec le 6502, un petit détour imprévu mais passionnant. Je veux maintenant adopter une approche similaire pour connecter au moins un bouton, ce qui me permettra de commencer à écrire des programmes interactifs et de commencer à réfléchir à l'émulation à proprement parler.

J'ai documenté ce projet au fur et à mesure dans des billets qui détaillent chaque session de travail. Cette page présente le déroulé général du projet du début jusqu'à aujourd'hui, elle est mise à jour en continu au fil de l'avancement du projet. Des renvois vers les billets détaillés sont présents dans les sections consacrées. [La liste complète des publications est disponible ici](/fr/projets/emulation/billets).


## Premiers pas avec le 6502

Pour vérifier qu'il se passe quelque chose dans le processeur j'ai connecté les 4 bits de poids faible du bus d'adresse sur 4 LEDs, et j'ai constaté une activité. J'ai également connecté les lignes du bus de données directement sur l'alim ou la masse avec des résitances pour faire en sorte qu'à chaque fois que le CPU lit une donnée sur le bus il récupère la valeur `0xEA`, qui correspond à l'instruction `NOP` (« No Operation »). Quand on observe les lignes d'adresse, on constate un comptage, qui correspond au fait que le CPU lit les instructions les unes après les autres dans la mémoire.

J'ai ensuite connecté les lignes d’adresses à l'Arduino ainsi que le signal d'horloge, et écrit un programme simple pour lire et afficher les données à chaque tic d'horloge via une interruption. Ben Eater utilise un Arduino Mega pour observer les 16 lignes d'adresse et les 8 lignes de données, mais mon Arduino Uno n'a pas assez de pins pour me permettre d'observer toutes les lignes, je suis donc resté sur les 4 bits de poids faible de l'adresse uniquement. 


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7380.mp4"
            legend="Mon 6502 en fonctionnement"
            alt="Une vidéo montrant un montage éléctronique expérimental. On voit une première breadboard avec une LED qui clignote rapidement, et un second module comprenant le 6502 connecté à 4 LEDs qui s'allument successivement dans un motif de comptage."
            width="50%"
        %}

    </div>

</div>


La prochaine étape est de fournir au CPU des données dynamiques en fonction de l'adresse qu'il demande, de sorte à former un programme qui ait du sens. Classiquement c'est le rôle d'une puce mémoire. Mais dans un premier temps j'expérimente avec Arduino.


<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7383.JPG"
            legend="L'Arduino connecté aux 4 LSBs du bus d'adresse et aux 8 lignes du bus de données du 6502"
            
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/pgm.mp4"
            legend="Exécution du premier programme"
        %}

    </div>

</div>



## Découverte de l'EEPROM

L'Arduino est bien sympatique, mais dans le système final les données sont stockées dans une puce mémoire. J'utilise ici une puce EEPROM [AT28C256](https://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf). C'est une mémoire de 32ko destinée à être utilisée en lecture seule, mais qu'on peut effacer et programmer éléctroniquement.

Je veux commencer par la base, en faisant des lectures et écritures en manipulant directement les signaux de contrôle. Sur une breadboard je connecte huit LEDs au bus de données de la ROM et je force toutes les lignes d'adresse à zéro à l'aide de cavaliers, sauf les quatre bits de poids faible que je connecte avec des fils de connexion repositionnables facilement.

Dans un premier temps le programme parcours séquentiellement les 16 adresses et affiche la données correspondante à chacune. Ça fonctionne bien et je retrouve bien le relevé initial avec la valeur `0xEA` à l'adresse `0`. Je code ensuite l'écriture, en commençant par une fonction qui écrit un seul octet. Il faut reproduire la séquence des signaux de contrôle que j'ai effectuée à la main juste avant. Ensuite j'ajoute la possibilité d'écrire une séquence de valeurs une à une.



<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7389.JPG"
            legend="Montage de test de la ROM"
            width="50%"
        %}

    </div>

</div>


L'objectif maintenant est de connecter la ROM au CPU pour que celui-ci lise et exécute le programme. En laissant la ROM sur sa breadboard, je relie désormais les 4 lignes d'adresse et le bus de données sur les broches correspondantes du 6502. Ce faisant je remarque que j'avais du aller un peu vite quand j'ai choisi les quatre lignes d'adresse à manipuler sur la ROM car ce n'était pas du tout les quatre bits de poids faible, bien que c'était mon intention. Il s'agissait en fait des lignes 13, 8, 9 et 11. En réalité ce n'est pas gênant, du moment que je connecte au CPU les mêmes lignes de la même manière, il retrouvera les données aux adresses attendues.

Pour analyser le résulat je choisis de me baser sur les LEDs connectés au bus de données de la ROM. Ce n'est pas forcément le plus pratique, et je pourrais connecter l'Arduino comme précédemment mais je n'ai pas envie d'ajouter encore davantage de fils volants à un montage déjà très chargé. Mais surtout j'aime utiliser toutes les opportunités qui se présentent pour confronter mes prédictions à la réalité. Parfois ça met en valeur des lacunes dans ma compréhension.


Je veux maintenant connecter la ROM de façon semi-permanente au 6502 sur la même breadboard et câbler proprement toutes les lignes d’adresse et de données. Mais avant ça il faut revoir la programmation de la ROM car cette fois les lignes d'adresses seront câblées correctement et le CPU ne retrouvera donc pas les données que j'ai programmé précédement en utilisant les mauvaises lignes d'adresse. Il y a aussi le fait qu'au démarrage le CPU va lire le vecteur reset situé aux adresses `0xFFFC` et `0xFFFD` pour savoir à partir de quelle adresse il doit commencer à exécuter les instructions. Avec 4 lignes d'adresse on pouvait placer le vecteur reset aux adresses `0x000C` et `0x000D`, mais avec un adressage complet ça ne fonctionnera pas. 


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7399.JPG"
            legend="L'EEPROM connectée au 6502"
            width="50%"
        %}

    </div>

</div>


## Programmation de la ROM

J'utilise le circuit [74HC595](https://www.ti.com/lit/ds/symlink/sn74hc595.pdf) que j'avais en stock. C'est un registre à décalage qui possède 8 lignes de sortie. Pour contrôler 15 lignes d'adresse il en faut donc deux. Comme d'habitude je commence par les bases, avec un montage minimal pour me familiariser avec le fonctionnement. Je place un registre à décalage et 8 LEDs avec leur résistances. 


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7405.mp4"
            legend="Injection de 0xEA"
            width="50%"
        %}

    </div>

</div>


Maintenant que la lecture et l'écriture fonctionnent (au délai près), je remet un peu d'ordre dans le code. Je réécris une fonction `print()` qui affiche des lignes de 16 octets plutôt qu'une seule adresse à la fois, et je fais en sorte de pouvoir lui passer une adresse arbitraire même si elle n'est pas un multiple de 16.

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


## La puce d'entrées-sorties / Chip Select

Le [6522](https://eater.net/datasheets/w65c22.pdf) est une puce d'interfaçage conçue pour fonctionner avec le 6502. Son nom en anglais est *Versatile Interface Adatper*, je l'appelle donc "VIA" pour faire court. Le VIA propose plusieurs fonctions complémentaires, notamment des timers, mais ce qui nous intéresse ici ce sont les deux ports parallèles d'entrée-sortie. Il s'agit de 16 lignes qui peuvent être configurées individuellement en entrée ou en sortie, et qu'on va pouvoir lire ou écrire depuis le CPU.

<table>
    <thead>
        <tr>
            <th>Binaire</th>
            <th>Hexadécimal</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>0000 0000 0000 0000</code></td>
            <td><code>0x0000</code></td>
            <td></td>
        </tr>
        <tr>
            <td><code>0100 0000 0000 0000</code></td>
            <td><code>0x4000</code></td>
            <td rowspan=4>VIA</td>
        </tr>
        <tr>
            <td><code>0110 0000 0000 0000</code></td>
            <td><code>0x6000</code></td>
        </tr>
        <tr>
            <td><code>0111 0000 0000 0000</code></td>
            <td><code>0x7000</code></td>
        </tr>
        <tr>
            <td><code>0111 1111 1111 1111</code></td>
            <td><code>0x7FFF</code></td>
        </tr>
        <tr>
            <td><code>1000 0000 0000 0000</code></td>
            <td><code>0x8000</code></td>
            <td rowspan=2>ROM</td>
        </tr>
        <tr>
            <td><code>1111 1111 1111 1111</code></td>
            <td><code>0xFFFF</code></td>
        </tr>
    </tbody>
</table>

Je choisis de rester simple pour l'instant et de m'arrêter à `A14`. Ça permet de connecter `CS1` et `/CS2` diretement sans introduire de logique supplémentaire, et le compromis en terme d'allocation de l'espace d'adresse est ok pour l'instant.


Je lance, fait un reset, mais ça ne fonctionne pas, les diodes restent éteintes. Ça me laisse perplexe. Je teste d'abord les LEDs en amenant directement le 5V dessus et elles s'allument bien. J'observe ensuite les valeurs en sortie du VIA avec Arduino, et elles restent toutes à 0. De la même manière je vérifie les signaux `CS1`, `/CS2`, la clock, et `/RW`, et tout semble correcte. `/RW` est à `1` la plupart du temps pour indiquer une lecture, et passe à `0` de temps en temps pendant exactement un cycle. Idem pour `CS1` et `/CS2` qui prennent bien les valeurs attendues.

J'entreprends alors d'essayer de piloter le VIA directement avec l'Arduino pour vérifier que j'arrive à le faire fonctionner en envoyant manuellement des commandes et confirmer que le programme de test envoie bien les bonnes commandes. Sur la breadboard je force `/CS1` à `1`, `/CS2` à `0`, et `/RW` à `0`. Avec le code je fais un reset en mettant à `/RES` à `0` et en faisant quelques cycles d'horloge, puis j'envoie les octets pour configurer le port A, mais toujours rien de visible. J'essaie avec le port B et toujours rien. À ce moment je commence à soupçonner mon VIA d'être défectueux.


<div class="inline-image-container">

    <div class="inline-image-container-row free-width mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7415.JPG"
            legend="Connection du VIA directement à l'Arduino"
            width="50%"
        %}

    </div>

</div>


## La bascule D


Je revisionne la [vidéo sur la bascule D](https://www.youtube.com/watch?v=peCh_859q7Q) et implémente le circuit sur une nouvelle petite breadboard. J'utilise un [74LS02](https://www.ti.com/lit/ds/symlink/sn74ls02.pdf) et un [74LS08](https://www.ti.com/lit/ds/symlink/sn74ls08.pdf) qui contiennent respectivement 4 portes NOR et 4 portes AND. Il y a pas mal de connexions à faire et il faut être vigilent car les pins ne sont pas disposées de la même manière sur les deux puces. Pour éviter de me tromper je dessine le schéma au brouillon et notes les pins à connecter. J'ajoute deux LEDs pour visualiser l'état de la sortie (une pour la sortie normale et une pour la sortie inversée).


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/d-flip-flop.JPG"
            legend="Mon brouillon utilisé pour la réalisation du circuit"
            width="50%"
        %}

    </div>

</div>



La bascule fonctionne donc bien mais pour l'instant elle capture tout ce qui passe sur le bus, ce qui n'est pas très utile. Il faut donc ajouter un peu de logique pour qu'elle ne capture que les données qui lui sont destinées. Pour pouvoir réutiliser le programme existant, je décide d'utiliser `A15` et `A14` pour pouvoir sélectionner l'adresse `0x4000`. Je prends aussi en compte le `/RW` pour ne répondre qu'aux commandes d'écriture. Dans notre cas ce n'est pas forcément nécessaire vu que la bascule ne peut que recevoir des données, pas en envoyer. L'idée est d'ajouter des portes logiques ET avec les signaux d'entrée de la bascule pour que le signal reçu par celle-ci ne passe que lorsque les bonnes conditions sont réunies. Ma première idée est de mettre le ET sur la donnée, mais je me rends vite compte que c'est une erreur. C'est le signal d'horloge qu'il faut bloquer, car c'est lui qui capture la donnée. L'idée c'est que la donnée en entrée va varier au gré de ce qui passe sur le bus, mais la bascule ne va capturer cette donnée que lorsque les signaux d'activation sont présents. Le reste du temps aucun signal de capture ne parvient à la bascule.

Comme tout à l'heure il faut se concentrer pour suivre le déroulement du programme, mais on voit que ça fonctionne !


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7420.mp4"
            legend="La bascule capture uniquement les données qui lui sont adressées"
            width="50%"
        %}

    </div>

</div>


Interfacer une bascule D au 6502 n'était pas prévu initialement mais ça s'est révélé très intéressant et ça m'a aidé à comprendre ce qui peut se jouer dans les puces qui communiquent sur un bus de données, comme la ROM ou le VIA. Je suis très content d'avoir fait ce petit détour.



## Bilan et conclusion

Le 6502 peut désormais piloter une LED et changer son état selon la logique définie par le programme. Ça reste bien sûr limité mais c'est déjà un bon système simple à émuler. Mais avant, je voudrais rendre les choses encore un petit peu plus intéressantes en ajoutant la possibilité pour un utilisateur d'injecter des données dans le système via un bouton. L'idée est donc de créer cette fois un périphérique d'entrée, c'est-à-dire capable d'envoyer une donnée sur le bus lorsque le CPU le demande. Après ça je pourrai enfin créer des programmes interractifs et attaquer l'émulation à proprement parler.