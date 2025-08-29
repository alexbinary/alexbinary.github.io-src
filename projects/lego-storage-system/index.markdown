---
layout: page
---

# Project: LEGO Storage System

## Phase 1: Meubles et boites

Articles détaillés :
- [LEGO Storage System - phase 1 (fr)](phase1_fr)
- [LEGO Storage System - phase 1 (en)](phase1_en)

### Meubles

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