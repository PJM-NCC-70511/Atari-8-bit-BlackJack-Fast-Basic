'REM PROJECT: BLACK JACK ATARI FAST BASIC. PORTED FROM DARK BASIC VERSION.
'REM CREATED: FRIDAY, AUGUST 10, 2012
'REM ***** MAIN SOURCE FILE *****

'REM **** Conversion in Progress ****
DATA BLACKJACKVALUE()  BYTE = 011,002,003,004,005,006,007,008,009,010,010,010,010,011
DATA POKERVALUE()      BYTE = 015,002,003,004,005,006,007,008,009,010,012,013,014,011
DATA CARDCHARACTER1()  BYTE = 000,082,083,084,085,086,087,088,089,081,090,091,092,081  '92
DATA CARDCHARACTER2()  BYTE = 000,000,000,000,000,000,000,000,000,080,000,000,000,081
DATA CARDCHARACTER3()  BYTE = 094,000,000,000,000,000,000,000,000,000,072,074,076,000
DATA CARDCHARACTER4()  BYTE = 095,000,000,000,000,000,000,000,000,000,073,075,077,000



DATA SUITSHOW0()       BYTE = 192,193,066,067,196,197,070,071 

DATA CARDSHOW1()       BYTE =  83,00,00,00,00,    213,00,00,00,00,   88,00,00,00,00, 218,00,196,197,00,    92,00,66,67,00,   221,00,192,193,00
DATA CARDSHOW2()       BYTE =  00,00,00,00,00,     00,00,00,00,00,   00,00,00,00,00,  00,200,201,00,00,    00,76,77,00,00,    00,000,000,00,00
DATA CARDSHOW3()       BYTE =  00,66,67,00,00,   00,192,193,00,00,   00,70,71,00,00,    00,78,79,00,00,    00,78,79,00,00,    00,222,223,00,00
DATA CARDSHOW4()       BYTE =  84,00,00,00,00,    217,00,00,00,00,   86,00,00,00,00, 219,00,192,193,00, 220,00,196,197,00,    93,00,070,071,00
DATA CARDSHOW5()       BYTE =  00,00,00,00,00,     00,00,00,00,00,   00,00,00,00,00,  00,202,203,00,00,  00,204,205,00,00,    00,000,000,00,00
DATA CARDSHOW6()       BYTE =  00,66,67,00,00,   00,192,193,00,00,   00,70,71,00,00,    00,78,79,00,00,    00,78,79,00,00,    00,094,095,00,00


DIM OLDORDER(512) WORD

DBL_DOWN_SET = 0
DBL_DOWN_3UP = 0
DECKSIZE = 52
NUMBER_OF_DECKS = 4
                                          
DIM BONUS_777_OPTION_SHOW$(1)   
BONUS_777_OPTION_SHOW$(0) =    "NO BONUS WITH 777       "
BONUS_777_OPTION_SHOW$(1) =    "PAYS 3:1, SUIT 4:1      "

DIM BONUS_678_OPTION_SHOW$(1)   
BONUS_678_OPTION_SHOW$(0) =    "NO BONUS WITH 678       "
BONUS_678_OPTION_SHOW$(1) =    "PAYS 3:1, SUIT 4:1      "
BONUS777 = 0
BONUS678 = 0
 
DEALERTIEWINS = 1

DEALERSOFT17HIT = 0
'DIM UNBUSTED_OPTION_SHOW$(1)
CARDCHARLIEWINSET = 6

SPLITSET = 0                      
'BLACKJACK_BONUS_OPTION_SHOW$(3) = "                                 "
SUIT21BONUS = 0
COLOR21BONUS  = 0 

DIM NUMBER_OF_PLAYERS_OPTION_SHOW$(3)
NUMBER_OF_PLAYERS_OPTION_SHOW$(0) = "ONE PLAYER   "            
NUMBER_OF_PLAYERS_OPTION_SHOW$(1) = "TWO PLAYERS  "
NUMBER_OF_PLAYERS_OPTION_SHOW$(2) = "THREE PLAYERS"
NUMBER_OF_PLAYERS_OPTION_SHOW$(3) = "FOUR PLAYERS "



MAXPLAYERS = 4
TRUE = 1
FALSE = 0
LASTPLAYER = 0
DIM CARDIMAGE$(56) 
CARDBACKIMAGE$ = "         "
CARDIMAGE$(0) = "         "
CARDIMAGE$(1) = "         "
CARDIMAGE$(2) = "         "
DIM BJCARDVALUE(56 * 10) BYTE
DIM PKCARDVALUE(56 * 10) BYTE
DIM CARDSUITVALUE(56 * 10) BYTE
DIM CARDORDER(56 * 10) WORD
DIM SUIT_CHARACTER(15) BYTE
DIM MODE_RES_X(64)  BYTE
DIM MODE_RES_Y(64)  BYTE
DIM MODE_BITDEPTH(64)  BYTE
DISPPLAYERSPACING = 0
DISPPLAYERLEFT = 4
DISPPLAYERTOP = 0
DISPPLAYERVERTICAL = 0
SELECTED_BITDEPTH = 0
SELECTED_RES_X = 0
SELECTED_RES_Y = 0
DEALERHIDDEN = 0
CARDNO = 0
RESHUFFLENO = 0
NEWCARDVALUE = 0
ROUNDSPLAYED = 0
PLAYERNO = 0
GONEXTPLAYER = 0
ALLOWSPLIT = 0
ALLOWINSURANCE = 0
EXITGAME = 0
NUMBEROFDECKS = 4
INSURANCE_STATUS = 0
DIM PLAYERNNAME$(4) 
DIM PLAYERNDRAWN(16) BYTE
DIM PLAYERNTOTAL(16) BYTE
DIM PLAYERNCASH%(4) 
DIM PLAYERNBET%(4) 
DIM PLAYERNSPLIT(4) BYTE
DIM PLAYERNACES(4) BYTE
DIM PLAYERNSPLITCARD(4) BYTE
DIM PLAYERBJCARDVAL(80)  BYTE
DIM PLAYERPKCARDVAL(80)  BYTE
DIM PLAYERSUCARDVAL(80)  BYTE
DIM PLAYERNDOUBLEUSED(4) 
DIM PLAYERNMESSAGE$(4) 
DIM HANDREWARD%(3) 
KEYPRESSED$=""
ERRORMESSAGE$ = ""
TEMPMESSAGE$ = ""
PLAYER_SECTION_ADDRESS = 0
LASTKEYPRESSED = 0
DEALERTIEWINS = 0
DEALERSOFT17HIT = 0 ' IF DEALER HAS ONE ACE
DEALERNOHIDDEN = 0
CARDCHARLIEWINSET = 6
ALLOWSURRENDER = 0 ' PLAYER GETS BACK HALF BET
SUIT21BONUS = 0
COLOR21BONUS = 0
SUITEDAJBONUS = 0 ' ACE + JACK PAY IN SAME SUIT 2:1
JOKERBETRETURN = 0 
JOKERSPECIALACE = 0
JOKERSPRESANT = 0
DIM PLAYERNWINS(4) 
TOTALCARDS = 0
DECKSIZE = 0
SUITSIZE = 0
SS = 0   
END_PROGRAM = 0

INVD$=CHR$(196) '[D]ouble
INVH$=CHR$(200) '[H]it 
INVI$=CHR$(201) '[I]nsurance
INVP$=CHR$(208) 
INVQ$=CHR$(209) '[Q]uit
INVR$=CHR$(210)
INVS$=CHR$(211) '[S]tand
INVT$=CHR$(212) 'Spli[T]
INVU$=CHR$(213) 'S[U]rrender
DRAWCARD_X = 0
DRAWCARD_Y = 0
A=0
B=0
C=0
D=0
E=0 
F$="" 
G=0 
H=0 
I=0 
J=0 
K=0 
L=0
M=0
N=0
O=0
P=0
Q=0
R=0
S=0
T=0
U=0
SPLITCHECK1 = 0
SPLITCHECK2 = 0
W=0
X=0
Y=0
Z=0
GAME_COMMAND$ = ""
END_PROGRAM = FALSE 'Program will loop until END_PROGRAM is non zero, and return to title screen. 

REPEAT
    EXEC INIT_DEFAULTS
    EXEC TITLE_SCREEN
    IF END_PROGRAM = 0
        EXEC INIT_GAME
       'EXEC SHOW_ALL_CARDS
        EXEC SHUFFLEDECKS    
        DPOKE 88,@SCREEN_ADDR
        CLS                
        EXITGAME = 0
        REPEAT            
            EXEC SHOWSTATS
            EXEC GETBETS
            IF EXITGAME = 0
                PLAYERNO = 0
                '**  EXEC SHOW_ALL_SPRITES
                EXEC PERFORM_DEAL
                IF PLAYERNO <= LASTPLAYER
                    REPEAT
                        EXEC PERFORM_PLAYER_INPUT                    
                        IF PLAYERNSPLIT(PLAYERNO) = 2
                            EXEC SHOWSTATS 
                            EXEC PERFORM_NEXTHAND                        
                        ELSE                         
                            IF PLAYERNSPLIT(PLAYERNO) <= 1 
                              'EXEC PERFORM_NEXTHAND 
                            ENDIF
                            PLAYERNO = PLAYERNO + 1
                        ENDIF
                    UNTIL PLAYERNO > LASTPLAYER    
                ENDIF
                PLAYERNO = 0 
                EXEC PERFORM_DEALER
                EXEC PERFORM_REWARDS
                IF LASTPLAYER = 1 OR LASTPLAYER = 3
                  SECTION_NUMBER = 4
                  EXEC SET_PLAYER_SCREEN_SECTION
                  POSITION 0,4
                  PRINT "       Press Space to Continue         "                                
                ENDIF
                REPEAT
                      EXEC SHOWSTATS
                      GET LASTKEYPRESSED
                      IF LASTKEYPRESSED>96 AND LASTKEYPRESSED<123 THEN LASTKEYPRESSED = LASTKEYPRESSED - 32 
                      KEYPRESSED$=CHR$(LASTKEYPRESSED)        
                UNTIL KEYPRESSED$ = " " 
                DPOKE 88,@SCREEN_ADDR
                PLAYERNSPLIT(PLAYERNO) = 0
                CLS                
                FOR I=0 TO 4
                    POKE @NUMCARDS+I,0
                    PLAYERNMESSAGE$(I) = ""                    
                NEXT I
                FOR I = 0 TO CARDNO 
                    J = CARDORDER(I) 
                    '***  ' ****   SPRITEJ+1, -200, -200, CARDIMAGE(J)
                NEXT I
                IF CARDNO >= RESHUFFLENO THEN EXEC SHUFFLEDECKS
            ENDIF
        UNTIL EXITGAME >= 1
    ENDIF
UNTIL END_PROGRAM = TRUE

  FOR I = $D000 TO $D00D
    POKE I,0
  NEXT I
  GRAPHICS 0

END

PROC INIT_GAME
        'Initialize Game Variables to Default Values
        'Set Game Colors and set Player / Missile Registers. 

        DECK = 0        
        CARDPLACE = 0
        IMAGEGET = 0
        LASTCARD = 0
        FILENUMBERSTRING$ = ""
        CLS
        DPOKE 560,@DISPLAY_LIST_GAME
        POKE 704,12
        POKE 705,12
        POKE 706,12
        POKE 707,12
        POKE 623,4      
        POKE 708,148
        POKE 709,42
        POKE 710,0
        POKE 711,68
        POKE 712,210
        DPOKE $0224,@GAME_VBI
        DPOKE $0200,@GAME00_DLI
        DPOKE 88,@SCREEN_ADDR
        POKE $D40E,192
        POKE $D008,3
        POKE $D009,3
        POKE $D00A,3
        POKE $D00B,3
        POKE $D00C,255
        POKE $D00D,15
        POKE $D00E,15
        POKE $D00F,15
        POKE $D010,15
        POKE $D011,255
        POKE $D01D,0

        FOR I=0 TO 4
            POKE @NUMCARDS+I,0
            PLAYERNMESSAGE$(I) = ""
        NEXT I
      
        IF SELECTED_RES_Y > 300 AND SELECTED_RES_Y < 621
            DISPPLAYERTOP = 244
            DISPPLAYERVERTICAL = 27
        ENDIF
        IF SELECTED_RES_Y > 620 AND SELECTED_RES_Y < 780 
            DISPPLAYERTOP = 248
            DISPPLAYERVERTICAL = 28
        ENDIF
        IF SELECTED_RES_Y >= 779 AND SELECTED_RES_Y < 1000 
            DISPPLAYERTOP = 280
            DISPPLAYERVERTICAL = 30
        ENDIF
        IF SELECTED_RES_Y > 999
            DISPPLAYERTOP = 320
            DISPPLAYERVERTICAL = 32
        ENDIF
        DISPPLAYERLEFT = 4
        IF DECKSIZE = 56
            LASTCARD = 55
            SUITSIZE = 14
         ELIF DECKSIZE = 52
            LASTCARD = 51            
            SUITSIZE = 13
         ELIF DECKSIZE = 48
            LASTCARD = 47
            SUITSIZE = 12
         ENDIF
        TOTALCARDS = DECKSIZE * NUMBER_OF_DECKS - 1        
        RESHUFFLENO = TOTALCARDS - 22
        IF LASTPLAYER >= 4 AND NUMBEROFDECKS >=6 THEN RESHUFFLENO = TOTALCARDS - 28
        CARDNO = 0
        FOR CARDPLACE = 0 TO SUITSIZE - 1
          SUIT_CHARACTER(CARDPLACE) = CARDNO
          CARDNO = CARDNO + 1 
          IF SUITSIZE = 12 AND CARDPLACE = 8 THEN CARDNO = CARDNO + 1 
        NEXT CARDPLACE        
        
        CARDNO = 0 
        CARDSUIT = 0
        IMAGEGET = 1
        FOR CARDPLACE = 0 TO TOTALCARDS
            IF (CARDPLACE MOD SUITSIZE) = 0
               CARDNO = 0
               CARDSUIT = CARDSUIT + 1
               IF CARDSUIT >=4 THEN CARDSUIT = 0
            ENDIF
            I = SUIT_CHARACTER(CARDNO) 
            V =  BLACKJACKVALUE(I)
            BJCARDVALUE(CARDPLACE) = V
            V =  POKERVALUE(I)
            PKCARDVALUE(CARDPLACE) = V
            CARDSUITVALUE(CARDPLACE) = 1 + CARDSUIT
            CARDORDER(CARDPLACE) = 255
            CARDNO = CARDNO + 1 
        NEXT CARDPLACE
        CARDNO = DECKSIZE
        JOKERSPRESANT = 0
        IF DECKSIZE = 56 THEN SUITSIZE = 14
        FOR N = 1 TO MAXPLAYERS
            PLAYERNCASH%(N) = 5000
            PLAYERNBET%(N) = 0
        NEXT N        
ENDPROC

PROC CALCTOTAL
    FROM = 0
    TOTAL = 0
    ACES = 0
    H = 0
    PLAYERNACES(PLAYERNO) = 0
    IF PLAYERNSPLIT(PLAYERNO) <= 2
        FROM = 0
        H = 0
    ENDIF
    IF PLAYERNSPLIT(PLAYERNO) = 3
        FROM = 7
        H = 4
    ENDIF
    IF PLAYERNSPLIT(PLAYERNO) = 4
        FROM = 14
        H = 8
    ENDIF
    FOR I = FROM TO FROM + PLAYERNDRAWN(PLAYERNO + H) - 1
        TOTAL = TOTAL + PLAYERBJCARDVAL(PLAYERNO*20+I)
        IF PLAYERBJCARDVAL(PLAYERNO*20+I) = 11 
            ACES = ACES + 1
            PLAYERNACES(PLAYERNO) = PLAYERNACES(PLAYERNO) + 1
         ENDIF
    NEXT I
    ' CHECK IF THERE ARE ANY ACES WHEN A TOTAL IS MORE THAN 21, IF SO, SUBRACT 10 UNTIL NO MORE ACES OR LESS THAN 22.
    IF ACES > 0
        FOR I = 0 TO ACES - 1 
            IF TOTAL > 21 THEN TOTAL = TOTAL - 10
        NEXT I
    ENDIF
    PLAYERNTOTAL(PLAYERNO+H) = TOTAL
ENDPROC

PROC PERFORM_DEAL
    PLAYERNUMBER = 0
    USEIMAGE = 0
    CARDSPACING = 0 
    CARDSPACING = 16
    SPLITCHECK1 = 254
    SPLITCHECK2 = 255
    ROUNDSPLAYED = ROUNDSPLAYED + 1
    CLS
    EXEC SHOWSTATS
    IF PLAYERNSPLIT(PLAYERNO) >= 2 THEN CARDSPACING = 14
    FOR I = 0 TO 15
        PLAYERNTOTAL(I) = 0
    NEXT I
    FOR PLAYERNUMBER = 0 TO LASTPLAYER
        FOR N = 0 TO 20
            PLAYERBJCARDVAL(PLAYERNUMBER*20+N) = 0
            PLAYERPKCARDVAL(PLAYERNUMBER*20+N) = 0
        NEXT N
        PLAYERNO = PLAYERNUMBER
        PLAYERNMESSAGE$(PLAYERNO) = ""
        PLAYERNSPLIT(PLAYERNO) = 0
        PLAYERNACES(PLAYERNO) = 0
        PLAYERNDOUBLEUSED(PLAYERNO) = 0
        PLAYERNSPLITCARD(PLAYERNO) = 0
        PLAYERNDRAWN(PLAYERNO+0) = 0
        PLAYERNDRAWN(PLAYERNO+4) = 0   
        SECTION_NUMBER = PLAYERNO
        EXEC SET_PLAYER_SCREEN_SECTION
        FOR N = 0 TO 1
             DRAWCARD_X = DISPPLAYERLEFT + 5 * N                 
             DRAWCARD_Y = PLAYER_SECTION_ADDRESS
             IF PLAYERNO = 0 
                 IF N = 1
                    EXEC DISPLAY_BACK 
                    DEALERHIDDEN = CARDNO
                 ELSE
                    EXEC DISPLAY_CARD
                 ENDIF
             ELSE                 
                 EXEC DISPLAY_CARD                 
             ENDIF                          
                
                 
             NEWCARDVALUE = BJCARDVALUE(CARDORDER(CARDNO))
             PLAYERBJCARDVAL(PLAYERNO*20 + PLAYERNDRAWN(PLAYERNO)) = NEWCARDVALUE
             PLAYERPKCARDVAL(PLAYERNO*20 + PLAYERNDRAWN(PLAYERNO)) = PKCARDVALUE(CARDORDER(CARDNO))
             PLAYERSUCARDVAL(PLAYERNO*20 + PLAYERNDRAWN(PLAYERNO)) = CARDSUITVALUE(CARDORDER(CARDNO))
             
             IF PLAYERNO > 0              
                IF N = 0                                 
                    IF SPLITSET = 0
                            SPLITCHECK1 = BJCARDVALUE(CARDORDER(CARDNO))
                    ELIF SPLITSET = 1
                            SPLITCHECK1 = PKCARDVALUE(CARDORDER(CARDNO))
                    ELIF SPLITSET = 2
                            IF BJCARDVALUE(CARDNO) < 11 
                                SPLITCHECK1 = PKCARDVALUE(CARDORDER(CARDNO))
                            ELSE
                                SPLITCHECK1 = 255
                            ENDIF
                    ENDIF
                 ENDIF
                 IF N = 1 
                    IF SPLITSET = 0     
                        SPLITCHECK2 = BJCARDVALUE(CARDORDER(CARDNO))
                    ELIF SPLITSET = 1
                            SPLITCHECK2 = PKCARDVALUE(CARDORDER(CARDNO))
                    ELIF SPLITSET = 2
                            IF BJCARDVALUE(CARDNO) < 11 
                                SPLITCHECK2 = PKCARDVALUE(CARDORDER(CARDNO))
                            ELSE
                                SPLITCHECK2 = 254 ' 255 WILL NOT EQUAL 254
                            ENDIF
                     ENDIF 
                     IF SPLITCHECK1 = SPLITCHECK2 
                        PLAYERNSPLIT(PLAYERNO) = 1
                        PLAYERNSPLITCARD(PLAYERNO) = CARDORDER(CARDNO)
                     ENDIF
                       
                     ' *** Temporary Override for checking                   
                     '  PLAYERNSPLIT(PLAYERNO) = 1



                 ENDIF
             ENDIF
              CARDNO = CARDNO + 1
              PLAYERNDRAWN(PLAYERNO) = PLAYERNDRAWN(PLAYERNO) + 1
        NEXT N
        PLAYERNDRAWN(PLAYERNO+0) = 2
        PLAYERNDRAWN(PLAYERNO+4) = 0
        IF LASTPLAYER < 3
            IF LASTPLAYER = 2 AND PLAYERNO = 2
                H = PLAYERNO + 1
            ELSE
                H = PLAYERNO
            ENDIF
        ELSE    
            H = PLAYERNO
        ENDIF
        POKE @NUMCARDS + H,(PLAYERNDRAWN(PLAYERNO) & 7) 
        IF PLAYERNO = 0 
             EXEC CALCTOTAL
             '' PLAYERNMESSAGE$(PLAYERNO) = "TOTAL:"
'             PLAYERNMESSAGE$(PLAYERNO) = STR$(CARDORDER(0))
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(CARDORDER(1))
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(CARDORDER(2))
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(CARDORDER(3))
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(CARDORDER(4))
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(CARDORDER(5))
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(CARDORDER(6))
              
        ELSE
             EXEC CALCTOTAL        
             IF PLAYERNTOTAL(PLAYERNO+0) = 21 
                PLAYERNMESSAGE$(PLAYERNO) = "T:21 BLACKJACK"               
             ELSE
                 PLAYERNMESSAGE$(PLAYERNO) = "T:" 
                 PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO))
             ENDIF
        ''    EXEC SHOWSTATS

'             I=CARDSUITVALUE(CARDORDER(0))
'             PLAYERNMESSAGE$(PLAYERNO) = STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(1))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(2))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(3))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(4))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(5))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(6))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(7))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+" "
'             I=CARDSUITVALUE(CARDORDER(8))
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)
'             PLAYERNMESSAGE$(PLAYERNO) =+"  "
'             I=TOTALCARDS
'             PLAYERNMESSAGE$(PLAYERNO) =+ STR$(I)


        ENDIF
            SECTION_NUMBER = PLAYERNUMBER
            EXEC SET_PLAYER_SCREEN_SECTION
            POSITION 21,4
            PRINT PLAYERNMESSAGE$(PLAYERNO)
        
    NEXT PLAYERNUMBER
    PLAYERNO = 1
    IF PLAYERNTOTAL(1+0) = 21 
        PLAYERNO = 2
        IF PLAYERNTOTAL(2+0) = 21 
            PLAYERNO = 3
            IF PLAYERNTOTAL(3+0) = 21 
                PLAYERNO = 4
                IF PLAYERNTOTAL(4+0) = 21 THEN PLAYERNO = MAXPLAYERS + 1
            ENDIF
        ENDIF
    ENDIF
    IF PLAYERNTOTAL(0) = 21 
        IF PLAYERBJCARDVAL(0) = 11 THEN PLAYERNO = MAXPLAYERS + 1
    ENDIF
ENDPROC

PROC DISPLAY_CARD
  CARD_TOPLEFT = DRAWCARD_Y + DRAWCARD_X
  C = CARDORDER(CARDNO)
  K = SUIT_CHARACTER(C MOD SUITSIZE)
  L = (CARDSUITVALUE(C) - 1) * 2
  G = (SUITSHOW0(L) & 128)
  

  POKE CARD_TOPLEFT+0,CARDCHARACTER1(K)!G   
  POKE CARD_TOPLEFT+1,CARDCHARACTER2(K)!G
  IF CARDCHARACTER3(K) = 0 
    POKE CARD_TOPLEFT+81,SUITSHOW0(L) + 0   
    POKE CARD_TOPLEFT+82,SUITSHOW0(L) + 1
  
  ELIF CARDCHARACTER3(K) = 94
    POKE CARD_TOPLEFT+01,CARDCHARACTER3(K)!G  
    POKE CARD_TOPLEFT+02,CARDCHARACTER4(K)!G  
    POKE CARD_TOPLEFT+81,SUITSHOW0(L) + 0   
    POKE CARD_TOPLEFT+82,SUITSHOW0(L) + 1
  ELSE
    POKE CARD_TOPLEFT+02,SUITSHOW0(L) + 0   
    POKE CARD_TOPLEFT+03,SUITSHOW0(L) + 1
    POKE CARD_TOPLEFT+41,CARDCHARACTER3(K)!G  
    POKE CARD_TOPLEFT+42,CARDCHARACTER4(K)!G
    IF L < 4
      POKE CARD_TOPLEFT+81,78!G  
      POKE CARD_TOPLEFT+82,79!G
    ELSE
      G = 128 - G
      POKE CARD_TOPLEFT+81,78!G  
      POKE CARD_TOPLEFT+82,79!G
    ENDIF      
  ENDIF 
ENDPROC

PROC DISPLAY_BACK
    CARD_TOPLEFT = DRAWCARD_Y + DRAWCARD_X
    MOVE @CARDBACKLINE,CARD_TOPLEFT + 00,4
    MOVE @CARDBACKLINE,CARD_TOPLEFT + 40,4
    MOVE @CARDBACKLINE,CARD_TOPLEFT + 80,4
    MOVE @CARDBACKLINE,CARD_TOPLEFT + 120,4 
ENDPROC

PROC DISPLAY_FRONT
    CARD_TOPLEFT = DRAWCARD_Y + DRAWCARD_X
    MOVE @CARDFRONTLINE,CARD_TOPLEFT + 00,4
    MOVE @CARDFRONTLINE,CARD_TOPLEFT + 40,4
    MOVE @CARDFRONTLINE,CARD_TOPLEFT + 80,4
    MOVE @CARDFRONTLINE,CARD_TOPLEFT + 120,4 
ENDPROC


PROC PERFORM_PLAYER_INPUT 
    KEYUP = 0
    GONEXTPLAYER = 0
    PLAYERNDOUBLEUSED(PLAYERNO) = 0
    REPEAT         
        EXEC SHOWSTATS
        IF PLAYERNCASH%(PLAYERNO) < PLAYERNBET%(PLAYERNO) THEN PLAYERNDOUBLEUSED(PLAYERNO) = 1
        IF DBL_DOWN_SET = 1 AND (PLAYERNTOTAL(PLAYERNO+0) <=9 OR PLAYERNTOTAL(PLAYERNO+0)>=12) THEN PLAYERNDOUBLEUSED(PLAYERNO) = 1
        IF DBL_DOWN_SET = 2 AND (PLAYERNTOTAL(PLAYERNO+0) <=8 OR PLAYERNTOTAL(PLAYERNO+0)>=12) THEN PLAYERNDOUBLEUSED(PLAYERNO) = 1
        IF (PLAYERNTOTAL(PLAYERNO+0) < 21 OR (PLAYERNSPLIT(PLAYERNO) = 3) AND PLAYERNTOTAL(PLAYERNO+4) <21)
            EXEC SHOWCOMMANDS
            
            GET LASTKEYPRESSED
            IF LASTKEYPRESSED>96 AND LASTKEYPRESSED<123 THEN LASTKEYPRESSED = LASTKEYPRESSED - 32 
            KEYPRESSED$=CHR$(LASTKEYPRESSED)
            IF KEYPRESSED$ = "H" 
                EXEC PERFORM_HIT
                IF PLAYERNDRAWN(PLAYERNO) >=3 AND DBL_DOWN_3UP = FALSE THEN PLAYERNDOUBLEUSED(PLAYERNO) = 1
                IF PLAYERNDRAWN(PLAYERNO) >=4 AND DBL_DOWN_3UP = TRUE THEN PLAYERNDOUBLEUSED(PLAYERNO) = 1
            ENDIF
            IF KEYPRESSED$ = "S" 
                GONEXTPLAYER = 1
                IF LASTPLAYER >= 3
                  IF PLAYERNSPLIT(PLAYERNO) <= 1 
                      PLAYERNMESSAGE$(PLAYERNO) = "T:"
                      IF PLAYERNSPLIT(PLAYERNO) <= 2
                        PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0))
                      ELSE
                        PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
                      ENDIF
                      PLAYERNMESSAGE$(PLAYERNO) =+" STAND"                
                  ELIF PLAYERNSPLIT(PLAYERNO) = 2                             
                      PLAYERNMESSAGE$(PLAYERNO) = "T:"
                      PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
                      PLAYERNMESSAGE$(PLAYERNO) =+ " STAND|T:" 
                      PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
                  ELIF PLAYERNSPLIT(PLAYERNO) = 3
                      PLAYERNMESSAGE$(PLAYERNO) = "T:"
                      PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
                      PLAYERNMESSAGE$(PLAYERNO) =+ "|T:" 
                      PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4)) 
                      PLAYERNMESSAGE$(PLAYERNO) =+ " STAND"
                  ENDIF
                ENDIF
            ENDIF
            IF KEYPRESSED$ = "D" AND PLAYERNDOUBLEUSED(PLAYERNO) = 0
                PLAYERNBET%(PLAYERNO) = PLAYERNBET%(PLAYERNO) * 2
                EXEC PERFORM_HIT
                GONEXTPLAYER = 1
                PLAYERNDOUBLEUSED(PLAYERNO) = 1
            ENDIF
            IF KEYPRESSED$ = "T" AND PLAYERNSPLIT(PLAYERNO) = 1 
                EXEC PERFORM_SPLITDEAL
            ENDIF
            IF KEYPRESSED$ = "U" AND ALLOWSURRENDER = TRUE AND PLAYERNDRAWN(PLAYERNO) = 2 AND PLAYERNSPLIT(PLAYERNO) <= 1 
                PLAYERNDRAWN(PLAYERNO) = - PLAYERNDRAWN(PLAYERNO)                
                PLAYERNMESSAGE$(PLAYERNO) = "SURRENDER"
                GONEXTPLAYER = 1
            ENDIF
            IF KEYPRESSED$ = "Q" 
                GONEXTPLAYER = 1
            ENDIF
            KEYPRESSED$ = ""
          ELSE
             GONEXTPLAYER = 1
          ENDIF          
    UNTIL GONEXTPLAYER = 1
ENDPROC

PROC PERFORM_DEALER
    PLAYERNO = 0    
    SECTION_NUMBER = 0
    EXEC SET_PLAYER_SCREEN_SECTION
    POSITION 0,4
    PRINT "Dealer                                 "    
    DRAWCARD_X = DISPPLAYERLEFT + 5 * 1                 
    DRAWCARD_Y = PLAYER_SECTION_ADDRESS
    EXEC DISPLAY_FRONT
    H = CARDNO
    CARDNO = DEALERHIDDEN
    EXEC DISPLAY_CARD 
    CARDNO = H
    EXEC CALCTOTAL
    IF PLAYERNTOTAL(0+0) < 21 
        REPEAT 
            IF DEALERSOFT17HIT = FALSE     
                IF PLAYERNTOTAL(0+0) <= 16 THEN EXEC PERFORM_HIT 
            ELSE
                IF PLAYERNTOTAL(0+0) <= 16 THEN EXEC PERFORM_HIT 
                EXEC CALCTOTAL
                IF PLAYERNTOTAL(0+0) = 17 AND PLAYERNACES(0) > 0 THEN EXEC PERFORM_HIT
                EXEC CALCTOTAL
            ENDIF                
        UNTIL PLAYERNTOTAL(0+0) >= 17
        IF PLAYERNTOTAL(0+0) <=21 
            PLAYERNMESSAGE$(0) = "TOTAL:" 
            PLAYERNMESSAGE$(0) =+ STR$(PLAYERNTOTAL(0)) 
            PLAYERNMESSAGE$(0) =+ " STANDING"
        ELSE
            PLAYERNMESSAGE$(0) = "TOTAL:" 
            PLAYERNMESSAGE$(0) =+ STR$(PLAYERNTOTAL(0)) 
            PLAYERNMESSAGE$(0) =+ " BUSTED"
        ENDIF        
    ELIF PLAYERNDRAWN(0) = 2 AND PLAYERNTOTAL(0) = 21  
        PLAYERNMESSAGE$(0) = "TOTAL:" 
        PLAYERNMESSAGE$(0) =+ STR$(PLAYERNTOTAL(0)) 
        PLAYERNMESSAGE$(0) =+ " BLACKJACK"
    ENDIF
    EXEC SHOWSTATS
ENDPROC

PROC PERFORM_HIT 
    CARDSPACING = 16    
    PLAYERNUMBER = PLAYERNO
    SECTION_NUMBER = PLAYERNO
    EXEC SET_PLAYER_SCREEN_SECTION        
    IF PLAYERNSPLIT(PLAYERNO) <=2
        N = PLAYERNDRAWN(PLAYERNUMBER + 0)
    ELIF PLAYERNSPLIT(PLAYERNO) = 3
        N = PLAYERNDRAWN(PLAYERNUMBER + 4)
    ENDIF    
    DRAWCARD_X = DISPPLAYERLEFT + 5 * N
    DRAWCARD_Y = PLAYER_SECTION_ADDRESS
    EXEC DISPLAY_CARD
    
    IF PLAYERNSPLIT(PLAYERNO) <=2
        SPLITBASE = 0
        H = 0
    ELIF PLAYERNSPLIT(PLAYERNO) >=3        
        SPLITBASE = 7
        H = 4
    ENDIF
    NEWCARDVALUE = BJCARDVALUE(CARDORDER(CARDNO))
    PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE+PLAYERNDRAWN(PLAYERNO + H)) = NEWCARDVALUE
    PLAYERPKCARDVAL(PLAYERNO*20+SPLITBASE+PLAYERNDRAWN(PLAYERNO + H)) = PKCARDVALUE(CARDORDER(CARDNO))
    PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE+PLAYERNDRAWN(PLAYERNO + H)) = CARDSUITVALUE(CARDORDER(CARDNO))
    PLAYERNDRAWN(PLAYERNO + H) = PLAYERNDRAWN(PLAYERNO + H) + 1
    CARDNO = CARDNO + 1
    IF LASTPLAYER < 3
        IF PLAYERNSPLIT(PLAYERNO) <=2            
            POKE @NUMCARDS + PLAYERNO + 0,PLAYERNDRAWN(PLAYERNO + 0)
            H = 0
        ELIF PLAYERNSPLIT(PLAYERNO) >=3
            POKE @NUMCARDS + PLAYERNO + 1,PLAYERNDRAWN(PLAYERNO + 4)
            H = 4
        ENDIF
    ELSE    
        POKE @NUMCARDS + PLAYERNO,PLAYERNDRAWN(PLAYERNO + 0)
        H = 0
    ENDIF    
    EXEC CALCTOTAL      
    IF PLAYERNTOTAL(PLAYERNO) >= 22 
        IF PLAYERNSPLIT(PLAYERNO) < 2 
            PLAYERNMESSAGE$(PLAYERNO) = "T:" 
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+H)) 
            PLAYERNMESSAGE$(PLAYERNO) =+ " BUSTED"
            GONEXTPLAYER = TRUE
        ELIF PLAYERNSPLIT(PLAYERNO) >= 3 AND PLAYERNTOTAL(PLAYERNO+4) > 22 AND LASTPLAYER <= 2
            PLAYERNMESSAGE$(PLAYERNO) = "T:" 
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+H)) 
            PLAYERNMESSAGE$(PLAYERNO) =+ " BUST"
            GONEXTPLAYER = TRUE
        ELIF PLAYERNSPLIT(PLAYERNO) >= 2 AND PLAYERNTOTAL(PLAYERNO+4) < 22 AND LASTPLAYER >= 3
            PLAYERNMESSAGE$(PLAYERNO) = "T:" 
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
            PLAYERNMESSAGE$(PLAYERNO) =+ " BUST|T:"  
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))       
            IF PLAYERNSPLIT(PLAYERNO) = 2 THEN GONEXTPLAYER = TRUE
        ENDIF
        IF PLAYERNSPLIT(PLAYERNO) = 3 AND PLAYERNTOTAL(PLAYERNO+4) >= 22 AND LASTPLAYER >= 3
            PLAYERNMESSAGE$(PLAYERNO) = "T:" 
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
            PLAYERNMESSAGE$(PLAYERNO) =+ "|T:"  
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4)) 
            PLAYERNMESSAGE$(PLAYERNO) =+ " BUST"
        ENDIF
    ELSE
        IF PLAYERNSPLIT(PLAYERNO) < 2 OR LASTPLAYER < 3
            PLAYERNMESSAGE$(PLAYERNO) = "T:" 
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+H))
        ELSE
            PLAYERNMESSAGE$(PLAYERNO) = "T:" 
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
            PLAYERNMESSAGE$(PLAYERNO) =+ "|T:"  
            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
        ENDIF
        IF (PLAYERNDRAWN(PLAYERNO) = 6 OR PLAYERNDRAWN(PLAYERNO) = 13) AND CARDCHARLIEWINSET = 6
            IF PLAYERNSPLIT(PLAYERNO) < 2 OR LASTPLAYER < 3
                PLAYERNMESSAGE$(PLAYERNO) = "T:" 
                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+H)) 
                PLAYERNMESSAGE$(PLAYERNO) =+ " 6 CARD CHARLIE"
            ELSE
                PLAYERNMESSAGE$(PLAYERNO) = "T:" 
                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
                PLAYERNMESSAGE$(PLAYERNO) =+ " C6|T:"  
                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
            ENDIF
            GONEXTPLAYER = TRUE
        ENDIF
        IF (PLAYERNDRAWN(PLAYERNO) = 5 OR PLAYERNDRAWN(PLAYERNO) = 12) AND CARDCHARLIEWINSET = 5
            IF PLAYERNSPLIT(PLAYERNO) < 2 OR LASTPLAYER < 3
                PLAYERNMESSAGE$(PLAYERNO) = "T:" 
                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+H)) 
                PLAYERNMESSAGE$(PLAYERNO) =+ " 5 CARD CHARLIE"
            ELSE
                PLAYERNMESSAGE$(PLAYERNO) = "T:" 
                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0)) 
                PLAYERNMESSAGE$(PLAYERNO) =+ " C5|T:"  
                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
            ENDIF
            GONEXTPLAYER = TRUE
        ENDIF
    ENDIF
ENDPROC

PROC PERFORM_REWARDS
    SPLITREWARD = 0
    PLAYERNUMBER = 0
    BONUSREWARD = 0
    SPLITBASE = 0   
    HANDNUMBER = 0             
    HANDTOTAL = 0
    HANDREWARD%(0) = 0
    HANDREWARD%(1) = 0
    HANDREWARD%(2) = 0
    HANDREWARD%(3) = 0
    FOR PLAYERNUMBER = 1 TO LASTPLAYER
        PLAYERNO = PLAYERNUMBER
        HANDNUMBER = 0
        SPLITBASE = 0
        REPEAT
            IF PLAYERNDRAWN(PLAYERNO) >= 2
                PLAYERNDRAWN(PLAYERNO) = 0
                HANDREWARD%(HANDNUMBER) = 0
                FOR C = 0 TO 6
                    IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE + C) > 0 THEN PLAYERNDRAWN(PLAYERNO) = PLAYERNDRAWN(PLAYERNO) + 1
                NEXT C
                IF HANDNUMBER = 0 THEN HANDTOTAL = PLAYERNTOTAL(PLAYERNO+0)
                IF HANDNUMBER = 1 THEN HANDTOTAL = PLAYERNTOTAL(PLAYERNO+4)
''               IF HANDNUMBER = 2 THEN HANDTOTAL = PLAYERNTOTAL(PLAYERNO+8)
            ENDIF
            IF HANDTOTAL = 21 
                IF PLAYERNDRAWN(PLAYERNO) = 2 
                    C = 0
                    IF COLOR21BONUS = 1 
                        IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 2 OR PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 4 THEN C = C + 1
                        IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) = 2 OR PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) = 4 THEN C = C + 1
                        IF C = 2 
                            HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) * 2
                            IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                               PLAYERNMESSAGE$(PLAYERNO) = "BLACKJACK BLACK  WON:" 
                               PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 2)
                            ENDIF
                            PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                        ELSE
                            C = 0
                            IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 1 OR PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 3 THEN C = C + 1
                            IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) = 1 OR PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) = 3 THEN C = C + 1
                            IF C = 2 
                                HANDREWARD%(HANDNUMBER) =PLAYERNBET%(PLAYERNO) * 2
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2
                                    PLAYERNMESSAGE$(PLAYERNO) = "BLACKJACK BLACK  WON:" 
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 2)
                                ENDIF
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ELSE
                                C = 0
                            ENDIF
                        ENDIF
                    ENDIF
                    IF C = 0 
                        IF SUIT21BONUS = 1 AND PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) 
                            HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) * 2
                            IF HANDNUMBER = 0 OR LASTPLAYER <=2
                                PLAYERNMESSAGE$(PLAYERNO) = "SUITED BLACKJACK  WON:" 
                                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(INT(PLAYERNBET%(PLAYERNO) * 2))
                            ENDIF
                            PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                        ELSE
                            HANDREWARD%(HANDNUMBER) = INT(PLAYERNBET%(PLAYERNO) * 1.5)
                            IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                              PLAYERNMESSAGE$(PLAYERNO) = "BLACKJACK  WON:" 
                              PLAYERNMESSAGE$(PLAYERNO) =+ STR$(INT(PLAYERNBET%(PLAYERNO) * 1.5))
                            ENDIF
                            PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                        ENDIF
                    ENDIF
                ENDIF             
                IF PLAYERNDRAWN(PLAYERNO) = 3            
                    BONUSREWARD = 0           
                    IF BONUS777 = 1                               
                        C  = 0
                        IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 7 THEN C = C + 1
                        IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  1) = 7 THEN C = C + 1
                        IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  2) = 7 THEN C = C + 1                
                        IF C = 3
                            IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) AND PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  2) 
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                    PLAYERNMESSAGE$(PLAYERNO) = "SUITED 777  WON:" 
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(INT(PLAYERNBET%(PLAYERNO) * 4))
                                ENDIF
                                HANDREWARD%(HANDNUMBER) =PLAYERNBET%(PLAYERNO) * 4
                                BONUSREWARD = 1
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ELSE
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                    PLAYERNMESSAGE$(PLAYERNO) = "777 BONUS  WON:" 
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 3)
                                ENDIF    
                                HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) * 3
                                BONUSREWARD = 1
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ENDIF
                        ELSE
                            IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) AND PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  2) AND SUIT21BONUS = TRUE AND BONUSREWARD = FALSE
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                    PLAYERNMESSAGE$(PLAYERNO) = "SUITED 21  WON:"
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 2)
                                ENDIF
                                HANDREWARD%(HANDNUMBER) =PLAYERNBET%(PLAYERNO) * 2
                                BONUSREWARD = 1                    
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ENDIF
                        ENDIF                
                    ENDIF 
                    IF BONUS678 = 1 AND BONUSREWARD = 0
                        C  = 0
                        IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 6 OR PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  1)  = 6 OR PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  2)  = 6 THEN C = C + 1
                        IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 7 OR PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  1)  = 7 OR PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  2)  = 7 THEN C = C + 1
                        IF PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  0) = 8 OR PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  1)  = 8 OR PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE +  2)  = 8 THEN C = C + 1
                        IF C = 3 
                            IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) AND PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  2) 
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                    PLAYERNMESSAGE$(PLAYERNO) = "21  SUITED 678 BONUS   WON:" 
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 4)
                                ENDIF
                                HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) * 4
                                BONUSREWARD = 1
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ELSE  
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2
                                    PLAYERNMESSAGE$(PLAYERNO) = "21  678 BONUS  WON:" 
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 3)
                                ENDIF
                                HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) * 3
                                BONUSREWARD = 1
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ENDIF
                        ELSE
                            IF PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  1) AND PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  0) = PLAYERSUCARDVAL(PLAYERNO*20+SPLITBASE +  2) AND SUIT21BONUS = TRUE AND BONUSREWARD = FALSE
                                IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                    PLAYERNMESSAGE$(PLAYERNO) = "SUITED 21 BONUS  WON:" 
                                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO) * 2)
                                ENDIF
                                HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) * 2
                                BONUSREWARD = 1                 
                                PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                            ENDIF
                        ENDIF
                    ENDIF 
                    IF BONUSREWARD = 0 OR PLAYERNDRAWN(PLAYERNO) >=4 
                        IF (HANDTOTAL > PLAYERNTOTAL(0) OR PLAYERNTOTAL(0) >= 22)  
                            IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                PLAYERNMESSAGE$(PLAYERNO) = "TOTAL :" 
                                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDTOTAL) 
                                PLAYERNMESSAGE$(PLAYERNO) =+ "  WON:" 
                                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO))
                            ENDIF
                            HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) 
                            PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                        ENDIF
                        IF HANDTOTAL = PLAYERNTOTAL(0) 
                            IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                                PLAYERNMESSAGE$(PLAYERNO) = "TOTAL :" 
                                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDTOTAL) 
                                PLAYERNMESSAGE$(PLAYERNO) =+ "    PUSH"
                            ENDIF
                            HANDREWARD%(HANDNUMBER) = 0
                        ENDIF
                    ENDIF            
                 ENDIF
            ELIF HANDTOTAL >= 22 
                  IF HANDNUMBER = 0 OR LASTPLAYER <=2
                        PLAYERNMESSAGE$(PLAYERNO) = STR$(HANDTOTAL)
                        TEMPMESSAGE$ = STR$(PLAYERNBET%(PLAYERNO)) 
                        IF LEN(TEMPMESSAGE$) <= 2 
                          PLAYERNMESSAGE$(PLAYERNO) =+" BUSTED  LOST:"
                        ELIF LEN(TEMPMESSAGE$) = 3
                          PLAYERNMESSAGE$(PLAYERNO) =+" BUSTED LOST:"
                        ELSE
                          PLAYERNMESSAGE$(PLAYERNO) =+" BUST LOST:"
                        ENDIF 
                        PLAYERNMESSAGE$(PLAYERNO) =+ TEMPMESSAGE$
                  ENDIF 
                  HANDREWARD%(HANDNUMBER) =- PLAYERNBET%(PLAYERNO) 
            ELIF PLAYERNDRAWN(PLAYERNO) <= -1 
                  IF HANDNUMBER = 0 OR LASTPLAYER <=2 
                        PLAYERNMESSAGE$(PLAYERNO) = "SURRENDERED LOST:" 
                        PLAYERNMESSAGE$(PLAYERNO) =+ STR$(INT(PLAYERNBET%(PLAYERNO)/2))
                  ENDIF
                  HANDREWARD%(HANDNUMBER) = - INT(PLAYERNBET%(PLAYERNO) / 2)
            ELIF HANDTOTAL < 22 
                IF PLAYERNDRAWN(PLAYERNO) >= CARDCHARLIEWINSET AND PLAYERNDRAWN(PLAYERNO) <= 7
                    IF HANDNUMBER = 0 OR LASTPLAYER <=2
                        IF CARDCHARLIEWINSET = 5 
                            PLAYERNMESSAGE$(PLAYERNO) = "5 CARD CHARLIE  WON:" 
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO))
                        ENDIF
                        IF CARDCHARLIEWINSET = 6
                            PLAYERNMESSAGE$(PLAYERNO) = "6 CARD CHARLIE  WON:" 
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO))
                        ENDIF
                    ENDIF
                    HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) 
                    PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                ELSE
                    IF (HANDTOTAL > PLAYERNTOTAL(0) OR PLAYERNTOTAL(0) >= 22 OR PLAYERNDRAWN(PLAYERNO) >= CARDCHARLIEWINSET)
                        HANDREWARD%(HANDNUMBER) = PLAYERNBET%(PLAYERNO) 
                        IF HANDNUMBER = 0 OR LASTPLAYER <=2
                            PLAYERNMESSAGE$(PLAYERNO) = "TOTAL:" 
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDTOTAL) 
                            PLAYERNMESSAGE$(PLAYERNO) =+ "  WON:" 
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO))
                        ENDIF
                        PLAYERNWINS(PLAYERNO) = PLAYERNWINS(PLAYERNO) + 1
                    ENDIF
                    IF HANDTOTAL = PLAYERNTOTAL(0) AND PLAYERNTOTAL(0) < 22                      
                        IF DEALERTIEWINS = 1 AND PLAYERNTOTAL(0) = 17                     
                            IF HANDNUMBER = 0 OR LASTPLAYER <=2  
                                PLAYERNMESSAGE$(PLAYERNO) = "TIE:" 
                                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDTOTAL) 
                                PLAYERNMESSAGE$(PLAYERNO) =+ "  LOST:" 
                                PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO))
                            ENDIF
                            HANDREWARD%(HANDNUMBER) =- PLAYERNBET%(PLAYERNO) 
                        ELSE                            
                            PLAYERNMESSAGE$(PLAYERNO) = "TOTAL:"                             
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDTOTAL) 
                            PLAYERNMESSAGE$(PLAYERNO) =+ "  PUSH"
                            HANDREWARD%(HANDNUMBER) = 0
                        ENDIF
                    ENDIF                        
                    IF HANDTOTAL < PLAYERNTOTAL(0) AND PLAYERNTOTAL(0) < 22
                        IF HANDNUMBER = 0 OR LASTPLAYER <=2  
                            PLAYERNMESSAGE$(PLAYERNO) = "TOTAL:" 
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDTOTAL) 
                            PLAYERNMESSAGE$(PLAYERNO) =+ "  LOST:" 
                            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNBET%(PLAYERNO))
                        ENDIF
                        HANDREWARD%(HANDNUMBER) =- PLAYERNBET%(PLAYERNO) 
                    ENDIF
                ENDIF
            ENDIF
            
            IF HANDNUMBER = 1 
                IF LASTPLAYER >=3
                  PLAYERNMESSAGE$(PLAYERNO) = "T:" 
                  PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0))
                  IF HANDREWARD%(0) > 0 
                      PLAYERNMESSAGE$(PLAYERNO) =+ " W:" 
                      PLAYERNMESSAGE$(PLAYERNO) =+ STR$(HANDREWARD%(0))
                  ENDIF
                  IF HANDREWARD%(0) < 0 
                    PLAYERNMESSAGE$(PLAYERNO) =+ " L:" 
                    PLAYERNMESSAGE$(PLAYERNO) =+ STR$(ABS(HANDREWARD%(0)))
                  ENDIF
                  IF HANDREWARD%(0) = 0
                      PLAYERNMESSAGE$(PLAYERNO) =+ " P"
                  ENDIF
                  PLAYERNMESSAGE$(PLAYERNO) =+ "|T:" 
                  PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
                  IF HANDREWARD%(1) > 0  
                      PLAYERNMESSAGE$(PLAYERNO) =+" W:" 
                      PLAYERNMESSAGE$(PLAYERNO) =+STR$(HANDREWARD%(1))
                  ENDIF
                  IF HANDREWARD%(1) < 0
                      PLAYERNMESSAGE$(PLAYERNO) =+" L:" 
                      PLAYERNMESSAGE$(PLAYERNO) =+STR$(ABS(HANDREWARD%(1)))
                  ENDIF
                  IF HANDREWARD%(1) = 0
                      PLAYERNMESSAGE$(PLAYERNO) =+ " P"
                  ENDIF
                ELSE
                ENDIF
            ENDIF
            
            SPLITBASE = SPLITBASE + 7
            IF PLAYERNSPLIT(PLAYERNO) <=1 OR PLAYERNSPLIT(PLAYERNO) =4 
                    HANDNUMBER = 2
            ELIF PLAYERNSPLIT(PLAYERNO) >= 2
                    IF HANDNUMBER = 0 
                        HANDNUMBER = 1
                        IF LASTPLAYER <= 2 
                          SECTION_NUMBER = PLAYERNO
                          PLAYERNSPLIT(PLAYERNO) = 2
                          EXEC SET_PLAYER_SCREEN_SECTION
                          POSITION 21,4
                          PRINT PLAYERNMESSAGE$(PLAYERNO)         
                          PLAYERNSPLIT(PLAYERNO) = 3
                        ENDIF
                    ELSE
                        HANDNUMBER = 2
                    ENDIF
'           ELIF PLAYERNSPLIT(PLAYERNO) =5
'                   HANDNUMBER = HANDNUMBER + 1
            ENDIF
        UNTIL HANDNUMBER >=2
        PLAYERNCASH%(PLAYERNUMBER) = PLAYERNCASH%(PLAYERNUMBER) + HANDREWARD%(0) + HANDREWARD%(1)
    NEXT PLAYERNUMBER
    ' BLACKJACKFORM.COMMANDDEAL.VISIBLE = TRUE
    ROUNDSPLAYED = ROUNDSPLAYED + 1
ENDPROC

PROC PERFORM_SPLITDEAL 
    CARDSPACING = 14
    SECTION_NUMBER = PLAYERNO
    EXEC SET_PLAYER_SCREEN_SECTION
    IF LASTPLAYER < 3
        H = PLAYERNO + 0
        IF LASTPLAYER = 2 AND PLAYERNO = 2 
            H = PLAYERNO + 1
        ENDIF
        POKE @NUMCARDS + H + 0,1
        POKE @NUMCARDS + H + 1,1
    ENDIF
            
    IF PLAYERNSPLIT(PLAYERNO) = 1    
        FOR N = 7 TO 13
            PLAYERBJCARDVAL(PLAYERNO*20+N) = 0
            PLAYERPKCARDVAL(PLAYERNO*20+N) = 0
        NEXT N
        IF PLAYERNO >= 1 AND PLAYERNO <= 5
            DRAWCARD_X = DISPPLAYERLEFT + 5 * N 
            DRAWCARD_Y = PLAYER_SECTION_ADDRESS 
            PLAYERBJCARDVAL(PLAYERNO*20+7) = PLAYERBJCARDVAL(PLAYERNO*20+1)        
            PLAYERPKCARDVAL(PLAYERNO*20+7) = PKCARDVALUE(CARDORDER(CARDNO))
            FOR N = 1 TO 6 
                PLAYERBJCARDVAL(PLAYERNO*20+N) = 0
                PLAYERPKCARDVAL(PLAYERNO*20+N) = 0
            NEXT N
            PLAYERNDRAWN(PLAYERNO) = 1
            N = PLAYERNSPLITCARD(PLAYERNO)        
            DRAWCARD_X = DISPPLAYERLEFT + 5 * 1
            DRAWCARD_Y = PLAYER_SECTION_ADDRESS
            EXEC DISPLAY_FRONT
            NEWCARDVALUE = BJCARDVALUE(CARDORDER(CARDNO))
            PLAYERBJCARDVAL(PLAYERNO*20+1) = BJCARDVALUE(CARDORDER(CARDNO))
            PLAYERSUCARDVAL(PLAYERNO*20+1) = CARDSUITVALUE(CARDORDER(CARDNO))                            
            PLAYERNDRAWN(PLAYERNO + 0) = 1
            PLAYERNDRAWN(PLAYERNO + 4) = 1
            PLAYERNSPLIT(PLAYERNO) = 3        
            CARDNO = CARDNO - 1
            SECTION_NUMBER = PLAYERNO
            EXEC SET_PLAYER_SCREEN_SECTION                        
            PLAYERBJCARDVAL(PLAYERNO*20+7) = BJCARDVALUE(CARDORDER(CARDNO))
            PLAYERSUCARDVAL(PLAYERNO*20+7) = CARDSUITVALUE(CARDORDER(CARDNO))                        
            DRAWCARD_X = DISPPLAYERLEFT 
            DRAWCARD_Y = PLAYER_SECTION_ADDRESS
            EXEC DISPLAY_CARD
            CARDNO = CARDNO + 1
            PLAYERNSPLIT(PLAYERNO) = 2
            EXEC SET_PLAYER_SCREEN_SECTION
            EXEC PERFORM_HIT
            EXEC CALCTOTAL
            PLAYERNSPLIT(PLAYERNO) = 3
            EXEC SET_PLAYER_SCREEN_SECTION
            EXEC PERFORM_HIT
            EXEC CALCTOTAL           
            PLAYERNSPLIT(PLAYERNO) = 2
            
            TEMPMESSAGE$ = " 0:"
            TEMPMESSAGE$ =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+0)) 
            TEMPMESSAGE$ =+ " 1:"
            TEMPMESSAGE$ =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+1))
            
            TEMPMESSAGE$ =+ "   7:"
            TEMPMESSAGE$ =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+7)) 
            TEMPMESSAGE$ =+ " 8:"
            TEMPMESSAGE$ =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+8))  
            SECTION_NUMBER = 4
            EXEC SET_PLAYER_SCREEN_SECTION
            POSITION 2,4
            PRINT TEMPMESSAGE$ 
            SECTION_NUMBER = 0
            EXEC SET_PLAYER_SCREEN_SECTION            
            IF LASTPLAYER >= 3 
              PLAYERNMESSAGE$(PLAYERNO) = STR$(PLAYERNTOTAL(PLAYERNO+0)) 
              PLAYERNMESSAGE$(PLAYERNO) =+ "|" 
              PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
            ELSE
              EXEC SET_PLAYER_SCREEN_SECTION
              PLAYERNMESSAGE$(PLAYERNO) = "TOTAL:"
              PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+0))
              TEMPMESSAGE$ = "T:"
              TEMPMESSAGE$ =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
              POSITION 21,4
              PRINT PLAYERNMESSAGE$(PLAYERNO)
              POSITION 21,9
              PRINT TEMPMESSAGE$
              TEMPMESSAGE$ = ""               
            ENDIF
        ENDIF
        PLAYERNDRAWN(PLAYERNO) = 2
        EXEC SHOWSTATS
     ELIF PLAYERNSPLIT(PLAYERNO) = 2 OR PLAYERNSPLIT(PLAYERNO) = 3
            FOR N = 14 TO 20
                PLAYERBJCARDVAL(PLAYERNO*20+N) = 0
            NEXT N
            G = DISPPLAYERLEFT + (PLAYERNO - 1) * DISPPLAYERSPACING + 148 + INT(DISPPLAYERSPACING * .17) 
            H = DISPPLAYERTOP + DISPPLAYERVERTICAL * 0 
            IF PLAYERNSPLIT(PLAYERNO) = 2
                PLAYERBJCARDVAL(PLAYERNO*20+7) = PLAYERBJCARDVAL(PLAYERNO*20+1)        
                FOR N = 1 TO 6 
                    PLAYERBJCARDVAL(PLAYERNO*20+N) = 0
                NEXT N
                PLAYERNDRAWN(PLAYERNO) = 1
            ENDIF     
            IF PLAYERNSPLIT(PLAYERNO) = 3
                PLAYERBJCARDVAL(PLAYERNO*20+14) = PLAYERBJCARDVAL(PLAYERNO*20+8)        
                FOR N = 8 TO 13
                    PLAYERBJCARDVAL(PLAYERNO*20+N) = 0
                NEXT N
                PLAYERNDRAWN(PLAYERNO) = 8
            ENDIF   
     ENDIF
ENDPROC

PROC PERFORM_NEXTHAND    
    IF PLAYERNSPLIT(PLAYERNO) = 2 
        IF LASTPLAYER < 3
            SECTION_NUMBER = PLAYERNO
            EXEC SET_PLAYER_SCREEN_SECTION
'            PLAYERNMESSAGE$(PLAYERNO) = "T:"
'            PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
             PLAYERNMESSAGE$(PLAYERNO) =+ "                   "
             PLAYERNMESSAGE$(PLAYERNO) = PLAYERNMESSAGE$(PLAYERNO)[1,18]
            POSITION 3,4
            PRINT "                 "
            POSITION 21,4
            PRINT PLAYERNMESSAGE$(PLAYERNO)                                
            IF LASTPLAYER = 2 AND PLAYERNO = 2
                H = PLAYERNO + 2
            ELSE
                H = PLAYERNO + 1
            ENDIF
        ELSE    
            H = PLAYERNO + 1
        ENDIF
        PLAYERNSPLIT(PLAYERNO) = 3
        POKE @NUMCARDS + H,2
        PLAYERNMESSAGE$(PLAYERNO) = "T:"
        PLAYERNMESSAGE$(PLAYERNO) =+ STR$(PLAYERNTOTAL(PLAYERNO+4))
        PLAYERNMESSAGE$(PLAYERNO) =+ "  "                                                                   
    
    ENDIF
    IF PLAYERNSPLIT(PLAYERNO) = 3 AND PLAYERBJCARDVAL(PLAYERNO*20+14) > 0
        PLAYERNSPLIT(PLAYERNO) = 4
        PLAYERNDRAWN(PLAYERNO) = 15
    ENDIF
    EXEC CALCTOTAL
ENDPROC

PROC GETBETS    
    GetBetPlayerNumber = 0
    DisplayBetPlayerNumber = 0
    N = 0
    BETIN$ = ""
    BETOK = 0
    BETVAL = 0
    ERRORMESSAGE$ = ""     
    QUITBOXLEFT = 0
    EXITGAME = 0
    BETIN$ = ""   
    POKE 752,0    
    FOR DisplayBetPlayerNumber = 1 TO LASTPLAYER
        SECTION_NUMBER = DisplayBetPlayerNumber 
        EXEC SET_PLAYER_SCREEN_SECTION
        POSITION 3,4:PRINT "$"
        POSITION 4,4:PRINT PLAYERNCASH%(DisplayBetPlayerNumber)                
    NEXT DisplayBetPlayerNumber
    
    
    FOR GetBetPlayerNumber = 1 TO LASTPLAYER        
        ERRORMESSAGE$ = ""
        PLAYERNSPLIT(GetBetPlayerNumber) = 0
        DPOKE 88,@SCREEN_ADDR
        POSITION 12,4:PRINT "Place Bets     ";INVQ$;"uit."              
        SECTION_NUMBER = GetBetPlayerNumber 
        EXEC SET_PLAYER_SCREEN_SECTION
        REPEAT
            BETOK = FALSE            
            FOR DisplayBetPlayerNumber = 1 TO LASTPLAYER
                SECTION_NUMBER = DisplayBetPlayerNumber 
                EXEC SET_PLAYER_SCREEN_SECTION
                IF GetBetPlayerNumber <> DisplayBetPlayerNumber                 
                    POSITION 12,4:PRINT "BET:    "
                    POSITION 16,4:PRINT PLAYERNBET%(DisplayBetPlayerNumber)
                ENDIF
            NEXT DisplayBetPlayerNumber            
            SECTION_NUMBER = GetBetPlayerNumber 
            EXEC SET_PLAYER_SCREEN_SECTION
            POSITION 12,4:PRINT "BET      "
            POSITION 15,4
            BETIN$ = ""            
            INPUT BETIN$
            IF LEN(BETIN$) > 4 
                 BETIN$ = BETIN$[1,4] 
                 IF BETIN$ = "    " THEN BETIN$ = "" 
            ENDIF       
            IF BETIN$="" 
              IF EXITGAME = 0
                  ERRORMESSAGE$ = "Must Enter Number"
              ENDIF
            ELSE                
              IF BETIN$="Q" 
                  EXITGAME = 1
                  GetBetPlayerNumber = 5
              ELSE
                EXITGAME = 0
                BETVAL = VAL(BETIN$)
                IF BETVAL > 9 AND BETVAL<1001 
                  BETOK = 1
                  ERRORMESSAGE$ = ""
                  PLAYERNBET%(GetBetPlayerNumber) = BETVAL                
                ELIF BETVAL>1000 
                     ERRORMESSAGE$ = "Maximum Bet:1000 "
                ELIF BETVAL<10 
                    ERRORMESSAGE$ = "Minimal Bet:10   "
                ENDIF
              ENDIF
            ENDIF
            IF ERRORMESSAGE$ <> "" 
                BETOK = 0
                POSITION 22,4
                PRINT ERRORMESSAGE$
            ENDIF                        
        UNTIL BETOK = 1 OR EXITGAME = 1
    NEXT GetBetPlayerNumber
ENDPROC

PROC SHOWSTATS
    DisplayBetPlayerNumber = 0
    DISPDEALERLEFT = 0
    ' TEXT 2, 2,  "CARDNO : " + STR$(CARDNO) + " / " + STR$(TOTALCARDS)
    FOR DisplayBetPlayerNumber = 0 TO LASTPLAYER        
        IF DisplayBetPlayerNumber = 0 
            DPOKE 88,@SCREEN_ADDR
            POSITION 0,4
            PRINT "Dealer"
            PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ "                   "
            PLAYERNMESSAGE$(DisplayBetPlayerNumber) = PLAYERNMESSAGE$(DisplayBetPlayerNumber)[1,18]
            POSITION 21,4
            PRINT PLAYERNMESSAGE$(DisplayBetPlayerNumber)
        ELSE
 
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) = ""
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE+0)) 
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ " "
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE+1)) 
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ " "
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE+2)) 
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ " "
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE+3)) 
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ " "
            'PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ STR$(PLAYERBJCARDVAL(PLAYERNO*20+SPLITBASE+4)) 



            SECTION_NUMBER = DisplayBetPlayerNumber 
            EXEC SET_PLAYER_SCREEN_SECTION
            POSITION 0,4            
            IF PLAYERNSPLIT(DisplayBetPlayerNumber) <=1
              H = 0
              PRINT "P";STR$(DisplayBetPlayerNumber)
            ELIF PLAYERNSPLIT(DisplayBetPlayerNumber) = 2 
              H = 0
              PRINT "H1"
              IF LASTPLAYER <=2 
                  POSITION 0,9
                  PRINT "H2"
              ENDIF
            ELIF PLAYERNSPLIT(DisplayBetPlayerNumber) >= 3
              PRINT "H2"
              H = 4
            ENDIF            
                        
            IF LEN(PLAYERNMESSAGE$(DisplayBetPlayerNumber)) <= 18
              POSITION 3,4:PRINT "$"
              POSITION 4,4:PRINT PLAYERNCASH%(DisplayBetPlayerNumber)                
              POSITION 12,4:PRINT "BET:    "
              POSITION 16,4:PRINT PLAYERNBET%(DisplayBetPlayerNumber)
              PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ "                    "
              PLAYERNMESSAGE$(DisplayBetPlayerNumber) = PLAYERNMESSAGE$(DisplayBetPlayerNumber)[1,18]
              POSITION 21,4
              PRINT PLAYERNMESSAGE$(DisplayBetPlayerNumber)              
            ELSE
              PLAYERNMESSAGE$(DisplayBetPlayerNumber) =+ "                          "
              PLAYERNMESSAGE$(DisplayBetPlayerNumber) = PLAYERNMESSAGE$(DisplayBetPlayerNumber)[1,24]
              POSITION 0,4:PRINT "                   "
              POSITION 0,4:PRINT "$"
              POSITION 1,4:PRINT PLAYERNCASH%(DisplayBetPlayerNumber)
              POSITION 8,4:PRINT "B:"
              POSITION 10,4:PRINT PLAYERNBET%(DisplayBetPlayerNumber)
              POSITION 15,4              
              PRINT PLAYERNMESSAGE$(DisplayBetPlayerNumber)
            ENDIF 
        ENDIF
    NEXT DisplayBetPlayerNumber
    DPOKE 88,@SCREEN_ADDR
    POKE 752,1
ENDPROC

PROC SHOWCOMMANDS    
    SPLITEXTRALEFT = 0
    GAME_COMMAND$ = ""
    DisplayBetPlayerNumber = 0
    IF PLAYERNSPLIT(PLAYERNO) = 3 OR PLAYERNSPLIT(PLAYERNO) = 4 
        SPLITEXTRALEFT = 0
    ELSE
        SPLITEXTRALEFT = 0
    ENDIF
    DisplayBetPlayerNumber = PLAYERNO - 1
    GAME_COMMAND$ =+ INVH$ 
    GAME_COMMAND$ =+ "IT "
    GAME_COMMAND$ =+ INVS$ 
    GAME_COMMAND$ =+ "TAND "
        
    IF PLAYERNDOUBLEUSED(PLAYERNO) = 0 
        GAME_COMMAND$ =+ INVD$ 
        GAME_COMMAND$ =+ "OUBLE "
    ENDIF    
    IF PLAYERNSPLIT(PLAYERNO) = 1 AND PLAYERNDRAWN(PLAYERNO) <= 2
        GAME_COMMAND$ =+ "SPLI"
        GAME_COMMAND$ =+ INVT$ 
        GAME_COMMAND$ =+ " "
    ENDIF    
    IF ALLOWSURRENDER = TRUE AND PLAYERNDRAWN(PLAYERNO) = 2 AND PLAYERNSPLIT(PLAYERNO) <= 1
        GAME_COMMAND$ =+ "S"
        GAME_COMMAND$ =+ INVU$ 
        GAME_COMMAND$ =+ "RRENDER "
    ENDIF
    IF INSURANCE_STATUS = 1 
        GAME_COMMAND$ =+ INVI$ 
        GAME_COMMAND$ =+ "NSURANCE "    
    ENDIF
    SECTION_NUMBER = PLAYERNO
    EXEC SET_PLAYER_SCREEN_SECTION
    IF PLAYERNSPLIT(PLAYERNO) <=1
        POSITION 0,4
        PRINT INVP$;CHR$(176+PLAYERNO)
    ELIF PLAYERNSPLIT(PLAYERNO) = 2
        POSITION 0,4
        PRINT INVH$;CHR$(177)
        POSITION 0,9
        PRINT INVH$;CHR$(178)        
    ENDIF
    SECTION_NUMBER = 0
    EXEC SET_PLAYER_SCREEN_SECTION
    POSITION 0,4
    IF LEN(GAME_COMMAND$) < 28      
      PRINT "Dealer                                 "
      POSITION 10,4
      PRINT GAME_COMMAND$
    ELSE
      POSITION 0,4
      PRINT GAME_COMMAND$
    ENDIF
ENDPROC

PROC SET_PLAYER_SCREEN_SECTION      
      IF SECTION_NUMBER = 0
          DPOKE 88,@SCREEN_ADDR + 000
      ELIF SECTION_NUMBER = 1 AND LASTPLAYER < 3
          IF PLAYERNSPLIT(SECTION_NUMBER) < 3
              DPOKE 88,@SCREEN_ADDR + 200
          ELSE
              DPOKE 88,@SCREEN_ADDR + 400
          ENDIF
      ELIF SECTION_NUMBER = 1 AND LASTPLAYER >= 3
          DPOKE 88,@SCREEN_ADDR + 200 
      ELIF SECTION_NUMBER = 2 AND LASTPLAYER < 3
          IF PLAYERNSPLIT(SECTION_NUMBER) < 3
              DPOKE 88,@SCREEN_ADDR + 600
          ELSE
              DPOKE 88,@SCREEN_ADDR + 800
          ENDIF
      ELIF SECTION_NUMBER = 2 AND LASTPLAYER >= 3          
          DPOKE 88,@SCREEN_ADDR + 400
      ELIF SECTION_NUMBER = 3
          DPOKE 88,@SCREEN_ADDR + 600
      ELIF SECTION_NUMBER = 4
          DPOKE 88,@SCREEN_ADDR + 800
      ENDIF
      PLAYER_SECTION_ADDRESS = DPEEK(88)
ENDPROC

PROC SHUFFLEDECKS
    B = 0
    I = 0
    J = 0
    K = 0
    L = 0
    N = 0
    M = 0
    O = 0
    ' ****   F AS FLOAT
    H = 0
    G0 = 0
    G1 = 0
    G2 = 0
    DPOKE 88,@SCREEN_ADDR
    
    POSITION 12,4
    PRINT "..Shuffling.."
 
    ' ****   DIS$ = ""
    
    ' ****   DIS$ = MID$(GET DATE$,5) + MID$(GET DATE$,4) + MID$(GET DATE$, 2) + MID$(GET DATE$,8) 
    ' ****   J = VAL(DIS$)
    
    ' ****   G1 = SELECTED_RES_Y * .2 + 24
    ' ****   F = (SELECTED_RES_X * 0.6) / TOTALCARDS
    FOR I = 0 TO TOTALCARDS + JOKERSPRESANT
        CARDORDER(I) = 255
        ' ****   SPRITEI+1, SELECTED_RES_X * .18 + F * I  , G1 , CARDBACKIMAGE
    NEXT I
    REPEAT
        J = 5 + RAND(4) * 2
    UNTIL (TOTALCARDS MOD J) > 0 AND ((TOTALCARDS + 1) MOD J) <> 2 AND ((TOTALCARDS + 1) MOD J) <> 3 AND ((TOTALCARDS + 1) MOD J) <> 4
    CARDNO = 0
    FOR I = 0 TO TOTALCARDS + JOKERSPRESANT
        IF CARDORDER(I) = 255
            CARDORDER(I) = CARDNO 
            CARDNO = (CARDNO + J) MOD (TOTALCARDS + 1 + JOKERSPRESANT)
        ENDIF
    NEXT I
    CARDNO = 0
    M = 0
    FOR M = 0 TO NUMBER_OF_DECKS
        FOR I = 0 TO TOTALCARDS            
            J = RAND(TOTALCARDS + JOKERSPRESANT)
            IF I = J THEN J = RAND(TOTALCARDS + JOKERSPRESANT)
            IF I = J THEN J = RAND(TOTALCARDS + JOKERSPRESANT)
            K = CARDORDER(J)
            CARDORDER(J) = CARDORDER(I)
            CARDORDER(I) = K            
        NEXT I
        IF M = 1 
            FOR I = 0 TO TOTALCARDS + JOKERSPRESANT
                OLDORDER(I) = CARDORDER(I)
            NEXT I    
        ENDIF
    NEXT M
    IF NUMBER_OF_DECKS <= 4
        L = 4
    ELIF NUMBER_OF_DECKS <= 6
        L = 7
    ELSE
        L = 10
    ENDIF  
    ' ****   G2 = SELECTED_RES_Y * .8 
    ' ****   G1 = SELECTED_RES_Y * .6
    ' ****   G0 = SELECTED_RES_Y * .4
    I = 0 
   REPEAT
       K = OLDORDER(I)
       J = CARDORDER(I)
       IF (I MOD L) = 1
           ' ****   SPRITEK+1, SELECTED_RES_X * .36 + F * K * .5 , G0 , CARDBACKIMAGE
       ENDIF
       IF (I MOD L) = 2
           ' ****   SPRITEK+1, SELECTED_RES_X * .36 + F * J * .5  , G1 , CARDBACKIMAGE
       ENDIF
       ' ****   SPRITEK+1, SELECTED_RES_X * .18 + F * J  , G2 , CARDBACKIMAGE
       ' **** SET    SPRITEPRIORITY K+1,J+1      
       I = I + 1
   UNTIL I > TOTALCARDS + JOKERSPRESANT
    CARDNO = 0
   FOR I = 0 TO  TOTALCARDS + JOKERSPRESANT
      ' ****   SPRITEI+1, -200, -200, CARDIMAGE(I)
   NEXT I
    
    POSITION 12,4
    PRINT "             "
    
ENDPROC

PROC INIT_DEFAULTS
    LASTPLAYER = 1
    DECKSIZE = 52    
    NUMBER_OF_DECKS = 4
    DBL_DOWN_SET = 0
    SPLITSET = 0
    BONUS777 = 1
    BONUS678 = 0
    DEALERTIEWINS  = 0
    DEALERSOFT17HIT = 0
    CARDCHARLIEWINSET = 6
    SUIT21BONUS  = 0    
    COLOR21BONUS  = 0    
    DBL_DOWN_3UP = 0           
    ALLOWSURRENDER = 0   
ENDPROC


PROC TITLE_SCREEN             
   A = 0
   B = 0
   C = 0
   I = 0
   J = 0
   K = 0   
   L = 0   
   N = 0
   CONSOL_DOWN = 0
   SELECTED = 0
   POKE @DLIV1,SELECTED   
   MOUSECLICK = 0
   BUTTONUP = 0
   SELECTED_MODE = 0
   MX = 0
   MY = 0
   ' SET WINDOW OFF
   ' SET DISPLAY MODE 1024,768,32
   ' SELECTED_BITDEPTH=32
   ' **** EMPTY CHECKLIST
   ' **** PERFORM CHECKLIST FOR DISPLAY MODES
    A = 1
    N = 1
    B = 0 
    
'   SET WINDOW ON
'   REPEAT
      RESET_TITLE = 0
      POKE 82,0
      POKE 710,210:POKE 709,10:POKE 712,210
      POKE 756,@CHARSET_GAME_HI
      DPOKE 560,@display_list_title
      DPOKE $0224,@TITLE_VBI
      DPOKE $0200,@TITLE00_DLI
      DPOKE 88,@SCREEN_ADDR
      POKE $D40E,192
      POKE @DLIV0,0
      POKE @DLIV1,0
      POKE 752,1
      POSITION 0,0
      CLS
      PRINT "   ATARI CASINO         BLACK JACK     "
      POSITION 0,1      
      PRINT "               A Game By Peter J. Meyer"


      POSITION 0,4
      PRINT "   Deck Size:"
      'POSITION 0,5
      PRINT "Number Decks:"
      'POSITION 0,6
      PRINT " Dealer Hits:"     
      'POSITION 0,7     
      PRINT "  Dealer Tie:"
      'POSITION 0,8
      PRINT "  Black Jack:"
      'POSITION 0,9 
      PRINT " Double Down:"
      'POSITION 0,10
      PRINT "Unbust Limit:"
      'POSITION 0,11
      PRINT "  Split Rule:"
      'POSITION 0,12
      PRINT "   Surrender:"
      'POSITION 0,13
      PRINT "   777 Bonus:"
      'POSITION 0,14
      PRINT "   678 Bonus:"
      'POSITION 0,15
      PRINT "     Players:"
                                                                                            
      POSITION 1,19
      PRINT "Select to Advance    Option to Change"
      POSITION 10,20
      PRINT "Press Start to Begin"

     EXEC SHOW_OPTIONS
     
     REPEAT
        IF PEEK($D01F) <> 7 
          IF CONSOL_DOWN = 0
            IF PEEK($D01F) = 5 
              SELECTED=PEEK(@DLIV1)
              SELECTED = SELECTED + 1
              IF SELECTED>11 THEN SELECTED=0
              POKE @DLIV1,SELECTED              
            ELIF PEEK($D01F) = 3
               A=PEEK(@DLIV1)
               EXEC Change_Game_Option
               EXEC SHOW_OPTIONS
            ENDIF          
            CONSOL_DOWN = 150
          ELSE
            CONSOL_DOWN = CONSOL_DOWN - 1 
          ENDIF
        ELSE
          CONSOL_DOWN = 0
        ENDIF   
     UNTIL PEEK($D01F) = 6
     POKE $D40E,064
     POKE 710,210:POKE 709,10:POKE 712,210      

''    UNTIL SELECTING=2 OR SELECTING=3
    
   'REM GET IMAGE 255,0,0,640,480
   'REM SAVE IMAGE "TITLE SCREEN SHOT.BMP",255
ENDPROC

PROC SHOW_OPTIONS
      POSITION 13,4
      'Deck size can be 48 or 52 cards, 56 Deck Size disabled
      IF DECKSIZE = 48
        PRINT "48 CARD DECKS(Spanish 21)"
      ELIF DECKSIZE = 52
        PRINT "52 CARD DECKS(Standard)  "
      ELIF DECKSIZE = 56
        PRINT "56 CARD DECKS(Fantasy)   "
      ENDIF
      

      POSITION 13,5
      'Number of Decks can 4,6,or 8 Decks
      IF NUMBER_OF_DECKS = 4
        PRINT "FOUR DECKS  "
      ELIF NUMBER_OF_DECKS = 6
        PRINT "SIX DECKS   "
      ELIF NUMBER_OF_DECKS = 8
        PRINT "EIGHT DECKS "
      ENDIF

      

      POSITION 13,6
      IF DEALERSOFT17HIT = 0
        PRINT "HOLDS ON 17 OR MORE      "
      ELSE
        PRINT "DEALER HITS SOFT 17      "
      ENDIF


      POSITION 13,7
      IF DEALERTIEWINS = 0
        PRINT "BET RETURNED. PUSH.      "
      ELSE
        PRINT "LOOSE BET, GOES TO DEALER"
      ENDIF
     
      POSITION 13,8 
      IF SUIT21BONUS = 0
          PRINT "NO BLACKJACK BONUS ALL 3:2"
      ELIF SUIT21BONUS = 1
          PRINT "SUIT BLACKJACK PAYS 2:1   "
      ELIF SUIT21BONUS = 2                    
          PRINT "SAME COLOR  PAYS 2:1      "
      ENDIF


      POSITION 13,9 
      IF DBL_DOWN_SET = 0
         PRINT "ANY TOTAL ALLOWED  "
      ELIF DBL_DOWN_SET = 1
         PRINT "10 OR 11 ONLY      "
      ELIF DBL_DOWN_SET = 2
         PRINT "9, 10, OR 11 ONLY  "
      ELSE  
         PRINT "UPTO 3 CARDS       "
      ENDIF

     
    
     POSITION 13,10
     IF CARDCHARLIEWINSET = 6 
          PRINT "SIX CARD CHARLIE WINS  "
     ELSE  
          PRINT "FIVE CARD CHARLIE WINS "
     ENDIF


      POSITION 13,11
      IF SPLITSET = 0
          PRINT "SPLIT ANY PAIR 10=(J,Q,K)"
      ELIF SPLITSET = 1
          PRINT "SPLIT EXACT PAIR         "
      ELSE  
          PRINT "NO SPLIT ACES            "
      ENDIF



     POSITION 13,12
     IF ALLOWSURRENDER = 0
        PRINT "NO PLAYER SURRENDER      "
     ELSE
        PRINT "ALLOWED HALF BET RETURNED"
     ENDIF  
  



     POSITION 13,13
     IF BONUS777 < 2 
        PRINT BONUS_777_OPTION_SHOW$(BONUS777)
     ENDIF

  

     POSITION 13,14  
     IF BONUS678<2
        PRINT BONUS_678_OPTION_SHOW$(BONUS678)
     ENDIF

     POSITION 13,15
     I = LASTPLAYER - 1 
     IF I < 4
           PRINT NUMBER_OF_PLAYERS_OPTION_SHOW$(I)
     ENDIF
ENDPROC

PROC Change_Game_Option
    SELECTED=PEEK(@DLIV1)
    IF SELECTED = 0 
        'Deck size can be 48 or 52 cards. 56 Card Deck Disabled.
        DECKSIZE = DECKSIZE + 4
        IF DECKSIZE >=56 THEN DECKSIZE = 48      
    ELIF SELECTED = 1
        'Number of Decks can 4,6,or 8 Decks
        NUMBER_OF_DECKS = NUMBER_OF_DECKS + 2
        IF NUMBER_OF_DECKS >= 10 THEN NUMBER_OF_DECKS = 4 
    ELIF SELECTED = 2
        'A soft hit is when dealer has 17 with an Ace, be able to hit again, and if over 21, Ace becomes 1.
        IF DEALERSOFT17HIT = 0 
          DEALERSOFT17HIT = 1
        ELSE
          DEALERSOFT17HIT = 0
        ENDIF    
    ELIF SELECTED = 3
        'Some Casino's have a push rule, if tie, bet is returned.
        IF DEALERTIEWINS = 0
            DEALERTIEWINS = 1
        ELSE
            DEALERTIEWINS = 0
        ENDIF
    ELIF SELECTED = 4
        'Blackjack on opening deal. If two hards are same suit or color, 2x bet is paid out'
        SUIT21BONUS = SUIT21BONUS + 1
        IF SUIT21BONUS >=3 THEN SUIT21BONUS = 0
    ELIF SELECTED = 5
        DBL_DOWN_SET = DBL_DOWN_SET + 1
        IF DBL_DOWN_SET >=3 THEN DBL_DOWN_SET = 0    
    ELIF SELECTED = 6
        CARDCHARLIEWINSET = CARDCHARLIEWINSET + 1
        IF CARDCHARLIEWINSET >=7 THEN CARDCHARLIEWINSET = 5
    ELIF SELECTED = 7
         SPLITSET = SPLITSET + 1
         IF SPLITSET>=3 THEN SPLITSET = 0
    ELIF SELECTED = 8
       IF ALLOWSURRENDER = 0
          ALLOWSURRENDER = 1
       ELSE
          ALLOWSURRENDER = 0
       ENDIF      
    ELIF SELECTED = 9
        IF BONUS777 = 0
            BONUS777 = 1
        ELSE
            BONUS777 = 0
        ENDIF
    ELIF SELECTED = 10
       IF BONUS678 = 0
          BONUS678 = 1
       ELSE
          BONUS678 = 0
       ENDIF    
    ELIF SELECTED = 11
      LASTPLAYER = LASTPLAYER + 1
      IF LASTPLAYER >=5 THEN LASTPLAYER = 1    
    ENDIF    
      


ENDPROC



     
    

  



