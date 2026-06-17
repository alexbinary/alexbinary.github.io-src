---
layout: post
title: "Mise en place du PCB pour ma télécommande multimédia"
topics: [soudure, pcb, modelisation3d]
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


## Mise à jour du modèle 3D et choix des boutons

Pour les prototypes précédents j'avais mis au point un modèle 3D du boitier. Quand j'ai conçu le PCB j'ai mis à jour le modèle pour l'adapter, et j'ai intégré une représentation du PCB en reprenant les dimensions du PCB directement depuis KiCad une fois que le design était à peu près stable. Par la suite j'ai ajusté en continu pour suivre les révisions.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/vue3d.png"
            legend="Le modèle 3D du boitier (couvercle masqué) avec une représentation du PCB"
        %}

    </div>

</div>


Le premier objectif avant la soudure est de choisir les boutons à souder. J'ai à ma disposition une collection de petits boutons tactiles 6x6mm ultra classiques avec différentes tailles de tiges. La taille de la tige du bouton est étroitement liée à l'épaisseur finale de la télécommande, il est donc important de choisir la bonne.

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


## Préparation de la soudure

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


Au passage je mets à jour le code Arduino puisque la correspondance entre les boutons et les broches de l'ESP32 a changé par rapport au prototype précédent. J'en profite aussi pour restructurer un peu et ajouter des commentaires. Les annotations que j'ai prévues sur le PCB me permettent d'identifier facilement quelle fonction correspond à quelle broche, là où sur les prototypes précédent je finissais toujours par tester manuellement pour identifier les boutons.


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/code.png"
            legend="Code qui définit la correspondance entre les boutons et les broches"
        %}

    </div>

</div>


[Le code est disponible sur GitHub](https://github.com/alexbinary/media-remote).

Par rapport au prototype précédent j'ai ajouté un bouton pour permettre le défilement des pistes audio dans les deux sens, et ainsi être symétrique avec les pistes de sous-titres. Sauf qu'au moment de chercher quel touche correspond au raccourci dans VLC, le raccourci pour passer à la piste précédente semble ne pas exister. Surprenant. Je décide de donc que les deux boutons passerons à la piste suivante 🤷‍♂️


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/vlc-shortcuts.png"
            legend="Un racourci VLC existe pour 'Passer à la piste audio suivante', mais pas pour la piste précédente"
        %}

    </div>

</div>


## Soudure

Je suis encore débutant en soudure mais je progresse. Depuis que j'ai ma station de soudage [FNIRSI DWS-200](https://fr.aliexpress.com/item/1005007327187617.html?spm=a2g0o.order_list.order_list_main.5.3e365e5br140E1&gatewayAdapt=glo2fra) avec un embout F210 les choses se passent plutôt bien. Je mets systématiquement un peu de flux avant chaque soudure, je dépose de l'étain sur le fer, et je laisse le métal se mettre en place tout seul. Dans l'ensemble je suis plutôt fier de mes soudures.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7459.JPG"
            legend="Premières soudures de la journée"
        %}

    </div>

</div>


Souder le connecteur batterie par le dessus n'a pas posé de difficultés particulières.

Pour souder l'ESP32 j'ai prévu sur le PCB des trous alignés avec ceux de la board de l'ESP, et l'idée est de passer un bout de fil et de le souder des deux côtés. Je teste une technique qui consiste à passer un seul fil dans tous les trous un coup vers le haut un coup vers le bas, à la manière d'un fil de couture. Avec le recul ce n'est pas probablement pas la meilleure technique. Nénamoins le résultat final est propre.

J'étais parti pour souder toutes les broches, mais sur le moment je me souviens que toutes ne sont pas utilisées. Je soude donc uniquement les 9 pattes des boutons.


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7462.JPG"
            legend='Technique "du fil de couture"'
        %}

    </div>


    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7488.JPG"
            legend="Résultat des soudures de l'ESP32 (dessous)"
        %}

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7489.JPG"
            legend="Résultat des soudures de l'ESP32 (dessus)"
        %}

    </div>

</div>


Les dernières soudures visent à relier les pastilles dédiées à la batterie situées sous l'ESP32 aux points de connexions prévus sur le PCB. Pour ça je fais passer un fil dans le trou du PCB et je soude l'extrémité sur la pastille de l'ESP. Après ça je coupe les pattes des boutons et du connecteur batterie, et la carte est terminée. La soudure demande pas mal de minutie et de concentration, et je finis avec quelques douleurs dans le dos. 


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7464.JPG"
            legend="Le PCB comparé à la perfboard précédente (dessus)"
        %}

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7465.JPG"
            legend="Le PCB comparé à la perfboard précédente (dessous)"
        %}

    </div>

</div>


## Premiers tests

La carte terminée, je décide de tester le fonctionnement. C'est le moment de vérité. Je flash le programme, le bluetooth connecte, je teste les boutons.

Initialement aucun bouton ne fonctionne. Je réfléchis un instant. Quand un bouton est enfoncé il est sensé connecter le 3.3V à une des broches de l'ESP32. Je réalise que j'ai oublié de souder la broche du 3.3V sur l'ESP32. J'ai utilisé un *power plane* pour amener le 3.3V aux boutons, et il n'y a donc pas de piste clairement visible qui va à l'ESP. C'est probablement pour ça que quand j'ai déterminé que je n'avais pas besoin de souder toutes les broches j'ai zappé celle-ci. Je vérifie que je n'ai pas oublié d'autres connexions, je corrige, et les boutons fonctionnent désormais.

Maintenant c'est le bouton pour passer à la piste de sous-titres précédente qui ne fonctionne pas. Il est sensé envoyer la touche C. Je vérifie dans un bloc note et effectivement il n'envoie rien. Je vérifie le code mais rien ne me saute aux yeux. Je vérifie les soudures, idem. J'essaie d'amener manuellement le 3.3V sur la broche de l'ESP32 sans passer par le bouton, et il ne se passe rien, alors que le même test sur le broche voisine déclenche bien l'envoie touche correspondante. Ça suggère un problème logiciel. Je me replonge dans le code, et je me souviens quand les précédentes versions j'utilisais la broche A0 pour lire la tension de la batterie. Je n'utilise pas cette fonction ici mais ça interfère probablement. Je décide de supprimer tout le code relatif au suivi de la batterie puisque je mon PCB ne permettra pas d'implémenter ce genre de fonctions de toute façon. Ça résout effectivement le problème.

Finalement, c'est le bouton pour naviguer dans les pistes audio qui ne se comporte pas correctement. Il envoie systématiquement deux fois la touche. Les deux boutons sont connectés sur deux broches voisines. En inspectant de près les connexion, je crois voir un minuscule pont de soudure entre les deux. Je nettoie et c'est résolu.


## Connexion de la batterie

J'essaie ensuite de connecter la batterie grâce au connecteur prévu à cet effet. Je suis content d'avoir implémenter un véritable connecteur, car sur tous les prototypes jusque là j'avais bricolé un connecteur de fortune avec deux fils volants. Le connecteur fait très propre.

Très rapidement après la connexion, j'entends des crépitements. Je débranche immédiatement, et j'ai un peu peur que la batterie prenne feu ou n'explose. L'interrupteur on/off est sur off, donc a priori la batterie n'était pas connectée à l'ESP32. Celui-ci me semble un peu chaud et ça me fait un peu peur.

En inspectant les soudures du connecteur batterie je crois voir une connexion entre les deux pastilles. Je nettoie rapidement, et j'en profite pour enlever les salissures laissées par la soudure sur le reste de la carte et inspecter rapidement toutes les soudures. Je rebranche l'ESP32 au PC et tout fonctionne bien. Je suis rassuré.

Je reconnecte la batterie et j'entends encore des crépitements. Cette fois je vérifie au multimètre et je confirme qu'il y a encore un court circuit entre les bornes du connecteur de la batterie. C'est vraiment le pire endroit pour intervenir car il est situé juste à côté de l'ESP32 et l'endroit n'est pas hyper accessible. C'étais quasiment mes premières soudures de la journée et elles pourraient être mieux. Les pastilles du PCB sont vraiment proches et j'ai mis beaucoup d'étain. J'aspire avec la pompe à désouder et c'est déjà plus propre. Je vérifie au multimètre et c'est tout bon ! J'espère maintenant que la batterie n'a pas subit de dommages.


<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7466.JPG"
            legend="Le connecteur batterie avant nettoyage"
        %}

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7468.JPG"
            legend="Le connecteur batterie après nettoyage"
        %}

    </div>

</div>


Je rebranche en tendant l'oreille, et ça semble ok. Enfin. J'allume l'interrupteur, et la télécommande fonctionne bien.

Finalement il y a eu pas mal de petits soucis après la soudure mais rien de très grave, tout a été vite résolu. Je peux passer au boitier.


## Impression du boitier

Avant d'imprimer le boitier, je dois encore ajuster l'ouverture pour l'interrupteur on/off. J'attendais de l'avoir soudé pour prendre les dimensions finales car contrairement aux boutons il n'a pas de point de montage totalement défini. J'ai prévu des pastilles rectangulaires sur lesquelles souder les pattes parallèlement au PCB, et la position est donc en partie déterminée lors de la soudure. Le positionnement latéral correspond bien à la position théorique. J'en profite pour réduire la marge pour essayer de faire venir le boitier au plus près du bouton.

J'ajoute aussi des arrondis sur les angles intérieurs pour améliorer la solidité. Le fait d'avoir réduit l'épaisseur des fonds crée maintenant une zone de pincement dans l'angle du fait de l'arrondi extérieur.


<div class="inline-image-container">

    <div class="inline-image-container-row force-mobile-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/remote-cross-section2-corner.png"
            legend="Coins avant"
        %}

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/remote-cross-section1-corner.png"
            legend="Coins après"
        %}

    </div>

</div>


Comme le design est encore expérimental j'imprime une pièce à la fois plutôt que tout d'un coup pour pouvoir valider au fur et à mesure et ajuster si nécessaire. J'imprime avec un filament transparent pour pouvoir voir comment les pièces se positionnent à l'intérieur du boitier.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7477.JPG"
            legend="La première pièce du boitier imprimée"
        %}

    </div>

</div>


## Réparation du connecteur batterie

Pendant que je travaillais sur Fusion pour préparer l'impression du boitier j'avais laissé le PCB à côté de moi avec la batterie connectée, et à un moment j'ai à nouveau entendu des crépitements. Cette fois avant de débrancher j'ai eu le temps de voir des étincelles. J'ai eu peur pour la batterie mais elle ne présentait pas de signes de domages, elle n'était même pas chaude. L'ESP lui m'a paru un peu tiède et ça m'inquiétait un peu.

Pendant que le boitier imprime j'inspecte donc à nouveau le connecteur batterie et cette fois il y a du noir. Je nettoie et je remets un coup de pompe à désouder. L'espacement entre les pattes du connecteur est 2mm, c'est peu. J'ai utilisé des pads plus petits que la normale pour éviter qu'ils se touchent mais ils sont c'est peut-être encore trop proches. Après avoir nettoyé je rebranche la batterie, sur le coup ça tient mais quand je joue un peu avec le connecteur ça se met à fumer. Aïe.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7470.JPG"
            legend="Le connecteur batterie après avoir fait des étincelles"
        %}

    </div>

</div>


Le connecteur empêche de voir la totalité des soudures et il y a peut-être des défauts que je ne vois pas. Je décide donc de tout désouder. Je suis content de ne pas avoir rangé le matériel de soudure. J'ai un peu de mal à désouder le connecteur mais je finis par y arriver, mais une pastille à rendu l'âme sur la face arrière. J'envisage un temps de remplacer le connecteur par de simples fils, comme sur les prototypes précédents, mais finalement je tente de resouder le connecteur, en soudant cette fois par le dessous, autant que possible malgré la pastille décollée. Je soude donc la pastille intacte sur le dessous, et l'autre sur le dessus. Dans la confusion je me trompe et resoude par le dessus la pastille que j'ai soudée par le dessous. J'essaie cette fois de mettre un minimum d'étain.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7472.JPG"
            legend="Une pastille s'est décollé "
        %}

    </div>

</div>


Je vérifie au multimètre qu'il n'y a pas de court circuit, et je vérifie également qu'on a bien les connexion avec le reste du circuit. Tout à l'air bon. Je joue plusieurs fois avec le connecteur puis revérifie, ça a l'air de tenir. J'hésite à mettre une goutte de colle liquide pour stabiliser la connexion. S'il faut réintervenir ça va devenir délicat. Finalement je me lance.


## Intégration dans le boitier

L'impression de la partie inférieure du boitier est terminée. J'avais peur que l'épaisseur d'1mm soit trop fragile mais finalement ça va. J'installe le PCB dedans et ça rentre parfaitement. La transparence du boitier me permet de vérifier que le PCB est bien en contact avec les points de support prévus. Tout est ok, je lance l'impression de la partie supérieure.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7481.JPG"
            legend="Le PCB installé dans le boitier"
        %}

    </div>

</div>


Une fois imprimée j'assemble la partie supérieure du boitier, et quelque chose empêche de fermer complètement. Il s'avère que c'est le connecteur batterie. Décidément toujours lui. Je réalise que je ne l'avais pas pris en compte dans mes calculs d'épaisseur du début. En fait il ne fait que 6mm donc ça devrait passer, mais avec les péripéties de la journée il a fini soudé sans être enfoncé complètement. Malgré ça le boitier global est très fin et ça ma plait beaucoup.

J'imprime un capuchon de bouton, je teste, et le boitier ne ferme pas, il y a quasiment 2mm de trop. Il faut donc maintenant ajuster les capuchons. Je note que pour les prochaines versions je peux prendre des boutons plus petits sans soucis, mais clairement pas des plus grands.


## Perte innatendue de l'ESP

Pendant que la partie supérieure du boitier s'imprimait, j'ai testé un peu le système. La connexion bluetooth sautait sporadiquement quand je manipulait la batterie, indiquant que la carte perdait l'alimentation. C'est sans doute préférable à un court circuit, mais pas terrible quand même. Si je ne touchait à rien ça avait l'air de tenir, c'était déjà ça.

Et puis soudain tout s'est arrêté. J'ai d'abord soupçonné la batterie d'être à plat, alors j'ai essayé de la charger. Je n'ai pas osé brancher la carte au PC par peur des conséquences qu'un court circuit pourrait avoir sur celui-ci (même si en vrai je pense qu'il y a peu de risques). Je l'ai donc branchée au secteur. Ça a fonctionné. J'ai débranché pour inspecter les connexions au multimètre, tout était ok. J'ai rebrancheé au secteur, ça a fonctionné quelques instant et puis à nouveau plus de connexion bluetooth, alors que la carte était toujours branchée au secteur. C'était plutôt mauvais signe.

J'ai débranché et déconnecté la batterie, et branché au PC. ArduinoIDE ne voyait pas la carte.

J'ai senti que l'ESP était chaude, et ça m'a rappellé un prototype précédent qui est mort de la même manière. J'ai testé au multimètre et la patte qui sort normalement le 3.3V ne sortait rien, alors que sur une ESP qui fonctionne et j'avais bien le 3.3V.

À ce moment là j'ai commencé à sérieusement me remettre en question. C'était le deuxième prototype qui mourrait comme ça. Je me suis dis que je devait faire quelque chose que les ESP ne supportent pas. Quelque chose en rapport avec la batterie ou l'alimentation.

En parallèle de l'impression et des tests du boîtier, j'ai interrogé ChatGPT. Je m'en sers surtout comme outil de réflexion et comme générateur d'idée. Je m'efforce de présenter le problème et décrire les événements. Je lis ce qu'il répond et vois si des choses me parlent. Je répond ce qui me passe par la tête pour alimenter la réflexion, etc.

Je trouve toujours surprenant les tournures du genre *"A failure mode I've personally seen on small ESP32 boards"*. J'ai l'impression qu'elles sont de plus en plus fréquentes en ce moment, et je pense qu'elles devraient être évitées.

La piste principale était que le circuit d'alimentation est mort, mais cela ne m'a pas vraiment fait avancer. Parmi les choses qu'il m'a dites : *"The fact that one board works and others don't suggests a process-related issue rather than a design issue. Solder bridges or conductive debris under the board"*. Ça suggère une mauvaise manipulation ou des maltraitances pendant l'assemblage. Il a également mentionné des chocs électrostatiques pendant les manipulations. Je devrais peut-être faire plus attention lorsque je manipule la carte.

*"The battery pads are tiny and located near sensitive circuitry"*. Les pastilles de connexion pour la batterie m'ont toujours mis mal à l'aise. Elles sont petites et je trouve qu'il n'est pas pratique d'y souder un fil. J'ai effectivement toujours peur d'abîmer la carte en chauffant avec le fer.

ChatGPT a également mentionné que le fait que les boutons amènent directement le 3,3 V sur les GPIO peut être dangereux si ceux-ci sont configurés en sortie et positionnés à 0. Il a suggéré : *"Adding a 1 kΩ–10 kΩ series resistor between each button and the GPIO is cheap insurance"*. J'ai trouvé cela intéressant et je le garde en tête.

J'ai également effectué quelques recherches pour voir comment les gens utilisent les ESP avec une batterie et comment ils connectent la batterie aux pastilles de connexion situées sous l'ESP. J'ai aussi cherché à savoir quelles sont les techniques courantes pour utiliser ce genre de connexions dans le cadre d'une liaison carte-à-carte. La technique qui m'a semblé la plus accessible consiste à placer un via en face de la pastille et à faire couler l'étain dedans. Ça m'a laissé un peu perplexe.

J'ai continué à converser avec ChatGPT et, à un moment, il a indiqué : *"The XIAO battery pads are intended for a LiPo connected all the time. Power transients from hot-plugging batteries can stress or even kill the regulator"*. Ça correspondait à ce que j'avais observé. Dans tous les exemples que j'avais vus, les gens soudent directement la batterie sur les pastilles. Je n'aime pas l'idée que la carte soit alimentée en permanence, c'est pour cette raison que j'ai mis un interrupteur marche/arrêt en série avec la batterie. Mais ChatGPT a indiqué que le fait de connecter et déconnecter la batterie, surtout lorsque l'USB est branché en même temps, peut solliciter fortement le module d'alimentation, qui peut finir par lâcher.

J'aime quand un système est robuste, et j'aime tester ses limites. Dans le cas présent j'ai branché/débranché l'USB, connecté/déconnecté la batterie, etc. sans précautions particulières car je m'attends, ou en tout cas je souhaite, que le système supporte ce genre d'usages. Mais les événements récent  semblent indiquer que ce n'est peut-être pas le cas.

Ce n'est pas une conclusion définitive car le prototype précédent que j'utilise régulièrement survit bien alors que j'ai tendance à déconnecter la batterie avec l'interrupteur plusieurs fois pendant un film, car la batterie ne tient pas très longtemps. Mais peut-être que c'est surtout quand l'USB est branché que ça pose problème.

Quoi qu'il en soit j'ai décidé qu'à partir de ce moment-là je connecterai la batterie directement sur l'ESP32, et j'utiliserai les modes sommeil si je ne veux pas décharger la batterie trop vite.


## Deuxième carte et finalisation du boitier

Le fabriquant du PCBs m'a fournit une dizaine de PCBs donc j'ai de la marge pour recommencer une nouvelle carte. J'ai tous les composants en de multiple exemplaires donc pas de soucis à ce niveau là. J'ai encore deux ESP32 en réserve. Il y a juste les boutons que j'ai en nombre limité. Je n'ai que 10 exemplaires de chaque taille de tige, mais il est toujours possible de s'adapter.

Je décide donc de souder un nouvel exemplaire du PCB en laissant cette fois de côté tout ce qui touche à la batterie pour déjà voir si ça tient comme ça. Et si c'est le cas je rajouterai la batterie mais je remplacerai l'interrupteur par un fil.

C'est donc reparti pour une séance de soudure. C'est l'occasion de pratiquer. Je développe ma technique. Cette fois il y a juste les boutons et les broches de l'ESP à souder, c'est vite vu. J'essaie cette fois de toucher un minimum l'ESP avec mes doigts.

Une fois soudée je teste la carte, tout fonctionne bien du premier coup. Je laisse branché en USB pendant que je continue sur le boitier, et je vérifie périodiquement que ça fonctionne toujours. Je m'efforce de ne pas brancher/débrancher inutilement.

Je réessaye le capuchon de bouton imprimé précédemment, et je décide d'augmenter la hauteur intérieure d'1mm sans changer la hauteur totale du bouton. Sauf que maintenant le capuchon repose sur le corps du bouton et on ne peut pas cliquer. Je refais le point sur les dimensions et détermine que dans l'état actuel j'ai à peine 1mm de marge entre le corps du bouton et le boitier, ce qui est très peu.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/remote-cross-section-button.png"
            legend="Vue en coupe d'un capuchon de bouton"
        %}

    </div>

</div>


Je décide d'augmenter la hauteur du boitier d'1 mm. Ça ne changera pas beaucoup l'épaisseur finale et ça donnera de la marge pour les boutons. Cette fois le boitier ferme, et les boutons fonctionnent, mais ils dépassent très peu du boitier. J'augmente donc la hauteur d'1mm en changeant une cote sur le dessin, mais je ne fais pas attention au fait que cette modification augmente du même coup la hauteur intérieure. Résultat ça ne clique pas. Je corrige et réimprime donc encore un capuchon. Rien de grave mais c'est plus laborieux que nécessaire. On est sur la fin de journée et je manque de concentration. La perte de l'ESP affecte aussi mon moral.

Le système de capuchon pour les boutons ne me parait pas idéal, et je pourrais peut-être le revoir. En fait c'est surtout que maintenant que j'ai drastiquement affiné la télécommande, le corps des boutons commence à être trop grand. Je note de chercher des boutons plus fins si ça existe.


## Bilan de la journée

Je termine la journée fatigué et un peu déprimé. Les causes de la perte des ESPs sont encore floues, et ça me donne l'impression que le système dans son ensemble est fragile, que la carte peut mourrir à tout instant au détour d'une manipulation anodine. Et je n'aime pas du tout ça. Le boitier et les boutons me donnent également une mauvaise impression. D'un côté l'ensemble semble fragile, bancal, et d'un autre côté il ya des points de frictions. L'impression générale ne me plait pas.

Je pense que c'est surtout la fatigue et les déconvenues de la journée qui me font voir les choses en noir. J'essaie de faire un bilan objectif da la journée. J'ai validé que le PCB fonctionne et que je peux souder correctement les composants dessus, et le PCB a permi d'affiner significativement le design globale de la télécommande, ce qui était tout l'objectif. C'est très positif.

Tous les problèmes qui subsistent peuvent trouver des solutions. Pour l'ESP, même si la cause exacte de la perte reste floue, je vais essayer de connecter directement la batterie. Pour le boitier et les boutons, je peux trouver comment assembler les deux parties du boitier ensemble, peut-être avec des vis ou des aimants. Pour les boutons, j'ai repéré des boutons ultra plats qui permettrait d'améliorer le mecanisme.

J'ai un stock de PCBs donc je peux me permettre d'expérimenter les aspects mécaniques. J'aimerais bien trouver une manière de connecter/déconnecter la carte ESP32 sur le PCB sans la souder à chaque fois, ce serait idéal. Dans le futur je peux peut-être faire une *breakout boards* et utiliser un connecteur plat pour la relier à un PCB. Envisager ces possiblités me redonne le moral un peu.


<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7485.JPG"
            legend="La nouvelle version à côté de la précédente"
        %}

    </div>

</div>


La dernière conclusion de cette journée, c'est que le projet vient de passer d'une phase de prototypage/preuve de concept à une phase d'améliorations itératives.

Jusque là l'objectif était d'obtenir quelque chose qui fonctionne selon les modalités souhaitées, à savoir une télécommande qui fonctionne sans fils et qu'on peut prendre en main. La priorité était sur les aspects fonctionnels et l'esthétique et la rigueur de construction passaient en second. Je ne faisais pas trop attention au confort d'utilisation, je prenais des marges disproportionnées pour être sûr que ça passe, etc. 

Désormais le fonctionnement est établi et je cherche à rendre les choses propres et élégantes. Je veux que les choses soient précises, minimales, et robustes. Ça demande de calculer les choses avec précisions, d'intégrer ensemble plusieurs paramètres concurrents, d'itérer avec des variations mineures, et de garder trace de ce qui fonctionne ou pas.

Je ne m'étais pas vraiment rendu compte de ce changement d'objectif et j'ai continué sur ma lancée. Mais je comprends maintenant que j'ai atteint les limites du mode de fonctionnement initial. Le projet est mûr pour passer à la phase suivante, et il est nécessaire d'adapter la méthode.


## La suite

Je vais utiliser la nouvelle version sans batterie et voir si elle survit. Si c'est le cas je reconnecterai la batterie sans interrupteur, et je me pencherai sur les modes sommeil de l'ESP32.

En parallèle je vais continuer à réfléchir à améliorer le boitier et le mecanisme des boutons. J'ai plusieurs idées pour l'assemblage des deux parties du boitier. Je tiens à ce que les choses restent démontables donc la colle est hors de propos. J'ai déjà commandé les boutons ultra plats qui devraient permettre de faire des boutons plus robustes, si je suis en mesure de les souder sur le PCB existant.

Et en faisant tout ça, je vais formaliser davantage le projet en faisant une fiche de suivi qui comportera des notes de conception, des diagrammes et des équations qui formalisent les relations entre les paramètres, des tableaux comparatifs des solutions envisagées, etc, à la manière de ce que j'ai déjà fait pour d'autres projets.