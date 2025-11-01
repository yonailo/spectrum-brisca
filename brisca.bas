Check 36731FE7

# Run-time Variables

Var user: Num = 128
Var a: NumFOR = 65512, 65511, 1, 1040, 3
Var a$: Str = "Game developped by Yonailo     "

# End Run-time Variables

  10 CLEAR 61695
  20 REM Brisca
  30 REM Fonts reserved memory
  40 REM 65535-(21*8)-7*(64*8) = 61789
  50 REM Rounded to the closet 256 multiple
  55 LOAD "screen" CODE 16384,6912
  56 PRINT AT 6,10;"LA BERISCA";AT 7,9;"(scr by DOkky)"
  59 INPUT "press enter to continue"; LINE a$
  60 LOAD "fonts" CODE 61696,7*8*64
  65 LOAD "screen" CODE 16384,6912
  70 REM UDGs
  80 GO SUB 1030
  90 REM Sets up paper colors
 100 BORDER 0: PAPER 4: INK 0: INVERSE 0: CLS
 101 PRINT AT 6,0;"Press S to start in server mode"
 102 PRINT AT 7,0;"Press C to start in client mode"
 105 LET a$="Game developped by Yonailo     "
 106 PAUSE 10: LET a$=a$(2 TO )+a$(1)
 107 PRINT AT 21,0;a$
 108 IF INKEY$="s" THEN GO TO 2000
 109 IF INKEY$="c" THEN GO TO 3000
 110 GO TO 106
 118 STOP
 119 REM empty all cards
 120 LET pos=1: GO SUB 860: LET pos=2: GO SUB 860: LET pos=3: GO SUB 860
 130 REM Score and variables
 140 GO SUB 270
 150 REM Shows all cards
 160 FOR i=1 TO 40 STEP 3
 170 REM pos. 1
 180 LET pos=1: LET card=i: GO SUB c(i,3)
 190 REM pos. 2
 200 LET pos=2: LET card=i+1: GO SUB c(i+1,3)
 210 REM pos. 3
 220 LET pos=3: LET card=i+2: GO SUB c(i+2,3)
 230 INPUT "Press enter to continue"; LINE a$
 240 NEXT i
 250 GO SUB 750
 260 STOP
 270 REM Score and variables
 280 LET psc=0: LET csc=0: LET stack=32: LET t=0: DIM f(7)
 281 REM fonts array
 282 REM   Aces(4) + jack, knight & king
 283 REM   64 bytes each, 4 bytes of padding
 290 FOR a=1 TO 7
 300 IF a=1 THEN LET f(a)=61696
 310 IF a<>1 THEN LET f(a)=f(a-1)+8*64
 320 NEXT a
 321 REM cards numeric array
 322 REM index 1 : card id
 323 REM index 2 :
 324 REM   1 -> ink color
 325 REM   2 -> paper color
 326 REM   3 -> drawing subrutine
 327 REM   4 -> font addr (optional)
 328 REM Cards string array
 329 REM index 1 : card id
 330 REM Index 2 : string(6) with
 336 REM   \::\:: or \a\b or \g\h or \m\n
 337 REM   \::\:: or \c\d or \i\j or \o\p
 338 REM   \::\:: or \e\f or \k\l or \q\r
 339 DIM c(40,4): DIM u$(40,6)
 340 FOR i=1 TO 40
 350 IF i<=10 THEN LET a=6: LET b=0: LET u$(i,1 TO 2)="\a\b": LET u$(i,3 TO 4)="\c\d": LET u$(i,5 TO 6)="  "
 360 IF i>10 AND i<=20 THEN LET a=2: LET b=7: LET u$(i,1 TO 2)="\a\b": LET u$(i,3 TO 4)="\c\d": LET u$(i,5 TO 6)="\e\f"
 370 IF i>20 AND i<=30 THEN LET a=5: LET b=0: LET u$(i,1 TO 2)="\g\h": LET u$(i,3 TO 4)="\i\j": LET u$(i,5 TO 6)="\k\l"
 380 IF i>30 AND i<=40 THEN LET a=0: LET b=7: LET u$(i,1 TO 2)="\m\n": LET u$(i,3 TO 4)="\o\p": LET u$(i,5 TO 6)="\q\r"
 390 LET c(i,1)=a: LET c(i,2)=b
 400 NEXT i
 410 LET c(1,3)=600: LET c(1,4)=f(1): LET c(11,3)=600: LET c(11,4)=f(2): LET c(21,3)=600: LET c(21,4)=f(3): LET c(31,3)=600: LET c(31,4)=f(4): LET c(8,3)=600: LET c(8,4)=f(5): LET c(18,3)=600: LET c(18,4)=f(5): LET c(28,3)=600: LET c(28,4)=f(5): LET c(38,3)=600: LET c(38,4)=f(5): LET c(9,3)=600: LET c(9,4)=f(6): LET c(19,3)=600: LET c(19,4)=f(6): LET c(29,3)=600: LET c(29,4)=f(6): LET c(39,3)=600: LET c(39,4)=f(6): LET c(10,3)=600: LET c(10,4)=f(7): LET c(20,3)=600: LET c(20,4)=f(7): LET c(30,3)=600: LET c(30,4)=f(7): LET c(40,3)=600: LET c(40,4)=f(7)
 440 FOR i=2 TO 40 STEP 10
 450 LET c(i,3)=8600
 460 LET c(i+1,3)=8200
 470 LET c(i+2,3)=8400
 480 LET c(i+3,3)=8800
 490 LET c(i+4,3)=8000
 500 LET c(i+5,3)=9000
 505 NEXT i
 510 PRINT AT 20,0;"PLY: ";psc;" points";AT 21,0;"COM: ";csc;" points": PRINT AT 20,15;"Stock: ";stack;AT 21,15;"Trump: ";t
 520 RETURN
 590 REM Card drawing only for
 600 REM aces(4), jacks(4), knights(4) & kings(4)
 610 REM params:
 620 REM   pos -> 1..3
 630 REM   card -> 1..40
 632 GO SUB 7000
 633 LET x=x+1: LET y=y+1
 635 LET id=card-10*INT (card/10)
 636 IF id>7 THEN LET id=id+2
 637 IF id=0 THEN LET id=12
 640 PRINT AT y,x; INK 0; PAPER 7;id
 641 IF id=1 THEN PRINT AT y,x+1; INK 0; PAPER 7;" "
 650 INK c(card,1): PAPER c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
 660 POKE 23607,INT ((c(card,4)-256)/256)
 670 LET v=32: FOR r=1 TO 10
 680 FOR c=1 TO 6
 690 PRINT AT y+r,x+c;CHR$ v: LET v=v+1
 700 NEXT c
 710 NEXT r
 720 INK 0
 725 POKE 23607,60
 726 PRINT AT y+11,x+1; PAPER 7;"      "
 732 IF id=10 OR id=11 OR id=12 THEN INK c(card,1): PAPER c(card,2): PRINT AT y+1,x+1;a$;b$;AT y+2,x+1;c$;d$;AT y+3,x+1;e$;f$
 740 RETURN
 860 REM Empty card space
 870 REM params
 880 REM   pos : 1..3
 881 LET w=9: LET h=13: PAPER 4: INK 0
 882 GO SUB 7000
 883 LET px=x: LET py=y
 890 FOR c=px TO px+w: PRINT AT py,c; PAPER 7;"\''": NEXT c
 900 FOR c=px TO px+w: PRINT AT py+h,c; INVERSE 1; PAPER 7;"\''": NEXT c
 910 FOR r=py TO py+h: PRINT AT r,px;"\ :";AT r,px+w; INVERSE 1;"\ :"
 920 IF r<>py AND r<>py+h THEN FOR c=px+1 TO px+w-1: PRINT AT r,c; PAPER 7;" ": NEXT c
 930 NEXT r
 940 RETURN
 950 STOP
 960 REM Instructions
 970 BORDER 0: PAPER 0: INK 7: CLS : PRINT AT 0,0;"3 cards are dealt to each player. The reminder is placed on top of the trump. After a round, both players draw a card from the stock in turn, the winner first.";''
 980 PRINT "There are 4 suits."; PAPER 6; INK 0;" Coins"; INK 7; PAPER 2;", Cups,"; PAPER 5; INK 0;" Swords "; INK 7; PAPER 0;"and "; PAPER 3;"Clubs."; PAPER 0;" The cards from the trump's suit always beat all of the others, however high they may be.";''
 990 PRINT "To win, the player must earn as many points as posible. The highest card of each suit are:";''
1000 PRINT TAB 0;"Ace";TAB 5;"Three";TAB 13;"King";TAB 20;"Knight";TAB 28;"Jack";'
1010 PRINT TAB 0;"11p";TAB 5;"10p";TAB 13;"4p";TAB 20;"3p";TAB 28;"2p";''
1020 PRINT "Playing the highest card is not mandatory, neither playing the same suit"
1030 REM UDGs
1040 RESTORE 1030: FOR a=USR "a" TO USR "r"+7
1050 READ user: POKE a,user
1060 NEXT a
1070 REM Cups "ab" \a\b
1080 REM      "cd" \c\d
1090 REM      "ef" \e\f
1100 DATA 3,14,28,63,127,255,128,255
1110 DATA 192,112,56,252,254,255,1,255
1120 DATA 111,118,63,15,7,3,1,3
1130 DATA 110,246,252,240,224,192,128,192
1140 DATA 7,7,3,1,7,31,63,127
1150 DATA 224,224,192,128,224,248,252,254
1160 REM Swords "gh" \g\h
1170 REM        "ij" \i\j
1180 REM        "kl" \k\l
1190 DATA 3,7,15,15,7,3,1,3
1200 DATA 192,224,240,240,224,192,128,192
1210 DATA 127,7,1,31,12,14,14,6
1220 DATA 254,224,128,248,48,112,112,96
1230 DATA 6,2,3,3,1,1,1,1
1240 DATA 96,64,192,192,128,128,128,128
1250 REM Clubs "mn" \m\n
1260 REM       "op" \o\p
1270 REM       "qr" \q\r
1280 DATA 3,7,13,13,29,29,31,31
1290 DATA 192,240,248,248,252,252,124,124
1300 DATA 31,31,31,31,9,13,7,7
1310 DATA 36,52,60,188,184,248,240,224
1320 DATA 5,5,3,3,1,1,1,1
1330 DATA 192,192,128,128,128,128,128,128
1340 RETURN
2000 REM Server mode
2010 DIM c(4)
2020 REM %listen #4,2000
2030 REM %control #5
2040 REM PRINT #5;"p"
2050 REM PRINT "Waiting..."
2060 REM INPUT #5;a;a$
2070 REM IF a<>0 THEN GO TO 200
2080 REM LET a$=INKEY$
2090 REM IF a$="x" THEN GO TO 700
3000 REM Client mode
7000 REM Gets coords from pos
7001 REM params
7002 REM   pos : 1..3
7003 REM return
7004 REM   x,y
7005 IF pos=1 THEN LET x=1: LET y=1
7006 IF pos=2 THEN LET x=11: LET y=1
7007 IF pos=3 THEN LET x=21: LET y=1
7008 RETURN
8000 REM Cards drawing for 6,16,26,36
8001 REM params :
8002 REM  pos -> 1..3, card : 1..40
8004 GO SUB 7000
8005 LET x=x+2: LET y=y+1
8007 LET id=card-10*INT (card/10)
8010 PRINT AT y,x-1; INK 0; PAPER 7;id;AT y,x;" "
8020 INK c(card,1): LET p=c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
8040 PRINT AT y+01,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8041 PRINT AT y+02,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8042 PRINT AT y+03,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8043 PRINT AT y+04,x; PAPER 7;"      "
8045 PRINT AT y+05,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8055 PRINT AT y+06,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8065 PRINT AT y+07,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8066 PRINT AT y+08,x; PAPER 7;"      "
8067 PRINT AT y+09,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8068 PRINT AT y+10,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8069 PRINT AT y+11,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8090 RETURN
8200 REM Cards drawing for 3,13,23,33
8201 REM params :
8202 REM  pos -> 1..3, card : 1..40
8204 GO SUB 7000
8205 LET x=x+2: LET y=y+1
8207 LET id=card-10*INT (card/10)
8210 PRINT AT y,x-1; INK 0; PAPER 7;id;AT y,x;" "
8220 INK c(card,1): LET p=c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
8240 PRINT AT y+01,x; PAPER p;a$;b$; PAPER 7;"    "
8241 PRINT AT y+02,x; PAPER p;c$;d$; PAPER 7;"    "
8242 PRINT AT y+03,x; PAPER p;e$;f$; PAPER 7;"    "
8243 PRINT AT y+04,x; PAPER 7;"      "
8245 PRINT AT y+05,x; PAPER 7;"    "; PAPER p;a$;b$
8246 PRINT AT y+06,x; PAPER 7;"    "; PAPER p;c$;d$
8247 PRINT AT y+07,x; PAPER 7;"    "; PAPER p;e$;f$
8248 PRINT AT y+08,x; PAPER 7;"      "
8254 PRINT AT y+09,x; PAPER p;a$;b$; PAPER 7;"    "
8255 PRINT AT y+10,x; PAPER p;c$;d$; PAPER 7;"    "
8265 PRINT AT y+11,x; PAPER p;e$;f$; PAPER 7;"    "
8290 RETURN
8400 REM Cards drawing for 4,14,24,34
8401 REM params :
8402 REM  pos -> 1..3, card : 1..40
8404 GO SUB 7000
8405 LET x=x+2: LET y=y+1
8407 LET id=card-10*INT (card/10)
8410 PRINT AT y,x-1; INK 0; PAPER 7;id;AT y,x;" "
8420 INK c(card,1): LET p=c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
8440 PRINT AT y+01,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8441 PRINT AT y+02,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8442 PRINT AT y+03,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8443 PRINT AT y+04,x; PAPER 7;"      "
8444 PRINT AT y+05,x; PAPER 7;"      "
8445 PRINT AT y+06,x; PAPER 7;"      "
8446 PRINT AT y+07,x; PAPER 7;"      "
8447 PRINT AT y+08,x; PAPER 7;"      "
8454 PRINT AT y+09,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8455 PRINT AT y+10,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8465 PRINT AT y+11,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8490 RETURN
8600 REM Cards drawing for 2,12,22,32
8601 REM params :
8602 REM  pos -> 1..3, card : 1..40
8604 GO SUB 7000
8605 LET x=x+2: LET y=y+1
8607 LET id=card-10*INT (card/10)
8610 PRINT AT y,x-1; INK 0; PAPER 7;id;AT y,x;" "
8620 INK c(card,1): LET p=c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
8640 PRINT AT y+01,x; PAPER 7;"  "; PAPER p;a$;b$; PAPER 7;"  "
8641 PRINT AT y+02,x; PAPER 7;"  "; PAPER p;c$;d$; PAPER 7;"  "
8642 PRINT AT y+03,x; PAPER 7;"  "; PAPER p;e$;f$; PAPER 7;"  "
8643 PRINT AT y+04,x; PAPER 7;"      "
8644 PRINT AT y+05,x; PAPER 7;"      "
8645 PRINT AT y+06,x; PAPER 7;"      "
8646 PRINT AT y+07,x; PAPER 7;"      "
8647 PRINT AT y+08,x; PAPER 7;"      "
8648 PRINT AT y+09,x; PAPER 7;"  "; PAPER p;a$;b$; PAPER 7;"  "
8649 PRINT AT y+10,x; PAPER 7;"  "; PAPER p;c$;d$; PAPER 7;"  "
8650 PRINT AT y+11,x; PAPER 7;"  "; PAPER p;e$;f$; PAPER 7;"  "
8690 RETURN
8800 REM Cards drawing for 5,15,25,35
8801 REM params :
8802 REM  pos -> 1..3, card : 1..40
8804 GO SUB 7000
8805 LET x=x+2: LET y=y+1
8807 LET id=card-10*INT (card/10)
8810 PRINT AT y,x-1; INK 0; PAPER 7;id;AT y,x;" "
8820 INK c(card,1): LET p=c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
8840 PRINT AT y+01,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8841 PRINT AT y+02,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8842 PRINT AT y+03,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8843 PRINT AT y+04,x; PAPER 7;"      "
8845 PRINT AT y+05,x; PAPER 7;"  "; PAPER p;a$;b$; PAPER 7;"  "
8855 PRINT AT y+06,x; PAPER 7;"  "; PAPER p;c$;d$; PAPER 7;"  "
8865 PRINT AT y+07,x; PAPER 7;"  "; PAPER p;e$;f$; PAPER 7;"  "
8866 PRINT AT y+08,x; PAPER 7;"      "
8890 PRINT AT y+09,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
8891 PRINT AT y+10,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
8892 PRINT AT y+11,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
8895 RETURN
9000 REM Cards drawing for 7,17,27,37
9001 REM params :
9002 REM  pos -> 1..3, card : 1..40
9004 GO SUB 7000
9005 LET x=x+2: LET y=y+1
9007 LET id=card-10*INT (card/10)
9010 PRINT AT y,x-1; INK 0; PAPER 7;id;AT y,x;" "
9020 INK c(card,1): LET p=c(card,2): LET a$=u$(card,1): LET b$=u$(card,2): LET c$=u$(card,3): LET d$=u$(card,4): LET e$=u$(card,5): LET f$=u$(card,6)
9040 PRINT AT y+01,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
9041 PRINT AT y+02,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
9042 PRINT AT y+03,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
9045 PRINT AT y+04,x; PAPER 7;"  "; PAPER p;a$;b$; PAPER 7;"  "
9055 PRINT AT y+05,x; PAPER p;a$;b$;c$;d$;a$;b$
9065 PRINT AT y+06,x; PAPER p;c$;d$;e$;f$;c$;d$
9090 PRINT AT y+07,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
9091 PRINT AT y+08,x; PAPER 7;"      "
9092 PRINT AT y+09,x; PAPER p;a$;b$; PAPER 7;"  "; PAPER p;a$;b$
9093 PRINT AT y+10,x; PAPER p;c$;d$; PAPER 7;"  "; PAPER p;c$;d$
9094 PRINT AT y+11,x; PAPER p;e$;f$; PAPER 7;"  "; PAPER p;e$;f$
9100 RETURN
