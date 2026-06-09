---
layout: project
title: Optics simulator
topics: [swiftui, programming, optics, physics]
image: /assets/projects/optics-simulator/screenshot1.png
project_status: 'active 🧑‍💻'
githubs: [https://github.com/alexbinary/OpticsSimulator]
last_updated: 2026-06-01
lang: en
lang_fr: /fr/projets/simulateur-optique
---

For some time now, I’ve been interested in augmented reality, and more specifically in projection systems that can integrate virtual objects into our real field of view. Most current augmented reality devices, whether headsets or glasses, rely on conventional projection paradigms and while they can create the illusion of depth through stereoscopy, it is just that, an illusion. They do not faithfully reproduce the way we naturally perceive the world.

To better understand the challenges as well as the solutions that are currently being developed, I am building a geometric optics simulation software in Swift. The goal is to help develop intuition for the behavior of light, the operation of optical systems, and the formation of images.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/optics-simulator/video.gif"
            legend="Current state of the app"
            alt="An animated image showing the software in action. A source at infinity is placed, then a screen, a converging lens, and a second lens. Light rays are drawn and adapt in real time."
        %}
    </div>

</div>


## Learning by doing

For someone new to optics the concepts can feel abstract. It is relatively easy to understand what happens when a light ray passes through a lens or reflects off a mirror, but it is harder to see how that affect the final image. What do we see at the end?

I have studied geometric optics in high school and wanted to revisit it from a more hands-on perspective. I learn more effectively by experimenting directly with concepts, and I want this software to be an interactive tool that allows users to modify the parameters of an optical system and immediately observe the consequences in a visual and intuitive way.

At the moment, the application supports:

* converging lenses;
* diverging lenses;
* plane mirrors;
* concave spherical mirrors;
* convex spherical mirrors;
* objects located at infinity.

It is also possible to add an observation screen and precisely choose which rays should be displayed or hidden. For now, the simulation is limited to a single optical axis, but I plan to move toward a free two-dimensional representation. This will likely be an interesting challenge.


## How I am building it

My development process is incremental. I add features one at a time and evolve the code architecture as new requirements emerge, rather than attempting to design the entire system upfront. This approach is heavily inspired by the [Handmade Hero video series by Casey Muratori](https://www.youtube.com/watch?v=Ee3EtYb8d1o).

The application is built entirely with SwiftUI and the Canvas API, with no external dependencies. Development takes place in Xcode, making extensive use of SwiftUI previews. I have implemented a system for saving and loading optical configurations, which greatly speeds up iteration cycles. 


## Technical challenges

One of the main challenges of the project is ray tracing. There are many cases to handle, some of them quite complex: distinguishing between the real and virtual portions of rays, extending trajectories to reveal relevant construction points, avoiding unnecessary overlaps, and maintaining a clear representation of the scene.

After several iterations, I arrived at a multi-stage architecture. First, I define the pedagogically relevant rays and the points they must connect. This is where most of the optical logic resides. Next, each ray is analyzed to determine which portions are real and which are virtual, based on the relative positions of sources, optical elements, and images. Finally, a deduplication phase ensures that every segment is drawn only once.


## What's next

In the future, I would like to expand the simulator with additional features:

* free positionning on a 2D space;
* mechanical constraints between elements to simulate simple mechanisms;
* semi-transparent mirrors;
* apertures;
* image rendering capabilities to visualize what would actually appear on a screen or through an optical system.

The objective is to create a tool that helps people understand optics through direct experimentation, making visible phenomena that often remain abstract when presented only through static diagrams or equations.
