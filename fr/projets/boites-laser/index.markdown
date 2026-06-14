---
layout: project
project_id: 13e81415-87f9-4500-9021-e1a646c46b8f
title: Boites en découpe LASER
topics: [decoupelaser]
image: /assets/projects/lego-storage-system/boites1.jpg
last_updated: 2026-05-28
lang: fr
lang_en: /en/projects/laser-boxes
---

Courant 2021 je cherchais à remplacer la solution commerciale que j'utilisais pour ranger ma collection de pièces de LEGO. J'ai eu l'occasion de me former à la découpe LASER dans un atelier partagé près de chez moi, et j'ai vite saisi le potentiel pour fabriquer des boites qui pourraient servir de base à une solution de rangement sur mesure.

J'ai commencé par explorer différentes techniques et designs avant de m'arrêter sur un système de créneaux serrés. Cette technique est devenue la base de nombreuses créations bien au-delà du rangement de LEGO.

{% comment %}
Pour faciliter la conception des différentes pièces j'ai codé un outil pour générer les tracés de découpe.
{% endcomment %}

Revenons au début.


## Plier du bois

Je voulais des boites qui soient les plus fines possible afin de maximiser l'espace disponible pour les pièces. J'ai commencé par chercher des matériaux et j'ai trouvé des chutes de contreplaqué de peuplier de 1mm d'épaisseur dans une boutique de modélisme. Parfait pour commencer.

Comme je voulais utiliser un minimum de colle, j'ai commencé à réfléchir à différentes méthodes pour fabriquer des boites en utilisant au maximum le pliage pour limiter le nombre de jointures à réaliser.

Pour plier du bois j'ai d'abord pensé à faire une rainure de sorte à laisser juste une faible épaisseur de matériau, suffisament pour qu'il puisse être plié. Bien que possible en théorie avec la découpe LASER, ça me paraissait délicat à réaliser.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_1.png"
            legend="Technique de la rainure pour plier du bois"
        %}

    </div>
    
</div>

Une technique commune consister à réaliser des découpes parallèles alternées. Ça augmente la souplesse générale de la pièce et permettant de la courber.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_2.png"
            legend="Technique des découpes alternées, aussi appelé 'pliage spring'"
        %}

    </div>

</div>

J'ai expérimenté avec la technique des découpes alternées en variant l'espacement des lignes. Plus les lignes sont proches et plus la pièce est souple, jusqu'à se plier simplement sous l'effet de la gravité. 

La technique me semblait prometteuse et j'ai commencé à imaginer des designs de boites exploitant cette technique. 


## Design enroulé

La première idée utilisait un fond avec coins arrondis autour duquel vient s'enrouler une bande de bois judicieusement assouplie avec les découpes alternées dans les coins.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_7.png"
            legend="Design enroulé"
        %}

    </div>

</div>

Ce design utilise deux pièces et deux assemblages sont nécessaires. Le premier pour lier le fond au tour, et l'autre pour "boucler" la pièce du contour. J'envisageais le recours à la colle pour les deux.

L'assemblage du fond est critique puisqu'il doit soutenir le poid du contenu de la boite, et s'il était amené à se rompre on perdrait le contenu de la boite.

L'assemblage du tour quant à lui devait lutter contre la tendance des coins à se remettre à plat, et un simple collage bout-à-bout me semblait avoir peu de chance de résister longtemps. Pour améliorer ça j'ai imaginé une solution qui consiste à réduire l'épaisseur sur l'extrémité des deux pièces et de les coller l'une sur l'autre. On peut aussi diviser en plusieurs petites zones et alterner le sens.

<div class="inline-image-container mobile-column">

    <div class="inline-image-container-row">
    
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_3.png"
            legend="Technique du recouvrement"
        %}

    </div>

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_4.png"
            legend="Technique du recouvrement croisé"
        %}

    </div>
    
</div>


## Design en panier

La deuxième idée exploitant le pliage était de former une sorte de panier, avec une pièce pliée en U et deux pièces latérales.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">
    
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_6.png"
            legend="Design en panier"
        %}

    </div>
    
</div>

Ce design nécessite six assemblages en angle. En alternative à la colle j'ai envisagé un mélange de la technique de pliage par rainure et de l'assemblage par recouvrement, que j'appelle "languette pliée" sur les schémas.

Une variante du panier consiste à faire une étoile, où les quatre côtés se plient à partir du fond. Cette solution réduit le risque de rupture au niveau entre le fond et les côtés.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">
    
        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_8.png"
            legend="Design en étoile"
        %}

    </div>
    
</div>

La conception en étoile pose un problème géométrique intéressant sur la forme à donner aux pièces dans les coins du bas. Pour déterminer la forme j'ai modélisé l'assemblage dans Blender. J'ai commencé par créer deux quarts de cylindre que j'ai disposé en angle à 90°, puis j'ai ajusté les points des extrémités pour que les formes se touchent sans se croiser. Ensuite j'ai dupliqué les pièces et je les ai "déplié" en appliquant une rotation à chaque arrête pour obtenir une forme plate.

<div class="inline-image-container force-desktop-full-width">
    
    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_10.png"
            legend="Vue 3D de l'angle avec les pièces dépliées"
            height="250"
        %}

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_11.png"
            legend="Vue du dessus"
            height="250"
        %}

    </div>

</div>


## Design en créneaux

Finalement, j'ai testé la technique classique des créneaux, où l'on fait plusieurs encoches complémentaires dans les deux pièces à assembler, et on colle.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_5.png"
            legend="Technique d'assemblage par créneaux"
        %}

    </div>

</div>

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/lego-storage-system/boites_v1/boites_v1_9.png"
            legend="Design classique"
        %}

    </div>

</div>

J'ai réalisé un test avec cette technique sur le contreplaqué de 1mm d'épaisseur que j'avais trouvé au magasin de modélisme. J'ai dessiné les cinq pièces dans Inkscape et exporté a format DXF pour la machine. La découpe et l'assemblage ont fonctionné comme prévus mais au final je me suis rendu compte que la faible épaisseur du bois rendait la boite trop fragile. Je suis alors passé sur du contreplaqué de 3mm d'épaisseur. En ajustant les largeurs relatives des créneaux j'ai pu obtenir un assemblage serré qui tient sans colle.

Et finalement c'est avec cette technique que j'ai réalisé toutes les boites par la suite.



{% comment %}


Là je me suis dit qu'en ajustant les largeurs relatives des créneaux on pourrait sûrement obtenir un assemblage serré qui tient sans colle. Pour expérimenter plus facilement j'ai codé un script, d'abord en Javascript puis en Swift, pour générer les tracés au format SVG à partir de paramètres d'entrée.


## Développement des créneaux

Je dessine les patrons en SVG avec Inkscape, et je peux ensuite les importer dans le logiciel de la découpe LASER.
J'ai vite senti que dessiner les créneaux à la main ne serait pas viable, surtout si je veux tester différents paramètres.
J'ai donc cherché à automatiser la tâche.

SVG est un format texte basé sur XML qui décrit les formes et les tracés via différentes instructions en utilisant un système de coordonnées numériques. Voici un exemple :

{% highlight svg %}
<svg viewBox="0 0 100 100" >
    <path
        style="fill:none;stroke:#000000;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
        d="M 10 10 ..."
    />
</svg>
{% endhighlight %}

Les instructions de tracé se trouvent dans le paramètre `d`.

Pour faire simple au début, j'ai enrepris d'écrire un script capable de générer une séquence d'instructions.
Je peux ensuite intégrer cette séquence dans le fichier SVG en mode texte.

J'ai utilisé Javascript pour écrire le script, et une fonction qui génère une ligne de créneaux à partir de paramètres que je peux ajuster facilement.

{% highlight js %}
let lengthAxis = "h"
let depthAxis = lengthAxis == "h" ? "v" : "h"
let totalLength = 40;
let ncren = 5;
let crenLength = totalLength/(2*ncren);
let crenDepth = 1;
let crenDirection = 1 // +/-1 to flip cren side
let lengthAdjust = 0 // positive value widens the crens
let depthAdjust = +0.15  // in the depth direction 

let startMove = lengthAxis+" "+(crenLength/2-lengthAdjust/2);
let crenMove = depthAxis+" "+crenDirection*(crenDepth+depthAdjust)+" "+lengthAxis+" "+(crenLength+lengthAdjust)+" "+depthAxis+" "+(-crenDirection*(crenDepth+depthAdjust))+"";
let spaceMove = lengthAxis+" "+(crenLength-lengthAdjust)+"";
let endMove = lengthAxis+" "+(crenLength/2-lengthAdjust/2)+"";

console.log(
    [
        startMove,
        Array(ncren).fill(crenMove)
            .join(" "+spaceMove+" "),
        endMove
    ]
    .join(" ")
);
{% endhighlight %}

Et voilà le résultat :

    h 2 v 1.15 h 4 v -1.15 h 4 v 1.15 h 4 v -1.15 h 4 v 1.15 h 4 v -1.15 h 4 v 1.15 h 4 v -1.15 h 4 v 1.15 h 4 v -1.15 h 2

Ce script m'a permi de dessiner les premières pièces et d'expérimenter avec différents paramètres.

J'ai fait des premiers tests avec le contreplaqué de 1mm mais l'assemblage n'était pas assez solide.
J'ai ensuite essayé avec du contreplaqué de 3mm et cette fois les résultats étaient excellents.
Le compromis entre solidité et volume était satisfaisant,
et c'était un matériau facile à trouver dans les magasins de bricolage proches de chez moi et relativement bon marché.

## Développement des boites

J'ai calqué la taille des premières boites sur la taille des compartiments du système de rangement que j'utilisais à l'époque, soit une boite carré de 75mm de côté.
Une boite avec ces dimensions peut accueillir une pièce de LEGO de 8 unités de long avec juste ce qu'il faut de marge.
Pour la hauteur j'ai voulu respecter le ratio des briques LEGO, en considérant que ma boite était équivalente à une brique de 2x2.
Les experts de la brique danoise savent que 2 unités LEGO correspondent à 5 hauteurs de plaque, et la hauteur d'une brique fait 3 plaques de haut.
Pour une boite de 75mm de côté on arrive donc à une hauteur de 75*3/5 = 45mm.
Je trouvais ça trop haut, alors je suis descendu à 2 plaques au lieu de 3, soit 30mm.
Je trouve que c'est le ratio parfait.

Partant de là, en partant du principe que ma boite de base fait 2x2 unités de large et 2 plaques de haut, j'ai expérimenté avec tout un tas de variantes en 1x1, 1x2, 2x3, 2x4, 3x3, etc en version 1, 2, 3 ou 4 plaques de hauteur. Je me suis vite rendu compte que les modèles de grande taille et faible hauteur sont utiles en tant que plateau pour contenir des pièces lors de constructions par exemples.
J'en ai fait des plus grands, que j'utilise encore couramment aujourd'hui.

## La suite

Quand j'ai commencé à avoir un certain nombre de boites en vrac, le besoin d'un niveau supérieur de rangement s'est fait sentir. J'ai alors développé progressivement des [meubles à tiroirs](meubles_v1) pour ranger les boites. Le système de tiroirs compartimentés avec les boites me permet de sortir les boîtes pour facilement prélever les pièces,
et de reconfigurer l'agencement dans les tiroirs en fonction des besoins,
et c'est vraiment très appréciable.

Par la suite j'ai [réimaginé les boites en impression 3D](boites_v2), en m'inspirant des solutions de type Gridfinity.

{% endcomment %}