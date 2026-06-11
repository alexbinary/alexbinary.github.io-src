---
layout: post_project
project_id: a10edb47-8a09-4f84-9f5d-214ac597b2ad
title: Premiers pas avec le 6502 gth
entry: 1
date: 2026-06-01 11:02:15 +0100
topics: [arduino, electronique]
image: /assets/projects/emulation/IMG_7377.JPG
githubs:
- https://github.com/alexbinary/arduino-6502,
permalink: /fr/2026/06/01/emulation--premiers-pas-avec-le-6502
lang: fr
lang_en: /en/2026/06/01/emulation--first-steps-with-the-6502
---

Je joue régulièrement à des jeux vidéo sur émulateur et je comprends dans les grandes lignes le principe de l’émulation mais j'ai envie d'en apprendre plus et de "mettre les mains dedans". J'aimerais bien savoir écrire un émulateur de GameBoy, et c'est probablement faisable avec suffisamment de patience, mais j'aime commencer par la base. Et la base c'est : "Au fond, l'émulation, c'est quoi ?"

Pour répondre à cette question je me suis donné pour projet de construire un système matériel simple que je peux programmer, et d'écrire ensuite un émulateur pour ce système. Je choisi de me baser sur le processeur 6502 et son interface 6522, en suivant [les vidéos de Ben Eater dans lesquelles il crée un ordinateur minimaliste basé sur le 6502](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH). Dans un premier temps je prévois une IHM minimale avec des boutons et des LEDs, et peut-être un petit écran OLED.

Ce projet est avant tout une exploration. C'est l'occasion pour moi de prendre en main des concepts hardware bas niveau et de pendre de l'expérience dans l'interaction entre matériel et logiciel. Dans ce genre de projets découverte j'aime partir de la base et expérimenter petit à petit avec les composants pour valider le fonctionnement supposé étape par étape, confronter mes prédictions à la réalité, et développer une compréhension solide des choses.

Aujourd'hui j'ai quasiment terminé le système hardware. Je rencontres des difficultés avec le 6522 et pour l'instant je les contourne avec des périphériques fait maison. C'est un petit détour inattendu mais très interressant. J'ai déjà un périphérique de sortie à une LED, et je travaille maintenant sur un périphérique d'entrée à un bouton. Je vais bientôt pouvoir écrire des programmes interactifs et commencer à réfléchir à l'émulation.


## Comprendre l'émulation

Prenons l'exemple de la GameBoy. Un jeu de GameBoy est un programme conçu pour être lu par l'électronique de la GameBoy dans le but de produire des images et du son en fonction des actions de l'utilisateur sur les boutons. Le but d'un "émulateur de GameBoy" est de prendre en entrée ce programme et de recréer l'expérience de jeu sur un PC, c'est-à-dire de générer les mêmes images et sons en fonction des actions de l'utilisateur, mais sur une stack matérielle complètement différente.

Écrire un émulateur demande donc de bien comprendre comment chaque instruction du programme impacte les images et le son produits par le système électronique, dans le but de récréer un résultat le plus proche possible. Il faut bien connaître le hardware d'origine et l'interraction entre le matériel et le logiciel, mais le but n'est pas nécessairement de reproduire fidèlement le fonctionnement interne du matériel. Ce qui compte c'est le résultat *observable*.


## Choix du hardware

J’ai choisi de construire un système basé sur le microprocesseur [6502](https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf). Le 6502 est un microprocesseur relativement simple idéal pour débuter. Il est aussi très célèbre puisque c'est le processeur utilisé par de nombreux appareils grand public des années 1980, notamment l’Apple II, le Commodore 64 et l'Atari 2600. Des versions modernisées sont toujours en production aujourd'hui et il existe une large communauté de passionnés.

En plus du 6502, je choisis une EEPROM [AT28C256](https://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf) pour stocker le programme, une RAM [62256](https://eater.net/datasheets/hm62256b.pdf) pour fournir de la mémoire vive au CPU, et des circuits logiques type 74LSXX pour le décodage d'adresse. Des LEDs et boutons seront connectés au 6502 via l'interface [6522](https://eater.net/datasheets/w65c22.pdf). Un écran OLED de type SSD1306 pourra être connecté en i2c. Je travaille sur breadboard, et j'utilise mon [Arduino Uno R4 Wi-Fi](https://docs.arduino.cc/resources/datasheets/ABX00087-datasheet.pdf) pour programmer la ROM, observer les signaux, expérimenter avec les composants, et aussi comme source d'alimentation.


## Premiers pas avec le 6502

Le 6502 est un microprocesseur, et sa fonction principale est donc d'exécuter des instructions. Contrairement à un microcontrôleur, il n'a aucune mémoire interne et aucun périphérique. Il interragit avec le monde extérieur via un bus de données et un bus d'addresse, sur lesquels il peut lire et écrire des données. Les instructions à éxécuter, les données à traiter, et les données produites, tout passe par le bus. En général on connecte sur le bus une mémoire qui contient le programme et les données de travail, et des périphérique comme un afficheur, une carte son, etc.

Pour commencer en douceur je suis la [série de vidéos de Ben Eater consacrée à la construction d’un ordinateur basé sur le 6502](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH). Je commence par installer le 6502 sur une breadboard, je connecte l'alimentation et les signaux de contrôle de base, et j'ajoute un bouton reset. Le signal d’horloge est généré par un module basé sur un circuit 555 que j’ai construit précédemment en suivant les [vidéos de Ben Eater sur le sujet](https://www.youtube.com/watch?v=kRlSFm519Bo). J'utilise mon Arduino Uno R4 Wi-Fi comme source d'alimentation et pour faire des observations par la suite.

Pour vérifier qu'il se passe quelque chose dans le processeur j'ai connecté les 4 bits de poids faible du bus d'adresse sur 4 LEDs, et j'ai constaté une activité. J'ai également connecté les lignes du bus de données directement sur l'alim ou la masse avec des résitances pour faire en sorte qu'à chaque fois que le CPU lit une donnée sur le bus il récupère la valeur `0xEA`, qui correspond à l'instruction `NOP` (« No Operation »). Quand on observe les lignes d'adresse, on constate un comptage, qui correspond au fait que le CPU lit les instructions les unes après les autres dans la mémoire.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7380.mp4"
            legend="Mon 6502 en fonctionnement"
            width="50%"
            alt="Une vidéo montrant un montage éléctronique expérimental. On voit une première breadboard avec une LED qui clignote rapidement, et un second module comprenant le 6502 connecté à 4 LEDs qui s'allument successivement dans un motif de comptage."
        %}

    </div>

</div>


J'ai ensuite connecté les lignes d’adresses à l'Arduino ainsi que le signal d'horloge, et écrit un programme simple pour lire et afficher les données à chaque tic d'horloge via une interruption. Ben Eater utilise un Arduino Mega pour observer les 16 lignes d'adresse et les 8 lignes de données, mais mon Arduino Uno n'a pas assez de pins pour me permettre d'observer toutes les lignes, je suis donc resté sur les 4 bits de poids faible de l'adresse uniquement. 

Lorsque le processeur démarre ou est réinitialisé, il va chercher l'adresse de la première instruction à exécuter. Pour cela il va lire une donnée de 16 bits aux adresses `0xFFFC` et `0xFFFD`, puis commence à récupérer les instructions à partir de cette adresse. Comme je n'observe que les 4 derniers bits de l'adresse, je m'attends à voir passer les valeurs `C` et `D`, qui correspondent aux valeurs binaires `1100` et `1101` respectivement. Lorsque j’appuie sur le bouton reset, je vois effectivement passer ces adresses. Comme le bus de données est câblé pour renvoyer `0xEA`, le CPU va commencer à lire les instructions à partir de l'adresse `0xEAEA`. La valeur `A` en binaire s'écrit `1010`, et c'est effectivement la première adresse qu'on voit après `C` et `D`. Très cool !


<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-video-item.html
            url="/assets/projects/emulation/ADDR.mp4"
            legend="Lecture du bus d'adresse en temps réel"
            alt="Une capture vidéo du logiciel Arduino où l'on voit un programme et des données 4 bits qui défilent. Les données montrent un motif de comptage."
        %}

        {% include inline-image-item.html
            url="/assets/projects/emulation/FFFC.png"
            legend="Lecture du bus d'adresse après un reset"
            alt="Une capture d'écran du logiciel Arduino où l'on voit une capture de données. La donnée 1100 est mise en subrillance, la donnée suivante est 1101, et encore après on lit 1010, puis les valeurs s'incrémentent."
        %}

    </div>

</div>


Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-6502).


## La suite

La prochaine étape est de fournir au CPU des données dynamiques en fonction de l'adresse qu'il demande, de sorte à former un programme qui ait du sens. Classiquement c'est le rôle d'une puce mémoire. Mais on peut aussi utiliser Arduino.

