---
layout: post
title:  "Project: Smart drawers"
date:   2025-03-28 09:17:53 +0100
---

![](/assets/2025-03-28-smart-drawers/0.jpg){: style="padding-bottom: 1rem"}

In this article, I present the general idea and the choice of components.
Later, I will share project updates.

## Introduction

In a previous article, I introduced the solution I designed and built to organize the LEGO pieces I sell in my online store. I am always looking to optimize stock management, whether it’s when I pick pieces for order preparation or when I add new pieces. Meanwhile, I've recently wanted to get back into electronics.

The first idea that came to mind was to implement a system of light indicators to highlight the drawer containing the pieces to pick. However, integrating components into a drawer that needs to remain mobile seemed complex. Moreover, I think a single LED wouldn’t be noticeable enough. Perhaps a whole strip of LEDs would be needed, or I could add a beep.

The next idea was to automate the drawer opening. A complete mechanization seemed complex and costly, and it would likely take up valuable space. So I rather leaned towards a simple push mechanism, similar to cash register drawers. The movement and noise are effective for drawing attention to the drawer. Initially, I imagined spring loaded drawers with a mechanical locking system that could be released electronically. That seemed complicated to develop and integrate, and it would also prevent manual opening, which I did not want.

Then I had the very simple idea to use electromagnets to push permanent magnets attached to the drawers. This could be integrated into the back of the furniture without taking up much space and would not prevent manual opening of the drawers. It’s an extremely simple and elegant solution!

### General architecture

The system would be controlled by my picking software, which would command the opening of the appropriate drawer at the moment I need to pick the pieces.

First, I need a control board to orchestrate the magnets and communicate with the PC. The simplest option is probably a Raspberry Pi, which I am already familiar with. However, I wanted to learn something new. I’ve heard a lot about Arduino but have never tested it myself. This is the perfect opportunity to remedy that. Furthermore, I want to work at a lower level, particularly regarding wireless communication. From a software perspective, working on a Raspberry Pi is akin to working on a Linux PC, and I don’t want that.

For wireless communication with the PC, I opt for Bluetooth, which seems to be a simple and widely used solution.

The magnets will be mounted at the back of the furniture and wired to the control board and the rest of the circuit, which will be integrated somewhere at the back of the furniture.

### Component research

As with any project involving many new elements, I start by aiming for something as simple as possible. The goal is to minimize sources of complications to achieve something that works. This allows me to validate the basic principle and get a handle on things. I can then iterate and refine.

I started my research on Amazon out of habit, but I quickly switched to AliExpress because the prices are significantly lower. The project is an experiment; I’m primarily looking to learn and test ideas. Entry-level components are sufficient. Some may remain unused, and others may be damaged, so there's no need to invest in quality.

If the project is successful, I can clean it up by refining the component choices for efficiency and durability.

In the same vein, when relevant, I lean towards prototyping components rather than final components. The cleanup will replace these components with final versions and free up the prototyping components for future projects.

## Control board

I choose the Arduino UNO R4 Wi-Fi. It’s the classic model, equipped with wireless Bluetooth and Wi-Fi connectivity. The presence of Wi-Fi is interesting; it leaves the option to use it for PC communication in addition to or instead of Bluetooth.

![Arduino UNO R4 Wi-Fi on the Arduino store](https://store.arduino.cc/cdn/shop/files/ABX00087_01.iso_65d9153b-9fe3-4d51-8f0a-750fcca31c5e_509x382.jpg)

[Arduino UNO R4 Wi-Fi on the Arduino store](https://store.arduino.cc/en-fr/products/uno-r4-wifi)

## Electromagnets

First and foremost, I need to have an idea of the force required to open a drawer. Ideally, I would have used a dynamometer, but I don’t have one. After some thought, I attached a string to a handle, stretched the string across the table in front of the drawer, and suspended various objects from the string until the drawer opened under the weight of the object acting through the string. By weighing the object afterward, I get an idea of the necessary force. In this case, an object weighing barely 100g was enough.

There apparently exists a kind of standard model of electromagnets, which comes in various sizes and strengths. The typical forces are in the kilogram range, which is more than sufficient for my case. The magnets are powered by 12 or 24V DC and have a threaded back for mounting.

![Electromagnets on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sb93cfd04f3e84579b00a24a26e19ce7fg.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Electromagnets on AliExpress](https://fr.aliexpress.com/item/1005005712625900.html)

## Controlling the magnets

Once I found the magnets, I needed to figure out how to control them with the Arduino, knowing that it operates at 5V. A search leads me to [this tutorial](https://deepbluembedded.com/arduino-electromagnet-control-circuit-code-example/) that does exactly what I’m trying to achieve.

### Transistor

The principle is to use a transistor as a switch that opens or closes the power circuit for the magnet. The tutorial uses an NPN bipolar transistor, reference TIP120. It’s a common reference, and I have no trouble finding it.

![Transistor TIP120 on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S39a89f0f8b0246e38bbc624e360ee1f19.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Transistor TIP120 on AliExpress](https://fr.aliexpress.com/item/1005007657188686.html)

### Resistors

A resistor is required to control the transistor. The value of the resistor depends on the characteristics of the transistor and the magnet. In my case, I don’t have much information about the electromagnet. For now, I’ll go with the resistor used in the tutorial. Once I have the magnet in hand, I can measure the data I need. In the meantime, to move forward, I find a pack of 300 resistors of different values on AliExpress for less than €2.

![Resistors on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S5afe69af1b43434f91b42a4f37a3b4c0Q.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Resistors on AliExpress](https://fr.aliexpress.com/item/1005005855324735.html)

### Diode

Finally, since the electromagnet is a solenoid, a *flyback diode* is required. A solenoid opposes sudden changes in current and needs to dissipate its energy when its power supply is cut off. This is the role of the flyback diode, which is connected in parallel in the opposite direction and thus forms a secondary circuit where the energy can dissipate without damaging the rest of the main circuit. The diode must be rated to handle the voltage and current. The classic reference is 1N4001, which can handle 1A and 50V, which is more than sufficient. I find this reference easily on AliExpress.

![Diodes 1N4001 on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S372589c6b14d453290d0a126206a4b6c3.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Diodes 1N4001 on AliExpress](https://fr.aliexpress.com/item/1005001552094086.html)

## Controlling multiple magnets

I have about thirty drawers in total and plan to install at least two magnets per drawer. Since the Arduino has only about ten output ports, I need a solution to add more outputs.

While researching, I first came across I2C circuits that add complete GPIOs, meaning ports that can be configured as input or output, with or without pull-up, etc. There are 16 ports per chip, and it’s possible to connect up to 8 chips on the same I2C bus by playing with the addresses for a total of 128 pins. This is sufficient for my case, but I always plan to expand my LEGO storage capacity, and the idea that there is a limit to the number of magnets I could control bothers me.

I continue my research and come across shift registers. These are very simple circuits that transform a serial output into parallel. The pins only function as outputs, which is not an issue in my case. They can be connected in series (*daisy chaining*) without any theoretical limit. This is perfect for me. The classic circuit is the 74HC595. I find the reference easily on AliExpress.

![Shift register 74HC595 on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sf000bea0f39043eeba141d929dc9001et.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Shift register 74HC595 on AliExpress](https://fr.aliexpress.com/item/1005004856540723.html)

## Power supply

The last major topic. I need to power the Arduino and the magnets. The Arduino operates at 5V. The magnets must be powered by 12V. I think the magnets can operate at 5V. The force will be reduced, but that may be sufficient in my case. However, I prefer to play it safe, even if it means adjusting later.

The documentation indicates that the Arduino can accept up to 24V input via an internal regulator that reduces the voltage to 5V. This simplifies things since I can use a common 12V power supply.

Even though it would be entirely possible, I do not want to use batteries.
So I look for wall bricks.

I don’t want to deal with finding the right connector. The Arduino has a classic *barrel jack* connector, but the documentation indicates that it can also be powered via pins. I find several power supply models provided with an adapter that allows wire connections. This will make things simpler. As a bonus, I find a model on AliExpress that is adjustable from 3-24V. This will allow me to adjust the magnet strength and will surely be very useful for future projects.

![Adjustable power supply 3-24V on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sd13fa0cffb734b0c834870c1d11174d9e.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Adjustable power supply 3-24V on AliExpress](https://fr.aliexpress.com/item/1005005638098269.html)

## Permanent magnets

The last piece of the puzzle. I had already bought magnets on AliExpress for a previous project, and I know that there are all sorts. I’m looking for magnets that are both flat enough not to take up too much space and wide enough to maximize interaction with the electromagnet. Even though I plan to embed them in the wood of the drawer in the long run, initially, I think I will simply attach them to the surface. Since the furniture is not designed to accommodate items in the back, the more compact the magnets are, the better. I choose a reference of 20x2mm with adhesive included.

![Permanent magnets on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/Sfcbed82347c64b00a45a704217c2df3a7.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Permanent magnets on AliExpress](https://fr.aliexpress.com/item/1005008096510030.html)

## Miscellaneous

The essentials are there. Now let’s see if I have everything needed to work efficiently.

I still have a nearly new breadboard in stock. I will start with that and see how far I can go. It will be too small to implement the circuits for all the drawers, but I think I can do a few to validate the principle. Ultimately, I could clean it up with a soldering board. I could even consider designing and having a custom printed circuit board made and creating a housing via 3D printing.

I also have a few jumpers and some LEDs in stock. These will be useful for experimenting and getting familiar with the components.

I will need wire to connect the magnets in the drawers to the central board. Two wires are needed per magnet, so I need enough total length. I will buy a few small spools of wire.

I will also order a basic multimeter. And that concludes the list of components.

![Wire on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S225cab5c7b6747cebf09016371dcfcceo.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Wire on AliExpress](https://fr.aliexpress.com/item/1005007256968315.html)

![Multimeter on AliExpress](https://ae-pic-a1.aliexpress-media.com/kf/S2a0fe6eaf6814accb0536a4c467851e75.jpg_960x960q75.jpg_.avif){: style="width:50%"}

[Multimeter on AliExpress](https://fr.aliexpress.com/item/1005005981700177.html)