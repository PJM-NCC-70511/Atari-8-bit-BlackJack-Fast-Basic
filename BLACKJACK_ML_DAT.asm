PMBANK                                  =$1800                                        
VARBANK                                 =$0600                                                                                                                                       
SCREEN_ADDR                             =$BC00                                         
GAME_SCREEN_ADDR                        =$BC00                                        

_RTCLOCK                                =$12
_PMBANK_HI                              = >_PMBANK   

_M0		        	          	            =$C0
_M1		        	          	            =$C1
_M2		        	          	            =$C2
_M3		        	          	            =$C3
_M4		        	          	            =$C4
_M5		        	          	            =$C5
_M6		        	          	            =$C6
_M7		        	          	            =$C7
_M8		        	          	            =$C8
_M9		        	          	            =$C9
_NDX0									                  =$CA
_NDX1									                  =$CB
_NDX2									                  =$CC
_NDX3									                  =$CD
_HOLDX									                =$CE
_HOLDY									                =$CF
              
                                      ;PLAY_SOUNDS                                      =SOUND_COMMANDER + $0000	    
                                      ;START_SOUND                                      =SOUND_COMMANDER + $009F      
                                      ;GET_NEXT_MUSIC_NOTE                              =SOUND_COMMANDER + $00F6      
                                      ;STOP_SOUND                                       =SOUND_COMMANDER + $0189      
                                      ;SILENCE                                          =SOUND_COMMANDER + $019E      

_SPRITENUM	                                     =_PMBANK+$0180
_SETSP0COLOR                                     =_PMBANK+$0190
_SETSP1COLOR                                     =_PMBANK+$01A0
_SETSPWIDTH                                      =_PMBANK+$01B0
_SPRITENHOZ                                      =_PMBANK+$01C0
_SPRITENVRT                                      =_PMBANK+$01E0
_SPHOZNEXT                                       =_PMBANK+$01F0

_SPRHZ0	                            	           =_PMBANK+$0200 
_SPRHZ1	                            	           =_PMBANK+$0210 
_SPRHZ2	                            	           =_PMBANK+$0220 
_SPRHZ3	                            	           =_PMBANK+$0230 
_SPZONT                                          =_PMBANK+$0240
_SPZONB                                          =_PMBANK+$0250
_SPSRC0                                          =_PMBANK+$0260 
_SPSRC1                                          =_PMBANK+$0278
_SPSRC2                                          =_PMBANK+$0290
_SPSRC3                                          =_PMBANK+$02A8
_SPSRC4                                          =_PMBANK+$02C0
_SPRITEUSE                                       =_PMBANK+$02D8
                                            
_MIBANK                                          =_PMBANK+$0300
_PMBNK0                                          =_PMBANK+$0400
_PMBNK1                             	           =_PMBANK+$0500
_PMBNK2                                          =_PMBANK+$0600
_PMBNK3                             	           =_PMBANK+$0700
            
_character_px                                    =_VARBANK + $020
_character_py                                    =_VARBANK + $021
_character_status                                =_VARBANK + $022
_prior_py                                        =_VARBANK + $024
_stick_read                                      =_VARBANK + $026 
_character_frame                                 =_VARBANK + $027
_prior_rt_clock                                  =_VARBANK + $02C
_menu_selection                                  =_VARBANK + $02D
_find_option                                     =_VARBANK + $02E
_bombs_on_option                                 =_VARBANK + $02F
_walls_on_option                                 =_VARBANK + $030
_shooters_option                                 =_VARBANK + $032
_mind_color                                      =_VARBANK + $034
_show_countdown                                  =_VARBANK + $036
_minds_found                                     =_VARBANK + $038
_minds_under                                     =_VARBANK + $03A
_titlephase                                      =_VARBANK + $03C
_score                                           =_VARBANK + $03E
_lives                                           =_VARBANK + $040
_level                                           =_VARBANK + $041
_topMem                                          =_VARBANK + $042;
_chbase1                                         =_VARBANK + $044;
_row_addr                                        =_VARBANK + $046; 
_exit_cx  	                                	   =_VARBANK + $048;
_exit_cy  	                                		 =_VARBANK + $049; 
_exit_p0  	                                		 =_VARBANK + $04A;
_exit_p1  	                                		 =_VARBANK + $04B; 
_SOUND_COMMANDER_VARIABLE_AREA                   =_VARBANK + $060;



      .export PMBANK
      .export VARBANK                                        
      .export SCREEN_ADDR                                         
      .export GAME_SCREEN_ADDR
      .export PMBANK_HI

            
_CHARSET_GAME:
  .incbin         "CARD2.FNT"
_CHARSET_TITLE:
;  .incbin         "MIND FIELD TITLE.FNT"
_TITLE_DATA:
;  .incbin         "Mind Field Title Screen.txt"

      _CHARSET_GAME_HI = > _CHARSET_GAME
      _CHARSET_TITLE_HI = > _CHARSET_TITLE

      
      .export _CHARSET_GAME
      .export _CHARSET_TITLE
      .export _CHARSET_GAME_HI 
      .export _CHARSET_TITLE_HI
      .export _TITLE_DATA


_GAME_VBI:
      .export _GAME_VBI 
		lda #<_GAME00_DLI
		sta VDSLST+0
		lda #>_GAME00_DLI
		sta VDSLST+1
		lda #$22
		sta COLBAK
		lda _mind_color
		sta COLPF3		
  ;//  inc_RTCLOCK
  ;//bne no_inc_other_clock
  ;//inc RTCLOCK+1
  ;//no_inc_other_clock:
      
	  	LDA _prior_py
	  	STA _NDX2
	  	LDA #>_PMBNK0
	  	STA _NDX3
	  	
	  	LDA #0
	  	LDY #13
Clear_Character_Prior_Loop:
      STA (_NDX2),Y
      DEY
      BPL Clear_Character_Prior_Loop   	
      	
      LDA _character_py
      STA _NDX2
      LDA #>_PMBNK0
      STA _NDX3
        
      LDY _character_frame  
        
             
      LDA _SPRITEADDR_PLY0LO,Y
      STA _NDX0
        
      LDA _SPRITEADDR_PLY0HI,Y
      STA _NDX1
        	
      LDY #13
Copy_Character_Image_Loop:
		LDA (_NDX0),Y
		STA (_NDX2),Y
		DEY
		BPL Copy_Character_Image_Loop
		
		LDA _character_px
		STA HPOSP0   	
    
    LDA _character_py 
		STA _prior_py 


		jmp XITVBV	


_TITLE_VBI:
      .export _TITLE_VBI 
		lda #<_TITLE00_DLI
		sta VDSLST+0
		lda #>_TITLE00_DLI
		sta VDSLST+1
		lda #$22
		sta COLBAK
		lda #$36
		sta COLPF3				
		inc _RTCLOCK+2
		jmp XITVBV


_PAUSE_VBI:
      .export _PAUSE_VBI

		jmp XITVBV

_TITLE00_DLI:
      .export _TITLE00_DLI 
	pha	
	lda #$D8
	sta WSYNC
	sta COLPF0
	lda #$06
	sta COLPF1
	lda #$AA
	sta COLPF1
	lda #>_CHARSET_TITLE
	sta CHBASE
	lda #<_TITLE01_DLI
	sta VDSLST+0
	lda #>_TITLE01_DLI
	sta VDSLST+1
	pla
	rti

_TITLE01_DLI:
      .export _TITLE01_DLI 
	pha	
	lda #142
	sta WSYNC
	sta COLPF0
	lda #216
	sta COLPF1
	lda #56
	sta COLPF2
	lda #>_CHARSET_GAME
 	sta CHBASE
	lda #<_TITLE00_DLI
	sta VDSLST+0
	lda #>_TITLE00_DLI
	sta VDSLST+1
	pla
	rti

_TITLE02_DLI:
      .export _TITLE02_DLI 
	PHA
  PLA
  RTI


_TITLE03_DLI:
      .export _TITLE03_DLI 
	PHA
  PLA
  RTI


_GAME00_DLI:
      .export _GAME00_DLI 
	PHA
  PLA
  RTI

_GAME01_DLI:
      .export _GAME01_DLI 
	PHA
  PLA
  RTI

_GAME02_DLI:
      .export _GAME02_DLI 
	PHA
  PLA
  RTI

_GAME03_DLI:
      .export _GAME03_DLI 
	PHA
  PLA
  RTI

_GAME04_DLI:
      .export _GAME04_DLI 
	PHA
  PLA
  RTI






;     _CHARSET_TITLE_HI         = .hibyte(_CHARSET_TITLE)
;     _CHARSET_GAME_HI          = .hibyte(_CHARSET_GAME)
;     .export _CHARSET_TITLE_HI
;     .export _CHARSET_GAME_HI
      
display_list_title:
     .byte $70,$70,$47
     .byte <_SCREEN_ADDR
     .byte >_SCREEN_ADDR
     .byte $07,$10
     .byte $02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$02,$10,$41
     .byte <display_list_title 
     .byte >display_list_title
    
display_list_game:
     .byte $70,$70,$42
     .byte <_SCREEN_ADDR
     .byte >_SCREEN_ADDR
     .byte $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$41
     .byte <display_list_game 
     .byte >display_list_game
      
      .export display_list_title
      .export display_list_game


_SCRREN_ROW_LOW:
    .byte <(_GAME_SCREEN_ADDR +   0),<(_GAME_SCREEN_ADDR +   40), <(_GAME_SCREEN_ADDR +  80), <(_GAME_SCREEN_ADDR + 120), <(_GAME_SCREEN_ADDR + 160)
    .byte <(_GAME_SCREEN_ADDR + 200), <(_GAME_SCREEN_ADDR + 240), <(_GAME_SCREEN_ADDR + 280), <(_GAME_SCREEN_ADDR + 320), <(_GAME_SCREEN_ADDR + 360)  
  	.byte <(_GAME_SCREEN_ADDR + 400), <(_GAME_SCREEN_ADDR + 440), <(_GAME_SCREEN_ADDR + 480), <(_GAME_SCREEN_ADDR + 520), <(_GAME_SCREEN_ADDR + 560)
  	.byte <(_GAME_SCREEN_ADDR + 600), <(_GAME_SCREEN_ADDR + 640), <(_GAME_SCREEN_ADDR + 680), <(_GAME_SCREEN_ADDR + 720), <(_GAME_SCREEN_ADDR + 760)
    .byte <(_GAME_SCREEN_ADDR + 800), <(_GAME_SCREEN_ADDR + 840), <(_GAME_SCREEN_ADDR + 880), <(_GAME_SCREEN_ADDR + 920), <(_GAME_SCREEN_ADDR + 960)
    .byte <(_GAME_SCREEN_ADDR + 1000) 
    
_SCRREN_ROW_HIGH:
	  .byte >(_GAME_SCREEN_ADDR +   0), >(_GAME_SCREEN_ADDR +  40), >(_GAME_SCREEN_ADDR +  80), >(_GAME_SCREEN_ADDR + 120), >(_GAME_SCREEN_ADDR + 160)
  	.byte >(_GAME_SCREEN_ADDR + 200), >(_GAME_SCREEN_ADDR + 240), >(_GAME_SCREEN_ADDR + 280), >(_GAME_SCREEN_ADDR + 320), >(_GAME_SCREEN_ADDR + 360)
  	.byte >(_GAME_SCREEN_ADDR + 400), >(_GAME_SCREEN_ADDR + 440), >(_GAME_SCREEN_ADDR + 480), >(_GAME_SCREEN_ADDR + 520), >(_GAME_SCREEN_ADDR + 560)
  	.byte >(_GAME_SCREEN_ADDR + 600), >(_GAME_SCREEN_ADDR + 640), >(_GAME_SCREEN_ADDR + 680), >(_GAME_SCREEN_ADDR + 720), >(_GAME_SCREEN_ADDR + 760)
  	.byte >(_GAME_SCREEN_ADDR + 800), >(_GAME_SCREEN_ADDR + 840), >(_GAME_SCREEN_ADDR + 880), >(_GAME_SCREEN_ADDR + 920), >(_GAME_SCREEN_ADDR + 960)
  	.byte >(_GAME_SCREEN_ADDR + 1000)  

      .export _SCRREN_ROW_LOW
      .export _SCRREN_ROW_HIGH




P000:
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255

     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255
     .byte %11111111; $FF  255

     
_SPRITEADDR_PLY0LO:
      .byte <P000
_SPRITEADDR_PLY0HI: 
      .byte >P000
     
_SPRITEADDR_PLY0W:
      .word P000


      .export _SPRITEADDR_PLY0LO      ; Makes Sprite Address Table available to C compiled program
      .export _SPRITEADDR_PLY0HI      ; Makes Sprite Address Table available to C compiled program
      .export _SPRITEADDR_PLY0W       ; Makes Sprite Address Table available to C compiled program

