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
            legend="Premières soudures"
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


Je reconnecte la batterie et j'entends encore des crépitements. Cette fois je vérifie au multimètre et je confirme qu'il y a encore un court circuit entre les bornes du connecteur de la batterie. C'est vraiment le pire endroit pour intervenir car il est situé juste à côté de l'ESP32 et l'endroit n'est pas hyper accessible. C'étais quasiment mes premières soudures de la journée et elles pourraient être mieux. Les pastilles du PCB sont vraiment proches et j'ai mis beaucoup d'étain. J'aspire avec la pompe à désouder et c'est déjà plus propre. Je vérifie au multimètre et c'est tout bon ! J'espère maintenant que la batterie n'a pas subit de dommages.

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


Pendant que la partie supérieure s'imprime, je teste un peu le système. À la connexion bluetooth qui saute je vois que la carte s'éteint sporadiquement quand je manipule la batterie. C'est sans doute préférable à un court circuit, mais pas terrible quand même. Si je ne touche à rien ça a l'air de tenir, c'est déjà ça.

Et puis soudain, plus rien. Je soupçonne la batterie d'être à plat, alors je décide de charger. Cependant je n'ose pas brancher au PC par peur des conséquences qu'un court circuit pourrait avoir sur celui-ci (même si en vrai je pense qu'il y a peu de risques). Je la branche donc au secteur. Ça fonctionne. Je débranche pour inspecter les connexions au multimètre, tout est ok. Je rebranche au secteur, ça fonctionne quelques instant et puis à nouveau plus de connexion bluetooth, alors que la carte est branchée au secteur. C'est plutôt mauvais signe.

Je débranche et déconnecte la batterie, et branche au PC. ArduinoIDE ne voit pas la carte. ⚰️

Je sens que l'ESP est chaude, et ça me rappelle un prototype précédent qui est mort de la même manière. Je teste au multimètre et la patte qui sort normalement le 3.3V ne sort rien. Je compare avec une ESP qui fonctionne et j'ai bien le 3.3V.

À ce moment là je commence à sérieusement me remettre en question. C'est le deuxième prototype qui meurt comme ça. Je me dis que je dois faire quelque chose que les ESP ne supportent pas. Quelque chose en rapport avec la batterie ou l'alimentation.

J'envisage de recommencer une nouvelle carte, en laissant la batterie de côté dans un premier temps pour voir si ça survit comme ça. J'ai reçu une dizaine de PCBs donc j'ai de la marge. J'ai tous les composants en de multiple exemplaires. J'ai encore deux ESP32 en réserve. Il y a juste les boutons que j'ai en nombre limité. Je n'ai que 10 exemplaires de chaque taille de tige, mais il est toujours possible de s'adapter. En attendant je veux déjà voir comment ce que donne ceux que j'ai choisi.

J'assemble la partie supérieure du boitier, et quelque chose empêche de fermer complètement. Il s'avère que c'est le connecteur batterie. Décidément toujours lui. J'avoue que je ne l'avais pas pris en compte dans mes calculs d'épaisseur du début. En fait il ne fait que 6mm donc ça devrait passer, mais avec les péripéties de la journée il a fini soudé sans être enfoncé complètement. Malgré ça le boitier global est très fin et ça ma plait beaucoup.

J'imprime un capuchon de bouton, je teste, et le boitier ne ferme pas, il y a quasiment 2mm de trop. Donc pour la prochaine version je peux prendre des boutons plus petits sans soucis, mais clairement pas des plus grands.


## Réflexion sur la mort de l'ESP

J'aimerais comprendre pourquoi les ESP meurent et comment l'éviter. J'interroge ChatGPT. Je m'en sert surtout comme outil de réflexion et comme générateur d'idée. Je m'efforce de présenter le problème et décrire les événements. Je lis ce qu'il répond et voit si des choses me parlent. Je répond ce qui me passe par la tête pour alimenter la réflexion, etc.

Je trouve toujours surprenant les tournures du genre *"A failure mode I've **personally** seen on small ESP32 boards"*. J'ai l'impression qu'elles sont de plus en plus fréquentes en ce moment, et je pense qu'elles devraient être évitées.

La piste principale c'est que le circuit d'alimentation est mort, mais ça ne m'avance pas vraiment. Parmi les choses qu'il me dit : *"The fact that one board works and others don't suggests a process-related issue rather than a design issue. Solder bridges or conductive debris under the board"* Ça suggère une mauvaise manipulation ou des maltraitances pendant l'assemblage. Il mentionne également des chocs électrostatiques pendant les manipulations. Je devrais peut-être faire plus attention quand je manipule la carte.

*"The battery pads are tiny and located near sensitive circuitry"*. Les pastilles de connexion pour la batterie m'ont toujours mis mal à l'aise. Ils sont petits et je trouve qu'il n'est pas pratique de venir souder un fil dessus. J'ai effectivement toujours peur d'âbimer la carte en chauffant avec le fer.

ChatGPT mentionne également que le fait que les boutons amènent directement le 3.3V sur les GPIO peut être dangereux si jamais ceux-ci sont configurés en sortie et sont positionné à 0. il suggère *"Adding a 1 kΩ–10 kΩ series resistor between each button and the GPIO is cheap insurance"*. Intéressant, je garde ça en tête.

Je fais également quelques recherches pour voir comment les gens utilisent les ESP avec une batterie, et comment ils connectent la batterie avec les pastilles de connexion situées sous l'ESP. Je fais également quelques recherches pour voir quelles sont les techniques courantes pour utiliser ce genre de connexions dans le cadre d'une connexion carte-à-carte. La technique qui serait la plus à ma portée consiste à placer un via en face de la pastille et faire couler l'étain dedans. Ça ne me parait pas très convaincant.

Je continue à converser avec ChatGPT et puis un moment *"The XIAO battery pads are intended for a LiPo connected all the time. Power transients from hot-plugging batteries can stress or even kill the regulator*. Ça correspond à ce que j'ai vu. Dans tous les exemples que j'ai vu les gens soudent directement la batterie sur les pastilles. Je n'aime pas l'idée que la carte soit alimentée en permanence, c'est pour cette raison que j'ai mis un interrupteur on/off en série avec la batterie. Mais ChatGPT indique que connecter/déconnecter la batterie, surtout si l'USB est branché en même temps, peu stresser le module d'alimentation, qui peut finir par lâcher. Il me parait probable que c'est ce qui tue mes cartes. Ceci dit, j'ai déjà pas mal utilisé le dernier prototype et comme la batterie ne tient pas très longtemps j'ai tendance à la déconnecter avec l'interrupteur plusieurs fois pendant un film. Et jusque là la carte survit bien.

Je décide qu'à partir de maintenant je connecterai la batterie directement sur l'ESP32. J'utiliserai les modes sommeil si je ne veux pas décharger la batterie trop vite.


## Deuxième carte et finalisation du boitier

Je décide de souder un nouvel exemplaire du PCB en laissant de côté tout ce qui touche à la batterie dans un premier temps pour voir si ça tient comme ça. Et si c'est le cas je rajouterai la batterie mais je remplacerai l'interrupteur par un fil.

C'est reparti pour une séance de soudure. C'est l'occasion de pratiquer. Je développe ma technique. Du coup il y a juste les boutons et les broches de l'ESP à souder, c'est vite vu. J'essaie cette fois de toucher un minimum l'ESP avec mes doigts.

Une fois soudée je teste la carte, tout fonctionne bien du premier coup. Cette fois j'essaie de ne pas trop allumer/éteindre.


j'aime vérifier encore et encore que les choses fonctionnent, surement due à l'anxiété
mais ça peut causer des problèmes
comme la fois où au collège le prof de physique avait demandé de ramener une pile neuve,
et j'en avais une avec le testeur intégré, et je n'arrêtais pas de la tester pour m'assurer qu'elle était bien pleine
quand le prof l'a testé avec son instrument il a dit "elle est pas neuve ta pile"
j'étais degz



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





