;;=============================================================================;;
;;                                                                             ;;
;;              		Bubbles  Game                                          ;;
;;                                                                             ;;
;;                                                                             ;;
;;                                                                             ;;
;;              Made by Gilad Mizrahi                            			   ;;
;;                                                                             ;;
;;                                                                             ;;
;;=============================================================================;;
.286
IDEAL
MODEL compact
 
 

STACK 0f500h

 
 
BMP_WIDTH = 320
BMP_HEIGHT = 200

SMALL_BMP_HEIGHT = 40
SMALL_BMP_WIDTH = 40


LOG_2_BLOCK_SIZE EQU 4  ; must be 1 or more not above 10 

BLOCK_SIZE = 1




REPT LOG_2_BLOCK_SIZE 
        BLOCK_SIZE =BLOCK_SIZE * 2   
ENDM  
 

DATASEG
SEGMENT Data para public

	  
	;BMP File data
	  

	 IntStr db 7 dup (' '), "$"
	
	black db 'black.bmp',0
	
	cannon db 'cannon.bmp',0
	EndScreen db 'GO1.bmp',0

	


	
	First db ?
	
	 Ball_Color db ?
	 Bubble_Color db ?

	 
	 CursorX dw ?	
	 CursorY dw ?	;Curser position
	 
	
	Ended db 0
	
	Xp dw ?
	Yp dw ?
	
	SizedRow db	?
	
	score dw 0	;score
	
	MaxYForBubble dW 6
		
	BALL_SIZE  = 8  ; 64 bytes
	
	 Ball   db	0,0,0,0,0,0,0,0			;ball
		 db 0,0,0,'*','*',0,0,0
		 db 0,0,'*','*','*','*',0,0
		 db 0,'*','*',-1,-1,'*','*',0
		 db 0,'*','*',-1,-1,'*','*',0
		 db 0,0,'*','*','*','*',0,0
		 db 0,0,0,'*','*',0,0,0
		 db	0,0,0,0,0,0,0,0
		

	
	XBall dw 148
	YBall dw 150
	
	RndCurrentPos dw 0 ;Random Varaible

	
	BubCord dw 2 dup (?)

	BmpLeft dw ?
	BmpTop dw ?
	BmpColSize dw ?
	BmpRowSize dw ?		;variables to open BMP
	
  ScrLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer
	
	ErrorFile           db 0
	
	SquareSize dw 60
	GotClick db 0
	
	Color db ?
		
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 400h dup (0)
	
	Xclick dw 160
	Yclick dw 130	;variables for buttons

	Frame1 	db 'f1.bmp',0
	Frame2 	db 'f2.bmp',0
	Frame3 	db 'f3.bmp',0
	Frame4 	db 'f4.bmp',0
	Frame5 	db 'f5.bmp',0
	Frame6 	db 'f6.bmp',0
	Frame7 	db 'f7.bmp',0
	Frame8 	db 'f8.bmp',0
	Frame9 	db 'f9.bmp',0
	Frame10 db 'f10.bmp',0
	Frame11	db 'f11.bmp',0
	Frame12 db 'f12.bmp',0
	Frame13 db 'f13.bmp',0
	Frame14 db 'f14.bmp',0
	Frame15 db 'f15.bmp',0
	Frame16 db 'f16.bmp',0
	Frame17 db 'f17.bmp',0
	Frame18 db 'f18.bmp',0
	Frame19 db 'f19.bmp',0
	Frame20 db 'f20.bmp',0
	Frame21 db 'f21.bmp',0
	Frame22 db 'f22.bmp',0
	Frame23 db 'f23.bmp',0
	Frame24 db 'f24.bmp',0
	Frame25 db 'f25.bmp',0
	Frame26 db 'f26.bmp',0
	Frame27 db 'f27.bmp',0
	Frame28 db 'f28.bmp',0
	Frame29 db 'f29.bmp',0
	Frame30 db 'f30.bmp',0
	Frame31 db 'f31.bmp',0
	Frame32 db 'f32.bmp',0
	Frame33 db 'f33.bmp',0
	Frame34 db 'f34.bmp',0
	Frame35 db 'f35.bmp',0
	Frame36 db 'f36.bmp',0
	Frame37 db 'f37.bmp',0
	Frame38 db 'f38.bmp',0
	Frame39 db 'f39.bmp',0
	Frame40 db 'f40.bmp',0
	Frame41 db 'f41.bmp',0
	Frame42 db 'f42.bmp',0
	Frame43 db 'f43.bmp',0
	Frame44 db 'f44.bmp',0
	Frame45 db 'f45.bmp',0
	Frame46 db 'f46.bmp',0
	Frame47 db 'f47.bmp',0
	Frame48 db 'f48.bmp',0
	Frame49 db 'f49.bmp',0
	Frame50 db 'f50.bmp',0
	Frame51 db 'f51.bmp',0
	Frame52 db 'f52.bmp',0
	Frame53 db 'f53.bmp',0
	Frame54 db 'f54.bmp',0
	Frame55 db 'f55.bmp',0
	Frame56 db 'f56.bmp',0
	Frame57 db 'f57.bmp',0
	Frame58 db 'f58.bmp',0
	Frame59 db 'f59.bmp',0
	Frame60 db 'f60.bmp',0
	Frame61 db 'f61.bmp',0
	Frame62 db 'f62.bmp',0
	Frame63 db 'f63.bmp',0
	Frame64 db 'f64.bmp',0
	Frame65 db 'f65.bmp',0
	Frame66 db 'f66.bmp',0
	Frame67 db 'f67.bmp',0
	Frame68 db 'f68.bmp',0
	Frame69 db 'f69.bmp',0
	Frame70 db 'f70.bmp',0
	Frame71 db 'f71.bmp',0
	Frame72 db 'f72.bmp',0
	Frame73 db 'f73.bmp',0
	Frame74 db 'f74.bmp',0
	Frame75 db 'f75.bmp',0
	Frame76 db 'f76.bmp',0
	Frame77 db 'f77.bmp',0
	Frame78 db 'f78.bmp',0
	Frame79 db 'f79.bmp',0
	Frame80 db 'f80.bmp',0
	Frame81 db 'f81.bmp',0
	Frame82 db 'f82.bmp',0
	Frame83 db 'f83.bmp',0
	Frame84 db 'f84.bmp',0
	Frame85 db 'f85.bmp',0
	Frame86 db 'f86.bmp',0
	Frame87 db 'f87.bmp',0
	Frame88 db 'f88.bmp',0
	Frame89 db 'f89.bmp',0
	Frame90 db 'f90.bmp',0
	Frame91 db 'f91.bmp',0
	Frame92 db 'f92.bmp',0
	Frame93 db 'f93.bmp',0
	Frame94 db 'f94.bmp',0
	Frame95 db 'f95.bmp',0
	Frame96 db 'f96.bmp',0
	Frame97 db 'f97.bmp',0
	Frame98 db 'f98.bmp',0
	Frame99 db 'f99.bmp',0
	Frame100 db 'f100.bmp',0
	Frame101 db 'f101.bmp',0
	Frame102 db 'f102.bmp',0
	Frame103 db 'f103.bmp',0
	Frame104 db 'f104.bmp',0
	Frame105 db 'f105.bmp',0
	Frame106 db 'f106.bmp',0
	Frame107 db 'f107.bmp',0
	Frame108 db 'f108.bmp',0
	Frame109 db 'f109.bmp',0
	Frame110 db 'f110.bmp',0
	Frame111 db 'f111.bmp',0
	Frame112 db 'f112.bmp',0
	Frame113 db 'f113.bmp',0
	Frame114 db 'f114.bmp',0
	Frame115 db 'f115.bmp',0
	Frame116 db 'f116.bmp',0
	Frame117 db 'f117.bmp',0
	Frame118 db 'f118.bmp',0
	Frame119 db 'f119.bmp',0
	Frame120 db 'f120.bmp',0
	Frame121 db 'f121.bmp',0
	Frame122 db 'f122.bmp',0
	Frame123 db 'f123.bmp',0
	Frame124 db 'f124.bmp',0
	Frame125 db 'f125.bmp',0
	Frame126 db 'f126.bmp',0
	Frame127 db 'f127.bmp',0
	Frame128 db 'f128.bmp',0
	Frame129 db 'f129.bmp',0
	Frame130 db 'f130.bmp',0
	Frame131 db 'f131.bmp',0
	Frame132 db 'f132.bmp',0
	Frame133 db 'f133.bmp',0
	Frame134 db 'f134.bmp',0
	Frame135 db 'f135.bmp',0
	Frame136 db 'f136.bmp',0
	Frame137 db 'f137.bmp',0
	Frame138 db 'f138.bmp',0
	Frame139 db 'f139.bmp',0
	Frame140 db 'f140.bmp',0
	Frame141 db 'f141.bmp',0
	Frame142 db 'f142.bmp',0
	Frame143 db 'f143.bmp',0
	Frame144 db 'f144.bmp',0
	Frame145 db 'f145.bmp',0
	Frame146 db 'f146.bmp',0
	Frame147 db 'f147.bmp',0
	Frame148 db 'f148.bmp',0
	Frame149 db 'f149.bmp',0
	Frame150 db 'f150.bmp',0
	Frame151 db 'f151.bmp',0
	Frame152 db 'f152.bmp',0
	Frame153 db 'f153.bmp',0
	Frame154 db 'f154.bmp',0
	
	
ends
	
	
	
	
CODESEG
 
	
ASSUME ds:data
start:
	mov ax, seg frame10
	mov ds, ax
	
	call SetGraphic
 
	call setAsyncMouse
	call ResetMatch
Animation:
	call ShowFrames
	cmp [GotClick],1
	jne	Animation

		
endAni:

	mov ax,2h
	int 33h	
	
	call ClearScreen
	
	call SetGraphic
	
	call ShowScoreText

	call ShowEndLine
	
	call BubblesFirstDraw
	xor si,si	;counter for loops

Game:
	call putBall

	call DrawOnMousePoint
	cmp [ended],1
	je GAMEENDED
	
	cmp [MaxYForBubble],170
	jge GameEnded
	
	mov [First],1

	push si
	mov bx,[word bubcord]
	push bx
	mov bx,[word bubcord + 2]
	push bx
	xor si,si
	call CheckSameColor
	pop si
	
	
	
	call ShowScoreText
	
	cmp si,6
	jne cont1
	
addl:
	call _25MicroSecDelay
	call AddLine
	cmp [ended],1
	je GAMEENDED
	xor si,si
	
cont1:
	cmp [MaxYForBubble],170
	jge GameEnded
	
	inc si
	jmp Game	;loops the game until end

GameEnded:
	mov ax,2
	int 33h
	call ShowEndScreen
exit:
	mov ah,0
	int 16h
		
	cmp ah,32d
	jne endmatch
	call resetmatch
	jmp ANIMATION
endmatch:	
	mov ax,2
	int 10h
	
	mov ax, 4c00h
	int 21h
	

	
;==========================
;==========================
;===== Procedures  Area ===
;==========================
;==========================

proc OpenShowBmp 
	
	 
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	call ReadBmpHeader
	
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call ShowBMP
	
	 
	call CloseBmpFile

@@ExitProc:
	ret
endp OpenShowBmp

 
 
	
; input dx filename to open
proc OpenBmpFile							 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile
 
 
 



proc CloseBmpFile 
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile




; Read 54 bytes the Header
proc ReadBmpHeader						
	push cx
	push dx
	
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	
	pop dx
	pop cx
	ret
endp ReadBmpHeader



proc ReadBmpPalette  ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	
	pop dx
	pop cx
	
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette							
										
	push cx
	push dx
	
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
CopyNextColor:
	mov al,[si+2] 		; Red				
	shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
	out dx,al 						
	mov al,[si+1] 		; Green.				
	shr al,2            
	out dx,al 							
	mov al,[si] 		; Blue.				
	shr al,2            
	out dx,al 							
	add si,4 			; Point to next color.  (4 bytes for each color BGR + null)				
								
	loop CopyNextColor
	
	pop dx
	pop cx
	
	ret
endp CopyBmpPalette


 
;INPUT: SI - LENGTH
;al - color 
proc DrawHorizontalLine	
	push si
	push cx
DrawLine:
	cmp si,0
	jz ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	 
	
	inc cx
	dec si
	jmp DrawLine
	
	
ExitDrawLine:
	pop cx
    pop si
	ret
endp DrawHorizontalLine


 
;INPUT: SI - LENGTH
;al - color 
proc DrawVerticalLine	
	push si
	push dx
 
DrawVertical:
	cmp si,0
	jz @@ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	
	 
	
	inc dx
	dec si
	jmp DrawVertical
	
	
@@ExitDrawLine:
	pop dx
    pop si
	ret
endp DrawVerticalLine



; cx = col dx= row al = color si = height di = width 
proc Rect
	push cx
	push di
NextVerticalLine:	
	
	cmp di,0
	jz @@EndRect
	
	cmp si,0
	jz @@EndRect
	call DrawVerticalLine
	inc cx
	dec di
	jmp NextVerticalLine
	
	
@@EndRect:
	pop di
	pop cx
	ret
endp Rect



proc DrawSquare
	push si
	push ax
	push cx
	push dx
	
	mov al,[Color]
	mov si,[SquareSize]  ; line Length
 	mov cx,[Xp]
	mov dx,[Yp]
	call DrawHorizontalLine

	 
	
	call DrawVerticalLine
	 
	
	add dx ,si
	dec dx
	call DrawHorizontalLine
	 
	
	
	sub  dx ,si
	inc dx
	add cx,si
	dec cx
	call DrawVerticalLine
	
	
	 pop dx
	 pop cx
	 pop ax
	 pop si
	 
	ret
endp DrawSquare

 
;sets to graphic mode
 proc  SetGraphic	near
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic
 
 


proc ShowBMP near
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpRowSize lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
	mov cx,[BmpRowSize]
	
 
	mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	xor dx,dx
	mov si,4
	div si
	cmp dx,0
	mov bp,0
	jz @@row_ok
	mov bp,4
	sub bp,dx

@@row_ok:	
	mov dx,[BmpLeft]
	
@@NextLine:
	push cx
	push dx
	
	mov di,cx  ; Current Row at the small bmp (each time -1)
	add di,[BmpTop] ; add the Y on entire screen
	
 
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	dec di
	mov cx,di
	shl cx,6
	shl di,8
	add di,cx
	add di,dx
	 
	; small Read one line
	mov ah,3fh
	mov cx,[BmpColSize]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory
	cld ; Clear direction flag, for movsb
	mov cx,[BmpColSize]  
	mov si,offset ScrLine
	rep movsb ; Copy line to the screen
	
	pop dx
	pop cx
	 
	loop @@NextLine
	
	pop cx
	ret
endp ShowBMP 





proc setAsyncMouse near
	 mov ax, seg MyMouseHandle 
     mov es, ax
     mov dx, offset MyMouseHandle   ; ES:DX ->Far routine
     mov ax,0Ch             ; interrupt number
     mov cx,0Ah              ; 2 + 8   Left Down and Right down
     int 33h                
	ret
endp setAsyncMouse



PROC MyMouseHandle  far
stop:
		
		push es
		
		push 0A000h  ; in order to write directly to video memory we must set es the address
		pop es
		
		 
		; show mouse
		push ax
		mov ax,01h
		int 33h	
		pop ax
		
		
		
		shr cx, 1 	 ;the Mouse default is 640X200 So divide 640 by 2 to get
		
		cmp ax,8
		jz ExitProc
		
		;hide mouse
		mov ax,02h
		int 33h
		
		
		mov di,dx    ; set di at the end of the dx line (dx * 320) 
		shl dx,6	 ; multiply line number twice by 64 and by 256 and add them (=320) 
		shl di,8
		add di,dx
		add  di,cx
	 	

		
		
		jmp ExitProc
		
		
		
ExitProc:	
		; show mouse
		mov ax,01h
		int 33h	
		
		pop es
		 
		ret
ENDP MyMouseHandle 

;All of the procs below are to make the animation
;All of them have no input and the only output is the animation
;they get a bmp pic and out it on the screen with a small delay
proc Show10Frames
	
	push seg Frame1
	pop ds

	mov dx, offset Frame1
	
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], 320
	mov [BmpRowSize] ,200
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame2
	call OpenShowBmp
	
	
	mov dx, offset Frame3
	call OpenShowBmp
	
	mov dx, offset Frame4
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame5
	call OpenShowBmp

	
	mov dx, offset Frame6
	call OpenShowBmp
	
	
	mov dx, offset Frame7
	call OpenShowBmp
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame8
	call OpenShowBmp
	
	mov dx, offset Frame9
	call OpenShowBmp
	
	
	mov dx, offset Frame10
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	
	
	


	
@@endproc:
	ret
endp Show10Frames

proc Show20Frames
	mov dx, offset Frame11
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame12
	call OpenShowBmp
	
	mov dx, offset Frame13
	call OpenShowBmp
	
	
	mov dx, offset Frame14
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame15
	call OpenShowBmp
	
	
	mov dx, offset Frame16
	call OpenShowBmp
	
	
	mov dx, offset Frame17
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame18
	call OpenShowBmp
	
	mov dx, offset Frame19
	call OpenShowBmp
	
	mov dx, offset Frame20
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
@@endproc:	
	ret
endp Show20Frames

;cont to show frames
proc Show30Frames
	mov dx, offset Frame21
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame22
	call OpenShowBmp
		
	
	mov dx, offset Frame23
	call OpenShowBmp
	
	mov dx, offset Frame24
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
		
	mov dx, offset Frame25
	call OpenShowBmp
		
	mov dx, offset Frame26
	call OpenShowBmp	
	call CloseBmpFile	
	
	mov dx, offset Frame27
	call OpenShowBmp	
	call CloseBmpFile	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame28
	call OpenShowBmp
	call CloseBmpFile
		
	mov dx, offset Frame29
	call OpenShowBmp
	call CloseBmpFile
	
	mov dx, offset Frame30
	call OpenShowBmp
	call CloseBmpFile
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
@@EndProc:
	ret
endp Show30Frames

;cont to show frames
proc	_40Frames
	mov dx, offset Frame31
	call OpenShowBmp
	call CloseBmpFile
		
	mov dx, offset Frame32
	call OpenShowBmp	
	call CloseBmpFile
		
	mov dx, offset Frame33
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame34
	call OpenShowBmp

	mov dx, offset Frame35
	call OpenShowBmp
	call CloseBmpFile
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame36
	call OpenShowBmp
	call CloseBmpFile

	mov dx, offset Frame37
	call OpenShowBmp
	call CloseBmpFile
	
	mov dx, offset Frame38
	call OpenShowBmp
	call CloseBmpFile
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame39
	call OpenShowBmp
	call CloseBmpFile
	
	mov dx, offset Frame40
	call OpenShowBmp
	call CloseBmpFile
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _40Frames

proc _50Frames
	mov dx, offset Frame42
	call OpenShowBmp
	call CloseBmpFile
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame44
	call OpenShowBmp
	call CloseBmpFile
	
	mov dx, offset Frame45
	call OpenShowBmp
	call CloseBmpFile
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame46
	call OpenShowBmp
	
	mov dx, offset Frame47
	call OpenShowBmp
	
	mov dx, offset Frame48
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame49
	call OpenShowBmp
	
	mov dx, offset Frame50
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _50Frames

proc _60Frames
	mov dx, offset Frame51
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame52
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame53
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame54
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame55
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame56
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame57
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame58
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame59
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame60
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _60Frames

proc _70Frames
	mov dx, offset Frame61
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame62
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame63
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame64
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame65
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame66
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame67
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame68
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame69
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame70
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _70Frames

proc _80Frames
	mov dx, offset Frame71
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame72
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame73
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame74
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame75
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame76
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame77
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame78
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame79
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame80
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _80Frames

proc _90Frames
	mov dx, offset Frame81
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame82
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame83
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame84
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame85
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame86
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame87
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame88
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame89
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame90
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _90Frames


proc _100Frames
	mov dx, offset Frame91
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame92
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame93
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	call _25microsecdelay
	
	mov dx, offset Frame94
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame95
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame96
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame97
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame98
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame99
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame100
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _100Frames


proc _110Frames
	mov dx, offset Frame101
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame102
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame103
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame104
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame105
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame106
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame107
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame108
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame109
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame110
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _110Frames

proc _120Frames
	mov dx, offset Frame111
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame112
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame113
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame114
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame115
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame116
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame117
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame118
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame119
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame120
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _120Frames

proc _130Frames
	mov dx, offset Frame121
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame122
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame123
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame124
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame125
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame126
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame127
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame128
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame129
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame130
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _130Frames

proc _140Frames
	mov dx, offset Frame131
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame132
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame133
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame134
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame135
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame136
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame137
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame138
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame139
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame140
	call OpenShowBmp
	call _25microsecdelay
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _140Frames

proc _150Frames
	mov dx, offset Frame141
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame142
	call OpenShowBmp	
	call _25microsecdelay
	
	mov dx, offset Frame143
	call OpenShowBmp	
	call _25microsecdelay
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame144
	call OpenShowBmp
	call _25microsecdelay
	
	mov dx, offset Frame145
	call OpenShowBmp
	call _25microsecdelay

	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame146
	call OpenShowBmp
	call _25microsecdelay

	mov dx, offset Frame147
	call OpenShowBmp
	call _25microsecdelay

	mov dx, offset Frame148
	call OpenShowBmp
	call _25microsecdelay

	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame149
	call OpenShowBmp
	call _25microsecdelay
	mov dx, offset Frame150
	call OpenShowBmp
	call _25microsecdelay
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _150Frames

proc LastFrames
	mov dx, offset Frame151
	call OpenShowBmp
	
	mov dx, offset Frame152
	call OpenShowBmp	
	
	mov dx, offset Frame153
	call OpenShowBmp	
	call _25microsecdelay

	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame154
	call OpenShowBmp
	call _25microsecdelay

	call CheckLeftClickPressed
@@endproc:
	ret
endp LastFrames


proc ShowFrames
	push dx

	call Show10Frames
	cmp [GotClick],1
	je	@@endproc
	
	call Show20Frames
	cmp [GotClick],1
	je	@@endproc
	
	call Show30Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _40Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _50Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _60Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _70Frames
	cmp [GotClick],1
	je	@@endproc

	call _80Frames
	cmp [GotClick],1
	je	@@endproc	
	
	call _90Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _100Frames
	cmp [GotClick],1
	jne	@@cont
	
@@endproc:
	pop dx
	ret
@@cont:	
	call _110Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _120Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _130Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _140Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _150Frames
	cmp [GotClick],1
	je	@@endproc
	
	call lastframes
	jmp @@endproc
	

endp ShowFrames




;Check if left click has been pressed and if it has did it press in a certain place
;input:Square size - the size of the button
;Xclick - x of button
;Yclick - y of button
;(there is a mouse input inside the proc)
;
;output - Gotclick = 0 - No press
;Gotclick = 1 - pressed in place
proc CheckLeftClickPressed
	push si
	push ax
	push bx
	push cx
	push dx
		
	
	mov ax,5h
	mov bx,0
	int 33h	;mouse input
	
	cmp bx,00h
	jna @@ENDCHECK ;Nothing Pressed
	and ax,0001h
	jz @@ENDCHECK   ;left wasn't pressed

;if left was pressed:
	shr cx,1	;makes it fit 320 horizontaly
	cmp cx,250
	ja @@ENDCHECK
	mov si, cx 
	add si, [SquareSize]
	cmp si , [Xclick]
	jl @@ENDCHECK
	mov si, cx 
	sub si, [SquareSize]
	cmp si , [Xclick]
	jg @@ENDCHECK
	
	mov si, dx 
	add si, [SquareSize]
	cmp si , [Yclick]
	jl @@ENDCHECK
	mov si, dx 
	sub si, [SquareSize]
	cmp si , [Yclick]
	jg @@ENDCHECK
	mov [GotClick],1
	jmp @@ENDCHECK
	
@@ENDCHECK:	
	pop dx
	pop cx
	pop bx
	pop ax
	pop si
	
	ret
endp CheckLeftClickPressed
	
	
;i made a bmp of black screen that i used over the time to re edit files, so i used it also as a "clear screen" option	
proc ClearScreen near	
	push dx
	mov dx,offset black
	call OpenShowBmp
	pop dx
ret
endp ClearScreen


;shows the score with a "score:" text
;could have done it with a string and an array but what is cool with that?
;show ax decimal is the best
proc ShowScoreText
	push dx
	push ax
	push bx
	
	
	mov  dl, 180  
	mov  dh, 100  
	mov  bh, 0    
	mov  ah, 02h  ;SetCursorPosition
	int  10h

	mov  al, 's'
	mov  bl, 7h  
	mov  bh, 0    
	mov  ah, 0Eh  ;draw letter
	int  10h
	
	mov  al, 'c'
	mov  bl, 7h 
	mov  bh, 0    
	mov  ah, 0Eh  
	int  10h	;draw letter
	
	mov  al, 'o'
	mov  bl, 7h 
	mov  bh, 0    
	mov  ah, 0Eh  
	int  10h	;draw letter
	
	mov  al, 'r'
	mov  bl, 7h 
	mov  bh, 0    
	mov  ah, 0Eh  
	int  10h	;draw letter
	
	mov  al, 'e'
	mov  bl, 7h 
	mov  bh, 0   
	mov  ah, 0Eh  
	int  10h	;draw letter
	
	mov  al, ':'
	mov  bl, 7h  
	mov  bh, 0    
	mov  ah, 0Eh  
	int  10h	;draw letter
	
	mov ax,[score]	;moves to ax the score to print it
	call ShowAxDecimal	;printing it
	
	pop bx
	pop ax
	pop dx
ret
endp ShowScoreText

proc ShowAxDecimal	near
       push ax
	   push bx
	   push cx
	   push dx
	   
	   ; check if negative
	   test ax,08000h
	   jz PositiveAx
			
	   ;  put '-' on the screen
	   push ax
	   mov dl,'-'
	   mov ah,2
	   int 21h
	   pop ax

	   neg ax ; make it positive
PositiveAx:
       mov cx,0   ; will count how many time we did push 
       mov bx,10  ; the divider
   
put_mode_to_stack:
       xor dx,dx
       div bx
       add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
       push dx    
       inc cx
       cmp ax,9   ; check if it is the last time to div
       jg put_mode_to_stack

	   cmp ax,0
	   jz pop_next  ; jump if ax was totally 0
       add al,30h  
	   mov dl, al    
  	   mov ah, 2h
	   int 21h        ; show first digit MSB
	       
pop_next: 
       pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   mov dl, al
       mov ah, 2h
	   int 21h        ; show all rest digits
       loop pop_next
		
   
	   pop dx
	   pop cx
	   pop bx
	   pop ax
	   
	   ret
endp ShowAxDecimal


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;														;
;														;
;						Ball							;
;														;
;														;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;puts the ball in place
;XBall - x
;YBall - y
proc putBall near
	push si
	push di
	push ax
	push bx
	push cx
	push dx
	
	mov bl,9
    mov bh,0fh
	call RandomByCs
	mov [Ball_Color],al	;randomizing ball color
	
	xor si,si
	xor bx,bx
	mov dx,[YBall]
nextR:
	
		mov di,0
		mov cx,[XBall]
	nextC:
		 
			mov ah,0dh
			int 10h	;gets the current pixel color
			
			xor al,[byte ball + bx ];xoring it to save the color before
putPixel:			
			mov ah,0ch	
			cmp [byte ball + bx],'*'	;Checks if there is a * int the current position(every * is being colored to the random color the rest is white)
			jne @@cont
			mov al,[Ball_Color]
@@cont:
			int 10h    ; put pixel	
			
			jmp ince

ince:
			inc cx
			inc di
			inc bx

		cmp di,BALL_SIZE
		jb nextC
		inc dx
		inc si
	
	cmp si, BALL_SIZE
	jb nextR
	 
	pop dx
	pop cx
	pop bx
	pop ax
	pop di
	pop si


	ret
endp putBall


;proc to wait 25 miliseconds
proc _25MicroSecDelay near
	push  cx
	push dx
	push ax


	mov     cx, 00h
	mov     dx, 46A0h
	mov     ah, 86h
	int     15h

	pop ax
	pop dx
	pop cx
	
	ret
endp _25MicroSecDelay



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;															;
;															;
;						Randoms								;
;															;
;															;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;Description  : get RND between any bl and bh includs (max 0 -255)
; Input        : 1. Bl = min (from 0) , BH , Max (till 255)
; 			     2. RndCurrentPos a  word variable,   help to get good rnd number
; 				 	Declre it at DATASEG :  RndCurrentPos dw ,0
;				 3. EndOfCsLbl: is label at the end of the program one line above END start		
; Output:        Al - rnd num from bl to bh  (example 50 - 150)
; More Info:
; 	Bl must be less than Bh 
; 	in order to get good random value again and agin the Code segment size should be 
; 	at least the number of times the procedure called at the same second ... 
; 	for example - if you call to this proc 50 times at the same second  - 
; 	Make sure the cs size is 50 bytes or more 
; 	(if not, make it to be more) 
proc RandomByCs	near
    push es
	push si
	push di
	
	mov ax, 40h
	mov	es, ax
	
	sub bh,bl  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp bh,0
	jz @@ExitP
 
	mov di, [word RndCurrentPos]
	call MakeMask ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
	
RandLoop: ;  generate random number 
	mov ax, [es:06ch] ; read timer counter
	mov ah, [byte cs:di] ; read one byte from memory (from semi random byte at cs)
	xor al, ah ; xor memory and counter
	
	; Now inc di in order to get a different number next time
	inc di
	cmp di,(endgame - start - 1)
	jb @@Continue
	mov di, 0
@@Continue:
	mov [word RndCurrentPos], di
	
	and ax, si ; filter result between 0 and si (the nask)
	cmp al,bh    ;do again if  above the delta
	ja RandLoop
	
	add al,bl  ; add the lower limit to the rnd num
		 
@@ExitP:	
	pop di
	pop si
	pop es
	ret
endp RandomByCs



;proc to mask for Random
Proc MakeMask   near 
    push bx

	mov si,1
    
@@again:
	shr bh,1
	cmp bh,0
	jz @@EndProc
	
	shl si,1 ; add 1 to si at right
	inc si
	
	jmp @@again
	
@@EndProc:
    pop bx
	ret
endp  MakeMask


;proc to mask for Random Word
Proc MakeMaskWord    
    push dx
	
	mov si,1
    
@@again:
	shr dx,1
	cmp dx,0
	jz @@EndProc
	
	shl si,1 ; add 1 to si at right
	inc si
	
	jmp @@again
	
@@EndProc:
    pop dx
	ret
endp  MakeMaskWord

;BX Min
;DX Max
;AX Random
proc RandomByCsWord
    push es
	push si
	push di
 
	
	mov ax, 40h
	mov	es, ax
	
	sub dx,bx  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp dx,0
	jz @@ExitP
	
	push bx
	
	mov di, [word RndCurrentPos]
	call MakeMaskWord ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
	
@@RandLoop: ;  generate random number 
	mov bx, [es:06ch] ; read timer counter
	
	mov ax, [word cs:di] ; read one byte from memory (from semi random byte at cs)
	xor ax, bx ; xor memory and counter
	
	; Now inc di in order to get a different number next time
	inc di
	cmp di,(endgame - start - 1)
	jb @@Continue
	mov di, 0
@@Continue:
	mov [word RndCurrentPos], di
	
	and ax, si ; filter result between 0 and si (the nask)
	
	cmp ax,dx    ;do again if  above the delta
	ja @@RandLoop
	pop bx
	add ax,bx  ; add the lower limit to the rnd num
		 
@@ExitP:
	
	pop di
	pop si
	pop es
	ret
endp RandomByCsWord


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;														;
;														;
;						Bubbles							;
;														;
;														;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;A proc that puts a new Bubbles Line for first time only!
;this proc will only work on first draw!
;input - None
;output - A bubble line on the screen
proc SummonBubblesLine
	push cx
	push dx
	push ax
	push di
	push bx
	
	mov di,[MaxYForBubble]
	mov dx,6
	
    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,5
	mov cx,28
@@draw:
	call FilledCircle
		
  	
    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,5
	
	add dx,11
	loop @@draw
	
	add [MaxYForBubble],11
	mov di,[MaxYForBubble]
	
	
@@end:
	pop bx
	pop di
	pop ax
	pop dx
	pop cx
ret
endp SummonBubblesLine



;  proc to draw a circle
; 	  How to call : 
;     mov       dx,60              ;column of circle center 
;     mov       di,100              ;row of circle center  
;     mov       al,04              ;colour
;     mov       bx,50              ;radius
proc circleV1
					push cx
					push si
                    mov       bp,0                ;x coordinate
                    mov       si,bx               ;y coordinate
@@c00:                
					xchg      bp,si               ;swap x and y
					call      _2pixelsV1            ;2 pixels
					call      _2pixelsV1 
					
					xchg      bp,si               ;swap x and y
					call      _2pixelsV1            ;2 pixels
					call      _2pixelsV1 
					
					
					sub       bx,bp               ;d=d-x
                    inc       bp                  ;x+1
					sub       bx,bp               ;d=d-(2x+1)
					jg        @@c01                 ;>> no step for y
                    add       bx,si               ;d=d+y
                    dec       si                  ;y-1
					add       bx,si               ;d=d+(2y-1)
@@c01:
					cmp       si,bp               ;check x>y
                    jae       @@c00                 ;>> need more pixels
					
					pop si
					pop cx
                    ret
endp circleV1


proc _2pixelsV1	near
					neg       si
                    push      di
                    add       di,si
					
					mov   cx,di    ; next 5 lines mul by 320 and add column
					shl   di,6     
					shl   cx,8
					add   di,cx
					add   di,dx
					 			
					mov       [es:di+bp],al
 					sub       di,bp
                    mov       [es:di],al

 					pop       di
                    ret 
endp _2pixelsV1

;a proc that simply gets the same inputs as a draw ball and decreasing the radius of the ball and drawing it again which makes it look filled with white frame
;input -
;dx 			    ;column of circle center 
;di,100              ;row of circle center  
;al,04              ;colour
;bx,50              ;radius
;output - Filled circle like an oreo on the screen
proc FilledCircle	near	
		push bx
		push ax
		mov al,7d
		call circleV1
		pop ax
		pop bx
		dec bx
		cmp bx,0
@@drawcircle:
		push bx
		call circleV1
		pop bx
		dec bx
		cmp bx,0
		jne @@drawcircle
ret
endp FilledCircle


; a proc that simply gets the same inputs as a draw ball and decreasing the radius of the ball and drawing it again which makes it look filled
;input -
;dx 			    ;column of circle center 
;di,100              ;row of circle center  
;al,04              ;colour
;bx,50              ;radius
;output - Filled circle like an oreo on the screen
proc FilledCircleNo	near	
@@drawcircle:
		push bx
		call circleV1
		pop bx
		dec bx
		cmp bx,0
		jne @@drawcircle
ret
endp FilledCircleNo



proc Circle	near	
@@drawcircle:
		push bx
		call circleV1
		pop bx
		dec bx
		cmp bx,0
		jne @@drawcircle
ret
endp Circle


;simply calls SummonBubblesLine proc 8 times
;no input
;only output is the balls
proc BubblesFirstDraw
	push cx
	
	mov cx,6	;drawing 6 lines of sorted randomized bubbles
@@draw:
	call SummonBubblesLine

	loop @@draw
	
	pop cx
ret
endp BubblesFirstDraw

;Draws the end lines which is the line that if one of the balls reach the game ends
proc ShowEndLine near
	mov dx,155
	mov cx,0
	mov al,4
	mov si,320
	call DrawHorizontalLine
	
ret
endp ShowEndLine


;Proc that adds a line to the screen according to the current state of balls
;that means that if there is few balls below or above the usuall level of the balls the new appeard balls will be in the correct place
;input
;
;
proc AddLine
	push cx
	push dx
	push ax
	push di
	push bx
	
	mov ax,02h
	int 33h

	mov dx,6
;--------------------------------
;Check Y
	push dx
	push ax
	push cx
	mov cx,dx
	
@@startGetY:
	call getminy
	
	mov di,dx
	
	pop cx
	pop ax
	pop dx
;--------------------------------
;End check

	add di,6

	cmp di,155
	jb @@cont
	
	mov [ended],1
	
@@cont:
     mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,5
	mov cx,28
@@draw:
	call FilledCircle
@@cont2:
	add dx,10
     mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,5
	add dx,1

;--------------------------------
;Check Y
	push dx
	push ax
	push cx
	mov cx,dx
	
	
@@startGetY1:
	call GETMINY
	
	mov di,dx
	add di,6
	pop cx
	pop ax
	pop dx
;--------------------------------
;End check
	

@@loop:
	
	loop @@draw

	add [MaxYForBubble],10

	
@@end:
mov ax,01h
int 33h


pop	bx
pop	di
pop	ax
pop	dx
pop	cx

ret
endp AddLine



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;														;
;														;
;					Game Ended							;
;														;
;														;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;Game Ended Screen
proc ShowEndScreen
	mov dx,offset EndScreen
	call OpenShowBmp
	
	xor dx,dx
	mov  dl,18
	mov  dh,16
	mov ah,2h
	int 10h
	
	mov ax,[score]
	call ShowAxDecimal
ret
endp ShowEndScreen



;reseting all vars
;no input 
;no output
proc ResetMatch near
	mov [GotClick],0
	mov [MaxYForBubble],6
	mov [Xclick],160
	mov [Yclick],130
	mov [SquareSize],60
	mov [ended],0
ret
endp ResetMatch

;a proc that draws a Bubble on Mouse click place with Ball's color
;input: - mouse input in the proc it self
;output: a ball that appears on the screen on mouse clicked place
proc DrawOnMousePoint
	push si
	push ax
	push bx
	push cx
	push dx
	
	call _25MicroSecDelay
	
	mov ax,1
	int 33h

	call GETMOUSEINPUT
	
	shr cx,1

	xor dx,dx	;cleans the remaining

	mov ax,cx
	mov bx,11
	div bx
	sub cx,dx	;making sure the number is divisble by 10(the perimter)
	add cx,6

	xor dx,dx
	mov ax,cx
	mov bx,10
	div bx
	

	cmp dx,0
	jne @@startGetY1
	add cx,dx		;adds the reminder to make sure the number will be divided
	
	
@@startGetY1:
	call GetMinY
	cmp dx,148
	jb @@conti
	mov [ended],1
	
@@conti:
	add dx,6
	mov [BubCord],cx
	mov [BubCord + 2],dx

@@cont:
	
	
	mov bx,5
	mov di,dx
	mov dx,cx
	mov al,[Ball_Color]
	call FilledCircle	;draws Bubble in place
	
	mov ax,1
	int 33h	;Shows Curser
	
	
pop dx
pop cx
pop bx
pop ax
pop si

ret
endp DrawOnMousePoint

;just a proc to make code shorter and life easier no input
;and output - cx = x
;dx = y
proc GetMouseInput
	mov ax,1
	int 33h	;Show Mouse cursor
@@Press:
	mov ax,05h
	mov bx,0
	int 33h	 ;mouse input
	
	
	cmp bx,00h
	jna @@Press  ; mouse wasn't pressed
	and ax,0001h
	jz @@Press   ; left wasn't pressed

	mov ax,2h
	int 33h
ret
endp GetMouseInput



;gets to the min Y possible for a bubble to place
;input - cx = x
;output - dx = Y
proc GetMinY
	mov dx,150d
@@GetY1:
	dec dx
	mov ah,0Dh
	int 10H
	cmp al,0
	je @@GetY1
ret
endp GetMinY


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A proc that checks if the ball near current is in the same color		;
;*recursion*															;
;																		;
;using var: Ball_Color													;
;Getting BubCord pushed in																		;
;											;
;																		;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BubX equ [bp + 6] 
BubY equ [bp + 4]
proc CheckSameColor
	push bp
	mov bp,sp
	
	call _25MicroSecDelay
	
	cmp [First],1	;if first DO NOT DELETE because we cant know if he has ball near him with the same color
	je @@CheckNext

	mov cx,BubX		
	mov dx,BubY
	mov ah,0dh
	int 10h		;reading the Pixel to check bubble's color


	cmp al,[Ball_Color]
	jne @@exit		;if equal to balls color it will continue
	
	mov si,0		;si cleans, si will be 1 only when last ball popped
	mov ax,2
	int 33h
	
@@DeleteBall:
		call getmid	;getting to the middle of the bubble

		mov BubY,di	;putting on vars the middle of the bubble
		mov BubX,dx
@@cont:

		mov bx,5
		mov al,0
		push bp	;pushing bp because bp changes in the proc
		call FilledCircleNo
		pop bp
		add [Score],10	;adding to score beacuse a ball has been popped
		cmp si,1		;checking if it was last ball
		je @@exit
		mov si,1	;if not "assume" that this is the last ball

		jmp @@checknext

@@exit:		;exit is here beacuse of jump out relative error
	pop bp
	ret 4

@@CheckNext:
	mov [First],0

	mov di,BubY
	mov dx,BubX
	sub di,8	;the upper ball
	push dx
	push di
	call CheckSameColor

	
	mov di,BubY
	mov dx,BubX
	add di,8		;the ball down(it won't pop a lot but in case there's an kind of shelf of balls it will pop the ball down)
	push dx
	push di
	call CheckSameColor

	mov di,BubY
	mov dx,BubX
	sub dx,8		;the left ball
	push dx
	push di
	call CheckSameColor
	

	mov di,BubY
	mov dx,BubX
	add dx,8		;the right ball
	push dx
	push di
	call CheckSameColor


@@deletecurrent:
	cmp si,1	;now if si is on it means that the last bubble has been popped and more important that a bubble has been popped so the ball can be deleted now
	jne @@exit
	mov dx,[bubcord]
	mov di,[BUBCORD + 2]	;getting original cords of the ball
	sub [score],10
	jmp @@cont


endp CheckSameColor





;a proc that count the middle of the ball
;this proc is a help proc to the SameColorCheck proc and it is to save place in the code and organize it
;it works very similar to the GetYMin proc
;but with X also to get to the middle of the ball
;input: dx - ball y, cx - Ball x
;output: di - ball X, dx Ball y
proc GetMid

@@findmidY:
		dec dx
		mov ah,0dh
		int 10h	
		cmp al,7
		jne @@findmidY
		add dx,5
		
@@findmidX:
		dec cx
		mov ah,0dh
		int 10h	;readPixel
		cmp al,7
		jne @@findmidX
		add cx,5
@@findmidYA:
		dec dx
		mov ah,0dh
		int 10h	;readPixel
		cmp al,7
		jne @@findmidYA
		add dx,5

		mov di,dx
		mov dx,cx
ret
endp GetMid


endgame:
END start