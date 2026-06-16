---
layout: post
title: Amélioration de ma télécommande multimédia avec un PCB dédié
topics: [pcb, soldering, 3dmodelling, troubleshooting]
image: 
permalink: /en/posts/2026/06/15/001
lang: en
lang_fr: /fr/billets/2026/06/15/001
---




This weekend's goal was simple: assemble the new PCB revision of my media remote and adapt the enclosure around it.

In practice, it turned into one of those sessions that reminds me that building hardware is rarely about executing a plan. It's about discovering all the assumptions hidden inside that plan.

## Starting with measurements

Before soldering anything, I wanted to redesign the enclosure around real dimensions rather than estimates.

The PCB itself measured exactly 1.6 mm, as expected. With the ESP32 installed, the total height came to about 6 mm. The battery pushed that to roughly 7 mm.

That number immediately became important: the enclosure could not be thinner than the tallest component.

From there I started working backward.

How much clearance did I want above the battery?

Where should the enclosure split line be relative to the USB port?

How tall should the buttons be?

I spent a surprisingly long time answering these questions. On paper they seem trivial. In reality, every decision affects several others.

The good news was that each iteration made the enclosure thinner. The original prototype was around 19 mm thick. After a few rounds of calculations and CAD adjustments I got the design down to roughly 10 mm.

That felt like a huge improvement.

## The button dilemma

Most of the mechanical design revolved around the buttons.

I had to choose between two switch heights: one slightly under 8 mm and another just under 9 mm.

The shorter one seemed safer.

The taller one seemed more flexible.

Eventually I chose the taller version.

The reasoning was simple: if a button is slightly too tall, I can compensate in the button cap design. If it's too short, there is very little I can do afterward.

What's funny is that I spent far more time thinking about this choice than it objectively deserved.

At some point I realized why.

Soldering makes decisions feel permanent.

Choosing the wrong button would mean desoldering parts and reworking the board. Rationally, that wasn't a disaster. Emotionally, it made me hesitate.

I noticed myself moving unusually slowly because I didn't want to make the wrong choice.

## Time to solder

Once the design work felt good enough, I moved on to assembly.

I planned the soldering order carefully:

* Power switch first while the PCB was still easy to hold.
* Battery connector before the ESP32.
* ESP32 afterward.
* Final connections last.

While inspecting the board I suddenly became worried that I might have used the wrong ESP32 pins in the design.

After checking the schematic, everything turned out to be correct.

A recurring theme of the weekend emerged: many problems existed only in my head until I verified them.

## Software problems disguised as hardware problems

After assembly came firmware testing.

The first obstacle was Arduino IDE refusing to recognize the boards correctly.

That led me down a brief rabbit hole of IDE updates, board package updates, and USB port selection.

Eventually everything flashed successfully.

Then none of the buttons worked.

After some debugging I discovered I had forgotten to solder the 3.3 V connection.

Not exactly a sophisticated failure mode.

Once corrected, almost everything worked.

Except one button.

The soldering looked good.

The schematic looked good.

The code looked good.

Shorting the pin directly on the ESP32 didn't work either.

That was the clue.

Eventually I found that I was still using the same pin for battery monitoring code that no longer made sense in this design.

I removed the battery monitoring code entirely, reflashed, and the button immediately started working.

One more mystery solved.

Then two buttons started generating double keypresses.

This time the culprit really was hardware: a tiny solder bridge between adjacent connections.

A bit of cleaning fixed it instantly.

## The battery connector saga

Then came the real challenge.

The battery.

The first time I connected it, I heard crackling noises.

I disconnected it immediately.

The ESP32 felt warm.

That's not a sound you want to hear from electronics.

A multimeter quickly revealed a short circuit near the battery connector.

The location could hardly have been worse: tiny pads, cramped access, right next to sensitive circuitry.

I cleaned the solder, removed excess material with a pump, verified everything electrically, and tried again.

Success.

At least temporarily.

Later in the session the connector started smoking.

Actual smoke.

At that point there was no avoiding it: the connector had to come off completely.

Removing it was tedious. One pad even started lifting from the PCB.

After cleaning everything thoroughly I reinstalled the connector with much less solder, checked continuity, checked for shorts, checked again, and finally reinforced it with glue.

It seemed stable.

For a while.

## Losing an ESP32

Eventually one ESP32 stopped behaving correctly.

It would no longer enumerate properly.

The regulator appeared dead.

The board became warm in suspicious ways.

At that point I considered it lost.

Surprisingly, I wasn't devastated.

Annoyed, yes.

But I had spare boards, spare PCBs, and enough evidence to start forming a theory.

The failures seemed connected to battery integration rather than the PCB design itself.

That distinction was important.

A design flaw would have required revisiting everything.

A process flaw is much easier to fix.

## Printing and fitting

While debugging electronics, I was also iterating on the enclosure.

I printed parts individually rather than committing to full prints.

Using transparent filament turned out to be incredibly useful because I could actually see how the PCB was sitting inside the enclosure.

That revealed small positioning issues that would have been difficult to diagnose otherwise.

The enclosure fit surprisingly well.

The USB opening was almost correct.

The switch location matched the model.

The overall thickness felt fantastic.

For the first time, the device started looking like a real product instead of a collection of experiments.

## The buttons strike back

Unfortunately, the buttons had one final surprise waiting for me.

They were too tall.

The enclosure would not close.

In hindsight, the evidence had been there all along.

The calculations were close enough that a small error became significant.

The good news was that the failure was informative.

Smaller buttons would definitely work.

Larger buttons definitely would not.

That is still progress.

I also experimented with changing the depth of the button caps.

One version looked promising until I tested it and discovered the cap was resting on the switch body, making it impossible to click.

Another reminder that CAD models are not reality.

## Ending the day with mixed feelings

By the end of the session I wasn't entirely satisfied.

An ESP32 was dead.

The battery situation still felt fragile.

The button mechanism wasn't as refined as I wanted.

The enclosure needed more work.

And yet, when I reviewed what had actually happened, the picture looked very different.

The PCB had been validated.

The firmware worked.

The enclosure was dramatically thinner than before.

I had identified a likely cause for the ESP32 failures.

I had concrete measurements instead of assumptions.

I had a functioning assembled prototype.

Objectively, it was a productive weekend.

Subjectively, it felt messy.

## A realization about project phases

The most useful insight wasn't technical.

It was about process.

Up until now this project has been in exploration mode.

The goal was simple:

Can this work?

When you're asking that question, a messy workflow is acceptable. Notes can be incomplete. Decisions can live in your head. Documentation can wait.

But eventually you reach a point where the next bottleneck isn't technology.

It's organization.

I think I've reached that point.

The frustration I've been feeling isn't really about the hardware.

It's a signal that the project has outgrown the "just make it work" phase.

Now I want diagrams.

Design notes.

Decision logs.

Tracking documents.

Measurements recorded somewhere permanent.

In other words, I want to treat it less like an experiment and more like a product.

That's actually a good problem to have.

It means the proof-of-concept phase is largely over.

Now comes the harder—and more interesting—part: making it good.




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
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7458.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7462.JPG"
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
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7488.JPG"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/IMG_7489.JPG"
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
            url="/assets/posts/2026-06-15-media-remote-pcb/remote-cross-section.png"
            legend="___"
        %}

    </div>

</div>

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/posts/2026-06-15-media-remote-pcb/schematic.png"
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