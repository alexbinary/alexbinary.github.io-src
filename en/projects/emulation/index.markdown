---
layout: project
project_id: a10edb47-8a09-4f84-9f5d-214ac597b2ad
title: Hardware emulation
topics: [6502, arduino, electronics, programming]
image: /assets/projects/emulation/IMG_7377.JPG
githubs: [
    https://github.com/alexbinary/arduino-6502,
    https://github.com/alexbinary/arduino-eeprom-programmer,
]
last_updated: 2026-06-09
lang: en
lang_fr: /fr/projets/emulation
---

I play video games on emulators and I understand the basic principles of emulation, but I want to learn more and get first hand experience. Sure it would be cool to learn how to write a Game Boy emulator, and it's probably doable with enough patience, but I like to start from the basics. That is why I set out to build a custom hardware system and write an emulator for it. This will allow me to start slow and discover the fundamental principles of emulation, adding complexity at my onw pace.

I chose to use the [6502](https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf) processor and its [6522](https://eater.net/datasheets/w65c22.pdf) interface, taking reference from [Ben Eater's excellent video series](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH) dedicated to those components. The 6502 was the CPU of many consumer devices in the 1980s, notably the Apple II, Commodore 64 and Atari 2600. It is a relatively simple microprocessor, ideal for beginners.  Modernized versions are still in production today, and there's a large community of enthusiasts.

The user interface of my system will initially be minimal, consisting only of buttons and LEDs, and perhaps a small OLED display. This project is primarily an exploration. It is an opportunity to learn low-level hardware concepts and gain experience with the interaction between hardware and software.

In this kind of exploratory project, I like to start from the basics and experiment incrementally with the components, validating expected behavior step by step, comparing my predictions with reality, and building a solid understanding of how things work. I therefore began by familiarizing myself with the 6502, experimenting with the address and data buses, the reset vector, and so on. I then moved on to an EEPROM, which I initially programmed manually on a breadboard by directly manipulating the control signals, before eventually designing an Arduino-driven automatic programming circuit.

I am now running into difficulties with the 6522 interface chip, which led me to build D flip-flops from scratch and interface them directly with the 6502—a completely unexpected but fascinating detour. My next goal is to apply a similar approach to connect at least one button, allowing me to start writing interactive programs and begin thinking seriously about emulation itself.

I have documented this project as it progressed through a series of posts detailing each work session. This page provides a summary of the project in its current state and offers some broader reflections on the discoveries I've made. It is continuously updated as the project advances and as my understanding evolves. Links to the detailed posts can be found throughout the relevant sections. [A complete list of publications is available here](/en/projects/emulation/posts).


## My thoughts on emulation

Writing an emulator first demands to understand how each instruction of a program written for the original electronic system affects the components that interact with the user. This requires a good understanding of the original hardware and the interaction between hardware and software, but it does not necessarily mean faithfully reproducing the internal behavior of every electronic component. What really matters are the elements the user interacts with.

Take the Game Boy as an example. Its user-facing interfaces are the directional pad, the A and B buttons, and the Start and Select buttons for input, along with the screen and speaker for output. The goal of an emulator is therefore to take a game's code—originally written to drive the Game Boy's hardware—and use the PC's hardware to recreate the visuals and sounds that the Game Boy would have produced.

A program may use the hardware in unusual ways, or a user may discover a bug or design flaw that allows the system to be used in an unintended or undocumented manner. Emulator developers must decide which of these behaviors are worth supporting, keeping in mind that any simulation is necessarily imperfect.

This last point is precisely what I want to explore in this project. At what level of accuracy does hardware need to be simulated? Is it always possible to infer the intention behind a sequence of instructions? Consider a device connected to the CPU via I²C, where programs normally use the provided driver. What happens if a program decides to implement the I²C protocol entirely in software instead? What would supporting that use case imply for the emulator's design?


## Hardware used in this project

For the most part, I use the same components as Ben Eater in his videos, or the closest equivalents I can find on AliExpress. Some components came from my own stock. I use my Arduino to program the ROM, observe signals, experiment with components, and also as a power supply.

<table>
    <tr>
        <th>Item</th>
        <th>Ref</th>
        <th>Link</th>
    </tr>
    <tr>
        <td>CPU</td>
        <td><a href="https://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf">6502</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005009342322425.html?spm=a2g0o.order_list.order_list_main.71.4d895e5bCl6ekk&gatewayAdapt=glo2fra">
            Ali<span class="desktop-only">Express</span>
        </a></td>
    </tr>
    <tr>
        <td>EEPROM</td>
        <td><a href="https://ww1.microchip.com/downloads/en/DeviceDoc/doc0006.pdf">AT28C256</a></td>
        <td><a href="https://fr.aliexpress.com/item/4001000243213.html?spm=a2g0o.order_list.order_list_main.77.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>RAM</td>
        <td><a href="https://eater.net/datasheets/hm62256b.pdf">62256</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005001859824763.html?spm=a2g0o.order_list.order_list_main.5.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Logic gates</td>
        <td>
            <a href="https://www.ti.com/lit/ds/symlink/sn74ls02.pdf">74LS02</a>
            <br class="mobile-only">
            <a href="https://www.ti.com/lit/ds/symlink/sn74ls04.pdf">74LS04</a>
            <br class="mobile-only">
            <a href="https://www.ti.com/lit/ds/symlink/sn74ls08.pdf">74LS08</a>
        </td>
        <td><a href="https://fr.aliexpress.com/item/1005007227095225.html?spm=a2g0o.order_list.order_list_main.125.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Shift registers</td>
        <td><a href="https://www.ti.com/lit/ds/symlink/sn74hc595.pdf">74HC595</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005004856540723.html?spm=a2g0o.order_list.order_list_main.370.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Interface</td>
        <td><a href="https://eater.net/datasheets/w65c22.pdf">6522</a></td>
        <td><a href="https://fr.aliexpress.com/item/1005011978744402.html?spm=a2g0o.order_list.order_list_main.83.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>LEDs</td>
        <td></td>
        <td>(stock)</td>
    </tr>
    <tr>
        <td>Buttons</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005004198996493.html?spm=a2g0o.order_list.order_list_main.295.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>OLED screen</td>
        <td>SSD1306</td>
        <td><a href="https://fr.aliexpress.com/item/1005008918700196.html?spm=a2g0o.order_list.order_list_main.150.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Breadboards</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005007174397080.html?spm=a2g0o.order_list.order_list_main.245.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Jumper wire</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005004336218242.html?spm=a2g0o.order_list.order_list_main.230.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Dupont wires</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005007072081464.html?spm=a2g0o.order_list.order_list_main.255.4d895e5bCl6ekk&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Resistors</td>
        <td></td>
        <td><a href="https://fr.aliexpress.com/item/1005005855324735.html?spm=a2g0o.order_detail.order_detail_item.3.1e252dd0EBGFs9&gatewayAdapt=glo2fra">Ali<span class="desktop-only">Express</span></a></td>
    </tr>
    <tr>
        <td>Arduino</td>
        <td><a href="https://docs.arduino.cc/resources/datasheets/ABX00087-datasheet.pdf" class="no-wrap">Uno R4 Wi-Fi</a></td>
        <td><a href="https://store.arduino.cc/collections/boards-modules/products/uno-r4-wifi?_pos=1&_fid=3febf6e59&_ss=c" class="no-wrap"><span class="desktop-only">Arduino </span>Shop</a></td>
    </tr>
</table>


## First steps with the 6502

I started by installing the 6502 on a breadboard, wiring the value `0xEA` onto the data bus, which corresponds to the `NOP` ("No Operation") instruction, and connecting LEDs to the four least significant bits of the address bus. To generate the clock signal, I use a 555-timer-based module that I built by following [Ben Eater's videos](https://www.youtube.com/watch?v=kRlSFm519Bo) on the subject. The LEDs display a counting pattern, indicating that the processor is advancing through the program.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7380.mp4"
            legend="First tests of the 6502"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="001"
%}

I then connected the address and data buses, as well as the read/write signal, to an Arduino and wrote code capable of supplying data on the bus according to the address requested by the CPU. I used this rudimentary setup to provide the CPU with a minimal three-instruction program and verified correct operation by observing bus activity.

For this kind of experiment, the Arduino generates the clock signal. I chose this approach to ensure that I was reading from and writing to the buses at the correct times, since I have not yet studied the 6502's timing characteristics in detail.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7383.JPG"
            legend="The Arduino is connected to the address and data bus of the 6502"
            
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/pgm.mp4"
            legend="Running the first program"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="002"
%}


## Introducing the EEPROM

The Arduino setup was useful for testing, but in the final system the EEPROM will provide the data. Staying true to the spirit of the project, I started from the basics by performing reads and writes through direct manipulation of the control signals, using LEDs to visualize the data. I then wrote Arduino code capable of reading and writing, first one byte at a time and eventually entire sequences.

<div class="inline-image-container force-desktop-full-width">

    <div class="inline-image-container-row mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7389.JPG?mm"
            legend="First EEPROM test setup"
        %}

        {% include inline-video-item.html
            url="/assets/projects/emulation/ROM.mp4"
            legend="Writing the first 14 bytes then reading them"
        %}

    </div>

</div>

Once I was able to program the ROM, I connected it to the 6502, initially as a temporary setup and later as a semi-permanent assembly while trying to keep the wiring reasonably tidy.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7399.JPG"
            legend="The EEPROM connected to the 6502"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="003"
%}


## Building a programmer with shift registers

My Arduino did not have enough pins to connect all eight data lines, fifteen address lines, and the EEPROM control signals. As a result, I initially programmed only four address bits. Later, I used shift registers I already had on hand in order to access the entire memory space.

As usual, I started with the basics, building a minimal setup to familiarize myself with the operation of shift registers. I wrote Arduino code to shift data into the registers and observe the results on LEDs.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7405.mp4"
            legend="Pushing 0xEA in a shift register"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="004"
%}

Afterward, I created a semi-permanent breadboard setup together with Arduino software capable of programming the ROM across its entire address range. I implemented memory-dump functions capable of displaying arbitrary ranges in blocks of sixteen bytes, as well as write functions capable of writing values to one or two bytes at a given address, or entire sequences.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/asm.png"
            legend="The beginnings of an assembler!"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="005"
%}


## Adding the 6522 Versatile Interface Adapter

I call it the VIA for short. The first task was to define the memory ranges allocated to the ROM and the VIA, and implement the chip-select signals. I opted for the simplest possible solution, minimizing both the number of connections and the amount of additional hardware required.

I then rewrote a simple test program for the VIA and connected LEDs to Port A outputs, but I was unable to get any meaningful result. I carefully checked the wiring, reviewed the documentation, observed the signals with the Arduino, and even attempted to control the VIA directly from the Arduino, but nothing worked. There is clearly something I am missing—or perhaps the VIA itself is defective.

<div class="inline-image-container">

    <div class="inline-image-container-row free-width mobile-column">

        {% include inline-image-item.html
            url="/assets/projects/emulation/IMG_7415.JPG"
            legend="Connecting the VIA to the Arduino"
        %}

    </div>

</div>

{% include project_post_link.html
    target_entry="006"
%}


## Making a D Flip-Flop

To continue making progress despite the issues with the 6522, I decided to implement a D flip-flop from logic gates by following the didcated [Ben Eater's video](https://www.youtube.com/watch?v=peCh_859q7Q). It was a bit technical as it involved a fair number of connections. I added two LEDs to visualize the output state—one for the normal output and one for the inverted output.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-image-item.html
            url="/assets/projects/emulation/d-flip-flop.JPG"
            legend="The draft I used when connecting everything"
        %}

    </div>

</div>

I then connected the flip-flop to the first bit of the data bus in place of the VIA and added logic so that it would only capture data when the correct address was used. I confirmed that the state displayed by the flip-flop matched expectations.

<div class="inline-image-container">

    <div class="inline-image-container-row">

        {% include inline-video-item.html
            url="/assets/projects/emulation/IMG_7420.mp4"
            legend="La bascule D remplace le VIA"
        %}

    </div>

</div>

Interfacing a D flip-flop with the 6502 was not part of the original plan, but it turned out to be very rewarding and helped me better understand what may be happening inside chips that communicate over a data bus, such as the ROM or the VIA. I am very glad I took this detour.

{% include project_post_link.html
    target_entry="007"
%}


## Future plans

At this point, I have a 6502-based system that I can program to control an LED according to arbitrary logic. It is obviously still very limited, but it is already becoming an interesting system to emulate.

Before moving on to emulation itself, however, I would like to connect a button so that I can create interactive programs. The idea is to use an approach similar to the D flip-flop experiment, but this time build a device capable of placing data onto the bus. I already have a few ideas about how to achieve that.
