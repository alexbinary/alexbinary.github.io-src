---
layout: project
project_id: ec2e67a6-246f-484e-abc7-6387aa07874a
title: Simulateur optique
topics: [swiftui, programmation, optique, physique]
image: /assets/projects/optics-simulator/screenshot1.png
githubs:
- https://github.com/alexbinary/OpticsSimulator
last_updated: 2026-06-01
lang: fr
lang_en: /en/projects/optics-simulator
---

Depuis quelque temps je m'intéresse à la réalité augmentée, et plus particulièrement aux systèmes de projection capables d'intégrer des objets virtuels dans notre champ de vision réel. La plupart des dispositifs de réalité augmentée actuels, qu'il s'agisse de casques ou de lunettes, utilisent le même principe de projection d'image que les écrans conventionnels et bien qu'ils puissent créer l'illusion de profondeur grâce notamment à la stéréoscopie, ça reste une illusion. Ils ne reproduisent pas fidèlement la manière dont nous percevons naturellement le monde.

Pour mieux comprendre les enjeux et les solutions alternatives en cours de développement je développe un logiciel de simulation d'optique géométrique en Swift. L'objectif est de développer une compréhension intuitive du comportement de la lumière, du fonctionnement des systèmes optiques et de la formation des images.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/optics-simulator/video.gif"
            legend="Démo de l'état actuel du logiciel"
            alt="Une image animée montrant le logiciel en action. On voit la mise en place d'une source à l'infini, un écran, une lentille convergente, puis une seconde lentille. Les rayons lumineux sont dessinés et s'adaptent en temps réel."
        %}
    </div>

</div>


## Apprendre par la pratique

Pour quelqu'un qui découvre l'optique, les concepts ne sont pas franchement intuitifs. Il est relativement simple de comprendre comment un rayon lumineux est dévié quand il traverse une lentille ou se réfléchit sur un miroir, mais il est moins simple de se représenter ce que ça signifie en terme d'image. Comment ce qu'on voit est modifié ?

J'ai eu des cours d'optique géométrique au lycée, et j'ai eu envie de m'y replonger avec une approche plus pratique. J'apprends généralement mieux quand je peux manipuler directement les concepts. Ce logiciel est conçu comme un outil interactif permettant de modifier les paramètres d'un système optique et d'observer immédiatement les conséquences de manière visuelle et compréhensible.

À l'heure actuelle, le logiciel prend en charge :

* les lentilles convergentes ;
* les lentilles divergentes ;
* les miroirs plans ;
* les miroirs sphériques concaves ;
* les miroirs sphériques convexes ;
* les objets situés à l'infini.

Il est également possible d'ajouter un écran d'observation et de choisir précisément quels rayons afficher ou masquer. Pour le moment, la simulation est limitée à un axe optique unique, mais j'envisage de passer à une représentation libre en deux dimensions. Ce sera probablement un bon challenge.


## Méthodologie

Je travaille de manière incrémentale. J'ajoute les fonctionnalités une par une et je fais évoluer l'architecture du code au fur et à mesure des besoins, plutôt que de chercher à concevoir l'ensemble du système à l'avance. Une approche inspirée par la série de vidéos [Handmade Hero de Casey Muratori](https://www.youtube.com/watch?v=Ee3EtYb8d1o) que je regarde en ce moment.

L'application est entièrement développée avec SwiftUI et l'API Canvas, sans dépendance externe. Je travaille dans Xcode en utilisant intensivement les previews SwiftUI. J'ai mis en place un système de sauvegarde et de chargement des configurations optiques, ce qui accélère énormément les itérations. 


## Challenges techniques

L'un des principaux défis du projet est le tracé des rayons lumineux. Les cas à gérer sont nombreux et parfois complexes : il faut distinguer les parties réelles et virtuelles des rayons, prolonger certaines trajectoires pour faire apparaître les points de construction pertinents, éviter les superpositions inutiles et conserver une représentation claire de la scène.

Je suis arrivé à une architecture en plusieurs étapes : dans un premier temps, je définis les rayons pédagogiquement pertinents ainsi que les points qu'ils doivent relier. C'est à ce niveau que se concentre l'essentiel de la logique physique. Ensuite, chaque rayon est analysé afin de déterminer quelles portions sont réelles et lesquelles sont virtuelles, en fonction de la position relative des sources, des dispositifs optiques et des images. Enfin, une phase de déduplication garantit que chaque segment n'est tracé qu'une seule fois pour un rendu propre et net.


## La suite

J'aimerais enrichir le simulateur avec de nouvelles fonctionnalités :

* un positionnement libre en 2 dimensions ;
* des contraintes mécaniques entre les éléments pour simuler des mécanismes simples ;
* des miroirs semi-transparents ;
* des diaphragmes ;
* un rendu d'image permettant de visualiser ce qui apparaîtrait réellement sur un écran ou à travers un système optique.

L'objectif reste le même : créer un outil qui permette de comprendre l'optique par l'expérimentation directe, en rendant visibles des phénomènes qui restent souvent abstraits lorsqu'ils sont présentés uniquement sous forme de schémas statiques ou d'équations.
