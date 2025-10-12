---
layout: page
last_updated: 2025-10-12
---

<table style="border: none; color: black;">
    <tr>
        <td style="vertical-align: top; border: none; padding: 0 2rem 0 0;">

            <h1>Hi, I'm Alex 👋</h1>

            <p>I'm an engineer and maker.</p>

            <p>
                I'm interested in 
                {% assign topics = "science, space, programming, 3D printing, electronics, woodworking, LEGO, photography, music, cinema" | split: ", "  %}
                {% assign links = "" | split: "" %}
                {% for topic in topics %}
                    {% capture link %}<a href="/{{ topic | split: " " | join: "" }}">{{ topic }}</a>{% endcapture %}
                    {% assign links = links | push: link %}
                {% endfor %}
                {{ links | join: ', ' }}.
                Click any of these to see related content.
            </p>

            <p style="margin-top: 3rem">Living in France, recently moved from Strasbourg to Toulouse.
            <i>Moving is always a challenge, but challenge make you grow.</i></p>

        </td>
        <td style="vertical-align: top; border: none; padding: 0;">

            <img src="assets/profile3.png" width="60%" style="padding-bottom: 1rem;" alt="profile" />
            <ul class="social-media-list">
                <li>
                    <a href="https://github.com/{{ site.github_username| cgi_escape | escape }}">
                        <svg class="svg-icon"><use xlink:href="{{ '/assets/minima-social-icons.svg#github' | relative_url }}"></use></svg>
                        <span class="username">{{ site.github_username| escape }}</span>
                    </a>
                </li>
                <li>
                    <a href="https://www.twitter.com/{{ site.twitter_username| cgi_escape | escape }}">
                        <svg class="svg-icon"><use xlink:href="{{ '/assets/minima-social-icons.svg#twitter' | relative_url }}"></use></svg>
                        <span class="username">{{ site.twitter_username| escape }}</span>
                    </a>
                </li>
                <li>
                    <a href="mailto:{{ site.email }}">
                        <svg fill="#828282" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" stroke="#828282" width=18><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><path d="M22,5V9L12,13,2,9V5A1,1,0,0,1,3,4H21A1,1,0,0,1,22,5ZM2,11.154V19a1,1,0,0,0,1,1H21a1,1,0,0,0,1-1V11.154l-10,4Z"></path></g></svg>
                        &nbsp;{{ site.email }}
                    </a>
                </li>
            </ul>

        </td>
    </tr>
</table>

{: style="margin-top: 3rem" }
## Keeping busy 🐜

- Preparing for an Advanced Master in Embedded systems at ISAE SupAero
- [Selling LEGO pieces worldwide on BrickLink](occupations/bricklink)


{: style="margin-top: 3rem" }
## Making stuff 🧑‍🔬

- [LEGO Storage System](projects/lego-storage-system) 🔥
- Media remote
- [BrickLink App](/projects/bricklink-app)
- Compta App


{: style="margin-top: 3rem" }
## Interests 🤯

- Coding
- [Movies & TV shows](/movies)
- Music
- [Ancient Egypt & archeology](/egypt)
- Space exploration & New Space


{: style="margin-top: 3rem" }
## Latest movies or shows 🎞️

- [Weapons](https://www.imdb.com/fr/title/tt26581740/)
- [Alien Earth](https://www.imdb.com/fr/title/tt13623632/)


{: style="margin-top: 3rem" }
## Latest books 📚

- [Robotic Exploration of the Solar System: Part 1: The Golden Age 1957-1982](https://www.amazon.fr/Robotic-Exploration-Solar-System-1957-1982/dp/0387493263/)
- [Henri Lœvenbruck, Nous rêvions juste de liberté](https://www.babelio.com/livres/Loevenbruck-Nous-revions-juste-de-liberte/695248)
- [Henri Lœvenbruck, Pour ne rien regretter](https://www.babelio.com/livres/Loevenbruck-Pour-ne-rien-regretter/1701851)
- [Guillaume Musso, Central Park](https://www.babelio.com/livres/Musso-Central-Park/572676)
- [Guillaume Musso, L'instant présent](https://www.babelio.com/livres/Musso-Linstant-present/689939)
- [Robert Charles Wilson, Bios](https://www.babelio.com/livres/Wilson-Bios/51027)
- [Robert Charles Wilson, Darwinia](https://www.babelio.com/livres/Wilson-Darwinia/25807)
- [Robert Charles Wilson, À travers temps](https://www.babelio.com/livres/Wilson--travers-temps/174247)


{: style="margin-top: 3rem" }
## Favorite YouTube channels 📺

- [Tantacrul](https://www.youtube.com/@Tantacrul)
- [DIY Perks](https://www.youtube.com/@DIYPerks)
- [Ben Eater](https://www.youtube.com/@BenEater)
- [Sebastian Lague](https://www.youtube.com/@SebastianLague)


{: style="margin-top: 3rem" }
## Links

### Coding

- Github: [https://github.com/alexbinary](https://github.com/alexbinary)

### Photography

- Flickr: [https://www.flickr.com/photos/189385048@N05/](https://www.flickr.com/photos/189385048@N05/)
- Instagram: [https://www.instagram.com/al.exandre1859](https://www.instagram.com/al.exandre1859)

### LEGO

- Flickr: [https://www.flickr.com/photos/163799831@N07/](https://www.flickr.com/photos/163799831@N07/)
- Rebrickable: [https://rebrickable.com/users/alexbinary/](https://rebrickable.com/users/alexbinary/)
- BrickLink: [https://store.bricklink.com/alexbinary](https://store.bricklink.com/alexbinary)