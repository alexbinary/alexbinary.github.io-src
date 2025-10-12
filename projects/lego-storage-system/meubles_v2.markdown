---
layout: project
title: Module Kallax
parent_project_title: LEGO Storage System
parent_project_url: ../lego-storage-system
last_updated: 2025-09-02
topics: [LEGO, woodworking]
project_status: active
---

Après avoir réalisé une série de [meubles indépendants](meubles_v1) pour ranger mes pièces de LEGO pour [ma boutique en ligne](/occupations/bricklink), je réfléchis désormais à adapter le design pour en faire un module à intégrer dans des étagères IKEA de type Kallax. J'en suis encore à la phase de conception.

### Kallax, une étagère versatile

Kallax est une gamme d'étagères IKEA flexibles et modulaires.
Les éléments de la gamme se présentent comme des ensembles de cases carrées agencées en blocs de 1x1, 1x2, 2x2, 1x5, 2x4, 3x4, qui peuvent être posés au sol ou fixés au mur.
Les meubles sont disponibles en plusieurs coloris et peuvent être utilisés nus ou en combinaison avec de nombreux accessoires. Il est ainsi possible d'ajouter des tiroirs, des portes, des étagères supplémentaires, des porte bouteille, des paniers, etc.
Les cases carrées permettent de combiner les modules et les meubles dans n'importe quelle orientation.

<table>
    <tr>
        <td style="vertical-align: bottom;">
            <p align="center">
                <img src="/assets/projects/lego-storage-system/kallax/kallax 1.jpg" width="80%" />
                <br/>
                <sub>Kallax 2x2</sub>
            </p>
        </td>
        <td>
            <p align="center">
                <img src="/assets/projects/lego-storage-system/kallax/kallax 2.jpg" />
                <br/>
                <sub>Kallax 1x4</sub>
            </p>
        </td>
    </tr>
    <tr style="background:none">
        <td>
            <p align="center">
                <img src="/assets/projects/lego-storage-system/kallax/kallax 3.jpg" width=350 height=350/>
                <br/>
                <sub>Kallax 2x4</sub>
            </p>
        </td>
        <td style="vertical-align: bottom;">
            <p align="center">
                <img src="/assets/projects/lego-storage-system/kallax/kallax 4.jpg" style="object-fit: cover" width=350 height=350 />
                <br/>
                <sub>Kallax 4x4</sub>
            </p>
        </td>
    </tr>
</table>


Mon idée est de créer un module sur mesure pour le rangement des pièces de LEGO dans la continuité de ce que j'ai déjà fait. Les avantages sont multiples : pas besoin de créer la structure externe du meuble, possibilité d'utiliser des Kallax de différentes tailles pour créer l'ensemble qu'on veut, et possbilité de combiner avec les modules existants pour créer des meubles hybrides répondant à des besoins complexes.

Comme une case n'est pas très large, je pense partir sur un module qui occupe deux cases.
La conception des étagères fait qu'il est facile d'enlever certains des séparateurs, pour peu que l'étagère se présente dans le bon sens.

Voilà un rendu possible :

<p align="center">
    <img src="/assets/projects/lego-storage-system/kallax/leka v2 5.png" width="50%" />
    <br/>
    <sub>Rendu possible d'un module tiroirs sur deux cases</sub>
</p>

### Conception du module

L'idée générale est d'utiliser deux faces latérales sur lesquelles viennent se fixer les tiroirs.
Cela donne un module qu'on peut assembler seul et ensuite glisser dans le Kallax.
L'arrière est fermée par un panneau fin. Les façades sont flush avec la Kallax.

<p align="center">
    <img src="/assets/projects/lego-storage-system/kallax/leka v2 6.png" width="70%" />
    <br/>
    <sub>Module tiroirs sur deux cases (module seul)</sub>
</p>

Pour dimensionner les éléments, commençons par relever les dimensions du Kallax. Comme on l'a vu, les cases sont carrées.

| Dimension Kallax | Valeur en mm
|-|
| Profondeur | 390
| Hauteur d'une case | 335
| Largeur d'une case | 335
| Largeur de deux cases (une fois le séparateur retiré) | 687

Les paramètres principaux qui déterminent les dimensions des éléments sont le nombre de tiroirs par case et le nombre de boites par tiroir en largeur et en profondeur.

Pour pouvoir expérimenter simplement avec différentes valeurs je crée des calculateurs sous Numbers (Excel). Pour chaque dimension (hauteur, largeur, profondeur), je liste les paramètres qui entrent en jeu et je détermine les relations entre eux le cas échéant.

Commençons par la hauteur. Pour identifier les éléments et leur relation, regardons de plus près la conception :

<p align="center">
    <img src="/assets/projects/lego-storage-system/kallax/leka v2 8.png" width="60%" />
    <br/>
    <sub>Zoom sur les éléments qui contribuent à la hauteur (vue arrière)</sub>
</p>

On constate que la hauteur dépend uniquement de l'empilement des tiroirs. Les glissières n'interviennent pas.

Voici les paramètres pour la hauteur :

| Paramètre | Unité | Description / Commentaire | Valeur
|-
| Hauteur cadre | mm | Hauteur des côtés du tiroir, égale à la hauteur totale occupée par une boite | TBD
| Nombre de tiroirs | | Nombre de tiroir dans le module | TBD
| Epaisseur fond de tiroir | mm | Epaisseur du fond du tiroir. Normalement fait en contreplaqué de 4mm | 4
| Débord façade dessus | mm | De combien la façade dépasse au dessus du cadre du tiroir | TBD
| Hauteur totale tiroir | mm | Hauteur totale du tiroir en prenant en compte la façade et le fond | Hauteur cadre + Epaisseur fond + Débord façade
| Espace entre les façades | mm | Espace entre deux façades et entre les première/dernière façades et le meuble | (Hauteur case - Nombre de tiroirs × Hauteur totale tiroir) / (Nombre de tiroirs + 1)

On peut maintenant tester plusieurs propositions.
Le but est de faire rentrer un maximum de tiroirs en laissant suffisament d'espace entre chaque.
On peut jouer sur le débord façade (en restant raisonnable) pour ajuster l'espacement entre les façades.
Jusque là j'avais un débord de 3 ou 4mm.
On ne peut pas vraiment descendre en dessous de ça, mais on peut augmenter un peu sans soucis.
Un espace entre les façade de l'ordre de 3mm donne un bon résultat fonctionnel et esthétique.
Jusqu'à présent j'ai fait des hauteur de boite de 30mm, mais je voudrais maintenant tester 40.

Voici les résultats pour 4 propositions, discutées en détails en dessous :

| | Prop. 1 | Prop. 2 | Prop. 3 | Prop. 4 |
|-
| **Hauteur boite** | **40** | **40** | **30** | **35**
| **Nombre de tiroirs** | **6** | **7** | **8** | **7**
| Epaisseur fond | 4 | 4 | 4 | 4
| **Débord façade** | **8** | **0** | **4** | **5**
| Hauteur totale tiroir | 52 | 44 | 38 | 44 |
| **Espace entre tiroirs** | **3,3** | **3,4** | **3,4** | **3,4**

Pour répartir correctement 6 tiroirs de 40mm (**prop. 1**) il faut un débord façade de 8mm. C'est un peu beaucoup mais c'est acceptable.

En éliminant complètement le débord de façade on peut faire tenir 7 tiroirs de 40mm (**prop. 2**), mais ça ne laisse que 3mm d'espace total entre le haut des boites et le fond du tiroir du dessus, c'est trop peu.

La hauteur classique de boite de 30mm (**prop. 3**) permet 8 tiroirs avec un débord de façade de 4mm. Avec 3mm d'espace entre les façades, c'est très similaire à ce que j'ai actuellement.

Alternativement, on peut aussi avoir 7 tiroirs de 35mm (**prop. 4**), mais attention à ne pas multiplier les formats différents. Je garde cette solution sous le coude.

Je choisi de partir sur **6 tiroirs de 40mm** (**prop. 1**).

Passons maintenant à la largeur. Regardons de plus près la conception :

<p align="center">
    <img src="/assets/projects/lego-storage-system/kallax/leka v2 9.png" width="90%" />
    <br/>
    <sub>Zoom sur les éléments qui contribuent à la largeur (vue du dessus)</sub>
</p>

Si les tiroirs sont suffisament larges, il est nécessaire d'ajouter un renfort pour éviter que le fond ne s'affaisse sous le poids du chargement. Les renforts divisent la zone de charge en plusieurs sections.

Contrairement à la hauteur où on pouvait jouer sur le débord façade, en largeur aucun élément ne peut être ajusté arbitrairement. Il y aura donc nécessairement du jeu entre le module et le meuble. Tout l'enjeu est d'arriver à une valeur de jeu ni trop grande ni trop petite.

Voici les paramètres pour la largeur :

| Paramètre | Unité | Description / Commentaire | Valeur
|-
| Epaiseur des supports | mm | Epaisseur des faces latérales sur lesquelles sont fixés les tiroirs, normalement fait en contreplaqué de 10mm | 10
| Epaisseur glissière | mm | Epaisseur d'une glissière | 12,7
| Taille boite | mm | Taille de base d'une boîte dans la largeur | 75
| Nombre de boites | | Nombre de boites que le tiroir peut accueillir en largeur | TBD
| Jeu autour des boites | mm | Avec les boites en bois il était nécessaire de laisser quelques mm de jeu dans la zone de charge, mais avec les boites en plastique on devrait pouvoir s'en passer puisque les boites l’intègrent déjà dans leurs dimensions | 0
| Nombre de renforts | | Nombre de renforts | TBD
| Epaisseur renfort | mm | Epaisseur des pièces de renfort, normalement faites en contreplaqué de 10mm | 10mm 
| Nombre de divisions | | Chaque renfort crée une division supplémentaire | Nombre de renforts + 1
| Largeur utile totale | mm | Largeur totale disponible pour les boites | Nombre de boites × Taille boite + (Nombre de divisions) × Jeu
| Epaisseur côtés cadre | mm | Epaisseur des pièces qui forment les côtés du cadre du tiroir, normalement faites en contreplaqué de 10mm | 10
| Largeur totale cadre | mm | Largeur externe totale du tiroir sans les glissières et sans la façade | Largeur utile totale + Nombre de renforts × Epaisseur renfort + Epaisseur côté cadre × 2
| Largeur totale | mm | Largeur totale du module | Largeur totale cadre + Epaisseur glissière × 2 + Epaisseur support × 2
| Jeu final | mm | Différence entre la largeur totale du module et l'espace disponible dans la Kallax | Largeur case - Largeur totale du module

On peut maintenant tester plusieurs propositions.
Le but est d'avoir un maximum de boites. Il est possible d'utiliser des demie-boites, mais dans la largeur je préfère un nombre entier si possible.

Voici les résultats pour 5 propositions, discutées en détails en dessous :

| | Prop. 1 | Prop. 2 | Prop. 3 | Prop. 4 | Prop. 5
|-
| **Support** | **10** | **0** | **10** | **0** | **4**
| Glissière | 12,7 | 12,7 | 12,7 | 12,7 | 12,7
| Taille boite | 75 | 75 | 75 | 75 | 75
| **Nombre boites** | **3½** | **4** | **8** | **8½** | **8½**
| Jeu | 0 | 0 | 0 | 0 | 0
| **Renforts** | **0** | **0** | **1** | **0** | **0**
| Epaisseur renfort | 10 | 10 | 10 | 10 | 10
| Divisions | 1 | 1 | 2 | 1 | 1
| Largeur utile totale | 262,5 | 300 | 600 | 637,5 | 637,5
| **Côtés cadre** | **10** | **4** | **10** | **10** | **4**
| Largeur totale cadre | 282,5 | 308 | 630 | 657,5 | 645,5
| Largeur totale | 327,9 | 333,4 | 675,4 | 682,9 | 678,9
| **Jeu** | **7,1** | **1,6** | **11,6** | **4,1** | **8,1**

Je commence par voir combien de boites on peut faire rentrer dans une case.
Le mieux que j'ai trouvé c'est 3½ (**prop. 1**). C'est vraiment peu, et ce n'est pas un nombre entier.

Il est possible d'avoir 4 boites (**prop. 2**) si on enlève les faces support et qu'on fait les côtés des tiroirs en contreplaqué de 4mm. Fixer les glissières directement sur la Kallax rend moins simple la mise en place/retrait du module dans la case, mais surtout ça oblige le tiroir à avoir exactement la bonne largeur au risque de ne pas coulisser correctement. J'ai eu des déboirs à ce niveau là sur le meuble C et je préfère éviter ça autant que possible. Et du coup le jeu restant de 1.6mm devrait être intégré dans la largeur du tiroir.
Pour les côtés des tiroirs en contreplaqué de 4mm au lieu de 10, on est en terrain inconnu. Ils pourraient s'assembler avec le fond avec la méthode des créneaux, mais ça pose la question de la capacité à tenir la charge. J'ai aussi un doute que l'épaisseur soit suffisante pour pouvoir y fixer correctement les glissières.

Si on veut faire mieux que 3 boites de large, il faut passer sur deux cases.
Avec les dimensions standard et un renfort, on peut avoir 8 boites (**prop. 3**), ce qui est correct.
On a un jeu total de 11mm ce qui est un petit peu beaucoup mais reste acceptable.

En enlevant les faces support et le renfort on peut avoir 8½ boites (**prop. 4**).
Avec autant boites sans renfort le fond risque de s'affaisser.
Ajouté à ça les contraintes liées à la suppression des supports, et le fait qu'on a même pas un nombre entier de boites.

Alternativement, en faisant les tiroir en CP4 (et on a vu que ce n'était pas une super solution), on peut garder les supports si on les fait aussi en CP4 (**prop. 5**). Comme avec les tiroirs, pas sûr qu'on puisse fixer correctement les glissières sur du CP4. Et on a toujours un nombre non entier de boites, ça ne vaut pas l'effort selon moi.

La meilleure solution pour moi est donc **8 boites sur deux cases**.

Pour finir, la profondeur. Regardons la conception :

<p align="center">
    <img src="/assets/projects/lego-storage-system/kallax/leka v2 10.png" width="80%" />
    <br/>
    <sub>Zoom sur les éléments qui contribuent à la profondeur (vue du dessus)</sub>
</p>

Les glissières que j'utilise jusque là, et dont j'ai encore un petit stock, font 400mm de long.
Les cases Kallax font 390 de profondeur, donc ça dépasse, mais ce n'est pas forcément gênant.
Il y a en général un peu d'espace avec le mur, et si ça ne dépasse pas trop ça ne se verra pas.

Je veux que le tiroir puisse donner l'impression de sortir plus que sa longueur, pour un accès confortable au fond du tiroir. L'astuce pour ça est de faire un tiroir plus courts que les glissières.
C'est ce que j'ai fait sur les meubles A et C.
Ça permet aussi de laisser de la place pour mon système d'ouverture automatique.

Voici les paramètres pour la profondeur :

| Paramètre | Unité | Description / Commentaire | Valeur
|-
| Longueur glissière | mm | Les glissières que j'ai font 400mm, mais le modèle existe en plusieurs longueurs par multiples de 50mm | 400 ou 350
| Taille boite | mm	| Taille de base d'une boîte dans la profondeur | 75	
| Nombre de boites || Nombre de boites que le tiroir peut accueillir en profondeur | TBD
| Jeu autour des boites | mm | Avec les boites en bois il était nécessaire d'avoir quelques mm de jeu, mais avec les boites en plastique on devrait pouvoir s'en puisque les boites l'intègrent déjà dans leurs dimensions | 0
| Profondeur utile totale | mm | Profondeur totale disponible pour les boites | Nombre de boites × Taille boite + Jeu
| Epaisseur pièce avant	| mm | Epaisseur de la pièce avant du cadre du tiroir, normalement faite en contreplaqué de 10mm | 10
| Epaisseur pièce arrière | mm | Epaisseur de la pièce arrière du cadre du tiroir, normalement faite en contreplaqué de 10mm | 10
| Profondeur totale du cadre | mm | Dimension externe du tiroir sans la façade | Profondeur utile + Epaisseur pièce avant + Epaisseur pièce arrière
| Sortie du tiroir | mm | Différence entre la longueur de la glissière et la longueur du tiroir | Longueur glissière - Profondeur totale cadre
| Epaisseur façade | mm | Epaisseur de la façade, normalement faite en 3 plis d'épaisseur 19mm | 19
| Longueur poussoir | mm | Longueur à réserver derrière le tiroir pour le système d'ouverture automatique | 52
| Epaisseur fond | mm | Epaisseur de la planche qui ferme le meuble à l'arrière. Normalement fait en contreplaqué de 4mm | 4
| Profondeur totale | mm | Profondeur totale du module | Profondeur totale du cadre + Epaisseur façade + Longueur poussoir + Epaisseur fond
| Débord arrière | mm | Longueur qui dépasse à l'arrière de la Kallax | Profondeur totale - Profondeur Kallax

Testons plusieurs propositions :

| | Prop. 1 | Prop. 2 | Prop. 3 | Prop. 4
|-
| **Glissière** | **400** | **400** | **350** | **350**
| Taille boite | 75 | 75 | 75 | 75
| **Nombre de boites** | **4½** | **5** | **4** | **4½**
| Jeu | 0 | 0 | 0 | 0
| Profondeur utile | 337,5 | 375 | 300 | 337,5
| Avant | 10 | 10 | 10 | 10
| Arrière | 10 | 10 | 10 | 10
| Profondeur totale cadre | 357,5 | 395 | 320 | 357,5
| **Sortie** | **42,5** | **5** | **30** | **-7,5**
| Façade | 19 | 19 | 19 | 19
| Poussoir | 52 | 52 | 52 | 52
| Fond | 4 | 4 | 4 | 4
| Profondeur totale | 432,5 | 470 | 386 | 432,5
| **Débord arrière** | **42,5** | **80** | **5** | **42,5**

Avec des glissières de 400mm on peut avoir 4½ boites (**prop. 1**) avec une bonne sortie et un débord arrière acceptable de 4cm. Ça donne les mêmes tiroirs que ce que j'ai sur les meubles A et C.

Monter à 5 boites (**prop. 2**) donne 8cm de débord arrière ce qui est trop.
Et on a quasiment plus de sortie.

J'ai voulu voir ce que ça donnerait avec des glissières plus courtes (**prop. 3**).
Avec 4 boites on tombe quasiment juste sans débord à l'arrière, et on a une sortie pas trop mal. Mais 4 boites c'est peu.

Si on essaie 4½ boites (**prop. 4**) on retombe sur quelque chose de similaire à la proposition 1, mais avec une sortie négative (ce qui veut dire que le tiroir ne sortira jamais complètement, la boite du fond est donc en partie condamnée).

Je choisis donc **4½ boites avec des glissières de 400mm**.


### Amélioration des façades

Sur les [itérations précédentes](meubles_v1) je fixais chaque façade par rapport à son tiroir respectif. Malgré le soin apporté au positionnement des tiroirs les uns par rapport aux autres, je n'ai jamais réussi à avoir un rendu parfait (sauf peut-être avec le meuble A mais au prix d'un temps d'usinage prohibitif à plus grande échelle).

Pour cette itération je voudrais trouver une manière de positionner les façades une fois les tiroirs en place, pour pouvoir les positionner relativement les unes aux autres dans leur configuration finale.
Je pense que c'est le plus simple pour atteindre un rendu global optimal sans chercher la perfection
dans le positionnement des glissières.
Il y a un challenge sur le fait de pouvoir positionner les façades sur les tiroirs alors que ceux-ci sont en place dans le meuble.
La solution que j'ai vue plusieurs fois est d'avoir un moyen de fixer temporairement les façades depuis l'avant, puis démonter le tiroir pour fixer définitivement depuis l'arrière.

Jusqu'à présent les façades sont positionnées et fixées principalement via les perçages pour les poignées, puis l'assemblage et consolidé avec deux vis sur les extrémités. C'est simple et efficace.

<p align="center">
    <img src="/assets/projects/lego-storage-system/kallax/leka v2 11.png" width="80%" />
    <br/>
    <sub>Fixation et positionnement des façades par les poignées (vue du dessus)</sub>
</p>

L'enjeu se situe surtout sur le positionnement vertical, une première idée serait donc d'allonger les  perçages pour les poignées, de fixer les poignées à l'envers (la poignée à l'intérieur du tiroir) de sorte à pouvoir serrer depuis l'extérieur, puis de consolider l'assemblage avant de remettre la poignée dans le bon sens.

On peut allonger le perçage de quelques millimètres en haut et en bas par rapport à sa position de référence, sans oublier d'allonger le fraisage pour la tête de vis également.
On n'agit que sur le perçage dans le cadre du tiroir, pas sur la façade, de sorte que la poignée est toujours bien positionnée par rapport à la façade, et c'est l'ensemble qui peut être ajusté sur le cadre du tiroir.


### Techniques de fabrication

Sur les dernières itérations j'ai découpé les façades dans la même pièce que le cadre.
Ça rend bien mais ça demande d'utiliser la fraiseuse numérique et ça prend du temps.

Dans le cas Kallax il n'y a pas de cadre à faire, on peut donc fabriquer les façades de manière classique à la scie.


### Illustration

J'aimerais essayer de graver au LASER une illustration complexe qui s'étend sur toutes les façades de façon continue. J'ai commencé à réfléchir au design.

L'idée est de graver toute l'illustration en une fois avant de découper les façades.
L'espacement final entre les pièces étant du même ordre de grandeur que la lame de scie, le rendu devrait rester correct sans qu'on ait besoin de le prendre en compte lors de la gravure.