---
layout: project
title: Rangement LEGO
topics: [LEGO, menuiserie]
image: /assets/projects/lego-storage-system/4.jpg
project_status: 'terminé ✅'
last_updated: 2025-10-31
lang: fr
lang_en: /en/projects/lego-storage-system
---

Depuis 2019 je tiens une [boutique en ligne de vente de pièces de LEGO](https://store.bricklink.com/alexbinary) sur la plateforme BrickLink. Les clients peuvent commander des pièces individuelles parmis plusieurs milliers de références uniques. Une bonne organisation du stock est donc critique. Au début j'utilisais une solution du commerce, elle m'a permis de démarrer mais elle a fini par montrer ses limites. J'ai alors entrepris de fabriquer une solution de rangement entièrement sur mesure.

Commençons par présenter la solution du commerce.

### Avantages et inconvénients de *Papi Max StackX Drawers*

*Papi Max StackX Drawers* est un produit qui s'adresse spécifiquement aux amateurs de LEGO, et qui promet notamment une forte densité de stockage.
Le système se présente sous la forme de modules individuels composés d'un boitier externe  dans lequel glisse un tiroir.
Les boitiers sont disponibles en blanc ou noir et peuvent s'empiler et s'assembler entre eux.
Les tiroirs sont transparents et équipés d'une poignée à l'avant.
Jusqu'à quatre cloisons peuvent être ajoutées dans la largeur et deux dans la longueur pour former jusqu'à 15 compartiments.

<div class="inline-image-container">
    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/papimax3.JPG"
            width="100%"
            legend="Les éléments individuels peuvent être empilés et assemblés entre eux librement"
            alt="Une photo montrant 20 modules assemblés en 4 piles de 3 et 2 piles de 4"
        %}

    </div>
    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/papimax1.jpg"
            width="100%"
            legend='Un conception "pressure free" permet aux tiroirs de coulisser dans leur boîtier même empilés'
            alt="Photo montrant plusieurs tiroirs Papimax ouverts"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/papimax4.jpg"
            width="100%"
            legend="Les séparateurs créent des compartiments"
            alt="Gros plan d'un tiroir Papimax ouvert montrant les séparateurs"
        %}

    </div>
</div>

[Un test détaillée du produit est disponible sur le site Brick Architect (en anglais)](https://brickarchitect.com/2019/review-papi-max-stackx-drawers/)

#### Les 👍

<ul class="plus">
<li>Vendu par éléments individuels, permettant de former une stucture globale de la taille et forme de son choix</li>
<li>Agencement interne ajustable</li>
<li>Possibilité de sortir complètement un tiroir pour l'emporter sur la zone de travail</li>
<li>Les tiroirs peuvent sortir quasiment jusqu'au bout permettant un accès facile à toute la surface</li>
</ul>

#### Les 👎

<ul class="minus">
<li>Impossible d'extraire un compartiment individuel pour l'amener sur la zone de travail ou vider son contenu (ça rend notamment très pénible le déplacement des pièces d'un compartiment à un autre)</li>
<li>Difficile de reconfigurer les cloisons quand les compartiments sont occupés</li>
<li>Les cloisons ne sont pas vérouillées et peuvent se soulever et laisser fuiter des pièces dans les compartiments voisins</li>
<li>Le tiroir se coince ou se bloque facilement s'il n'est pas manié avec rigueur</li>
<li>Le plastique transparent des tiroirs est sujet au jaunissement à la lumière du soleil</li>
<li>Prix élevé</li>
</ul>

Finalement, le système de cloisons amoviles était séduisant sur le papier mais peu pratique à l'usage.
Ajouté à ça, la basse qualité de construction et le prix élevé étaient prohibitifs pour continuer avec cette solution.


### Découpe LASER et boites modulaires

Courant 2021 j'ai eu l'occasion de me former à la découpe LASER dans un atelier partagé près de chez moi.
Après une séance de formation, j'ai commencé à expérimenter avec cette machine, et j'en ai vite saisi le potentiel pour fabriquer des boites qui pourraient servir de base à une solution de rangement sur mesure, où l'on peut emporter, déplacer et agencer à loisir des compartiments dans des tiroirs. 

<div class="inline-image-container">
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/laser1.jpg"
            legend="Prise en main de la découpe LASER"
            alt="Une photo montrant l'auteur dans une petite pièce occupée par une grosse machine"
            width="350"
            height="330"
        %}
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/laser2.jpg"
            legend="Première réalisation"
            alt='Une photo montrant une plaquette de bois dans laquelle est découpée une forme sur laquelle est gravé le mot "Alex"'
            width="350"
            height="330"
        %}

    </div>
</div>

Après avoir rapidement exploré différentes techniques d'assemblage et de construction des boites, je me suis fixé sur un assemblage par <b>créneaux serrés</b>.
En ajustant bien la taille relative des créneaux il est possible d'assembler les pièces au maillet et ça tient parfaitement sans colle.
Une solution simple comme j'aime.

<div class="inline-image-container">
    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_5.png"
            width="60%"
            legend="Technique d'assemblage par créneaux"
            alt="Un dessin illustrant deux pièces dans lequelles sont découpées des encoches complémentaires permettant un assemblage"
        %}
    </div>
</div>

L'idée ensuite était de faire un système des boites modulaires que l'on peut agencer à loisir dans des grands tiroirs. Ce système permet d'emporter, de déplacer, et de vider facilement les compartiments.

J'ai calqué la taille des premières boites sur la taille des compartiments précédents, ce qui donne une boite carré de 75mm de côté.
Une boite avec ces dimensions peut accueillir une pièce de LEGO de 8 unités de long avec juste ce qu'il faut de marge.
Pour la hauteur j'ai voulu respecter le ratio des briques LEGO, en considérant que ma boite était équivalente à une brique de 2x2.
Les experts de la brique danoise savent que la hauteur d'une brique 2x2 est égale à 3/5e de sa largeur.
Pour une boite de 75mm de côté on arrive donc à une hauteur de 75*3/5 = 45mm.
Je trouvais ça trop haut, alors j'ai enlevé un tier (ce qui dans le monde LEGO correspond à passer de la hauteur d'une brique à la hauteur de deux plaques) ce qui donne 30mm.
Je trouve que c'est le ratio parfait.

Partant de là, en partant du principe que ma boite de base fait 2x2 unités de large et 2 plaques de haut, j'ai expérimenté avec tout un tas de variantes en 1x1, 1x2, 2x3, 2x4, 3x3, etc en version 1, 2, 3 ou 4 plaques de hauteur. 

<div class="inline-image-container">
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites2.jpg"
            legend="Pièces de boites tout juste découpées"
            alt="Une photo montrant une planche de bois encore dans la machine de découpe juste après la fin du travail. Une centaine de pièces de différents format sont découpées dans un agencement optimisé qui laisse très peu de chutes (ce n'était pas toujours aussi beau :p)"
            width="350"
            height="330"
        %}
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites1.jpg"
            legend="Pièces de boites prêtes à être assemblées"
            alt="Une photo montrant 4 piles de pièces de boite de format différents"
            width="350"
            height="330"
        %}

    </div>
    
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/7.jpg"
            legend="Différents modèles de boites assemblées"
            alt="Une photo montrant 4 boites empilées les unes sur les autres, les deux du dessous sont larges, les deux du dessus sont plus petites, à chaque fois il y a une haute et une plus fine"
            width="350"
            height="330"
        %}
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/9.jpg"
            legend="D'autres variantes de boites"
            alt="Une photo montrant une vingtaine de boites. Certaines sont étroites et hautes, d'autres plus longues et basses."
            width="350"
            height="330"
        %}

    </div>
</div>

Je me suis vite rendu compte que les modèles de grande taille et faible hauteur sont utiles en tant que plateau pour contenir des pièces lors de constructions par exemples.
J'en ai fait des plus grands, que j'utilise encore couramment aujourd'hui.

### Des tiroirs pour ranger les boites

Quand j'ai commencé à avoir un certain nombre de boites en vrac, le besoin d'un niveau supérieur de rangement s'est fait sentir. J'ai commencé par expérimenter avec un système de modules semblables au *Papi Max*, avec la même technique de fabrication en découpe LASER que pour les boites. Ce n'était pas parfait mais c'était très encourageant et ça m'a motivé à continuer.

<div class="inline-image-container mobile-only">
    <div class="inline-image-container-row mobile-column" id="casier">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/casier1_3.jpg"
            legend="Premiers tiroirs en découpe LASER"
            alt="Une photo montrant les tiroirs fermés, on voit bien les modules individuels qui hébergent chaque tiroir"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/casier2_1.jpg"
            legend="Chaque tiroir coulisse dans son module"
            alt="Une photo montrant 5 tiroirs découpés au LASER partiellement ouverts"
        %}
        
    </div>
</div>

<div class="inline-image-container desktop-only">
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/casier1_3.jpg"
            legend="Premiers tiroirs en découpe LASER"
            alt="Une photo montrant les tiroirs fermés, on voit bien les modules individuels qui hébergent chaque tiroir"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/casier2_2.jpg"
            legend="Chaque tiroir coulisse dans son module"
            alt="Une photo montrant 5 tiroirs découpés au LASER partiellement ouverts"
        %}
        
    </div>
</div>

Pour la suite, je voulais une sensation de qualité à l'ouverture et fermeture des tiroirs.
C'était important pour moi.
Je voulais que mes tiroirs donnent une impression de solidité et de qualité,
avec une ouverture et fermeture fluide,
sans pencher à mesure que le tiroir s'ouvre,
et sans peur de déloger le tiroir si on ouvre un peu trop vite.
Je voulais aussi que les tiroirs puissent s'ouvrir sur la totalité de la profondeur pour permettre d'accéder même aux boites du fond.

Après quelques recherches j'ai trouvé un modèle de glissières à sortie totale sur Amazon, disponible en plusieurs longueurs, et qui semblait répondre à mes exigences de qualité.

<div class="inline-image-container">
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="https://m.media-amazon.com/images/I/61StOmAlP4L._AC_SX425_.jpg"
            legend='Glissières à sortie totale trouvées sur <a href="https://www.amazon.fr/dp/B08596LKYP">Amazon</a>'
            alt="Une photo montrant une paire de glissières métalliques"
            width="40%"
        %}

    </div>
</div>

Après quelques expérimentations avec les glissières, j'ai fabriqué un premier prototype de meuble avec du contreplaqué de peuplier de 10mm.
J'ai découpé les pièces avec une scie sauteuse mais le résultat était très moyen.
Rien n'était vraiment droit, et l'ouverture/fermeture des tiroirs n'était pas fluide
et les tiroirs ouverts entraient en collision.

L'atelier partagé qui héberge la découpe LASER possède également un atelier bois.
Après avoir fait les formations nécessaires, 
j'ai entrepris un second prototype, en utilisant cette fois la scie circulaire sur table.
Le résultat était nettement meilleur.

<div class="inline-image-container">
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/15.jpg"
            legend="Premiers essais avec les glissières"
            alt="Une photo montrant une glissières avec une pièce de bois fixée sur la partie fixe et la partie mobile"
        %}
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/13.jpg"
            legend="Premier prototype fonctionnel"
            alt="Une photo d'un petit meuble comprenant 5 tiroirs. Le tiroir du bas est grand ouvert révélant que l'intérieur est aménagé avec des boites carrés dans une grille 5x5"
        %}

    </div>
</div>

### Des vrais grands meubles

J'avais un prototype qui me plaisait beaucoup et j'avais maintenant très envie de continuer en faisant des meubles plus grands.
J'ai commencé par faire un meuble deux fois plus large sur le même modèle que le prototype.
Mis à part que les fonds de tiroirs s'affaissaient sous la charge, ça fonctionnait bien et ça m'a motivé à continuer.

Pour le meuble suivant j'ai vu grand tout de suite: 15 tiroirs + 1 tiroir double hauteur pour des pièces plus volumineuses.
Mis à part les façades, tout a été réalisée en matériaux de récupération.
Par rapport au modèle précédent j'ai ajouté une cloison qui coupe le tiroir en deux pour maintenir le fond.

<div class="inline-image-container">
    <div class="inline-image-container-row mobile-column">
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/menuiserie2.jpg"
            legend="Beaucoup de pièces à découper pour ce meuble"
            alt="Une photo montrant plusieurs groupes de pièces de bois découpées à l'identique"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/meuble1.jpg"
            legend="Montage en cours..."
            alt="Une photo d'un meuble partiellement terminé. Les 16 tiroirs manquent encore leur fond et leur façade"
        %}

    </div>
</div>


### Bilan et perspective

Je dispose aujourd'hui d'un total de 5 meubles de différentes capacités que j'utilise au quotidien pour ranger mes pièces de LEGO pour ma boutique en ligne.
Le système des boites modulaires permet d'emporter, déplacer et agencer à loisir les compartiments dans les tiroirs. L'ouverture des tiroirs est fluide, sans effort et donne une impression de qualité que j'aime beaucoup.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/1.jpg"
            height="250"
            legend="L'ensemble complet que j'utilise aujourd'hui"
            alt="Une photo montrant un empilement composé de bas en haut d'un grand meuble de 16 tiroirs, deux meubles de 5 tiroirs, et deux petits meubles demie largeur de 5 tiroirs chacun"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/4.jpg"
            height="250"
            legend="Vue de l'intérieur d'un tiroir"
            alt="Une photo montrant l'intérieur d'un tiroir divisé en deux partie, chacun remplie de boites de différents formats contenant des pièces de LEGO en différentes tailles et quantité agencées sur une grille bien définie"
        %}

    </div>
</div>

J'ai toujours besoin de plus de place de rangement,
et je prévois de fabriquer encore d'autres meubles,
en cherchant toujours à améliorer la conception.
J'aimerais réussir à aligner mieux les tiroirs entre eux.
J'aimerais aussi trouver une solution au fait que les glissières ne permettent pas au tiroir de sortir plus que sa profondeur,
ce qui rend encore l'accès aux boites du fond difficile,
surtout quand il y a la poignée du tiroir du dessus juste au dessus.

Pour les prochains meubles je voudrais essayer d'ajouter une grande illustration qui s'étale sur les façades des tiroirs.

Je réflechis aussi à faire des modules à insérer dans des étagères IKEA de type Kallax.