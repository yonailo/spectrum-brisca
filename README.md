# spectrum-brisca

Brisca (also known as Berisca) is a popular Spanish card game played by two teams of two with a 40-card Spanish-suited pack.
The brisca game is a 1 vs 1 networking card's game. 

<div style="display: flex; gap: 20px">
<img src="images/brisca.png" alt="front" width="300">
<img src="images/image1.png" alt="back" width="300">
</div>
<br/>

# Table of contents

* [Brisca rules](#brisca-rules)
* [Repository file structure](#repository-file-structure)
* [Development](#development)
* [How to run](#how-to-run)
* [Special thanks](#special-thanks)

# Brisca rules

There are 4 suits : "coins", "coups", "swords" and "clubs".

The cards from the trump's suit always beat all of the others, however high they may be.

To win, the player must earn as many points as posible. The highest card of each suit are:

* Ace : 11 points
* Three : 10 points
* King : 4 points
* Knight : 3 points
* Jack : 2 points

All other cards account for zéro points. The winner of the last round is the first to play the next one. If the second player does not throw a card of the same suit nor a triump, the first player wins the round.

Note that playing the highest card is not mandatory, neither playing the same suit.

The game ends when there are no more cards in the stock and all hand's cards have been played. A draw can be achieved with 60 points only.

# Repository file structure

The repository's files are :

```
┣ 📁 assets  : binary files for the fonts
┣ 📁 images  : images for the README.md
┣ 📁 spectranet : prebuilt images & fuse roms
┣ 🗒 brisca.bas : brisca BASIC code
┣ 🗒 brisca.szx : brisca snapshot for developping
┣ 🗒 brisca.tap : brisca TAP file
```

# Development

The game has been developped with [FUSE](https://fuse-emulator.sourceforge.net/) for the spectranet integration and with [BasinC](https://arda.kisafilm.org/blog/?p=1480&lang=en) for everything else (fonts creation & cards drawing).

![game screenshot](images/image2.png)

Initially I was thinking in making a computer vs player game, but after discovering the exciting world of [spectranet](https://spectranet.bytedelight.com/) I chose to create a networking game.

The spectranet hardware allows up to 4 sockets, that includes the listening socket so theoretically only up to 3 clients could be connected. If you have a filesystem already mounted, that also remove one of the available sockets. In order to make things easier, only 2 clients per server are supported.

The [loading screen](assets\screen-presentation-by-D0kky.scr) has been developped by DOk^RA :

![loading screen](images/image5.png)

## Custom fonts & UDGs

Some of the cards are drawn using UDGs and there are 7 cards that are drawn using a "custom font". You can point the CHARS system variable to a reserved memory space to replace the original 255 spectrum caracters set with your own. This allows to fast drawing some of the cards :

* 4 Aces (one for each suit)
* Generic Jack, Knight & King (their suit is added as an UDG)

The available room for each card is a rectagle of 6x10 caracters. In order to simplify the handling of the CHARS system var, each custom font has been padded with 0 up to 64 bytes.

At the beginning of the code, the espace needed for the fonts & UDGs is reserved with CLEAR :

```
10 CLEAR 61695
20 REM Brisca
30 REM Fonts reserved memory
40 REM 65535-(21*8)-7*(64*8) = 61789
50 REM Rounded to the closet 256 multiple
```

So starting at memory position 61696, in groups of 64 bytes (6x10 + 4 bytes of padding), you will find "ace coins", "ace coups", "ace swords", "ace clubs", "generic jack, "generic knight" and "generic king".

All the drawings have been created with BasinC UDG Character Editor :

![Ace clubs](images/image4.png)

For the rest of the cards, UDGs are used for drawing. Each suit UDG uses a rectangle of 2x3 chars, so there is not enough room for having the 4 suits (4*2*3 = 24 and there are only 21 UDGs).

In order to cope with this limitation, I could have used some of the font's padding for the missing suit, but to simplify I have used the coups suit as a coin suit removing the bottom line (so the coin's suit is made of a grid of 2x2 chars instead of 2x3 as the others). For the generic cards fonts (jacks, knights and kings), the corresponding suit is added as an UDG after drawing them.

## Data structures and coding

I have tried to document the expected parameters of every GO SUB call. The main data structures are :

```
339 DIM c(40,4): DIM u$(40,6): DIM n$(40,13)
```

The c integer array contains for each card its INK & PAPER colors, its drawing subroutine and its custom font memory address (when applicable). The u string array has a reference for drawing the 2x3 grid suit. Finally, the n string array contains the english name of every card.

The cards are identified with numeric IDs
* [1..10] : coin suit (1 -> Ace, 8 -> Jack, 9 -> Knight, 10 -> King)
* [11..20] : coups suit (11 -> Ace, 18 -> Jack, 19 -> Knight, 20 -> King)
* [21..30] : coups suit (21 -> Ace, 28 -> Jack, 29 -> Knight, 30 -> King)
* [31..40] : coups suit (31 -> Ace, 38 -> Jack, 39 -> Knight, 40 -> King)

## Networking

![networked game](images\image3.png)

The game is made to be played with spectranet's rom. At this moment only FUSE supports spectranet's rom. The [procedure described here](https://sourceforge.net/p/fuse-emulator/wiki/Spectranet%20Emulation/) in order to install the spectranet firmware with FUSE does not work with the FUSE 1.6.0. You will find [here](spectranet\spectranet_setIPandReset.szx) a prebuilt snapshot that allows you to configure your IP address and your gateway (NOTE that the FUSE implementation does not support DHCP yet.). You might need to install the [FUSE roms](spectranet\fuse\roms.zip) available within this repository too.

### Sockets

In server mode, the game listens on port 2000. It allows only 2 clients, which are identified with channels #6 and #7 respectively.

The clients can specify the remote DNS name or IP address in order to connect to the server.

The game starts with at least 2 clients are connected.

### Message's exchange

The game is managed by the server, it is the server which shuffles the stock of cards and who distributes them to each client. The server computes the winner at each round, decides who plays next and at the end signals the winner and loser.

The communication is made of multiple commandes exchanged between the parties :

* (s>c) `CARD` + (s>c) `<cardid>`
* (s>c) `TRUMP` + (s>c) `<trumpid>`
* (s>c) `PLAY`
* (s>c) `PLAYED` + (s>c) `<cardplayed>`
* (s>c) `POINTS P1` / `POINTS P2` + (s>c) `<points>`
* (s>c) `WIN` / `LOSE` / `DRAW`

>(s>c) means "the client sends to the server"

As it is not easy to manipulate strings with the ZX Spectrum, some messages are made of two writes to the communication channel, the first one is the command (i.e. "CARD") and the second write is a value.

The communication from client to server only happens to send to the server the card that the user has played, only after receiving a "PLAY" command from the server.

### Issues

If a client does not play of if one of the clients lose communication with the server, the server will wait forever waiting for a card. This could be avoided using the [control socket](https://spectrum.alioth.net/doc/index.php/Guide) (channel #5) in order to give each client a timeout for playing. Sadly there are issues with the control socket implementation. 

When the server polls the control socket while waiting for a card from the first client, it works well, but when it is the turn of the other client, the control socket does not receive what the second client sends until the first one has sent something else (which can not occur in the game logic but I have tested it with `telnet`), which desyncronises the game.

In the current implementation, it is not possible to BREAK the server while waiting for client data with `INPUT #6` or `INPUT #7`.

As there is no way of discarding new connections, trying to connect more than 2 clients is undefined.

# How to run

The game can be run in client or server mode. The server mode will start listening for connections at port 2000.

You can not play against the computer, the must be two clients and a server.

There is a TNFS server made by me, from where you can spawn the game directly, at the address "spectranet.tuxe.es".

# Special thanks

This work would have not been possible without the aide of a lot of people. Foremost and first, thanks to `@bkg2k` from the [Recalbox discord server](https://discord.gg/recalbox) for repairing my original ZX Spectrum 48k+ computer.

I can not stop here without citing the great and welcomed people from the [ZX Spectrum discord](https://discord.gg/Sj4ZAjKC). They have saved my life multiple times when I was blocked, they have always tried to answer my questions (in a very bad english) even when they were obvious or stupid. They have told me to read-the-fucking-manual in a very kindly way, and I know they are right.

We all laugh together because we all love our childhood's machine, and that's all that counts for us.

Rest in peace Sir. Sinclair, I thank you too.
