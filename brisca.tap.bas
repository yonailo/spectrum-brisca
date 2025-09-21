Check 59956AC7
Auto 8224

# Run-time Variables

Var w: Num = 9
Var h: Num = 13
Var t: Num = 0
Var x: Num = 12
Var y: Num = 2
Var user: Num = 128
Var px1: Num = 1
Var py1: Num = 1
Var px2: Num = 11
Var py2: Num = 1
Var px3: Num = 21
Var py3: Num = 1
Var px: Num = 21
Var py: Num = 1
Var psc: Num = 0
Var csc: Num = 0
Var stack: Num = 32
Var yaux: Num = 14
Var a: NumFOR = 65512, 65511, 1, 9005, 2
Var c: NumFOR = 30, 29, 1, 7521, 3
Var r: NumFOR = 15, 14, 1, 7520, 2

# End Run-time Variables

  10 REM Brisca
  15 BORDER 0: PAPER 4: INK 0: INVERSE 0: CLS
  20 GO SUB 9000
  30 GO SUB 7000
  40 GO SUB 6000
  50 REM Card 11 pos. 1
  55 LET x=px1+1: LET y=py1+1
  60 GO SUB 7010
  70 REM Car 17 pos. 2
  80 LET x=px2+1: LET y=py2+1
  90 GO SUB 7200
5999 STOP
6000 REM Score
6005 LET psc=0: LET csc=0: LET stack=32: LET t=0
6010 PRINT AT 20,0;"PLY: ";psc;" points";AT 21,0;"COM: ";csc;" points": PRINT AT 20,15;"Stock: ";stack;AT 21,15;"Trump: ";t
6020 RETURN
7000 REM Empty all cards
7005 LET px1=1: LET py1=1: LET px2=11: LET py2=1: LET px3=21: LET py3=1: LET w=9: LET h=13
7006 LET px=px1: LET py=py1: GO SUB 7500
7007 LET px=px2: LET py=py2: GO SUB 7500
7008 LET px=px3: LET py=py3: GO SUB 7500
7009 RETURN
7010 REM Card 11 (Ace cups)
7020 PRINT AT y,x; PAPER 7;"1"
7030 INK 2: INVERSE 1: PRINT AT y,x+3;"  "
7040 PRINT AT y+1,x+2;"    "
7050 PRINT AT y+2,x+1;"      "
7060 PRINT AT y+3,x+1;"      "
7070 PRINT AT y+4,x;" ";AT y+4,x+3;"  ";AT y+4,x+7;" "
7080 PRINT AT y+5,x;" ";AT y+5,x+2;"    ";AT y+5,x+7;" "
7090 PRINT AT y+6,x+1;" ";AT y+6,x+3;"  ";AT y+6,x+6;" "
7100 PRINT AT y+7,x+2;"    "
7110 PRINT AT y+8,x+3;"  "
7120 PRINT AT y+9,x+3;"  "
7130 PRINT AT y+10,x+1;"      "
7140 PRINT AT y+11,x;"        "
7150 INK 0: INVERSE 0
7160 RETURN
7200 REM Card 17 (7 coups)
7210 PRINT AT y,x; PAPER 7;"7"
7220 INK 2: INVERSE 1: LET yaux=y
7225 FOR a=1 TO 3
7230 PRINT AT yaux+1,x;"\a\b": PRINT AT yaux+1,x+6;"\a\b"
7240 PRINT AT yaux+2,x;"\c\d": PRINT AT yaux+2,x+6;"\c\d"
7250 PRINT AT yaux+3,x;"\e\f": PRINT AT yaux+3,x+6;"\e\f"
7252 LET yaux=yaux+4
7255 NEXT a
7260 PRINT AT y+5,x+3;"\a\b": PRINT AT y+6,x+3;"\c\d": PRINT AT y+7,x+3;"\e\f"
7499 RETURN
7500 REM Cards bg
7510 FOR c=px TO px+w: PRINT AT py,c; PAPER 7;"\''": NEXT c
7515 FOR c=px TO px+w: PRINT AT py+h,c; INVERSE 1; PAPER 7;"\''": NEXT c
7520 FOR r=py TO py+h: PRINT AT r,px;"\ :";AT r,px+w; INVERSE 1;"\ :"
7521 IF r<>py AND r<>py+h THEN FOR c=px+1 TO px+w-1: PRINT AT r,c; PAPER 7;" ": NEXT c
7522 NEXT r
7530 RETURN
7999 STOP
8000 REM Instructions
8010 BORDER 0: PAPER 0: INK 7: CLS : PRINT AT 0,0;"3 cards are dealt to each player. The reminder is placed on top of the trump. After a round, both players draw a card from the stock in turn, the winner first.";''
8020 PRINT "There are 4 suits."; PAPER 6; INK 0;" Coins"; INK 7; PAPER 2;", Cups,"; PAPER 5; INK 0;" Swords "; INK 7; PAPER 0;"and "; PAPER 3;"Clubs."; PAPER 0;" The cards from the trump's suit always beat all of the others, however high they may be.";''
8030 PRINT "To win, the player must earn as many points as posible. The highest card of each suit are:";''
8040 PRINT TAB 0;"Ace";TAB 5;"Three";TAB 13;"King";TAB 20;"Knight";TAB 28;"Jack";'
8050 PRINT TAB 0;"11p";TAB 5;"10p";TAB 13;"4p";TAB 20;"3p";TAB 28;"2p";''
8060 PRINT "Playing the highest card is not mandatory, neither playing the same suit"
9000 REM UDGs
9005 FOR a=USR "a" TO USR "r"+7
9006 READ user: POKE a,user
9007 NEXT a
9010 REM Cups "ab" \a\b
9020 REM      "cd" \c\d
9030 REM      "ef" \e\f
9040 DATA 3,14,28,63,127,255,128,255
9045 DATA 192,112,56,252,254,255,1,255
9060 DATA 111,118,63,15,7,3,1,3
9065 DATA 110,246,252,240,224,192,128,192
9080 DATA 7,7,3,1,7,31,63,127
9085 DATA 224,224,192,128,224,248,252,254
9100 REM Swords "gh" \g\h
9110 REM        "ij" \i\j
9120 REM        "kl" \k\l
9130 DATA 3,7,15,15,7,3,1,3
9140 DATA 192,224,240,240,224,192,128,192
9150 DATA 127,7,1,31,12,14,14,6
9160 DATA 254,224,128,248,48,112,112,96
9170 DATA 6,2,3,3,1,1,1,1
9180 DATA 96,64,192,192,128,128,128,128
9190 REM Clubs "mn" \m\n
9200 REM       "op" \o\p
9210 REM       "qr" \q\r
9220 DATA 3,7,13,13,29,29,31,31
9230 DATA 192,240,248,248,252,252,124,124
9240 DATA 31,31,31,31,9,13,7,7
9250 DATA 36,52,60,188,184,248,240,224
9260 DATA 5,5,3,3,1,1,1,1
9270 DATA 192,192,128,128,128,128,128,128
9280 RETURN
