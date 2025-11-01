---
layout: project
title: Rangement LEGO
topics: [LEGO, menuiserie]
image: /assets/projects/lego-storage-system/4.jpg
project_status: 'terminé ✅'
last_updated: 2025-10-31
lang: fr
---

Depuis 2019 je tiens une [boutique de vente de pièces en ligne](https://store.bricklink.com/alexbinary) sur la plateforme BrickLink. Les clients peuvent commander des pièces individuelles parmis plusieurs milliers de références uniques. Une bonne organisation du stock est donc critique. Au début j'utilisais une solution du commerce, elle m'a permis de démarrer mais elle a fini par montrer ses limites. J'ai alors entrepris de fabriquer une solution de rangement entièrement sur mesure.

### Papi Max StackX Drawers: Avantages et inconvénients

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
            legend="Individual elements can be stacked and connected together"
            alt="An image of a setup composed of multiple Papimax drawers"
        %}

    </div>
    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/papimax1.jpg"
            width="100%"
            legend="Drawers slide from their case"
            alt="An image of a multiple Papimax drawers open"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/papimax4.jpg"
            width="100%"
            legend="Use separators to create compartments"
            alt="A close up image of an open Papimax drawer showcasing the separators"
        %}

    </div>
</div>

[Un test détaillée du produit est disponible sur le site Brick Architect](https://brickarchitect.com/2019/review-papi-max-stackx-drawers/)

#### Les 👍

<ul class="plus">
<li>Vendu par éléments individuels, permettant de former une stucture globale de la taille et forme de son choix</li>
<li>Agencement interne ajustable</li>
<li>Possibilité de sortir complètement un tiroir pour l'emporter sur la zone de travail</li>
<li>Les tiroirs peuvent sortir quasiment jusqu'au bout permettant un accès facile à toute la surface</li>
</ul>

#### Les 👎

<ul class="minus">
<li>Impossible d'extraire un compartiment individuel pour l'amener sur la zone de travail ou vider son contenu. Ça rend notamment très pénible le déplacement des pièces d'un compartiment à un autre</li>
<li>Reconfigurer les cloisons demande de vider entièrement le tiroir</li>
<li>Les cloisons reposent par gravité et ne sont pas vérouillées.
Avec les manipulations du tiroir elles se soulèvent et laissent fuiter des pièces dans les compartiments voisins</li>
<li>Il arrive souvent que le tiroir se coince ou se bloque s'il n'est pas manié avec rigueur</li>
<li>Le plastique transparent des tiroirs est sujet au jaunissement à la lumière du soleil</li>
<li>Prix élevé</li>
</ul>

Finalement, le système de cloisons amoviles était séduisant sur le papier mais peu pratique à l'usage.
Ajouté à ça, la basse qualité de construction et le prix élevé étaient prohibitifs pour continuer avec cette solution.


### Une solution DIY sur mesure

Ma solution repose sur un système des boites modulaires que l'on peut emporter, déplacer et agencer à loisir dans des grands tiroirs. L'ouverture des tiroirs est fluide, sans effort et donne une impression de qualité.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/1.jpg"
            height="250"
            legend="Un ensemble de meubles"
            alt="A picture showing multiple pieces of furniture stacked"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/4.jpg"
            height="250"
            legend="Des casiers dans les tiroirs"
            alt="A picture showing the compartments inside a drawer"
        %}

    </div>
</div>

Le développement s'est fait par exploration progressive.
J'ai commencé par développer les boites puis les tiroirs pour les ranger.


### Développement des boites

Courant 2021 j'ai eu l'occasion de me former à la découpe LASER dans un atelier partagé près de chez moi.
Après une séance de formation, j'ai commencé à expérimenter avec cette machine, et j'en ai vite saisi le potentiel pour fabriquer des boites qui pourraient servir de base à une solution de rangement sur mesure.

Après avoir rapidement exploré différentes techniques d'assemblage et de construction des boites, je me suis fixé sur un assemblage par <b>créneaux serrés</b>.

<div class="inline-image-container">
    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_5.png"
            width="60%"
            legend="Technique d'assemblage par créneaux"
            alt="A drawing showing how two pieces can be assembled with finger joints"
        %}
    </div>
</div>

J'ai calqué la taille des premières boites sur la taille des compartiments du système de rangement que j'utilisais à l'époque, soit une boite carré de 75mm de côté.
Une boite avec ces dimensions peut accueillir une pièce de LEGO de 8 unités de long avec juste ce qu'il faut de marge.
Pour la hauteur j'ai voulu respecter le ratio des briques LEGO, en considérant que ma boite était équivalente à une brique de 2x2.
Les experts de la brique danoise savent que 2 unités LEGO correspondent à 5 hauteurs de plaque, et la hauteur d'une brique fait 3 plaques de haut.
Pour une boite de 75mm de côté on arrive donc à une hauteur de 75*3/5 = 45mm.
Je trouvais ça trop haut, alors je suis descendu à 2 plaques au lieu de 3, soit 30mm.
Je trouve que c'est le ratio parfait.

Partant de là, en partant du principe que ma boite de base fait 2x2 unités de large et 2 plaques de haut, j'ai expérimenté avec tout un tas de variantes en 1x1, 1x2, 2x3, 2x4, 3x3, etc en version 1, 2, 3 ou 4 plaques de hauteur. Je me suis vite rendu compte que les modèles de grande taille et faible hauteur sont utiles en tant que plateau pour contenir des pièces lors de constructions par exemples.
J'en ai fait des plus grands, que j'utilise encore couramment aujourd'hui.


<div class="inline-image-container">
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/7.jpg"
            legend="Des boites"
            alt="A picture showing a few boxes stacked"
            width="350"
            height="330"
        %}
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/9.jpg"
            legend="Encore des boites"
            alt="A picture showing more boxes stacked"
            width="350"
            height="330"
        %}

    </div>
</div>

### Développement des meubles

Quand j'ai commencé à avoir un certain nombre de boites en vrac, le besoin d'un niveau supérieur de rangement s'est fait sentir. J'ai alors développé progressivement des meubles à tiroirs pour ranger les boites. J'ai expérimenté avec différents designs et techniques de fabrication, et j'ai aujourd'hui un ensemble de 5 meubles dont je me sers au quotidien. Une partie a été réalisée en matériaux de récupération.

La sensation de qualité à l'ouverture et fermeture des tiroirs était un critère important pour moi.
Je voulais que mes tiroirs donnent une impression de solidité et de qualité,
avec une ouverture et fermeture fluide,
sans pencher à mesure que le tiroir s'ouvre,
et sans peur de déloger le tiroir si on ouvre un peu trop vite.
Je voulais aussi que les tiroirs puissent s'ouvrir sur la totalité de la profondeur pour permettre d'accéder même aux boites du fond.

Après avoir trouvé et commandé des glissières métalliques à sortie totale sur Amazon,
j'ai fabriqué un premier prototype de meuble avec du contreplaqué de peuplier de 10mm.
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
            alt="A picture showing a few boxes stacked"
        %}
        
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/phase1/13.jpg"
            legend="Premier prototype fonctionnel"
            alt="A picture showing more boxes stacked"
        %}

    </div>
</div>

Je suis ensuite passé à la vitesse supérieure en créant un meuble deux fois plus large, puis un meuble comprenant 16 tiroirs, dont un double hauteur pour des pièces plus volumineuses.
Pour éviter que le fond ne s'affaisse, j'ai ajouté une cloison qui coupe le tiroir en deux parties et permet de maintenir le fond.


## Bilan et perspective

Je dispose aujourd'hui d'un total de 5 meubles de différentes capacités que j'utilise au quotidien pour ranger mes pièces de LEGO pour ma boutique en ligne.

J'ai toujours besoin de plus de place de rangement,
et je prévois de fabriquer encore d'autres meubles,
en cherchant toujours à améliorer la conception.
Le positionnement des tiroirs n'est toujours pas idéal sans exploser le budger en temps d'usinage.

Aussi, les glissières actuelles ne permettent pas au tiroir de sortir plus que sa profondeur,
ce qui rend encore l'accès aux boites du fond difficile,
surtout quand il y a la poignée du tiroir du dessus juste au dessus.

Pour les prochains meubles je voudrais essayer d'ajouter une grande illustration qui s'étale sur les façades des tiroirs.

Je réflechis aussi à faire des modules à insérer dans des étagères IKEA de type Kallax.

--