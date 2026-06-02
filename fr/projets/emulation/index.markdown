---
layout: project
title: Emulation matérielle
topics: [emulation, electronique, programmation, 6502]
image: /assets/projects/emulation/IMG_7377.JPG
project_status: 'en cours 🧑‍💻'
project_github: 
last_updated: 2026-06-02
lang: fr
lang_en: /en/projects/emulation
---

Je joue régulièrement à des jeux vidéo sur émulateur et je comprends dans les grandes lignes le principe de l’émulation mais j'ai envie d'en apprendre plus et de "mettre les mains dedans". J'aimerais bien savoir écrire un émulateur de GameBoy, et c'est probablement faisable avec suffisamment de patience, mais j'aime commencer par la base. Et la base c'est : "Au fond, l'émulation, c'est quoi ?"

Je construis un système matériel simple que je peux programmer et qui servira de référence pour écrire un émulateur pour ce système. Le système se base sur le processeur 6502 et comprendra des boutons et des LEDs, et peut-être un écran. Pour l'instant j'en suis à me familiariser avec le 6502.


## Comprendre l'émulation

Prenons l'exemple de la GameBoy. Un jeu de GameBoy est un programme conçu pour être lu par le hardware de la GameBoy dans le but de produire des images et du son en fonction des actions de l'utilisateur sur les boutons. Le but d'un "émulateur de GameBoy" est de prendre en entrée ce programme et de recréer l'expérience de jeu sur un PC, c'est-à-dire de générer son et image en fonction des actions de l'utilisateur, mais sur une stack matérielle complètement différente.

Le but quand on écrit un émulateur est de comprendre l'effet de chaque instruction du programme sur le matériel d'origine et de recréer un résultat global fidèle sur le nouveau hardware. Écrire un émulateur demande donc de bien connaître le hardware d'origine et l'interraction hardware/software, mais il ne s'agit pas nécessairement de reproduire fidèlement le fonctionnement interne du matériel. Ce qui compte c'est le résultat *observable*.

Pour mettre en pratique ces réflexions et les confronter à la réalité, je voudrais créer de zéro un système matériel simple qui puisse être programmé, et ensuite écrire un émulateur pour ce système. Créer le système matériel à émuler permet d'avoir une référence précise et permet de comparer l'exécution des programmes et valider l'émulateur. Si j'écris l'émulateur en "imaginant" le hardware émulé, qu'est-ce qui me permet de dire que le résultat est juste ?


## Le choix du hardware

J’ai choisi de construire un système basé sur le microprocesseur 6502. Le 6502 est un microprocesseur relativement simple idéal pour débuter. Il est aussi très célèbre puisqu'il se trouvait au cœur de nombreux appareils grand public dans les années 1980, notamment l’Apple II, le Commodore 64 et l'Atari 2600. Des versions modernisées sont toujours en production aujourd'hui et il existe une large communauté de passionnés.

Mon objectif est de créer un système capable d’exécuter un programme assembleur et de produire un résultat observable en fonction d'actions de l'utilisateur. De simples boutons feront l'affaire pour les actions utilisateurs, et dans un premier temps je prévois d'utiliser quelques LEDs pour les sorties. Par la suite j'essairai peut-être d'incorporer un écran OLED que j'ai en stock, ça permettrait de se rapprocher d'une console de jeu 🎮.


## Premiers pas avec le 6502

Le 6502 est un microprocesseur, et sa fonction principale est donc d'exécuter des instructions. Contrairement à un microcontrôleur, il n'a aucune mémoire interne et aucun périphérique. Il interragit avec le monde extérieur via un bus de données et un bus d'addresse, sur lesquels il peut lire et écrire des données. Les instructions à éxécuter, les données à traiter, et les données produites, tout passe par le bus. En général on connecte sur le bus une mémoire qui contient le programme et les données de travail, et des périphérique comme un afficheur, une carte son, etc.

Pour commencer en douceur je suis la [série de vidéos de Ben Eater](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH) consacrée à la construction d’un ordinateur basé sur le 6502. Je commence par installer le 6502 sur une breadboard, je connecte l'alimentation et les signaux de contrôle de base, et j'ajoute un bouton reset. Le signal d’horloge est généré par un module basé sur un circuit 555 que j’ai construit précédemment en suivant les [vidéos de Ben Eater](https://www.youtube.com/watch?v=kRlSFm519Bo) sur le sujet. J'utilise un Arduino Uno comme source d'alimentation et pour faire des observations par la suite.

Pour vérifier qu'il se passe quelque chose dans le processeur j'ai connecté les 4 bits de poids faible du bus d'adresse sur 4 LEDs, et j'ai constaté une activité. J'ai également connecté les lignes du bus de données directement sur l'alim ou la masse avec des résitances pour faire en sorte qu'à chaque fois que le CPU lit une donnée sur le bus il récupère la valeur 0xEA, qui correspond à l'instruction NOP (« No Operation »). Quand on observe les lignes d'adresse, on constate un comptage, qui correspond au fait que le CPU lit les instructions les unes après les autres dans la mémoire.


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

Lorsque le processeur démarre ou est réinitialisé, il va chercher l'adresse de la première instruction à exécuter. Pour cela il va lire une donnée de 16 bits aux adresses 0xFFFC et 0xFFFD, puis commence à récupérer les instructions à partir de cette adresse. Comme je n'observe que les 4 derniers bits de l'adresse, je m'attends à voir passer les valeurs C et D, qui correspondent aux valeurs binaires 1100 et 1101 respectivement. Lorsque j’appuie sur le bouton reset, je vois effectivement passer ces adresses. Comme le bus de données est câblé pour renvoyer 0xEA, le CPU va commencer à lire les instructions à partir de l'adresse 0xEAEA. La valeur A en binaire s'écrit 1010, et c'est effectivement la première adresse qu'on voit après C et D. Très cool !


<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-video-item.html
            url="/assets/projects/emulation/ADDR.mp4"
            legend="Lecture du bus d'adresse en temps réel"
            height="550"
            alt="Une capture vidéo du logiciel Arduino où l'on voit un programme et des données 4 bits qui défilent. Les données montrent un motif de comptage."
        %}

        {% include inline-image-item.html
            url="/assets/projects/emulation/FFFC.png"
            legend="Lecture du bus d'adresse après un appui sur le bouton reset"
            height="550"
            alt="Une capture d'écran du logiciel Arduino où l'on voit une capture de données. La donnée 1100 est mise en subrillance, la donnée suivante est 1101, et encore après on lit 1010, puis les valeurs s'incrémentent."
        %}

    </div>

</div>


## La suite

La prochaine étape est de fournir au CPU des données dynamiques en fonction de l'adresse qu'il demande, de sorte à former un programme qui ait du sens. Classiquement c'est le rôle d'une puce mémoire. Mais on peut aussi utiliser Arduino.