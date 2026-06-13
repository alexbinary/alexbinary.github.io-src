---
layout: post
title: Ajout des aimants MagSafe à un iPhone X avec une coque imprimée en 3D
topics: [3dprint]
image: /assets/projects/phone-case/IMG_7436.JPG
permalink: /fr/billets/2026/06/13/001
lang: fr
lang_en: /en/posts/2026/06/13/001
---

## Introduction

En 2026, mon [iPhone X](https://fr.wikipedia.org/wiki/IPhone_X) commence à faire son âge. Je n'ai jamais mis de coque sur mes téléphones, et les iPhone que j'ai eu par le passé ont toujours bien survécu aux chutes occasionnelles qu'ils ont subit malgré ma prudence. La dernière chute en date de mon iPhone X a provoqué la fissure du dos, et je ne suis plus aussi à l'aise qu'avant pour le laisser vivre sans protection. Étant équipé d'une imprimante 3D, je me suis intéressé à la fabrication de coques.

J'ai trouvé un modèle en ligne que j'ai légèrement adapté puis personnalisé, et j'en suis content. J'ai un peu l'impression de retrouver un nouveau téléphone. J'ai aussi testé différentes couleurs et j'apprécie de pouvoir changer de style.

Dernièrement le port Lightning de mon iPhone X a rendu l'âme. Heureusement, ce modèle est équipé de la charge par induction, et c'est désormais la seule option pour charger la batterie. Je le chargeais déjà régulièrement de cette manière à la maison, mais j'utilisais le port Lightning en déplacement ou dans la voiture. Je ne peux plus faire ça aujourd'hui.

L'iPhone X date d'avant MagSafe, c'est-à-dire qu'il n'est pas équipé des aimants permettant de le lier à la station de charge. Ce n'est pas gênant pour charger à la maison, mais c'est plus embêtant en déplacement ou quand je veux l'utiliser en charge. Pour remédier à ça j'ai acheté un chargeur MagSafe et une coque qui intègre les fameux aimants, et ça fonctionne très bien, mais j'ai voulu essayer d'intégrer les aimants dans les coques que je fabrique moi-même.

J'ai trouvé des [aimants compatibles](https://fr.aliexpress.com/item/1005005115150292.html?spm=a2g0o.order_list.order_list_main.50.cb535e5brNk5u3&gatewayAdapt=glo2fra
) sur AliExpress et en ai commandé quelques uns. En réalité ce ne sont pas des aimants mais de simples pièces métalliques. La description AliExpress indique "plaque métallique magnétique" et "feuille de fer autocollante", donc disons que j'aurais pu m'en douter. Je teste de les mettre sur mon chargeur et ça colle plutôt bien 👍.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/magnet.png"
            legend="Les aimants MagSafe commandés sur AliExpress"
            width="50%"
        %}

    </div>

</div>


## Modélisation

Je commence par prendre les mesures exacts de l'anneau pour modifier mon modèle 3D. Je veux d'abord vérifier l'épaisseur pour voir si je peux l'intégrer dans l'épaisseur de la coque.

Au pied à coulisse je mesure entre 0,4 et 0,5 mm. En tenant compte de la couche adhésive on va dire que l'aimant fait 0,4 mm. Je mesure l'épaisseur de ma coque: 1,4 mm. Il y a donc largement assez de matière pour intégrer l'anneau.

Mon objectif est de minimiser l'épaisseur de plastique entre l'anneau et le chargeur afin de maximiser la force d'attraction. Je décide donc de ne conserver que 0,4 mm de plastique côté extérieur, soit deux couches d'impression avec mes réglages habituels. Ça me semble être le minimum pour que la surface tienne le coup.

J'ai envisagé d'enfermer complètement l'anneau dans la pièce en reprenant l'impression après son insertion. Je n'ai encore jamais fait ce genre de choses et ce serait l'occasion d'essayer. Mais pour un premier prototype je préfère rester simple.

J'ouvre Fusion et je confirme que le fond de la coque fait bien 1,4 mm d'épaisseur.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/profile.png"
            legend="Le profil utilisé pour tracer la coque"
            
        %}

    </div>

</div>

J'avais déjà déterminé la position du centre de la bobine de charge grâce à une image radio de l'iPhone X. Il ne reste donc qu'à dessiner le logement de l'anneau.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/xray.jpg"
            legend="Image en rayons X de l'iPhone X"
            width="50%"
        %}

    </div>

</div>

Je mesure l'anneau et j'ajoute 1mm de marge sur toutes les dimensions pour faciliter l'insertion. Pour reproduire correctement les arrondis, je prends une photo de l'anneau et je l'importe dans Fusion pour servir de référence.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/ring2.png"
            legend="J'utilise un photo comme référence pour la modélisation"
            width="50%"
        %}

    </div>

</div>


## Impression

Avant toute chose je vérifie dans le slicer que l'épaisseur résiduelle est bien de deux couches. Tout est conforme au plan.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/slicer.png"
            legend="Le slicer montre qu'il n'y a pas plus de deux couches dans le fond du logement de l'anneau"
            width="50%"
        %}

    </div>

</div>

Pour ce genre de projets j'aime utiliser un filament transparent. Ici ça permet de vérifier la position et la bonne tenue de l'anneau quand la coque est en place.

L'impression dure 38 minutes ⏳

Comme la pièce est assez fine, je préfère attendre qu'elle refroidisse complètement avant de la décoller du plateau. C'est moins risqué que de la retirer dès la fin de l'impression en pliant le plateau, comme je fais souvent. Avantage supplémentaire du filament transparent : on voit facilement les zones qui se sont décollées et celles qui ne le sont pas encore.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/IMG_7433.JPG"
            legend="La coque imprimée en filament transparent avec le logement pour l'anneau"
            width="50%"
        %}

    </div>

</div>


## Montage

Je vérifie d'abord que l'anneau s'insère correctement dans son logement et ça rentre parfaitement. Je constate qu'il reste encore suffisamment d'épaisseur pour envisager de l'enfermer complètement dans une future version, comme prévu.

Avant de coller l'anneau je teste avec le chargeur MagSafe. L'attraction est nettement moins forte qu'avec ma coque du commerce qui elle embarque de vrais aimants. Ça tient quand même bien, mais le problème principal est que le chargeur ne se centre pas toujours correctement tout seul. C'est un peu décevant.

Je poursuis malgré tout et j'enlève la protection adhésive de l'anneau et le colle dans son logement.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/phone-case/IMG_7436.JPG"
            legend="La coque liée au chargeur grâce à l'anneau métallique"
            width="50%"
        %}

    </div>

</div>


## Conclusion

Le chargeur ne se centre pas automatiquement de manière aussi évidente qu'avec une vraie coque MagSafe et il faut donc rester attentif au positionnement. C'est l'avantage de la coque transparente qui laisse voir l'anneau. En fait il existe quand même une sorte de "puits de potentiel" magnétique, qui fait qu'on peut déplacer légèrement le chargeur et sentir lorsqu'il arrive dans la bonne position. On peut aussi survoler le chargeur avec le téléphone et attendre que ça "claque" tout seul. Et là en général c'est bien positionné.

Sinon la tenue est plutôt bonne. Le chargeur reste bien fixé et je peux utiliser le téléphone pendant qu'il recharge sans problème. Je suis satisfait de ce premier prototype. Object rempli.