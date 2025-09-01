---
layout: topic
title: LEGO Storage System
category: Project
last_updated: 2025-09-01 10:10:09
tags: [LEGO, woodworking, 3dprinting, electronics]
project_status: active
---

[![](/assets/projects/lego-storage-system/4.jpg)
](/assets/projects/lego-storage-system/4.jpg)

Fan de LEGO depuis toujours, je tiens depuis 2019 une boutique de vente de pièces en ligne sur la plateforme BrickLink. Pour organiser mon stock j'ai d'abord utilisé un système de rangement à base de casiers en plastiques, mais j'en ai vite vu les limites. Ayant eu ces dernières années l'occasion de m'initier à la menuiserie, j'ai entrepris de fabriquer une solution de rangement sur mesure.

Le projet comporte aujourd'hui trois grands axes :

- *Les meubles*. C'est la structure externe. Il s'agit de meubles de type commode avec des tiroirs de faible hauteur compartimentés. J'ai fabriqué plusieurs meubles en faisant évoluer un peu le design et les techniques de fabrication, et j'ai pu me débarasser complètement des casiers en plastiques. Je reviens sur la conception et l'historique de cette partie sur [cette page](meubles_v1). Aujourd'hui je réfléchis à adapter le design pour en faire un module à intégrer dans des étagères IKEA de type Kallax. Détails sur [cette page](meubles_v2).

- *Les boites*. C'est le système d'organisation dans les tiroirs. Il s'agit de boites de différents formats permettant d'agencer l'espace selon les besoins. Les premières versions des boites étaient fabriquées en bois découpé au LASER. J'ai fabriqué une quantité astronomique de boites de ce type dans de nombreux formats différents. Je reviens sur cette aventure en détails sur [cette page](boites_v1). Par la suite j'ai imaginé un système en impression 3D, vaguement inspiré des solutions de type Gridfinity, et j'ai réduit le nombre de formats pour ne garder que quelques formats essentiels. Je détaille la conception et la production de ces boites sur [cette page](boites_v2). Je remplace progressivement les boites en bois par les nouvelles boites en plastique.

- *Un système d'ouverture automatique des tiroirs*. Un système qui comprend une partie mécanique réalisée en impression 3D et un système de commande basé sur Arduino. Le système peut être connecté à mon logiciel de préparation de commandes. La partie mécanique est globalement validée. La partie électronique reste à finaliser. Description complète sur [cette page](smart-drawers_fr).

Le reste de cette page présente une vue d'ensemble chronologique du projet.


## Le problème initial

Quand j'ai ouvert ma boutique ma solution de rangement était *Papi Max StackX Drawers*.
C'est un produit qui s'adresse spécifiquement aux amateurs de LEGO, et qui promet notamment une forte densité de stockage.
[Une revue détaillée est disponible sur le site Brick Architect](https://brickarchitect.com/2019/review-papi-max-stackx-drawers/).

Le système se présente sous la forme de modules individuels composés d'un boitier externe  dans lequel glisse un tiroir.
Les boitiers sont disponibles en blanc ou noir et peuvent s'empiler et s'assembler entre eux.
Les tiroirs sont transparents et équipés d'une poignée à l'avant.
Jusqu'à quatre cloisons peuvent être ajoutées dans la largeur et deux dans la longueur pour former jusqu'à 15 compartiments.

Les + :
- Vendu par éléments individuels, permettant de former une stucture globale de la taille et forme de son choix
- Agencement interne ajustable
- Possibilité de sortir complètement un tiroir pour l'emporter sur la zone de travail
- Les tiroirs peuvent sortir quasiment jusqu'au bout permettant un accès facile à toute la surface

Les - :
- Impossible d'extraire un compartiment individuel pour l'amener sur la zone de travail ou vider son contenu. Ça rend notamment très pénible le déplacement des pièces d'un compartiment à un autre
- Reconfigurer les cloisons demande de vider entièrement le tiroir
- Les cloisons reposent par gravité et ne sont pas vérouillées.
Avec les manipulations du tiroir elles se soulèvent et laissent fuiter des pièces dans les compartiments voisins
- Il arrive souvent que le tiroir se coince ou se bloque s'il n'est pas manié avec rigueur
- Le plastique transparent des tiroirs est sujet au jaunissement à la lumière du soleil
- Prix élevé

Finalement, le système de cloisons amoviles était séduisant sur le papier mais peu pratique à l'usage.
Ajouté à ça la basse qualité de construction et le prix élevé, une meilleure solution était nécessaire.


## Les premières boites

Courant 2021 j'ai eu l'occasion de me former à la découpe LASER.
J'ai alors commencé à expérimenter pour fabriquer des boites qui pourraient me servir à ranger et organiser mes pièces de LEGO.


## Les premiers meubles

Ces dernières années j'ai eu l'occasion de m'initier à la menuiserie.
Je voulais agrandir mon stock mais ne voulais pas poursuivre avec la solution de rangement existante, j'ai donc entammé un travail de conception et f

J'ai ainsi fabriqué un ensemble de meubles à tiroirs 

J'ai conçu et fabriqué un ensemble de meubles de type commode comprenant de 5 à une quizaine de tiroirs de faible hauteur.

J'ai tout construit en bois, à partir de panneaux achetés en magasin de bricolage ou récupérés.

Il était important pour moi que l'ouverture des tiroirs donne une impression de qualité. Je ne voulais pas que les tiroirs penchent une fois ouvert, et je ne voulais pas courir le risque que le tiroir tombe si on ouvre un peu trop rapidement.

Je voulais aussi que les tiroirs puissent s'ouvrir en totalité afin de pouvoir exploiter facilement l'intégralité du volume disponible.

J'ai achetés des glissières à sortie totale de marque Junker sur Amazon. Le résultat est très satisfaisant.

Après avoir expérimenté un peu avec des poignées fabriqués en bois, j'ai acheté des poignées en métal.


## Révision des boites

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

L'objectif est de créer un système automatique d'ouverture des tiroirs de mes meubles de rangement de pièces de LEGO.

Je voulais initialement utiliser des aimants mais les premiers tests n'ont pas été concluants.

J'ai finalement conçu un système de poussoir mécanique sur ressort actionné par une languette coulissante.

La languette devait initialement être commandée par un solenoid, mais la force n'était pas suffisante. La version finale utilise un servo moteur.

J'ai passé beaucoup de temps à concevoir le mécanisme mais aujourd'hui j'ai quelque chose qui fonctionne de manière satisfaisante et avec un bon niveau de fiabilité.

La suite est d'équiper les 5 tiroirs du petit meuble que j'utilise pour tester, et de transformer l'électronique qui fonctionne aujoud'hui sur une breadboard en quelque chose de plus permanent. Les réflexions sont en cours sur ce sujet.


## Module Kallax

Article détaillé :
- [LEGO Storage system: Module Kallax](meubles_v2)

--

Articles dédiés :
- [Meubles v1](meubles_v1)
- [Meubles v2 (Kallax)](meubles_v2)
- [Boite v1 (découpe LASER)](boites_v1)
- [Boite v2 (impression 3D)](boites_v2)
- [Smart Drawers](smart-drawers_fr)