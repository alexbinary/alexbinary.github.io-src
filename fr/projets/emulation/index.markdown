---
layout: project
title: Emulation matérielle
topics: [emulation, electronique, programmation, 6502]
image: /assets/projects/emulation/IMG_7377.JPG
project_status: 'en cours 🧑‍💻'
project_github: https://github.com/alexbinary/arduino-6502
last_updated: 2026-06-06
lang: fr
lang_en: /en/projects/emulation
---

Je joue régulièrement à des jeux vidéo sur émulateur et je comprends dans les grandes lignes le principe de l’émulation mais j'ai envie d'en apprendre plus et de "mettre les mains dedans". J'aimerais bien savoir écrire un émulateur de GameBoy, et c'est probablement faisable avec suffisamment de patience, mais j'aime commencer par la base. Et la base c'est : "Au fond, l'émulation, c'est quoi ?"

Je suis en train de construire un système matériel simple que je peux programmer, avec pour projet d'écrire un émulateur pour ce système. J'utilise le processeur 6502, des boutons et des LEDs, et peut-être à terme un écran. Pour l'instant j'en suis à me familiariser avec le 6502 et divers composants annexes.


## Comprendre l'émulation

Prenons l'exemple de la GameBoy. Un jeu de GameBoy est un programme conçu pour être lu par le hardware de la GameBoy dans le but de produire des images et du son en fonction des actions de l'utilisateur sur les boutons. Le but d'un "émulateur de GameBoy" est de prendre en entrée ce programme et de recréer l'expérience de jeu sur un PC, c'est-à-dire de générer son et image en fonction des actions de l'utilisateur, mais sur une stack matérielle complètement différente.

Le but quand on écrit un émulateur est de comprendre l'effet de chaque instruction du programme sur le matériel d'origine et de recréer un résultat global fidèle sur le nouveau hardware. Écrire un émulateur demande donc de bien connaître le hardware d'origine et l'interraction hardware/software, mais il ne s'agit pas nécessairement de reproduire fidèlement le fonctionnement interne du matériel. Ce qui compte c'est le résultat *observable*.

Pour mettre en pratique ces réflexions et les confronter à la réalité, mon but est de créer de zéro un système matériel simple qui puisse être programmé, et ensuite écrire un émulateur pour ce système. Créer le système matériel à émuler permet d'avoir une référence précise et permet de comparer l'exécution des programmes et valider l'émulateur. Si j'écris l'émulateur en "imaginant" le hardware émulé, qu'est-ce qui me permet de dire que le résultat est juste ?


## Le choix du hardware

J’ai choisi de construire un système basé sur le microprocesseur 6502. Le 6502 est un microprocesseur relativement simple idéal pour débuter. Il est aussi très célèbre puisque c'est le processeur utilisé par de nombreux appareils grand public des années 1980, notamment l’Apple II, le Commodore 64 et l'Atari 2600. Des versions modernisées sont toujours en production aujourd'hui et il existe une large communauté de passionnés.

Mon objectif est de créer un système capable d’exécuter un programme assembleur et de produire un résultat observable en fonction d'actions de l'utilisateur. De simples boutons feront l'affaire pour les actions utilisateurs, et dans un premier temps je prévois d'utiliser quelques LEDs pour les sorties. Par la suite j'essairai peut-être d'incorporer un écran OLED que j'ai en stock, ça permettrait de se rapprocher d'une console de jeu 🎮.


## Premiers pas avec le 6502

Le 6502 est un microprocesseur, et sa fonction principale est donc d'exécuter des instructions. Contrairement à un microcontrôleur, il n'a aucune mémoire interne et aucun périphérique. Il interragit avec le monde extérieur via un bus de données et un bus d'addresse, sur lesquels il peut lire et écrire des données. Les instructions à éxécuter, les données à traiter, et les données produites, tout passe par le bus. En général on connecte sur le bus une mémoire qui contient le programme et les données de travail, et des périphérique comme un afficheur, une carte son, etc.

Pour commencer en douceur je suis la [série de vidéos de Ben Eater consacrée à la construction d’un ordinateur basé sur le 6502](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH). Je commence par installer le 6502 sur une breadboard, je connecte l'alimentation et les signaux de contrôle de base, et j'ajoute un bouton reset. Le signal d’horloge est généré par un module basé sur un circuit 555 que j’ai construit précédemment en suivant les [vidéos de Ben Eater sur le sujet](https://www.youtube.com/watch?v=kRlSFm519Bo). J'utilise un Arduino Uno comme source d'alimentation et pour faire des observations par la suite.

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


## Données dynamiques

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


## Utilisation d'une EEPROM

L'Arduino est bien sympatique, mais dans le système final les données sont stockées dans une puce mémoire. J'utilise ici une puce EEPROM de 32ko. C'est une mémoire destinée à être utilisée en lecture seule, mais qu'on peut effacer et programmer éléctroniquement.

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


## Connexion au 6502

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


## La suite

Je veux maintenant connecter la ROM au 6502 de manière un peu plus permanente sur la même breadboard, câbler toutes les lignes d'adresse et de données, ainsi que la logique d'activation de la puce. Pour ça il sera utile de pouvoir programmer l'intrégralité de la mémoire disponible, et j'ai quelques idées à ce sujet. Après ça je pourrais commencer à installer la puce d'entrées-sorties qui permettra d'avoir enfin des résultats observables.