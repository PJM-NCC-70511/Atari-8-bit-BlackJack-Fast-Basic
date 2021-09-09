set PATH=..\fastbasic;..\bin

rem -c:fastbasic_custom.cfg

fb ..\Fast_Basic_Projects\BlackJackFB.bas ..\Fast_Basic_Projects\BLACKJACKFB_ML_DAT.asm

rem fastbasic-fp BlackJackFB.bas BlackJackFB.asm 

rem ca65 -t atari -o BLACKJACKFB_ML_DAT.o BLACKJACKFB_ML_DAT.asm -l BLACKJACKFB_ML_DAT.txt

rem ca65 -t atari -o BlackJackFB.o BlackJackFB.asm -l BlackJackFB.txt

rem cl65 -t atari -C fastbasic.cfg BlackJackFB.o fastbasic-fp.lib BLACKJACKFB_ML_DAT.o -o BlackJackFB.XEX

rem ld65      -C fastbasic.cfg BlackJackFB.o BLACKJACKFB_ML_DAT.o -o BlackJackFB.XEX fastbasic-fp.lib 



pause
