---
layout: page
---

# Project: LEGO Storage System

J'ai conçu et fabriqué un ensemble de meubles de type commode comprenant de 5 à une quizaine de tiroirs de faible hauteur.

J'ai tout construit en bois, à partir de panneaux achetés en magasin de bricolage ou récupérés.

Il était important pour moi que l'ouverture des tiroirs donne une impression de qualité. Je ne voulais pas que les tiroirs penchent une fois ouvert, et je ne voulais pas courir le risque que le tiroir tombe si on ouvre un peu trop rapidement.

Je voulais aussi que les tiroirs puissent s'ouvrir en totalité afin de pouvoir exploiter facilement l'intégralité du volume disponible.

J'ai achetés des glissières à sortie totale de marque Junker sur Amazon. Le résultat est très satisfaisant.

Après avoir expérimenté un peu avec des poignées fabriqués en bois, j'ai acheté des poignées en métal.


## Module Kallax

### Kallax, une étagère versatile

Kallax est une gamme d'étagères IKEA flexibles et modulaires.
Les éléments de la gamme se présentent comme des ensembles de cases carrées agencées en blocs de 1x1, 1x2, 2x2, 1x5, 2x4, 3x4, qui peuvent être posés au sol ou fixés au mur.
Les meubles sont disponibles en plusieurs coloris et peuvent être utilisés nus ou en combinaison avec de nombreux accessoires. Il est ainsi possible d'ajouter des tiroirs, des portes, des étagères supplémentaires, des porte bouteille, des paniers, etc.
Les cases carrées permettent de combiner les modules et les meubles dans n'importe quelle orientation.

<p align="center">
    <img src="../assets/projects/lego-storage-system/kallax 1.jpg" width="50%" />
    <br/>
    <sub>Kallax 2x2</sub>
</p>

Mon idée est de créer un module sur mesure pour le rangement des pièces de LEGO dans la continuité de ce que j'ai déjà fait. Les avantages sont multiples : pas besoin de créer la structure externe du meuble, possibilité d'utiliser des Kallax de différentes tailles pour créer l'ensemble qu'on veut, et possbilité de combiner avec les modules Kallax existant pour créer des meubles hybrides répondant à des besoins complexes.

Pour peu que la Kallax se présente dans le bon sens, il est relativement simple d'enlever un séparateur, ce qui permet d'utilier deux cases de manière contigue.
Comme une case n'est pas très large, ce sera sûrement utile.

Voilà à quoi pourrait ressembler un module tiroir comme je l'imagine, sur deux cases :

<p align="center">
    <img src="../assets/projects/lego-storage-system/leka v2 1.png" width="50%" />
    <br/>
    <sub>Module tiroirs sur deux cases</sub>
</p>

### Vue d'ensemble de la conception

J'imagine un module où les tiroirs sont maintenus par deux pièces latérales, le tout étant fermé à l'arrière par un panneau fin.

<p align="center">
    <img src="../assets/projects/lego-storage-system/leka v2 4.png" />
    <br/>
    <sub>Vue d'ensemble de la conception (module seul)</sub>
</p>

<p align="center">
    <img src="../assets/projects/lego-storage-system/leka v2 2.png" />
    <br/>
    <sub>Vue de dessus en coupe</sub>
</p>

<p align="center">
    <img src="../assets/projects/lego-storage-system/leka v2 3.png" />
    <br/>
    <sub>Vue de l'arrière en coupe</sub>
</p>

### Dimensionnement

Un point crucial pour commencer est de déterminer combien de tiroirs je peux faire dans une case et combien de boites ils peuvent accueillir en largeur et en profondeur.
Il ne faut pas oublier de prendre en compte le système d'ouverture automatique des tiroirs.

Je commence par relever les dimensions du Kallax :

| Dimension | Valeur en mm
|-|
| Profondeur | 390
| Hauteur d'une case | 335
| Largeur d'une case | 335
| Largeur de deux cases (une fois le séparateur retiré) | 687

Ensuite pour déterminer les paramètres et dimensions idéales, je fais des calculateurs sous Numbers (Excel) qui me permettent de faire varier les paramètres pour déterminer les meilleures combinaisons.

#### Dimensionnement en hauteur

Jusqu'à présent j'ai fait des hauteur de boite de 30mm, je voudrais tester des tiroirs de hauteur 40.
Le but est de faire rentrer un maximum de tiroirs en laissant suffisament d'espace entre chaque.
Le débord façade peut être ajusté pour obtenir un espacement entre les façades de l'ordre de 3mm, qui est une valeur qui donne un bon résultat sur le plan fonctionel et esthétique.

**Paramètres pour la hauteur**

| Paramètre | Unité | Description / Commentaire | Valeur
|-
| Hauteur boite | mm | Hauteur totale d'une boite | TBD
| Nombre de tiroirs | | Nombre de tiroir dans le module | TBD
| Epaisseur fond de tiroir | mm | Epaisseur du fond du tiroir, normalement fait en contreplaqué de 4mm | 4
| Débord façade dessus | mm | Débord de la façade sur le dessus du cadre du tiroir | TBD
| Hauteur totale tiroir | mm | Hauteur totale d'une façade de tiroir | Hauteur boite + Epaisseur fond + Débord façade
| Espace entre les façades | mm | Espace entre deux façades et entre les première/dernière façades et le dessus/dessous du meuble. | (Hauteur totale disponible - Nombre de tiroirs × Hauteur totale tiroir) / (Nombre de tiroirs + 1)

**Solutions pour la hauteur**

| Item | Solution 1 | Solution 2 | Solution 3 | Solution 4
|-
| **Hauteur boite** | **30** | **40** | **40** | **35**
| **Nombre de tiroirs** | **8** | **6** | **7** | **7**
| Epaisseur fond | 4 | 4 | 4 | 4
| **Débord façade** | **4** | **8** | **0** | **5**
| Hauteur totale tiroir | 38 | 52 | 44 | 44 |
| **Espace entre tiroirs** | **3.4** | **3.3** | **3.4** | **3.4**

| Solution | Description | Commentaire |
|-|-|-|:-:|
| **1** | 8 tiroirs de 30mm | - 4mm de débord de façade et 3mm d'espacement, c'est très similaire à ce que j'ai actuellement | ✅
| **3** | 6 tiroirs de 40mm | - passe bien | ✅
| **2** | 7 tiroirs de 40mm | - 3mm d'espacement sans débord de façade laisse trop peu d'espace | ❌
| **3** | 7 tiroirs de 35mm | - passe bien<br>- des boites de 35 pourquoi pas (mais attention à ne pas multiplier les formats différents) | garde sous le coude

#### Dimensionnement en largeur

Je détermine que l'idéal est de faire un module qui occupe deux cases de largeur (il n'est pas compliqué de retirer la cloison, pourvu qu'on prenne la Kallax dans le bon sens). Ça permet de faire tenir 8 boîtes en largeur.

**Paramètre pour la largeur**

| Paramètre | Unité | Description / Commentaire | Valeur
|-
| Epaiseur côtés caisson | mm | Epaisseur des côtés du caisson, normalement fait en contreplaqué de 10mm | 10
| Epaisseur glissière | mm | Epaisseur d'une glissière | 12.7
| Taille boite | mm | Taille de base d'une boîte dans la largeur | 75
| Nombre de boites | | Nombre de boites que le tiroir peut accueillir en largeur | TBD
| Jeu autour des boites | mm | Jeu pour laisser les boites respirer dans le tiroir. Avec les boites en bois il était nécessaire d’avoir quelques mm de jeu, avec les boites en plastique on devrait pouvoir se passer de jeu puisque les boites l’intègrent déjà dans leurs dimensions | 0
| Nombre de renforts | | Au delà de 6 ou 7 boites il devient nécessaire d'avoir au moins un renfort | TBD
| Epaisseur renfort | mm | Epaisseur des pièces intermédiaires qui aident à soutenir le fond de tiroir et qui divisent l'espace interne, normalement fait en contreplaqué de 10mm | 10mm 
| Nombre de divisions | | Chaque renfort crée une division | Nombre de renforts + 1
| Largeur utile totale | mm | Largeur totale disponible pour les boites | Nb boite × Taille boite + (Nb divisions) × Jeu
| Epaisseur côtés cadre | mm | Epaisseur des pièces qui forment les côtés du cadre du tiroir, normalement fait en contreplaqué de 10mm | 10
| Largeur totale cadre | mm | Largeur externe totale du tiroir sans les glissières et sans la façade | Largeur utile totale + Nb renfort × Epaisseur renfort + Epaisseur côté cadre × 2
| Largeur totale | mm | Largeur totale du module | Largeur totale cadre + Epaisseur glissière × 2 + Epaisseur côté caisson × 2
| Jeu | mm | Différence entre la largeur totale du module et l'espace disponible dans la Kallax | Largeur case Kallax - Largeur totale du module

**Solutions pour la largeur**

| Item | Solution 1 | Solution 2 | Solution 3 | Solution 4 | Solution 5
|-
| **Côtés caisson** | **10** | **0** | **10** | **0** | **4**
| Glissière | 12.7 | 12.7 | 12.7 | 12.7 | 12.7
| Taille boite | 75 | 75 | 75 | 75 | 75
| **Nombre boites** | **3½** | **4** | **8** | **8½** | **8½**
| Jeu | 0 | 0 | 0 | 0 | 0
| **Renforts** | **0** | **0** | **1** | **0** | **0**
| Epaisseur renfort | 10 | 10 | 10 | 10 | 10
| Divisions | 1 | 1 | 2 | 1 | 1
| Largeur utile totale | 262.5 | 300 | 600 | 637.5 | 637.5
| **Côtés cadre** | **10** | **4** | **10** | **10** | **4**
| Largeur totale cadre | 282.5 | 308 | 630 | 657.5 | 645.5
| Largeur totale | 327.9 | 333.4 | 675.4 | 682.9 | 678.9
| **Jeu** | **7.1** | **1.6** | **11.6** | **4.1** | **8.1**

| Solution | Description | Commentaire
|-
| **1** | 1 case, 3½ boites | - 3½ boites c'est vraiment peu<br>- Je préfère un nombre entier dans la largeur | ❌
| **2** | 1 case, 4 boites, pas de caisson | - Glissières à fixer directement sur la Kallax, ce qui amène son lot de problèmes<br>- Les côtés des tiroirs en CP4 peuvent s'assembler avec le fond avec la méthode des créneaux, ça peut sûrement tenir la charge, mais j'ai un doute que l'épaisseur soit suffisante pour tenir correctement les glissières | ❌
| **3** | 2 cases, 8 boites | - Caisson<br>- Cadre de tiroir standard<br>- 8 boites c'est correct<br>- Jeu total confortable | ✅
| **4** | 2 cases, 8½ boites sans renfort, pas de caisson | - Glissières à fixer directement sur la Kallax<br>- 8 boites sans renfort = risque d'affaissement du fond<br>- Nombre non entier de boites | ❌
| **5** | 2 cases, 8½ boites sans renfort, caisson 4mm | - J'ai des doutes sur la faisabilité d'un caisson en CP4<br>- Tiroirs en CP4 | ❌

#### Dimensionnement en profondeur

Pour la profondeur, j'accepte que les tiroirs dépassent un peu à l'arrière. Il y a en général un peu d'espace avec le mur, et si le débord n'est pas trop grand il ne se voit pas. Je voudrais également intégrer mon système d'ouverture automatique, donc il faut compter environ 5cm dans le fond. En utilisant des glissières de 400mm je peux faire tenir 4,5 boites en profondeur, ce qui offre une sortie de 42mm et un débord total de 42mm, ce qui est acceptable.

**Paramètres pour la profondeur**

| Paramètre | Unité | Description / Commentaire | Valeur
|-
| Longueur glissière | mm | Les glissières sont disponibles en plusieurs longueurs par multiples de 50mm, celles que j'utilise jusque là font 400mm | 400 ou 350
| Taille boite | mm	| Taille de base d'une boîte dans la profondeur | 75	
| Nombre de boites || Nombre de boites que le tiroir peut accueillir en profondeur. On peut utiliser des demies longueurs | TBD
| Jeu autour des boites | mm | Jeu pour laisser les boites respirer dans le tiroir. Avec les boites en bois il était nécessaire d'avoir quelques mm de jeu, avec les boites en plastique on devrait pouvoir se passer de jeu puisque les boites l'intègrent déjà dans leurs dimensions | 0
| Profondeur utile totale | mm | Profondeur totale disponible pour les boites | Nb boites × Taille boite + Jeu
| Epaisseur pièce avant	| mm | Epaisseur de la pièce avant du cadre du tiroir, normalement faite en contreplaqué de 10mm | 10
| Epaisseur pièce arrière | mm | Epaisseur de la pièce arrière du cadre du tiroir, normalement faite en contreplaqué de 10mm | 10
| Profondeur totale du cadre | mm | Dimension externe du tiroir sans la façade | Profondeur utile + Epaisseur pièce avant + Epaisseur pièce arrière
| Sortie du tiroir | mm | Différence entre la longueur de la glissière et la longueur du tiroir | Longueur glissière - Profondeur totale cadre
| Epaisseur façade | mm | Epaisseur de la façade, normalement faite en 3 plis d'épaisseur 19mm | 19
| Longueur poussoir | mm | Longueur à réserver derrière le tiroir pour le système d'ouverture automatique | 52	
| Epaisseur fond | mm | Epaisseur de la planche qui ferme le meuble à l'arrière. Normalement fait en contreplaqué de 4mm | 4
| Profondeur totale | mm | Profondeur totale du module | Profondeur totale du cadre + Epaisseur façade + Longueur poussoir + Epaisseur fond
| Débord arrière | mm | Longueur qui dépasse à l'arrière de la Kallax | Profondeur totale - Profondeur Kallax

**Solutions pour la profondeur**

| Item | Solution 1 | Solution 2 | Solution 3
|-
| **Glissière** | **350** | **400** | **400**
| Taille boite | 75 | 75 | 75
| **Nombre de boites** | **4** | **5** | **4½**
| Jeu | 0 | 0 | 0
| Profondeur utile | 300 | 375 | 337,5
| Avant | 10 | 10 | 10
| Arrière | 10 | 10 | 10
| Profondeur totale cadre | 320 | 395 | 357,5
| **Sortie** | **30** | **5** | **42,5**
| Façade | 10 | 19 | 19
| Poussoir | 52 | 52 | 52
| Fond | 4 | 4 | 4
| Profondeur totale | 386 | 470 | 432,5
| **Débord arrière** | **-4** | **80** | **42,5**

| Solution | Description | Commentaire | Choix |
|----------|-------------|-------------|-------|
| **1** | Glissières 350mm, 4 boites | - Tombe quasiment juste sans débord<br>- 4 boites c'est peu | ❌ |
| **2** | Glissières 400mm, 5 boites | - Utilise les glissières en stock<br>- 5 boites c'est bien<br>- 8cm de débord arrière c'est trop | ❌ |
| **3** | Glissières 400mm, 4½ boites | - Utilise les glissières en stock<br>- Débord arrière acceptable<br>- Bonne sortie<br>- 4½ boites c'est acceptable<br>NB: disposition des meubles A et C | ✅ |


