---
layout: project
project_id: a10edb47-8a09-4f84-9f5d-214ac597b2ad
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


## Premier programme

La prochaine étape est de fournir au CPU des données dynamiques en fonction de l'adresse qu'il demande, de sorte à former un programme qui ait du sens. Classiquement c'est le rôle d'une puce mémoire. Mais dans un premier temps j'expérimente avec Arduino.

En plus des 4 lignes d'adresses utilisées jusque là, j'ajoute les 8 lignes du bus de données. Je connecte également le signal read/write pour détecter quand le CPU cherche à lire sur le bus.

Avant d'aller plus loin je retravaille le programme pour afficher les nouvelles données, et je fais également en sorte que ce soit l'Arduino qui génère le signal d'horloge. Ça permet de mieux coordonner les actions sur le bus en fonction de l'horloge, et au passage de pouvoir régler librement la vitesse. Le module à base de 555 que j'utilise, bien que réglable, ne va pas aussi bas que je voudrais.

Ces modifications en place, j'écris un code qui envoie `0xEA` sur le bus lorsque le CPU est en lecture.

<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7383.JPG"
            legend="L'Arduino connecté aux 4 LSBs du bus d'adresse et aux 8 lignes du bus de données du 6502"
            
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/EA.mp4"
            legend="L'Arduino écrit 0xEA sur le bus quand il détecte que le 6502 est en lecture"
            
        %}

    </div>

</div>

Maintenant qu'on est capable d'envoyer des données dynamiques au CPU, on peut essayer de lui faire exécuter une petit programme. Très petit en l'occurrence puisque comme je travaille avec seulement 4 bits d'adresse on ne peut fournir que 16 octets au total, dans lesquels il faut compter les deux bits d'adresse du vecteur reset situés aux adresses `0xC` et `0xD`. Techniquement j'aurais pu ajouter un fil ou deux ce qui pourrait respectivement doubler ou quadrupler l'espace disponible, mais je trouvais que c'était un bon challenge.

Pour que ce soit intéressant, je choisi des instructions qui provoquent des accès à la mémoire en lecture et en écriture. L'instruction `LDA` (Load Accumulator) charge dans l'accumulateur la valeur stockée à l'adresse indiquée. `ADC` (Add with Carry) additionne à l'accumulateur la valeur lue à l'adresse spécifiée. `STA` (Store Accumulator) écrit le contenu de l'accumulateur en mémoire. Chacun de ces trois instructions prennent en paramètre l'adresse mémoire à utiliser sur deux octets, les poids faibles en premier. Avec 3 instructions on a déjà rempli 9 octets. Immédiatement après je place les deux octets de données qui seront additionnés par le CPU. Il reste juste un octet libre avant le vecteur de reset.

Voici le programme final (données en hexadécimal):

| Addr | Instruction | Données |
|---|---|---|
| `0x0` | `LDA $0009` | `AD 09 00` |
| `0x3` | `ADC $000A` | `6D 0A 00` |
| `0x6` | `STA $000B` | `8D 0B 00` |
| `0x9` |             | `28`       |
| `0xA` |             | `02`       |
| `0xB` |             |            |
| `0xC` |             | `00`       |
| `0xD` |             | `00`       |
| `0xE` |             |            |
| `0xF` |             |            |

Explications :

1. `LDA`<span class="fixed-space"> </span>`$0009` : Charger la valeur à l'adresse `0x09` dans l'accumulateur
2. `ADC`<span class="fixed-space"> </span>`$000A` : Ajouter la valeur à l'adresse `0x0A` à la valeur présente dans l'accumulateur
3. `STA`<span class="fixed-space"> </span>`$000B` : Écrire la valeur présente dans l'accumulateur à l'adresse `0x0B`

On devrait donc voir passer sur le bus les événements suivants :

<table>
  <thead>
    <tr>
      <th>Addr</th>
      <th>R/W</th>
      <th>Data</th>
      <th>Événement</th>
    </tr>
  </thead>
  <tbody class="monospace">
    <tr>
      <td>0xC</td>
      <td>R</td>
      <td>00</td>
      <td class="normal-font" owspan=2>Lecture du vecteur reset</td>
    </tr>
    <tr>
      <td>0xD</td>
      <td>R</td>
      <td>00</td>
    </tr>
    <tr><td></td><td></td><td></td><td></td></tr>
    <tr>
      <td>0x0</td>
      <td>R</td>
      <td>AD</td>
      <td class="normal-font" rowspan=3>Lecture de la première instruction</td>
    </tr>
    <tr>
      <td>0x1</td>
      <td>R</td>
      <td>09</td>
    </tr>
    <tr>
      <td>0x2</td>
      <td>R</td>
      <td>00</td>
    </tr>
    <tr><td></td><td></td><td></td><td></td></tr>
    <tr>
      <td>0x9</td>
      <td>R</td>
      <td>28</td>
      <td class="normal-font">Lecture de la donnée</td>
    </tr>
    <tr><td></td><td></td><td></td><td></td></tr>
    <tr>
      <td>0x3</td>
      <td>R</td>
      <td>6D</td>
      <td class="normal-font" rowspan=3>Lecture de la deuxième instruction</td>
    </tr>
    <tr>
      <td>0x4</td>
      <td>R</td>
      <td>09</td>
    </tr>
    <tr>
      <td>0x5</td>
      <td>R</td>
      <td>00</td>
    </tr>
    <tr><td></td><td></td><td></td><td></td></tr>
    <tr>
      <td>0xA</td>
      <td>R</td>
      <td>02</td>
      <td class="normal-font">Lecture de la donnée</td>
    </tr>
    <tr><td></td><td></td><td></td><td></td></tr>
    <tr>
      <td>0x6</td>
      <td>R</td>
      <td>8D</td>
      <td class="normal-font" rowspan=3>Lecture de la troisième instruction</td>
    </tr>
    <tr>
      <td>0x7</td>
      <td>R</td>
      <td>0B</td>
    </tr>
    <tr>
      <td>0x8</td>
      <td>R</td>
      <td>00</td>
    </tr>
    <tr><td></td><td></td><td></td><td></td></tr>
    <tr>
      <td>0xB</td>
      <td>W</td>
      <td>2A</td>
      <td class="normal-font">Ecriture de la donnée</td>
    </tr>
  </tbody>
</table>

Le résultat correspond bien à ce qui est attendu :

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/pgm.mp4"
            legend="Exécution du premier programme"
            width="70%"
        %}

    </div>

</div>

Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-6502).


## Découverte de l'EEPROM

L'Arduino est bien sympatique, mais dans le système final les données sont stockées dans une puce mémoire. J'utilise ici une puce EEPROM [AT28C256](https://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf). C'est une mémoire de 32ko destinée à être utilisée en lecture seule, mais qu'on peut effacer et programmer éléctroniquement.

Je veux commencer par la base, en faisant des lectures et écritures en manipulant directement les signaux de contrôle. Sur une breadboard je connecte huit LEDs au bus de données de la ROM et je force toutes les lignes d'adresse à zéro à l'aide de cavaliers, sauf les quatre bits de poids faible que je connecte avec des fils de connexion repositionnables facilement.

Il y a 3 signaux de contrôle sur la ROM :

| Signal | Signification | Usage |
|-|-|
| `/CE` | Chip Enabled | Active la puce |
| `/OE` | Output Enabled | Active la sortie de données |
| `/WE` | Write Enabled | Déclenche l'écriture |

Sur la breadboard je connecte CE à 0, et je gère manuellement OE et WE.

<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7389.JPG"
            legend="Montage de test de la ROM"
            width="50%"
        %}

    </div>

</div>

Je commence par tester la lecture. Je mets `/OE` à `0` pour activer la sortie et `/WE` à `1` pour être en mode lecture, et je fais défiler les adresses en repositionnant les 4 fils prévus à cet effet. Les LEDs affichent le contenu stocké dans la mémoire à chaque adresse.

Voici mon relevé :

| Adresse | Donnée |
| - | - |
| `0x0000` | `00` |
| `0x0001` | `FF` |
| `0x0002` | `00` |
| `0x0003` | `FF` |
| `0x0004` | `00` |
| `0x0005` | `FF` |
| `0x0006` | `00` |
| `0x0007` | `FF` |
| `0x0008` | `FF` |
| `0x0009` | `FF` |
| `0x000A` | `FF` |
| `0x000B` | `FF` |
| `0x000C` | `FF` |
| `0x000D` | `FF` |
| `0x000E` | `FF` |
| `0x000F` | `FF` |

Je teste maintenant une écriture. Le fonctionnement est le suivant : En temps normal (mode lecture) `/WE` est à `1`. Lorsque `/WE` passe à `0`, la puce capture la valeur présente sur le bus d'adresse. Quand `/WE` repasse à `1` elle capture la donnée et procède à l'écriture dans la mémoire.

Je commence par désactiver la sortie en plaçant `/OE` à `1`. Je configure l'adresse `0`, puis je forme la valeur `0xEA` sur le bus de données à l'aide de cavaliers, et je vérifie la valeur sur les LEDs. Enfin je fais passer `/WE` à `0` puis de nouveau à `1`.

Je repasse en mode lecture en enlevant les cavalier sur les lignes de données, je remet `/OE` à `0`, et je vois bien la valeur 0xEA apparaître sur les LEDs. Je regarde les autres adresses et constate que je retrouve bien les valeurs relevées précédemment à l'éxception de l'adresse `0` qui affiche désormais `0xEA`. Première écriture manuelle réussie !

Je connecte maintenant l'adresse et les données ainsi que les signaux de contrôle à l'Arduino et code un programme pour automatiser les lectures et écritures.

Dans un premier temps le programme parcours séquentiellement les 16 adresses et affiche la données correspondante à chacune. Ça fonctionne bien et je retrouve bien le relevé initial avec la valeur `0xEA` à l'adresse `0`. Je code ensuite l'écriture, en commençant par une fonction qui écrit un seul octet. Il faut reproduire la séquence des signaux de contrôle que j'ai effectuée à la main juste avant. Ensuite j'ajoute la possibilité d'écrire une séquence de valeurs une à une.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/writeByte.png"
            legend="Fonction d'écriture d'un octet dans la ROM"
            width="50%"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/ROM.mp4"
            legend="Ecriture des 14 premiers octets puis relecture"
            width="50%"
        %}

    </div>

</div>

Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-6502).


## Connexion de l'EEPROM au 6502

L'objectif maintenant est de connecter la ROM au CPU pour que celui-ci lise et exécute le programme. En laissant la ROM sur sa breadboard, je relie désormais les 4 lignes d'adresse et le bus de données sur les broches correspondantes du 6502. Ce faisant je remarque que j'avais du aller un peu vite quand j'ai choisi les quatre lignes d'adresse à manipuler sur la ROM car ce n'était pas du tout les quatre bits de poids faible, bien que c'était mon intention. Il s'agissait en fait des lignes 13, 8, 9 et 11. En réalité ce n'est pas gênant, du moment que je connecte au CPU les mêmes lignes de la même manière, il retrouvera les données aux adresses attendues.

Pour analyser le résulat je choisis de me baser sur les LEDs connectés au bus de données de la ROM. Ce n'est pas forcément le plus pratique, et je pourrais connecter l'Arduino comme précédemment mais je n'ai pas envie d'ajouter encore davantage de fils volants à un montage déjà très chargé. Mais surtout j'aime utiliser toutes les opportunités qui se présentent pour confronter mes prédictions à la réalité. Parfois ça met en valeur des lacunes dans ma compréhension.

Avant de lancer le test je modifie le programme de sorte que le bus reste en mode lecture. Je retire l'instruction `STA` et restructure un peu l'ordre. Voici le nouveau programme :

| Addr | Instruction | Données |
|---|---|---|
| `0x0` | `LDA $0009` | `AD 09 00` |
| `0x3` | `LDA $000A` | `AD 0A 00` |
| `0x6` | `ADC $000B` | `6D 0B 00` |
| `0x9` |             | `28`       |
| `0xA` |             | `02`       |
| `0xB` |             | `0A`       |
| `0xC` |             | `00`       |
| `0xD` |             | `00`       |
| `0xE` |             |            |
| `0xF` |             |            |

Si tout se passe bien on est sensé observer les données suivantes sur le bus :

<table>
  <thead>
    <tr>
      <th>Hexa</th>
      <th>Binaire</th>
      <th>Explication</th>
    </tr>
  </thead>
  <tbody class="monospace">
    <tr><td>00</td><td>0000&nbsp;0000</td><td class="normal-font" rowspan=2>Vecteur Reset</td></tr>
    <tr><td>00</td><td>0000&nbsp;0000</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td>AD</td><td>1010&nbsp;1101</td><td class="normal-font" rowspan=3>Première instruction</td></tr>
    <tr><td>09</td><td>0000&nbsp;1001</td></tr>
    <tr><td>00</td><td>0000&nbsp;0000</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td>28</td><td>0010&nbsp;1000</td><td class="normal-font">Donnée</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td>AD</td><td>1010&nbsp;1101</td><td class="normal-font" rowspan=3>Deuxième instruction</td></tr>
    <tr><td>0A</td><td>0000&nbsp;1010</td></tr>
    <tr><td>00</td><td>0000&nbsp;0000</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td>02</td><td>0000&nbsp;0010</td><td class="normal-font">Donnée</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td>6D</td><td>0110&nbsp;1101</td><td class="normal-font" rowspan=3>Troisième instruction</td></tr>
    <tr><td>0B</td><td>0000&nbsp;1011</td></tr>
    <tr><td>00</td><td>0000&nbsp;0000</td></tr>
    <tr><td></td><td></td><td></td></tr>
    <tr><td>0A</td><td>0000&nbsp;1010</td><td class="normal-font">Donnée</td></tr>
  </tbody>
</table>

Les premières observations m'ont laissé perplexe. Les résultats n'avaient pas l'air de correspondre à ce qui est attendu, et j'ai commencé à me demander ce qui n'allait pas. J'avais l'impression de reconnaitre le `02` (`0000 0010`) mais à l'envers, mais je ne voyais pas comment les données auraient pu être inversées. Et puis j'ai réalisé que je lisais les LEDs dans le mauvais sens ! Je m'attendais à voir la même chose que ce que j'avais affiché à l'écran pour référence, mais sur les LEDs les bits de poids faible étaient à gauche et non à droite. J'ai retourné la plaque et là tout semblait correspondre. J'ai filmé la séquence pour analyser les résultat plus rigourseuement, et je confirme que tout correspond parfaitement.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7393.mp4"
            legend="Observation des données qui transitent sur le bus"
        %}

    </div>

</div>


Je veux maintenant connecter la ROM de façon semi-permanente au 6502 sur la même breadboard et câbler proprement toutes les lignes d’adresse et de données. Mais avant ça il faut revoir la programmation de la ROM car cette fois les lignes d'adresses seront câblées correctement et le CPU ne retrouvera donc pas les données que j'ai programmé précédement en utilisant les mauvaises lignes d'adresse. Il y a aussi le fait qu'au démarrage le CPU va lire le vecteur reset situé aux adresses `0xFFFC` et `0xFFFD` pour savoir à partir de quelle adresse il doit commencer à exécuter les instructions. Avec 4 lignes d'adresse on pouvait placer le vecteur reset aux adresses `0x000C` et `0x000D`, mais avec un adressage complet ça ne fonctionnera pas. 

La ROM utilise 15 lignes d'adresse (32k adressable) alors que le CPU en utilise 16 (64k adressable). Pour l'instant je connecte les 15 premières lignes et je laisse la 16e du CPU non connectée. Ainsi quand le CPU demande l'adresse `0xFFFC`, ça correspondra à l'adresse `0x7FFC` dans la ROM. C'est donc là qu'il faut placer le vecteur reset. On peut ensuite placer le programme où on veut dans la mémoire, tant qu'on renseigne l'adresse correspondante dans le vecteur reset.

Je décide de commencer par écrire le programme à l'adresse `0x0000`, et d'écrire ensuite le vecteur reset. Je reprends mon montage de programmation et je connecte toutes les lignes d’adresse à `0` en laissant cette fois les 4 vraies lignes de poids faible ajustables. Je lance la programmation avec le code Arduino utilisé précédemment.

Pour écrire le vecteur reset, je décide par soucis de simplicité d'écrire à nouveau tout le programme à l'adresse `0x7FF0`, ce qui permet de faire exactement la même manip que précédemment mais cette fois avec les lignes d'adresse à `1`. Le vecteur reset étant `00`<span class="fixed-space"> </span>`00`, ça devrait fonctionner, mais pour rendre les choses intéressantes je décide de modifier la valeur et de mettre `0xFFF0`, ce qui aura pour effet d'exécuter le programme situé en `0x7FF0` et non en `0x0000`.

Résumé des écritures dans la ROM :

| Addr | Données | Commentaire
|---|---|---|
| `0x0000` | `AD 09 00` | `LDA $0009` |
| `0x0003` | `AD 0A 00` | `LDA $000A` |
| `0x0006` | `6D 0B 00` | `ADC $000B` |
| `0x0009` | `28`       |             |
| `0x000A` | `02`       |             |
| `0x000B` | `0A`       |             |
| `0x000C` | `00`       |             |
| `0x000D` | `00`       |             |
| `0x7FF0` | `AD 09 00` | `LDA $0009` |
| `0x7FF3` | `AD 0A 00` | `LDA $000A` |
| `0x7FF6` | `6D 0B 00` | `ADC $000B` |
| `0x7FF9` | `28`       |             |
| `0x7FFA` | `02`       |             |
| `0x7FFB` | `0A`       |             |
| `0x7FFC` | `F0`       |             |
| `0x7FFD` | `FF`       |             |


La ROM étant prête, je l'installe sur la breadboard à côté du 6502. Pour l'instant je force `/CE` à `0`, `/OE` à `0` et `/WE` à `1`, la ROM sera toujours active et ne fonctionnera qu'en écriture. Je connecte ensuite les lignes d'adresse et les lignes de données. J'essaie de faire quelque chose de propre, en m’inspirant des [techniques de Ben Eater](https://www.youtube.com/watch?v=PE-_rJqvDhQ).

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7399.JPG"
            legend="L'EEPROM connectée au 6502"
            width="50%"
        %}

    </div>

</div>

Pour l'observation j'utilise des nappes pour les bus, c'est plus propre que les fils volants. Comme précédemment c'est l'Arduino qui fait la clock, et j'observe uniquement les 4 LSB de l'adresse (les vrais maintenant).

J'alimente, je fais un reset du CPU, et voici le résultat :

| Adresse théorique | Adresse observée | Data
|---|---|---|
| `0xFFFc` | `0xc` | `f0` |
| `0xFFFd` | `0xd` | `ff` |
| `0x7FF0` | `0x0` | `ad` |
| `0x7FF1` | `0x1` | `09` |
| `0x7FF2` | `0x2` | `00` |
| `0x0009` | `0x9` | `28` |
| `0x7FF3` | `0x3` | `ad` |
| `0x7FF4` | `0x4` | `0a` |
| `0x7FF5` | `0x5` | `00` |
| `0x000a` | `0xa` | `02` |
| `0x7FF6` | `0x6` | `6d` |
| `0x7FF7` | `0x7` | `0b` |
| `0x7FF8` | `0x8` | `00` |
| `0x000b` | `0xb` | `0a` |

Tout fonctionne comme prévu 🎉


## Les registres à décalage

Maintenant que le système est en mesure de lire des programmes arbitrairement longs, il est nécessaire de pouvoir programmer la ROM plus de 16 octets à la fois. Jusque là je n'utilisais que 4 lignes d'adresses car l'Arduino n'a pas assez de broches pour utiliser les 15 lignes en même temps, mais il est possible de produire plus de sortie grâce à un composant qu'on appelle *registre à décalage*.

Un registre à décalage est capable de produire plusieurs sorties à partir d'un seul bit d'entrée. On envoie les valeurs une par une et elles sont distribuées sur les lignes de sorties, dans l'ordre. Chaque nouvelle donnée "pouse" les données déjà présente d'un cran. Il est possible de connecter plusieurs registres les uns à la suite des autres pour produire un nombre arbitraire de sorties. On peut également figer la sortie le temps qu'on pousse toutes les données pour éviter que les appareils connectés ne voient les données se déplacer d'une ligne à l'autre, ce qui pourrait avoir des conséquences indésirables.

J'utilise le circuit [74HC595](https://www.ti.com/lit/ds/symlink/sn74hc595.pdf) que j'avais en stock. C'est un registre à décalage qui possède 8 lignes de sortie. Pour contrôler 15 lignes d'adresse il en faut donc deux. Comme d'habitude je commence par les bases, avec un montage minimal pour me familiariser avec le fonctionnement. Je place un registre à décalage et 8 LEDs avec leur résistances. 

Le 74HC595 possède en tout 5 signaux de contrôle :

| Signal | Signification | Fonction
|-|-|
| `/OE` | Output Enabled | Active la sortie des données
| `SER` | Serial input | Reçoit la donnée d'entrée
| `SRCLK` | Shift register clock | Pousse la donnée d'entrée dans le registre et décale les données existantes
| `RCLK` | Storage register clock | Libère la sortie pour refléter les données internes
| `/SRCLR` | Overriding clear | Efface tout

Je connecte l'alimentation et la masse, et je mets `/SRCLR` à `1` car je ne prévois pas de l'utiliser. Je mets `/OE` à `0` pour activer la sortie, et le reste sera piloté manuellement. Je passe `SER` à `1`, puis passe `SRCLK` à `1` puis à nouveau à `0`. J'essaie plusieurs fois avec différentes valeurs mais les tests ne sont pas très concluants. J'ai soit toutes les LEDs allumées, soit toutes éteintes. Je soupçonne des mauvais contacts, mais à un moment j'ai les 4 premières éteintes et les autres allumées. Je me dit que mes manipulations manuelles provoquent peut-être plusieurs pulse sur `SRCLK` ce qui a pour effet de pousser plusieurs données d'un coup. Je décide donc de passer au pilotage par Arduino.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7402.JPG"
            legend="Premier montage du registre à décalage avec Arduino"
            width="50%"
        %}

    </div>

</div>


Je connecte les signaux de contrôle sur l'Arduino et code un programme de test. Je commence par essayer de pousser un bit à la fois. Ça a l'air de bien fonctionner. J'écris une fonction de test qui pousse alternativement un `1` et un `0` avec un délai entre chaque. Ça fonctionne comme attendu. Je teste ensuite une fonction capable de pousser un octet. Tout fonctionne bien. Au début j'avais mis des temporisations mais en fait elles ne sont pas nécessaire. J'ai connecté une LED supplémentaire pour afficher la valeur du dernier bit de donnée dans le registre. Contrairement aux autres cette donnée est toujours à jour avec l'état interne même si on fige la sortie, car elle est destinée à être connectée au registre suivant quand on chaine plusieurs.


<div class="inline-image-container mobile-column">

    <div class="inline-image-container-row mobile-column">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7403.mp4"
            legend="Injection de 1, 0, 1, 0, etc"
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7405.mp4"
            legend="Injection de 0xEA"
        %}

    </div>

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/push.png"
            legend="Code pour pousser les données dans le registre à décalage"
            width="50%"
        %}

    </div>

</div>


Arduino fournit une fonction `shiftOut()` qui permet de pousser 8 bits de données. Je teste en lui passant les pins que j'ai configurées pour la donnée d'entrée et pour la clock et vérifie que ça fonctionne bien. La fonction pousse les données mais ne met pas à jour la sortie, donc il faut toujours faire ça manuellement.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/shift.png"
            legend="La fonction shiftOut() permet de pousser 8 bits"
            width="50%"
        %}

    </div>

</div>


Je teste maintenant d'ajouter un registre. Je le place sur la breadboard à côté du premier, je connecte l'alimentation, `/OE` et `/SRCLR`. Je ne peux pas ajouter d'autres LEDs donc je laisse les 4 premières connectées au 4 premières sorties du premier registre, et je connecte les 4 dernières au 4 dernières sorties du second registre. Et au début, rien ne fonctionne. C'est parce que j'avais oublié de connecter les signaux `SER`, `RCLK` et `SRCLK` du premier registre sur le second. Une fois fait ça fonctionne bien. Je teste en poussant un `1` puis que des `0` pour voir avancer le `1`. Comme attendu il traverse les 4 premières LEDs, puis après un temps réapparait sur les 4 suivantes.


<div class="inline-image-container">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7408.JPG"
            legend="Montage avec deux registres"
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7410.mp4"
            legend="Déplacement d'un bit au travers de deux registres"
        %}

    </div>

</div>

Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-eeprom-programmer).


## Programmation de la ROM

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


## La puce d'entrées-sorties

Maintenant que je peux écrire dans la mémoire des programmes arbitrairement longs, le but est désormais d'ajouter des LEDs et des boutons pour pouvoir écrire et exécuter des programmes interactifs qui produisent des résultats directement observables sans instruments.

Le CPU seul n'est pas en mesure de piloter directement des LEDs et des boutons, car les seules choses qu'il peut faire directement c'est lire et écrire sur les bus d'adresse et de données. Pour piloter une LED ou lire un bouton il faut un système intermédiaire qui s'interface avec la LED ou le bouton d'un côté, et communique avec le CPU via le bus de l'autre côté.

Le [6522](https://eater.net/datasheets/w65c22.pdf) est une puce d'interfaçage conçue pour fonctionner avec le 6502. Son nom en anglais est *Versatile Interface Adatper*, je l'appelle donc "VIA" pour faire court. Le VIA propose plusieurs fonctions complémentaires, notamment des timers, mais ce qui nous intéresse ici ce sont les deux ports parallèles d'entrée-sortie. Il s'agit de 16 lignes qui peuvent être configurées individuellement en entrée ou en sortie, et qu'on va pouvoir lire ou écrire depuis le CPU.

Le VIA possède 16 registres de contrôle dans lesquel le CPU va lire ou écrire via le bus de données pour réaliser les fonctions souhaitées. Pour sélectionner le registre dans lequel on veut lire ou écrire, on utilise le bus d'adresse. Comme on a que 16 registres, 4 lignes d'adresse suffisent.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/w65c22 regs.png"
            legend="Liste des registres du 6522 (extrait de la datasheet)"
            width="70%"
        %}

    </div>

</div>


### Chip Select et espace d'adressage

Jusqu'à maintenant on avait qu'un seul composant connecté aux bus d'adresse et de données : l'EEPROM. On va maintenant ajouter le VIA, et il faut donc s'assurer que le CPU puisse communiquer avec chaque composant sans perturber les autres ou être perturbé par leur présence sur le bus. Pour ça on utilise le *Chip Select* (aussi appelé *Chip Enabled*). C'est un signal qui permet d'activer le composant avec lequel le CPU cherche à communiquer à un instant donné. Chaque composant possède une ou plusieurs entrée pour ce signal, et ne prennent le contrôle du bus que lorsque le signal les y autorise. Le reste du temps les pins connectées au bus sont électroniquement déconnectées du bus (dans ce qu'on appelle un *état de haute impédance*).

Pour déterminer quel composant doit être actif on utilise le bus d'adresses. Avec 16 lignes d'adresse le CPU peut produire 65 536 adresses différentes. Ces 65 536 adresses constituent ce qu'on appelle "l'espace d'adressage", et l'idée est de découper cet espace d'adressage en plusieurs plages et d'attribuer une plage à chaque composant. Pour ça on utilise des lignes d'adresse judicieusement choisies pour générer le signal Chip Select pour chaque composant.

Jusqu'à maintenant j'avais forcé le *Chip Select* (signal `/CE`) de l'EEPROM pour qu'elle soit toujours active. L'intégralité de l'espace d'adressage lui était par conséquent attribuée. La ROM possède seulement 15 lignes d'adresse (32k adressable), et on avait laissé la 16e ligne déconnectée. Par conséquent quand le CPU utilise une adresse dans la plage `0x0000-0x7FFF`, ça correspond directement à une adresse dans la ROM. Mais c'est également le cas pour les adresses `0x8000-0xFFFF` car si on ne prend en compte que les 15 premiers bits de l'adresses, les adresses sont identiques. Du point de vue du CPU le contenu de la ROM apparait dupliqué.

| Binaire | Hexadécimal
|-|-
| `0000 0000 0000 0000` | `0x0000`
| `0111 1111 1111 1111` | `0x7FFF`
| `1000 0000 0000 0000` | `0x8000`
| `1111 1111 1111 1111` | `0xFFFF`

La 16e ligne d'adresse (`A15`) étant inutilisée pour adresser les données dans la ROM, on peut l'utiliser pour le *Chip Select*. Si on la connecte directement sur l'entrée `/CE` de la ROM, étant donné que la puce est activée si le signal est à `0`, celle-ci ne répondra plus qu'aux adresse dans la plage `0x0000-0x7FFF`. On a ainsi alloué la plage `0x0000-0x7FFF` à l'EEPROM et libéré le reste pour d'autres composants. Cependant, rappelons-nous qu'au démarrage le CPU interroge les adresses `0xFFFC` et `0xFFFD` (vecteur reset), et dans cette configuration de la mémoire ça ne fonctionnerait pas. On pourrait rajouter un composant dont la tâche est de répondre spécifiquement à ces deux adresses, mais on devrait alors veiller à mettre à jour la valeur en fonction d'où on place le début du programme dans la ROM. Le plus simple est en fait d'allouer la plage `0x8000-0xFFFF` à la ROM. On peut faire ça en inversant `A15` (avec une porte logique NOT) avant de le connecter sur `/CE`. Ainsi l'adresse `0x7FFC` dans la ROM correspondra à l'adresse `0xFFFC` du point de vue du CPU. En revanche, l'adresse `0x0000` de la ROM se retrouve à l'adresse `0x8000` du point de vue du CPU. Il faudra donc être vigilant lors de l'écriture du programme.

On peut maintenant réfléchir à l'espace mémoire à allouer au VIA. On sait déjà que cette plage doit être comprise dans la plage `0x0000-0x7FFF`. On pourrait allouer toute la plage, et tant qu'on ajoute pas d'autres composants sur le bus ça ne pose pas de problème. Mais je prévois d'ajouter au moins une puce de RAM par la suite, donc essayons de faire mieux que ça. Pour rappel le VIA n'a que 16 registres, la plage d'adresse n'a donc besoin de contenir au minimum que 16 adresses. Elle peut évidemment être plus grande que ça.

Je commence à être à court de breadboards, et celles déjà utilisées sont déjà bien chargées, je voudrais donc une solution qui utilise un minimum de connexions et un minimum de composants. Le VIA possède deux signaux *Chip Select* : `CS1` et `/CS2`. La puce est activée lorsque `CS1` est à `1` et `/CS2` à `0`. On sait déjà que le VIA doit être désactivé lorsque la 16e ligne d'adresse (`A15`) est à `1`, puisque ça correspond à la plage allouée à la ROM. On peut donc connecter `A15` sur `/CS2`. Si on s'arrête là on a effectivement alloué la plage `0x0000-0x7FFF` au VIA. Imaginons maintenant qu'on branche `A14` sur `CS1`. Le VIA ne serait alors actif que lorsque la 16e ligne d'adresse (`A15`) est à `0` et la 15e (`A14`) est à `1`, ce qui correspond à la plage d'adresses `0x4000-0x7FFF`. Si on ajoutait `A13` avec un ET on réduirait à la plage `0x6000-0x7FFF`. Et si on ajoutait encore `A12` ça donnerait `0x7000-0x7FFF`. Plus on réduit la plage mémoire allouée et plus on laisse de l'espace pour autre chose, mais plus ça demande de logique pour le *Chip Select*.

| Binaire | Hexadécimal
|-|-
| `0000 0000 0000 0000` | `0x0000`
| `0100 0000 0000 0000` | `0x4000`
| `0110 0000 0000 0000` | `0x6000`
| `0111 0000 0000 0000` | `0x7000`
| `0111 1111 1111 1111` | `0x7FFF`
| `1000 0000 0000 0000` | `0x8000`
| `1111 1111 1111 1111` | `0xFFFF`

Je choisis de rester simple pour l'instant et de m'arrêter à `A14`. Ça permet de connecter `CS1` et `/CS2` diretement sans introduire de logique supplémentaire, et le compromis en terme d'allocation de l'espace d'adresse est ok pour l'instant.

Résumé des connexions à faire :

| Ligne d'adresse | Connexion
|-|-
| `A15` | `/CE` de la ROM via une porte NOT
| `A15` | `/CS2` du VIA 
| `A14` | `CS1` du VIA 


### Montage de la ROM

Je veux installer le VIA et la logique du *Chip Select* de manière semi permantente sur une grande breadboard que j'assemble avec celle du 6502, mais je n'ai plus de grande breadboard. J'en ai commandé des nouvelles, mais en attendant de les recevoir je fais un montage temporaire sur une petite breadboard, en faisant les connexion avec des lignes Dupont. Ça ne me laissera pas assez de Duponts pour monitorer les bus avec l'Arduino, mais tant pis.

Pour faire simple j'utilise une puce [74LS04](https://www.ti.com/lit/ds/symlink/sn74ls04.pdf) qui contient 6 inverseurs et je la place sur la breadboard du 6502 après l'espace réservé à la ROM. C'est temporaire car je prévoie de mettre la RAM à cet endroit par la suite. J'alimente le 74LS04, j'amène `A15` sur l'entrée du premier inverseur, je retire le fil de connexion qui maintenait `/CE` de la ROM à la masse, et je branche la sortie de l'inverseur à la place.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7422.JPG"
            legend="L'inverseur qui permet de générer le Chip Select pour la ROM"
            width="50%"
        %}

    </div>

</div>

Avant de passer à l'installation du VIA et immobiliser les fils de connexion, il faut reprogrammer la ROM. Pour éviter de reprogrammer si jamais ça ne fonctionne pas comme prévu du premier coup (ce qui demande pour l'instant de recâbler l'Arduino à chaque fois, ce n'est pas très pratique), j'essaie de faire un programme dont les effets sont reconnaissables sans ambiguité. J'imagine un programme qui allume 3 LED avec un motif alternatif `010-101`. Il n'est pas nécessaire de faire appel à un compteur ou un timer, avec une horloge suffisamment lente on verra le motif clignoter sans soucis même si les instructions se suivent directement sans délai.

C'est le moment de se pencher plus en détails sur le fonctionnement du VIA. Pour configurer les pins du port A en sortie il faut écrire dans le registre 3. Un bit à `1` dans ce registre configure le pin correspondant en sortie. Ensuite pour définir la valeur sur le pin il faut écrire dans le registre 1. Vue le mapping mémoire que nous avons fait précédemment, l'adresse à utiliser pour les registres 1 et 3 sont respectivement `0x4001` et `0x4003`.

Basiquement notre programme ressemble donc à ça :

1. écrire `1111 1111` (`0xFF`) à l'adresse `0x4003`
2. écrire `0000 0010` (`0x02`) à l'adresse `0x4001`
3. écrire `0000 0101` (`0x05`) à l'adresse `0x4001`
4. recommencer à 2.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/w65c22 regs 2.png"
            legend="Registres de contrôle des ports A et B du 6522 (extrait de la datasheet)"
            width="70%"
        %}

    </div>

</div>

En pseudo code machine ça donne ça :

1. `LDA #$FF`
2. `STA $4003`
3. `LDA #$02`
4. `STA $4001`
5. `LDA #$05`
6. `STA $4001`
7. `JMP $XXXX`

Explications: Pour écrire une valeur donnée dans un registre du VIA, on charge d'abord la valeur dans l'accumulateur, puis on envoie la valeur de l'accumulateur à l'adresse du registre. L'instruction `JMP` permet de déplacer le pointeur d'exécution à l'adresse indiquée. Ici on veut revenir à l'instruction `LDA #$02` pour former une boucle infinie. Pour définir l'adresse à donner à l'instruction `JMP` il faut connaître à quelle adresse exacte se situe l'instruction visée. Pour ça il faut :
- savoir à quelle adresse commence le programm dans la mémoire
- combien d'octets occupent les instructions qui précèdent
- prendre en compte l'allocation de l'espace d'adressage défini précédemment

Pour faire simple on peut placer le programme à l'adresse `0x0000` dans la mémoire, ce qui correspond à `0x8000` du point de vue du CPU. Il faudra donc penser à placer cette valeur dans le vecteur reset.

Nous avons déjà rencontré l'instruction `STA` précédemment. Le code correspondant est `0x8D`, et l'adresse est passée dans les deux octets suivants, les poids faibles en premier. Nous avons également déjà rencontré l'instruction `LDA`, mais nous avions utilisé la version qui prend une adresse, alors qu'ici nous voulons lui passer la valeur directement. On aurait pu mettre la donnée en mémoire et utiliser `LDA` avec l'adresse correspondante, mais pourquoi faire compliqué. Dans la datasheet on trouve que le code pour `LDA` en mode d'adressage immédiat est `0xA9`, et la valeur est indiquée dans l'octet qui suit. Regardons maintenant l'instruction `JMP`. Elle existe aussi dans plusieurs mode d'adressage, ici nous voulons le mode "adressage absolu" qui prend une adresse. Le code correspondant est `0x4C`, et l'adresse est indiquée sur les deux octets suivants, poids faibles en premier comme d'habitude.

Voici le programme final :

| Adresse CPU | Adresse ROM | Donnée
|-|-
| `0x8000`| `0x0000`| `A9 FF`
| `0x8002`| `0x0002`| `8D 03 40`
| `0x8005`| `0x0005`| `A9 02`
| `0x8007`| `0x0007`| `8D 01 40`
| `0x800A`| `0x000A`| `A9 05`
| `0x800C`| `0x000C`| `8D 01 40`
| `0x800F`| `0x000F`| `4C 05 80`
| `0xFFFC`| `0x7FFC`| `00`
| `0xFFFD`| `0x7FFD`| `80`

On voit que l'instruction `LDA #$02` si retrouve à l'adresse `0x8005`, c'est donc cette valeur qu'on donne au `JMP`. Je programme la ROM avec le setup défini précédemment, et je la remet en place sur le circuit.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/via.png"
            legend="Le programme de test du VIA écrit sur la ROM"
            width="70%"
        %}

    </div>

</div>

Avant d'installer le VIA je vérifie que le *Chip Select* fonctionne comme prévu et que le programme est bon. Je branche l'Arduino sur le bus et observe les données, toujours avec uniquement les 4 premières lignes d'adresse. Voici le résultat :

| Adresse théorique | Adresse observée | R/W | Donnée
|-|-|-
| `0xFFFc` | `0xc` | `R`| `0x00`
| `0xFFFd` | `0xd` | `R`| `0x80`
| `0x8000` | `0x0` | `R`| `0xa9`
| `0x8001` | `0x1` | `R`| `0xff`
| `0x8002` | `0x2` | `R`| `0x8d`
| `0x8003` | `0x3` | `R`| `0x03`
| `0x8004` | `0x4` | `R`| `0x40`
| `0x4003` | `0x3` | `W`| `0xff`
| `0x8005` | `0x5` | `R`| `0xa9`
| `0x8006` | `0x6` | `R`| `0x02`
| `0x8007` | `0x7` | `R`| `0x8d`
| `0x8008` | `0x8` | `R`| `0x01`
| `0x8009` | `0x9` | `R`| `0x40`
| `0x4001` | `0x1` | `W`| `0x02`
| `0x800a` | `0xa` | `R`| `0xa9`
| `0x800b` | `0xb` | `R`| `0x05`
| `0x800c` | `0xc` | `R`| `0x8d`
| `0x800d` | `0xd` | `R`| `0x01`
| `0x800e` | `0xe` | `R`| `0x40`
| `0x4001` | `0x1` | `W`| `0x05`
| `0x800f` | `0xf` | `R`| `0x4c`
| `0x8010` | `0x0` | `R`| `0x05`
| `0x8011` | `0x1` | `R`| `0x80`
| `0x8005` | `0x5` | `R`| `0xa9`
| `0x8006` | `0x6` | `R`| `0x02`
| `0x8007` | `0x7` | `R`| `0x8d`
| `0x8008` | `0x8` | `R`| `0x01`
| `0x8009` | `0x9` | `R`| `0x40`
| `0x4001` | `0x1` | `W`| `0x02`
| `0x800a` | `0xa` | `R`| `0xa9`
| `0x800b` | `0xb` | `R`| `0x05`
| `0x800c` | `0xc` | `R`| `0x8d`
| `0x800d` | `0xd` | `R`| `0x01`
| `0x800e` | `0xe` | `R`| `0x40`
| `0x4001` | `0x1` | `W`| `0x05`
| `0x800f` | `0xf` | `R`| `0x4c`
| `0x8010` | `0x0` | `R`| `0x05`
| `0x8011` | `0x1` | `R`| `0x80`

Tout est conforme.


### Montage du VIA

Je peux maintenant enfin installer le VIA. Je place le 6522 sur une petite breadboard, et je connecte tout de suite VDD et VSS. J'ajoute 3 LEDs à côtés avec leur résistance et je connecte les LEDs aux 3 premières sorties du port A. Je passe en revue le reste des pins. Il faut connecter :
- les 8 lignes de données (`D0` à `D7`)
- les 4 lignes adresses (`A0` à `A15`)
- le signal d'écriture/lecture (`/RW`)
- la clock (`PHI2`)
- le reset (`/RES`)
- `CS1` et `/CS2`

Nous n'utilisions pas le signal d'écriture/lecture (`/RW`) jusqu'à présent puisque la ROM n'est utilisée qu'en lecture. Mais le VIA peut-être utilisé en lecture et écriture, même si notre programme de test ne fait pour l'instant qu'écrire. Les signaux d'horloge et de reset peuvent être repris directement sur ceux du 6502. Je branche donc tout ça, l'Arduino fournit le signal d'horloge comme d'habitude.

Je lance, fait un reset, mais ça ne fonctionne pas, les diodes restent éteintes. Ça me laisse perplexe. Je teste d'abord les LEDs en amenant directement le 5V dessus et elles s'allument bien. J'observe ensuite les valeurs en sortie du VIA avec Arduino, et elles restent toutes à 0. De la même manière je vérifie les signaux `CS1`, `/CS2`, la clock, et `/RW`, et tout semble correcte. `/RW` est à `1` la plupart du temps pour indiquer une lecture, et passe à `0` de temps en temps pendant exactement un cycle. Idem pour `CS1` et `/CS2` qui prennent bien les valeurs attendues.

J'entreprends alors d'essayer de piloter le VIA directement avec l'Arduino pour vérifier que j'arrive à le faire fonctionner en envoyant manuellement des commandes et confirmer que le programme de test envoie bien les bonnes commandes. Sur la breadboard je force `/CS1` à `1`, `/CS2` à `0`, et `/RW` à `0`. Avec le code je fais un reset en mettant à `/RES` à `0` et en faisant quelques cycles d'horloge, puis j'envoie les octets pour configurer le port A, mais toujours rien de visible. J'essaie avec le port B et toujours rien. À ce moment je commence à soupçonner mon VIA d'être défectueux.

Je tente de lire les entrées sur les ports. J'ajoute `/RW` dans le code pour pouvoir lire/écrire, et je connecte directement le 5V sur une des pins d'entrées. Là je réalise que les LEDs sont toujours connectées au port A alors que je teste le port B. Je corrige ça et relance le test précédent mais toujours rien. Je fais le teste de lecture et je lis `0`. Ça me laisse vraiment perplexe.


<div class="inline-image-container">

    <div class="inline-image-container-row free-width mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7415.JPG"
            legend="Connection du VIA directement à l'Arduino"
        %}

        {% include inline-image-item.html
            url="/assets/projects/emulation/code_via_test.png"
            legend="Extrait du code de test du VIA"
        %}

    </div>

</div>

Le code Arduino est disponible [sur GitHub](https://github.com/alexbinary/arduino-6502).


## La bascule D

Pour essayer de générer de nouvelles idées je revisionne [la vidéo de Ben Eater sur le VIA](https://www.youtube.com/watch?v=yl8vPW5hydQ). Comme nous l'avons vu, la raison pour laquelle le 6502 ne peut pas piloter directement des périphériques est que les données envoyées sur le bus ne sont présentes que pendant un cycle d'horloge. Il faut donc quelque chose qui capture la donnée et la garde en mémoire. Dans des vidéos précédentes Ben Eater a expliqué comment construire des bascules de type RS ou D. Ce sont des circuits très simples qu'on peut réaliser avec quelques portes logiques et capables de mémoriser une donnée et la mettre à jour en fonction de différents signaux. La bascule RS prend en entrée un signal *set* qui active la sortie et un signal *reset* qui la désactive. La bascule D elle possède un signal de donnée et un signal d'horloge, et la donnée est capturée à chaque front montant de l'horloge. C'est exactement ce qu'il nous faut ici.

Je revisionne la [vidéo sur la bascule D](https://www.youtube.com/watch?v=peCh_859q7Q) et implémente le circuit sur une nouvelle petite breadboard. J'utilise un [74LS02](https://www.ti.com/lit/ds/symlink/sn74ls02.pdf) et un [74LS08](https://www.ti.com/lit/ds/symlink/sn74ls08.pdf) qui contiennent respectivement 4 portes NOR et 4 portes AND. Il y a pas mal de connexions à faire et il faut être vigilent car les pins ne sont pas disposées de la même manière sur les deux puces. Pour éviter de me tromper je dessine le schéma au brouillon et notes les pins à connecter. J'ajoute deux LEDs pour visualiser l'état de la sortie (une pour la sortie normale et une pour la sortie inversée).

Comme d'habitude je teste en contrôlant manuellement les signaux d'entrée. Au début ça ne fonctionne pas, mais c'est parce que j'avais oublié de connecter ensemble les deux rails d'alimentation de la breadboard, un oubli malheureusement courant. Une fois corrigé ça fonctionne parfaitement : sur un front montant du signal d'horloge, la donnée présentée sur le signal d'entrée est capturée sur la sortie. Modifier le signal d'entrée n'affecte pas la sortie tant que l'horloge ne bouge pas. Contrairement à un verrou (*latch* en anglais), qui met à jour la sortie continuellement tant que le signal *Enable* est à `1`, une bascule ne capture la donnée qu'à l'instant où l'horloge passe de `0` à `1`. Je confirme que c'est bien le cas chez moi.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/d-flip-flop.JPG"
            legend="Mon brouillon utilisé pour la réalisation du circuit"
        %}

    </div>
    
    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/sn74ls02.png"
            legend="Identification des pins du 74LS02"
        %}

        {% include inline-image-item.html
            url="/assets/projects/emulation/sn74ls08.png"
            legend="Identification des pins du 74LS08"
        %}

    </div>

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7416.JPG"
            legend="Bascule D réalisée sur breadboard"
        %}

    </div>

</div>

Le fonctionnement dans notre circuit sera le suivant : L'entrée de la bascule est connectée à une des 8 lignes du bus de données. Quand on veut changer l'état de la bascule, le CPU place la donnée à envoyer sur le bus de données. Ensuite, le signal d'horloge déclenche la capture de la donnée par la bascule. Si on s'arrête là, la bascule capture toute les données qui passent sur le bus, et le CPU n'a aucun moyen de l'en empêcher. Il faut ajouter un équivalent du *Chip Select* expliqué précédement, c'est-à-dire utiliser les lignes d'adresses pour n'activer la bascule que lorsque le CPU utilise une adresse qui lui est affectée. Avant de réfléchir à ça, je veux déjà tester que la bascule fonctionne bien avec le bus de données. Je vérifie dans la datasheet du 6502 que les données sont bien présentes sur le bus au moment du front montant de l'horloge, et c'est bien le cas. Ça devrait donc fonctionner.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/w65c02s timing.png"
            legend="Schéma des timing du 6502 (extrait de la datasheet)"
        %}

    </div>

</div>


Je branche donc l'entrée de la bascule sur la ligne `D0` du 6502 et le signal d'horloge sur `PHI2`. Je reprends le programme de test utilisé précédemment qui est encore dans la ROM et calcule ce qu'on devrait observer. Voici le résultat :

| Adresse | R/W | Données | D0
|-|
| `0xFFFC`| `R` | `00`	     | `0`
| `0xFFFD`| `R` | `80`	     | `0`
| `0x8000`| `R` | `A9 FF`	 | `1 1`
| `0x8002`| `R` | `8D 02 40` | `1 0 0`
| `0x4002`| `W` | `FF`	     | `1`
| `0x8005`| `R` | `A9 02`	 | `1 0`
| `0x8007`| `R` | `8D 00 40` | `1 0 0`
| `0x4000`| `W` | `02`	     | `0`
| `0x800A`| `R` | `A9 05`	 | `1 1`
| `0x800C`| `R` | `8D 00 40` | `1 0 0`
| `0x4000`| `W` | `05`	     | `1`
| `0x800F`| `R` | `4C 05 80` | `0 1 0`


J'alimente le circuits, et je vois tout de suite que la bascule s'anime, c'est bon signe. Je reset le CPU et j'observe attentivement. Après un reset le CPU prend 7 cycles d'horloge pour s'initialiser, on devrait donc voir la séquence prévue commencer 7 cycles après avoir lâché le bouton reset. Comme d'habitude c'est l'Arduino qui fournit le signal d'horloge et on peut utiliser le fait qu'il clignote à chaque changement d'état de l'horloge pour suivre l'exécution du programme. Ça demande un peu de concentration mais c'est très satisfaisant de constater que le bascule change d'état exactement aux moments prévus !

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7419.mp4"
            legend="La bascule capture tout ce qui passe sur le bus"
            width="50%"
        %}

    </div>

</div>

La bascule fonctionne donc bien mais pour l'instant elle capture tout ce qui passe sur le bus, ce qui n'est pas très utile. Il faut donc ajouter un peu de logique pour qu'elle ne capture que les données qui lui sont destinées. Pour pouvoir réutiliser le programme existant, je décide d'utiliser `A15` et `A14` pour pouvoir sélectionner l'adresse `0x4000`. Je prends aussi en compte le `/RW` pour ne répondre qu'aux commandes d'écriture. Dans notre cas ce n'est pas forcément nécessaire vu que la bascule ne peut que recevoir des données, pas en envoyer. L'idée est d'ajouter des portes logiques ET avec les signaux d'entrée de la bascule pour que le signal reçu par celle-ci ne passe que lorsque les bonnes conditions sont réunies. Ma première idée est de mettre le ET sur la donnée, mais je me rends vite compte que c'est une erreur. C'est le signal d'horloge qu'il faut bloquer, car c'est lui qui capture la donnée. L'idée c'est que la donnée en entrée va varier au gré de ce qui passe sur le bus, mais la bascule ne va capturer cette donnée que lorsque les signaux d'activation sont présents. Le reste du temps aucun signal de capture ne parvient à la bascule.

Si on résume, on veut donc que la capture ne se fasse que si toutes les conditions suivantes sont réunies :
- `A15 = 0`
- `A14 = 1`
- `/RW = 0`
- `PHI2 = 1`

Il faut donc connecter sur le signal de capture le résultat de l'expression suivante :

`CLK = /A15 ET A14 ET /RW ET PHI2`
{: style="text-align: center;"}

Je n'ai pas utilisé toutes les portes logiques disponibles sur les puces pour faire la bascule. Il reste 1 NOR et 2 AND, et si besoin on a encore 5 inverseurs sur le puce utilisée pour le *Chip Select* de la ROM. Voyons ce qu'on peut faire avec ça.

Voici la table de vérité de la porte NOR :

| `a` | `b` | `a NOR b`
|-|-|-
| `0` | `0` | `1`
| `0` | `1` | `0`
| `1` | `0` | `0`
| `1` | `1` | `0`

On constate que :

`a NOR b`
{: style="text-align: center;"}

est équivalent à :

`/a ET /b`
{: style="text-align: center;"}

Si on réarrange les termes de notre expression on peut écrire :

`CLK = (/A15 ET /RW) ET A14 ET PHI2`  
{: style="text-align: center;"}

En utilisant l'équivalence `NOR`/`ET` on peut transformer :

`CLK = (A15 NOR RW) ET A14 ET PHI2`
{: style="text-align: center;"}

On utilise ainsi une porte NOR et 2 portes ET, exactement ce qu'on a sous la main, c'est parfait. Je réalise le montage mais avant de tester je reprends le programme et détermine ce qu'on devrait observer. Cette fois la valeur de la bascule ne devrait changer que lorsque le CPU envoie une écriture sur une adresse comprise dans la plage `0x4000-0x7FFF`, ce qui donne ça :


| Adresse | R/W | Données | LED
|-|
| `0xFFFC`| `R` | `00`	     | `0`
| `0xFFFD`| `R` | `80`	     | `0`
| `0x8000`| `R` | `A9 FF`	 | `0 0`
| `0x8002`| `R` | `8D 02 40` | `0 0 0`
| `0x4002`| `W` | `FF`	     | `1`
| `0x8005`| `R` | `A9 02`	 | `1 1`
| `0x8007`| `R` | `8D 00 40` | `1 1 1`
| `0x4000`| `W` | `02`	     | `0`
| `0x800A`| `R` | `A9 05`	 | `0 0`
| `0x800C`| `R` | `8D 00 40` | `0 0 0`
| `0x4000`| `W` | `05`	     | `1`
| `0x800F`| `R` | `4C 05 80` | `1 1 1`


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



## La suite

Le 6502 peut désormais piloter une LED et changer son état selon la logique définie par le programme. Ça reste bien sûr limité mais c'est déjà un bon système simple à émuler. Mais avant, je voudrais rendre les choses encore un petit peu plus intéressantes en ajoutant la possibilité pour un utilisateur d'injecter des données dans le système via un bouton. L'idée est donc de créer cette fois un périphérique d'entrée, c'est-à-dire capable d'envoyer une donnée sur le bus lorsque le CPU le demande. Après ça je pourrai enfin créer des programmes interractifs et attaquer l'émulation à proprement parler.