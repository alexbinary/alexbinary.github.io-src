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


### Module Kallax

L'idée est de créer des modules qui peuvent s'intégrer facilement dans un meuble Kallax, comme il en existe déjà. L'avantage est qu'on a pas besoin de créer la structure externe du meuble, on peut utiliser des Kallax de différentes tailles pour créer l'ensemble qu'on veut, et on peut combiner les modules avec l'écosystème Kallax existant pour créer des meubles hybrides.

La première étape est de déterminer les dimensions.
Une case Kallax fait 335 de côté et 390 de profondeur.

Je détermine que l'idéal est de faire un module qui occupe deux cases de largeur (il n'est pas compliqué de retirer la cloison, pourvu qu'on prenne la Kallax dans le bon sens). Ça permet de faire tenir 8 boîtes en largeur.

Pour la profondeur, j'accepte que les tiroirs dépassent un peu à l'arrière. Il y a en général un peu d'espace avec le mur, et si le débord n'est pas trop grand il ne se voit pas. Je voudrais également intégrer mon système d'ouverture automatique, donc il faut compter environ 5cm dans le fond. En utilisant des glissières de 400mm je peux faire tenir 4,5 boites en profondeur, ce qui offre une sortie de 42mm et un débord total de 42mm, ce qui est acceptable.

Pour la hauteur, je voudrais tester des tiroirs de hauteur 40 au lieu de 30. Avec un espacement total entre les tiroirs d'environ 3mm, je peux faire tenir 6 tiroirs.

Pour déterminer ces dimensions, je m'aide d'un calculateur sous Excel (Numbers).

#### Profondeur

**Calculateur**

| Item | Unité | Description / Commentaire | Valeur
|-
| Longueur glissière | mm | Les glissières sont disponibles en plusieurs longueurs par multiples de 50mm, celles que j'utilise jusque là font 400mm | 400 ou 350
| Taille boite | mm	| Taille d'une unité de rangement dans mon système de rangement modulaire | 75	
| Nombre de boites || Nombre de boites que le tiroir peut accueillir en profondeur. On peut utiliser des demies longueurs | TBD
| Jeu autour des boites | mm | Jeu pour laisser les boites respirer dans le tiroir. Avec les boites en bois il était nécessaire d'avoir quelques mm de jeu, avec les boites en plastique on devrait pouvoir se passer de jeu puisque les boites l'intègrent déjà dans leurs dimensions | 0
| Profondeur utile | mm | Profondeur totale dédiée uniquement aux boites | Nb boites × Taille boite + Jeu
| Epaisseur pièce avant	| mm | Epaisseur de la pièce avant du cadre du tiroir, normalement faite en contreplaqué de 10mm | 10
| Epaisseur pièce arrière | mm | Epaisseur de la pièce arrière du cadre du tiroir, normalement faite en contreplaqué de 10mm | 10
| Profondeur totale du cadre | mm | Dimension externe du tiroir sans la façade | Profondeur utile + Epaisseur pièce avant + Epaisseur pièce arrière
| Sortie du tiroir | mm | Différence entre la longueur de la glissière et la longueur du tiroir | Longueur glissière - Profondeur totale cadre
| Epaisseur façade | mm | Epaisseur de la façade, généralement faite en 3 plis d'épaisseur 19mm | 19
| Longueur poussoir | mm | Longueur à réserver derrière le tiroir pour le système d'ouverture automatique | 52	
| Epaisseur fond | mm | Epaisseur de la planche qui ferme le meuble à l'arrière. Généralement fait en contreplaqué de 4mm | 4
| Profondeur totale | mm | Profondeur totale du module | Profondeur totale du cadre + Epaisseur façade + Longueur poussoir + Epaisseur fond
| Débord arrière | mm | Longueur qui dépasse à l'arrière de la Kallax | Profondeur totale - Profondeur Kallax

**Solutions**

| Item | Unité | Solution 1 | Solution 2 | Solution 3
|-
| **Glissière** | mm | **350** | **400** | **400**
| Taille boite | mm | 75 | 75 | 75
| **Nombre de boites** || **4** | **5** | **4,5**
| Jeu | mm | 0 | 0 | 0
| Profondeur utile | mm | 300 | 375 | 337,5
| Avant | mm | 10 | 10 | 10
| Arrière | mm | 10 | 10 | 10
| Profondeur totale cadre | mm | 320 | 395 | 357,5
| **Sortie** | mm | **30** | **5** | **42,5**
| Façade | mm | 10 | 19 | 19
| Poussoir | mm | 52 | 52 | 52
| Fond | mm | 4 | 4 | 4
| Profondeur totale | mm | 386 | 470 | 432,5
| **Débord arrière** | mm | **-4** | **80** | **42,5**

| Solution | Description | Commentaire
|-
| **1** | Glissières 350mm, 4 boites | Tombe quasiment juste sans débord, mais 4 boites c'est peu | ❌
| **2** | Glissières 400mm, 5 boites | Utilise les glissières en stock, 5 boites c'est bien, mais 8cm de débord arrière c'est trop | ❌
| **3** | Glissières 400mm, 4.5 boites | Utilise les glissières en stock, débord arrière acceptable, bonne sortie. 4.5 boites c'est acceptalbe. NB: disposition des meubles A et C. | ✅

Solution retenue : **3**
