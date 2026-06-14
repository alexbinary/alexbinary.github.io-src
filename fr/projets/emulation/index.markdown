---
layout: project
project_id: a10edb47-8a09-4f84-9f5d-214ac597b2ad
title: Émulation matérielle
topics: [6502, arduino, electronique, programmation]
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

J'ai documenté ce projet au fur et à mesure dans des billets qui détaillent chaque session de travail. Cette page présente une synthèse du projet tel qu'il est avancé aujourd'hui et propose une mise en perspective des découvertes. Elle est mise à jour en continu au fil de l'avancement du projet et de mes réflexions. Des renvois vers les billets détaillés sont présents dans les sections consacrées. [La liste complète des publications est disponible ici](/fr/projets/emulation/billets).


## Mes réflexions sur l'émulation

Pour écrire un émulateur il faut commencer par bien comprendre comment chaque instruction d'un logiciel écrit pour le système électronique d'origine impacte les éléments à l'interface avec l'utilisateur. Pour ça il est nécessaire de bien connaître le hardware d'origine et l'interraction entre le matériel et le logiciel, mais le but n'est pas nécessairement de reproduire fidèlement le fonctionnement interne de tous les composants électroniques. Ce qui compte ce sont les éléments avec lesquels l'utilisateur interragit.

Prenons l'exemple de la *Game Boy*. Les interfaces avec l'utilisateur sont : les boutons directionnels, les boutons A et B, et les boutons *Start* et *Select* pour les entrées, et l'écran et le haut parleur pour les sorties. Le but d'un émulateur est donc, à partir du code du jeu écrit au départ pour piloter le hardware de la Game Boy, de piloter le hardware du PC d'une manière à recréer les visuels et les sons qui auraient été produits par le hardware de la Game Boy.

Il est possible qu'un programme exploite le matériel d'une manière marginale, ou qu'un utilisateur identifie un bug ou un défaut de conception qui permet d'utiliser le système d'une manière non prévue par les concepteurs ou non documentée. Il appartient aux développeurs de l'émulateur de faire les compromis pertinents pour supporter ou non ces usages, en gardant en tête que toute simulation sera nécessairement imparfaite.

Ce dernier point est précisément ce que je veux explorer dans ce projet. À quel niveau de précision est-il nécessaire de simuler le hardware ? Est-il toujours possible de comprendre l'intention derrière une série d'instructions ? J'imagine le cas où un périphérique est connecté au CPU en I²C et que les programmes utilisent normalement le driver natif, que se passe-t-il si un programme décide de recoder lui-même le protocol I²C en software ? Qu'est-ce que supporter cet usage implique pour le fonctionnement de l'émulateur ?


## Matériel utilisé dans ce projet

J'utilise globalement les mêmes composants que Ben Eater dans ses vidéos, ou les références les plus proches que je trouve sur AliExpress. J'ai certains composants dans mon stock. J'utilise mon Arduino pour programmer la ROM, observer les signaux, expérimenter avec les composants, et aussi comme source d'alimentation.

<table>
    <tr class="desktop-only">
        <th>Composant</th>
        <th>Référence</th>
        <th>Lien</th>
    </tr>
    <tr class="mobile-only">
        <th>Comp.</th>
        <th>Réf.</th>
        <th>Lien</th>
    </tr>
    <tr>
        <td>CPU</td>
        <td><a href="https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf">6502</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005009342322425.html?spm=a2g0o.order_list.order_list_main.71.4d895e5bCl6ekk&gatewayAdapt=glo2fra">
            Ali<span class="desktop-only">Express</span>
        </a></td>
    </tr>
    <tr>
        <td>EEPROM</td>
        <td><a href="https://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf">AT28C256</a></td>
        <td><a href="https://fr.aliexpress.com/item/4001000243213.html?spm=a2g0o.order_list.order_list_main.77.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>RAM</td>
        <td><a href="https://eater.net/datasheets/hm62256b.pdf">62256</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005001859824763.html?spm=a2g0o.order_list.order_list_main.5.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Portes logiques</td>
        <td>
            <a href="https://www.ti.com/lit/ds/symlink/sn74ls02.pdf">74LS02</a>
            <br class="mobile-only">
            <a href="https://www.ti.com/lit/ds/symlink/sn74ls04.pdf">74LS04</a>
            <br class="mobile-only">
            <a href="https://www.ti.com/lit/ds/symlink/sn74ls08.pdf">74LS08</a>
        </td>
        <td><a href="https://fr.aliexpress.com/item/1005007227095225.html?spm=a2g0o.order_list.order_list_main.125.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Registre&nbsp;à décalage</td>
        <td><a href="https://www.ti.com/lit/ds/symlink/sn74hc595.pdf">74HC595</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005004856540723.html?spm=a2g0o.order_list.order_list_main.370.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Interface</td>
        <td><a href="https://eater.net/datasheets/w65c22.pdf">6522</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005011978744402.html?spm=a2g0o.order_list.order_list_main.83.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>LEDs</td>
        <td></td>
        <td>en stock</td>
    </tr>
    <tr>
        <td>Boutons</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005004198996493.html?spm=a2g0o.order_list.order_list_main.295.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Écran OLED</td>
        <td>SSD1306</td>
        <td><a href="https://fr.aliexpress.com/item/1005008918700196.html?spm=a2g0o.order_list.order_list_main.150.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Breadboards</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005007174397080.html?spm=a2g0o.order_list.order_list_main.245.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Jumper wire</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005004336218242.html?spm=a2g0o.order_list.order_list_main.230.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Lignes Dupont</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005007072081464.html?spm=a2g0o.order_list.order_list_main.255.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Résistances</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005005855324735.html?spm=a2g0o.order_detail.order_detail_item.3.1e252dd0EBGFs9&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Arduino</td>
        <td><a href="https://docs.arduino.cc/resources/datasheets/ABX00087-datasheet.pdf">Uno R4 Wi-Fi</a></td>
        <td><a href="https://store.arduino.cc/collections/boards-modules/products/uno-r4-wifi?_pos=1&_fid=3febf6e59&_ss=c"><span class="desktop-only">Arduino </span>Shop</a></td>
    </tr>
</table>


## Premiers pas avec le 6502

J'ai commencé par installer le 6502 sur une breadboard en câblant la valeur `0xEA` sur le bus de données, qui correspond à l'instruction `NOP` (« No Operation »), et j'ai connecté des diodes sur le 4 bits de poids faible du bus d'adresse. Pour générer le signal d’horloge j'utilise un module basé sur un circuit 555 que j’ai construit en suivant les [vidéos de Ben Eater](https://www.youtube.com/watch?v=kRlSFm519Bo) sur le sujet. Les diodes montrent un comptage, signe que le processeur avance dans le programme.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7380.mp4"
            legend="Premiers tests du 6502"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="001"
%}

J'ai ensuite connecté les lignes d’adresses et de données à l'Arduino ainsi que le signal read/write, et écrit un code capable d'envoyer des données sur le bus en fonction de l'adresse demandée par le CPU. J'ai utilisé ce système rudimentaire pour fournir au CPU un programme minimaliste à 3 instructions, et validé le bon fonctionnement en observant l'activité sur le bus. Dans ce genre d'opération c'est l'Arduino qui génère le signal d'horloge. J'ai fait ça pour être sûr de lire et écrire sur les bus aux bons moments car je ne me suis pas encore penché sur les timings du 6502.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7383.JPG"
            legend="L'Arduino connecté aux bus d'adresse et de données du 6502"
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/pgm.mp4"
            legend="Exécution du premier programme"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="002"
%}


## Prise en main de l'EEPROM

La manip avec l'Arduino est sympa pour tester, mais dans le système final c'est l'EEPROM qui fournit les données. Conformément à l'esprit du projet j'ai commencé par la base en faisant des lectures et écritures en manipulant directement les signaux de contrôle, avec des LEDs pour visualiser les données. J'ai ensuite écrit un code Arduino pour lire et écrire, d'abord un octet à la fois puis toute une séquence.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7389.JPG?mm"
            legend="Montage de test de la ROM"
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/ROM.mp4"
            legend="Ecriture des 14 premiers octets puis relecture"
        %}

    </div>

</div>

Une fois capable de programmer la ROM, je l'ai connecté au 6502, d'abord de manière temporaire puis de manière semie-permanente en essayant de faire quelque chose de propre. 


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7399.JPG"
            legend="L'EEPROM connectée au 6502"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="003"
%}


## Création d'un programmeur avec des registres à décalage

Mon Arduino ne disposant pas de suffisamment de broches pour connecter les 8 lignes de données et les 15 lignes d'adresses + les signaux de contrôles de l'EEPROM, je programmais jusque là sur seulement 4 bits d'adresse. Par la suite j'ai utilisé des registres à décalage que j'avais en stock pour pouvoir programmer l'entiereté de la mémoire. Comme d'habitude j'ai commencé par les bases, avec un montage minimal pour me familiariser avec le fonctionnement des registres à décalage et j'ai écrit un code Arduino pour pousser des données dans le registres et observer les résultats sur des LEDs.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7405.mp4"
            legend="Injection de 0xEA dans un registre à décalage"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="004"
%}


Ensuite j'ai réalisé un montage semi-permanent sur breadboard associé à un code Arduino capable de programmer la ROM sur l'intégralité de la plage mémoire. J'ai implémenter une fonction de lecture de la mémoire capable d'afficher une plage arbitraire par bloc de 16 octets, et des fonctions d'écriture capables d'écrire une valeur sur ou deux octets à une adresse donnée, ou toute une séquence. 

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/asm.png"
            legend="Prémisce d'un assembleur !"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="005"
%}


## Ajout du 6522 "Versatile Interface Adapter"

Je l'appelle "VIA" pour faire court. La première chose à faire était de mettre au clair les plages mémoire allouées à la ROM et au VIA, et d'implémenter les signaux *Chip Select*. Je suis allé au plus simple en choisissant une solution qui utilise le moins de connexions et de composants supplémentaires.

J'ai réécrit un programme simple pour tester le VIA, connecté des LEDs en sorties du Port A, mais impossible d'avoir un quelconque résultat. J'ai bien vérifié les câblages, vérifié la documentation, observé les signaux avec Arduino, et même tenté de piloter directement le VIA avec l'Arduino, mais rien n'y fait. Il y a visiblement quelque chose qui m'échappe, à moins que mon VIA soit défectueux...


<div class="inline-image-container">

    <div class="inline-image-container-row free-width mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7415.JPG"
            legend="Connection du VIA directement à l'Arduino"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="006"
%}


## Implémentation d'une bascule D

Pour avancer malgré les problèmes avec le 6522, j'ai tenté d'implémenter une bascule D à partir de portes logiques en suivant la [vidéo de Ben Eater](https://www.youtube.com/watch?v=peCh_859q7Q). C'était un peu technique il y avait pas mal de connexions à faire. J'ai ajouté deux LEDs pour visualiser l'état de la sortie (une pour la sortie normale et une pour la sortie inversée).

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/d-flip-flop.JPG"
            legend="Mon brouillon utilisé pour le câblage de la bascule"
        %}

    </div>

</div>

J'ai ensuite connecté la bascule sur le premier bit du bus de données à la place du VIA, et ajouté une logique pour ne capturer les données que quand la bonne adresse est utilisée, et en analysant attentivement le programme présent dans la ROM j'ai été en mesure de confirmer que la donnée affichée par la bascule correspond bien aux attentes.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7420.mp4"
            legend="La bascule D remplace le VIA"
        %}

    </div>

</div>


Interfacer une bascule D au 6502 n'était pas prévu initialement mais ça s'est révélé très intéressant et ça m'a aidé à comprendre ce qui peut se jouer dans les puces qui communiquent sur un bus de données, comme la ROM ou le VIA. Je suis très content d'avoir fait ce petit détour.

{% include project_post_link.html
    target_entry="007"
%}


## Bilan et perspectives

J'ai aujourd'hui un système basé sur le 6502 que je peux programmer pour piloter une LED selon une logique arbitraire. Ça reste bien sûr limité mais c'est un système qui commence à être intéressant à émuler. Avant de passer à l'émulation cependant, je voudrais connecter un bouton pour permettre de créer des programmes interractifs. L'idée est d'utiliser une approche similaire à la bascule D, mais pour cette fois créer un périphérique capable d'envoyer des données sur le bus. J'ai déjà quelques idées.