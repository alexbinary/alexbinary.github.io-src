---
layout: page
---

<h1><u>Project</u>:<br>LEGO Storage System</h1>

![](/assets/projects/lego-storage-system/0.jpg)

Fan de LEGO depuis toujours, je tiens depuis 2019 une boutique de vente de pièces en ligne sur la plateforme BrickLink. Pour organiser mon stock j'ai d'abord utilisé un système de rangement à base de casiers en plastiques, mais j'en ai vite vu les limites. Ayant eu ces dernières années l'occasion de m'initier à la menuiserie, j'ai entrepris de fabriquer une solution de rangement sur mesure.

Ce projet a développé avec le temps plusieurs ramifications :

- La structure de base. Il s'agit d'un système de meubles avec des tiroirs de faible hauteur et compartimentés. J'ai fabriqué plusieurs meubles en faisant évoluer un peu le design et les techniques de fabrication, et j'ai pu me débarasser complètement des casiers en plastiques. Désormais je réfléchis à adapter le design pour en faire un module adapté aux étagères IKEA de type Kallax.

- L'organisation dans les tiroirs. C'est un système de boites de différents formats permettant d'agencer l'espace selon les besoins. Les premières versions des boites étaient fabriquées en bois découpé au LASER. J'ai fabriqué une quantité astronomique de boites de ce type dans de nombreux formats différents. Par la suite j'ai imaginé un système en impression 3D, vaguement inspiré des solutions de type Gridfinity, et j'ai réduit le nombre de formats pour ne garder que quelques formats essentiels. Le remplacement progressif des boites en bois par les nouvelles boites en plastique est actuellement en cours.

- Un système d'ouverture automatique des tiroirs. La partie mécanique est développée par mes soins et fabriquée en impression 3D, et le système de commande est basé sur Arduino et peut être connecté à mon logiciel de préparation de commandes. La partie mécanique est globalement validé. La partie électronique reste à finaliser. Ce projet est en voie de finalisation.


## Les débuts de l'aventure BrickLink

Comme beaucoup d'enfants, quand j'étais petit je jouais aux LEGO.
En grandissant j'ai un peu mis cette activité de côté, même si je n'ai jamais vraiment remisé ma collection.
Et puis vers 2015 j'ai commencé à racheter des sets, et c'était le début d'une vraie passion d'adulte pour ce jeu de construction.

La communauté LEGO avait bien évolué, et j'étais moi aussi prêt à aborder ce loisir d'une manière nouvelle. J'ai découvert plusieurs sites internet et communautés en ligne, notamment Rebrickable, Brickset, et BrickLink.

BrickLink est une place de marché où amateurs et professionnels du monde entier peuvent vendre des pièces de LEGO au détail. C'est un endroit fantastique pour tout amateur sérieux désireux de réaliser ses propres créations ou des créations de membres de la communauté, ou simplement redonner vie à d'anciens sets incomplets.

Je me suis mis à passer régulièrement des commandes sur BrickLink dans l'optique de recréer certains oeuvres de créateurs mais aussi pour travailler sur des projets personnels.

Et puis vers 2019, j'ai voulu tester l'autre côté et ouvrir une boutique.


## Les problèmes des rangements en plastique

Pendant un temps j'ai rangé mes pièces dans un système de casiers en plastique, mais j'en ai vite vu les limites. Notamment un manque de confort et de souplesse.


## Les premiers meubles et boites en bois

Articles détaillés :
- [LEGO Storage System - phase 1 (fr)](phase1_fr)
- [LEGO Storage System - phase 1 (en)](phase1_en)

### Meubles

Ces dernières années j'ai eu l'occasion de m'initier à la menuiserie.
Je voulais agrandir mon stock mais ne voulais pas poursuivre avec la solution de rangement existante, j'ai donc entammé un travail de conception et f

J'ai ainsi fabriqué un ensemble de meubles à tiroirs 

J'ai conçu et fabriqué un ensemble de meubles de type commode comprenant de 5 à une quizaine de tiroirs de faible hauteur.

J'ai tout construit en bois, à partir de panneaux achetés en magasin de bricolage ou récupérés.

Il était important pour moi que l'ouverture des tiroirs donne une impression de qualité. Je ne voulais pas que les tiroirs penchent une fois ouvert, et je ne voulais pas courir le risque que le tiroir tombe si on ouvre un peu trop rapidement.

Je voulais aussi que les tiroirs puissent s'ouvrir en totalité afin de pouvoir exploiter facilement l'intégralité du volume disponible.

J'ai achetés des glissières à sortie totale de marque Junker sur Amazon. Le résultat est très satisfaisant.

Après avoir expérimenté un peu avec des poignées fabriqués en bois, j'ai acheté des poignées en métal.


### Boites

Je fabrique des boîtes modulaires en impression 3D pour ranger les pièces de LEGO dans les meubles que j'ai fabriqués.

Les boîtes sont prévues pour s'encastrer dans un système de grille.

Dernièrement j'avais des soucis d'impression car les coins des faces carées rebiquaient (*warping*).
J'ai d'abord essayé de nettoyer le plateau, pensant que c'était un problème d'adhérance au plateau.
Ça a aidé un peu, mais le problème persistait.

J'ai pensé que c'était en raison du courant d'air, car j'imprime généralement avec la fenêtre ouverte.
J'ai donc testé fenêtre fermée, et ce n'était pas beaucoup mieux.

En dernier recours, j'ai testé d'ajouter des supports.
Là c'était beaucoup mieux, mais les supports apportent d'autres désagréments.

J'en étais là quand j'ai vu une vidéo qui m'a donné l'idée d'arrondir les angles de mes faces carrées qui posaient problème.
Après un peu de travail pour modifier mon modèle 3D de manière cohérente, je lance un test.
Et là magie, plus de problème.

En règle générale en impression 3D, il est souvent bon d'arrondir les angles trop durs.


## Smart Drawers

Articles détaillés :
- [Smart drawers (fr)](smart-drawers_fr)
- [Smart drawers (en)](smart-drawers_en)

L'objectif est de créer un système automatique d'ouverture des tiroirs de mes meubles de rangement de pièces de LEGO.

Je voulais initialement utiliser des aimants mais les premiers tests n'ont pas été concluants.

J'ai finalement conçu un système de poussoir mécanique sur ressort actionné par une languette coulissante.

La languette devait initialement être commandée par un solenoid, mais la force n'était pas suffisante. La version finale utilise un servo moteur.

J'ai passé beaucoup de temps à concevoir le mécanisme mais aujourd'hui j'ai quelque chose qui fonctionne de manière satisfaisante et avec un bon niveau de fiabilité.

La suite est d'équiper les 5 tiroirs du petit meuble que j'utilise pour tester, et de transformer l'électronique qui fonctionne aujoud'hui sur une breadboard en quelque chose de plus permanent. Les réflexions sont en cours sur ce sujet.


## Module Kallax

Article détaillé :
- [LEGO Storage system: Module Kallax](kallax)