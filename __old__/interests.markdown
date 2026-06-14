---
layout: page
last_updated: 2025-10-12
title: Interests
published: false
---

<ul>
    {% assign topics = "science, space, programming, 3D printing, electronics, woodworking, LEGO, photography, music, cinema" | split: ", "  %}
    {% assign links = "" | split: "" %}
    {% for topic in topics %}
        <li><a href="/{{ topic | split: " " | join: "" }}">{{ topic }}</a></li>
    {% endfor %}
</ul>