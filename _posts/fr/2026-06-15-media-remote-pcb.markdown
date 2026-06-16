---
layout: post
title: "Mise en place du PCB pour ma télécommande multimédia"
topics: [soldering, pcb, troubleshooting, 3dmodelling]
image: /assets/posts/2026-06-15-media-remote-pcb/IMG_7458.JPG
githubs:
- https://github.com/alexbinary/media-remote
permalink: /fr/billets/2026/06/15/001
lang: fr
lang_en: /en/posts/2026/06/15/001
---


## Introduction

Quand je regarde des films à la maison je suis très souvent en train d'ajuster le volume, revenir en arrière ou en avant, activer ou non les sous-titres, mettre en pause et reprendre, etc. J'utilise mon Mac pour regarder les films sur grand écran depuis mon canapé, et j'ai donc besoin de prendre un clavier sans fil sur les genoux pour gérer la lecture. 

Depuis quelques temps je travaille sur un projet de télécommande qui serait moins encombrante qu'un clavier complet. Le système se base sur un ESP32 C6 programmé pour se présenter au PC comme un clavier bluetooth. Des boutons permettent de déclencher l'envoi de la touche souhaitée, et une petite batterie assure l'alimentation. J'ai récemment terminé un premier protoype sur perfboard avec boitier imprimé en 3D et j'en suis très content. 

Ces dernières semaines j'ai appri à utiliser KiCad et j'ai conçu mon premier PCB avec l'objectif de remplacer la perfboard pour rendre le montage plus propre et la télécommande plus compacte. Je viens de recevoir le PCB, je peux donc passer à l'intégration.


## Préparatifs

La première étape était de choisir les boutons à souder. J'ai à ma disposition une collection de petits boutons tactiles 6x6mm ultra classiques avec différentes tailles de tiges. La taille de la tige du bouton est étroitement liée à l'épaisseur finale de la télécommande, il est donc important de choisir la bonne.

Pour déterminer la taille de tige idéale pour les boutons je me sers du modèle 3D que j'ai préparé. Avant toute chose je refais quelques mesures pour vérifier et ajuster le modèle si nécessaire. Je confirme que l'épaisseur du PCB est bien de 1,6 mm d'épaisseur comme prévu. Avec l'ESP32 dessus j'ai un total d'environ 6 mm, et avec la batterie ça monte à environ 7 mm. La base des boutons culminant à 4.7mm, c'est donc *a priori* la batterie qui conditionne l'épaisseur minimale du boitier. Je modifie le modèle en conséquence.

Avant de mesurer la taille nécessaire pour les boutons, je cherche à réduire l'épaisseur globale au minimum. Le boitier du premier prototype fait 19mm, et pour cette nouvelle version j'aimerais voir jusqu'où je peux aller dans la finesse. Au tout début du projet j'avais fabriqué une maquette pour déterminer la forme idéale, et j'avais déterminé 10mm d'épaisseur. Ça parait ambitieux, il serait intéressant de voir si j'arrive un jour à l'atteindre.

Un élément qui joue sur l'épaisseur totale c'est l'espace laissé entre le fond du boitier et le PCB. Je cherche donc à minimiser les choses qui dépassent sous le PCB. Je détermine que je peux souder les boutons par le dessus et non par le dessous comme je pensais le faire initialement, ce qui permet, si je coupe ensuite les pattes, d'avoir zéro dépassement sous le PCB au niveau des boutons. Idem pour le connecteur batterie. Pour l'ESP en revanche je ne peux pas éviter les soudures sur la face inférieure, et il y aura aussi deux fils connectés par le dessous pour la batterie. J'avais initialement prévu 2mm d'espace sous le PCB mais avec tout ça j'évalue désormais qu'1mm pourrait probablement suffire.

Mon boitier est construit en deux parties, une pour le dessus et une pour le dessous. Jusque là les fonds faisaient 2mm d'épaisseur. Ça me semblait un minimum pour assurer une bonne rigidité, mais j'ai envie d'essayer 1mm. Avec tous ces changements j'arrive quasiment à 10mm d'épaisseur. Ça m'étonne presque et m'enthousiasme beaucoup.

Le modèle étant à jour, je peux reprendre le calcul des boutons. Je détermine qu'une taille de tige telle qu'une hauteur totale depuis la face inférieure du PCB donne 8mm est idéale. Dans ma collection les modèles les plus proches font soit un peu moins, soit un peu plus.  La tige du bouton sert à guider les capsules qui recouvrent les boutons et j'ai peur que les capsules ne soient pas bien guidées si le bouton est trop petit. Je peux toujours accomoder un bouton un peu trop grand en ajustant la capsule, mais l'inverse semble plus embêtant. Je choisis donc le plus grand.


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/remote-cross-section.png"
            legend="Vue en coupe du boitier avec le PCB à l'intérieur et les boutons"
        %}

    </div>

</div>


Au final j'ai passé une bonne partie d'une soirée à réfléchir aux dimensions, mesurer les composants, ajuster le modèle et choisir les boutons. J'ai l'impression d'avoir passé bien plus de temps que nécessaire. Je crois que je n'arrivais pas bien à visualiser le lien entre toutes les dimensions qui entrent en jeu. J'ai choisi de placer la ligne de jointure au milieu du port USB, et les calculs se font donc toujours plus ou moins par rapport à lui, et je crois que sur le coup ça m'a un peu embrouillé. J'avais peut-être aussi peur de me tromper dans le choix des boutons et de devoir recommencer la soudure, même si en soit n'est pas bien grave. J'étais peut-être simplement fatigué. Quoi qu'il en soit je n'ai pas lâché l'affaire et j'ai abouti à une situation dont j'étais satisfait et je me sentais prêt à attaquer la soudure le lendemain.


## Soudure et premiers tests

Avant de me lancer je réfléchis à l'ordre de soudure des composants. Je me dis que le switch on/off va demander de tenir le PCB dans les pinces, et qu'il est plus facile de faire ça quand il n'y a encore rien dessus. Il sera donc soudé en premier. Ensuite, le connecteur batterie est proche de l'ESP32, donc si je le soude par le dessus il sera plus facile de le faire avant que l'EPS32 soit en place. Ensuite je peux souder les boutons, et finir par l'ESP32.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7458.JPG"
            legend="Tout est prêt pour passer à la soudure"
        %}

    </div>

</div>


En observant le PCB je suis soudain pris d'un doute et je vérifie sur le schéma électrique quelles pins j'ai utilisées sur l'ESP, et je vérifie sur la documentation officielle qu'elles sont bien utilisables pour mon cas. C'est tout bon.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/schematic.png"
            legend="Le schéma électrique de la télécommande"
        %}

    </div>

</div>


Je passe à la soudure. Je suis encore débutant mais depuis que j'ai ma station de soudage FNIRSI DWS-200 avec un embout F210 les choses se passent plutôt bien. Je mets systématiquement un peu de flux avant chaque soudure, je dépose de l'étain sur le fer, et je laisse le métal se mettre en place tout seul. Dans l'ensemble je suis plutôt fier de mes soudures.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7459.JPG"
            legend="Premières soudures"
        %}

    </div>

</div>


Pour souder l'ESP32 j'ai prévu sur le PCB des trous alignés avec ceux de la board de l'ESP, et l'idée est de passer un bout de fil et de le souder des deux côtés. Je teste une technique qui consiste à passer un seul fil dans tous les trous un coup vers le haut un coup vers le bas, à la manière d'un fil de couture. C'est un peu galère à faire et je ne suis pas sûr que c'était très judicieux. Nénamoins le résultat final est propre.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7462.JPG"
            legend='Technique "du fil de couture"'
        %}

    </div>

</div>


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7488.JPG"
            legend="___"
        %}

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7489.JPG"
            legend="___"
        %}

    </div>

</div>



## Quand un problème logiciel ressemble à un problème matériel

Les premiers tests n'ont pas été totalement fluides.

L'IDE Arduino refusait parfois de reconnaître correctement les cartes. Cela m'a conduit à mettre à jour l'environnement, les définitions de cartes et à revérifier plusieurs paramètres.

Finalement, le flash se passe correctement.

Puis aucun bouton ne fonctionne.

Après quelques minutes de recherche, je découvre que j'ai tout simplement oublié une soudure sur le 3,3 V.

Pas exactement le bug le plus sophistiqué de l'histoire.

Une fois corrigé, presque tout fonctionne.

Sauf un bouton.

La soudure semble bonne.

Le schéma semble bon.

Le code semble bon.

Même en court-circuitant directement la broche sur l'ESP32, rien ne se passe.

C'est ce détail qui m'a mis sur la bonne piste.

En relisant le code, je réalise que j'utilise encore cette même broche pour la surveillance de la batterie, une fonctionnalité qui n'est même pas implémentée sur cette version.

Je supprime tout le code lié à la batterie, je reflashe, et le bouton fonctionne immédiatement.

Puis deux autres boutons se mettent à envoyer systématiquement une double pression.

Cette fois, la cause est bien matérielle : un minuscule pont de soudure entre deux connexions voisines.

Quelques secondes de nettoyage suffisent à régler le problème.

## La saga du connecteur batterie

Puis vient la partie la plus délicate : la batterie.

La première fois que je la branche, j'entends des crépitements.

Je débranche immédiatement.

L'ESP32 est tiède.

Ce n'est jamais un bon signe.

Le multimètre confirme rapidement la présence d'un court-circuit autour du connecteur batterie.

L'endroit est particulièrement mal choisi : des pads minuscules, difficilement accessibles, juste à côté de composants sensibles.

Je retire l'excès d'étain, je vérifie à nouveau les continuités, et je reteste.

Tout semble fonctionner.

Du moins pendant un moment.

Plus tard dans la journée, le connecteur recommence à poser problème.

Cette fois il fume.

Il n'y a plus vraiment le choix : il faut tout dessouder et recommencer.

L'opération est fastidieuse. Une des pastilles commence même à se décoller du PCB.

Après un nettoyage complet, je ressoude le connecteur en utilisant beaucoup moins d'étain, je contrôle minutieusement au multimètre, puis je renforce mécaniquement l'ensemble avec un peu de colle.

Cette fois, le montage paraît sain.

## Une ESP32 sacrifiée à la science

Malheureusement, l'une des cartes ESP32 finit par rendre l'âme.

Elle n'est plus correctement détectée.

Le régulateur semble avoir cessé de fonctionner.

La carte chauffe anormalement.

Je la considère rapidement comme perdue.

Étonnamment, ce n'est pas ce qui m'a le plus frustré.

J'avais encore des cartes de rechange.

Surtout, j'avais commencé à accumuler suffisamment d'indices pour formuler une hypothèse.

Le problème semblait davantage lié à l'intégration de la batterie qu'au design du PCB lui-même.

Et cette distinction est importante.

Un problème de conception aurait remis en question l'ensemble du projet.

Un problème de mise en œuvre est généralement beaucoup plus facile à corriger.

## Itérations sur le boîtier

En parallèle de l'électronique, je continuais à faire évoluer le boîtier.

J'ai choisi d'imprimer les pièces progressivement plutôt que de lancer immédiatement une impression complète.

L'utilisation d'un filament transparent s'est révélée particulièrement utile. Je pouvais observer directement comment le PCB se positionnait à l'intérieur du boîtier.

Cela m'a permis d'identifier quelques petits défauts d'alignement que je n'aurais probablement pas remarqués autrement.

Globalement, les résultats étaient très encourageants.

L'ouverture USB était presque correcte.

La position du switch correspondait au modèle.

L'épaisseur générale était excellente.

Pour la première fois, l'objet commençait davantage à ressembler à un produit qu'à une succession d'expériences.

## Les boutons contre-attaquent

Les boutons avaient cependant une dernière surprise en réserve.

Ils sont trop grands.

Le boîtier ne ferme pas.

Avec le recul, tous les indices étaient déjà là dans les calculs. J'étais simplement trop proche des limites pour que les approximations restent sans conséquence.

Malgré tout, cette erreur apporte une information précieuse.

Les boutons plus petits fonctionneront.

Des boutons plus grands ne fonctionneront pas.

C'est déjà une décision validée.

J'ai également expérimenté différentes profondeurs de capuchons.

Certaines versions semblaient prometteuses dans Fusion 360 mais devenaient inutilisables une fois imprimées, parce que le capuchon venait reposer sur le corps du bouton et empêchait tout clic.

Encore un rappel que le modèle 3D n'est pas la réalité.

## Une fin de journée mitigée

En terminant la session, je n'étais pas totalement satisfait.

J'avais perdu une ESP32.

Le système batterie me semblait encore fragile.

Le mécanisme des boutons demandait du travail.

Le boîtier nécessitait plusieurs améliorations.

Et pourtant, lorsque je regarde les faits, le bilan est largement positif.

Le PCB est validé.

Le firmware fonctionne.

Le boîtier est beaucoup plus fin qu'avant.

J'ai une piste crédible pour expliquer les défaillances des ESP32.

J'ai remplacé plusieurs hypothèses par des mesures concrètes.

J'ai un prototype fonctionnel.

Objectivement, c'est une bonne journée.

Subjectivement, elle m'a paru désordonnée.

## Quand le projet change de phase

La réflexion la plus importante n'est finalement pas technique.

Jusqu'à présent, ce projet était dans une phase d'exploration.

L'objectif était simplement de répondre à une question :

« Est-ce que ça peut fonctionner ? »

Dans cette phase, il est normal de travailler de manière assez informelle. Les notes sont incomplètes. Les décisions restent dans la tête. La documentation peut attendre.

Mais à un moment donné, le projet change de nature.

Le principal obstacle n'est plus technique.

Il devient organisationnel.

Je pense avoir atteint ce point.

La frustration que je ressens n'est probablement pas liée au matériel lui-même.

C'est plutôt le signal que le mode « exploration » a atteint ses limites.

J'ai maintenant envie de schémas.

De notes de conception.

D'un suivi plus structuré.

De documents qui expliquent pourquoi certaines décisions ont été prises.

Bref, j'ai envie de traiter ce projet davantage comme un produit que comme une expérience.

Et finalement, c'est plutôt une bonne nouvelle.

Cela signifie que la phase de preuve de concept est largement derrière moi.

Le prochain défi n'est plus de faire fonctionner le système.

C'est de le rendre bon.




<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/button-profile.png"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/code.png"
            legend="___"
        %}

    </div>

</div>



<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7464.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7465.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7466.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7468.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7470.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7472.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7477.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7481.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7485.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7495.JPG"
            legend="___"
        %}

    </div>

</div>





<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/vlc-shortcuts.png"
            legend="___"
        %}

    </div>

</div>