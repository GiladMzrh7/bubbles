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

    OneBmpLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer
   
    ScrLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer

	;BMP File data
	

	 IntStr db 7 dup (' '), "$"
	
	black db 'black.bmp',0
	
	cannon db 'Cannon.bmp',0
	EndScreen db 'GO1.bmp',0
	
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 400h dup (0)
	
	Frame_1d db 6 dup (?),0
	Frame_2d db 7 dup (?),0
	Frame_3d db 8 dup (?),0
	
	ErrorFile           db 0

	
		
	 Ball_Color db ?
	 Bubble_Color db ?

	 
	 CursorX dw ?	
	 CursorY dw ?	;Curser position
	 
	Color db ?
	Xclick dw 160
	Yclick dw 130	;variables for buttons
	
	Xp dw ?
	Yp dw ?
	
	SizedRow db	?
	
	SquareSize dw 60
	GotClick db 0
	
	BmpLeft dw ?
	BmpTop dw ?
	BmpColSize dw ?
	BmpRowSize dw ?		;variables to open BMP
	
	
	
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
	
	borderY db ?
	borderX db ?		;bool variables to check if the ball reached the border
	
	RndCurrentPos dw 0 ;Random Varaible

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

	
	BubCord dw 2 dup (?)
CODESEG
 
	
	
start:
	mov ax, @data
	mov ds, ax
	
	call SetGraphic
 
	call setAsyncMouse
	call ResetMatch
Animation:
	;call ShowFrames
	;cmp [GotClick],1
	;je	endAni
	;jmp Animation
	
	
endAni:
	mov ax,2h
	int 33h	
	mov ax,1
	int 33h
	
	call ClearScreen
	
	call ShowCannon
	
	
	call SetGraphic	;reset palette
	
	call ShowScoreText

	;call ShowEndLine
	
	call BubblesFirstDraw
	xor ax,ax	;counter for loops
Game:
	call putBall
	
	call DrawOnMousePoint
	
	cmp [MaxYForBubble],170
	jge GameEnded
	
	call CheckSameColor
	
	mov [Score],100
	
	call ShowScoreText
	
	cmp ax,4
	jne cont1
	
addl:
	call AddLine
	xor ax,ax
	
cont1:
	cmp [MaxYForBubble],170
	jge GameEnded
	
	inc ax
	jmp Game	;loops the game until end

GameEnded:
	mov ax,2
	int 33h
	call ShowEndScreen
exit:
	
	mov ah,0
	int 16h
	cmp ah,28d
	je Start
	
	
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



proc Show10Frames

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

;cont to show frames
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
		
	
	mov dx, offset Frame27
	call OpenShowBmp	
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame28
	call OpenShowBmp
	
		
	mov dx, offset Frame29
	call OpenShowBmp
		
	
	mov dx, offset Frame30
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
@@EndProc:
	ret
endp Show30Frames

;cont to show frames
proc LastNormalFrames
	mov dx, offset Frame31
	call OpenShowBmp
	
	mov dx, offset Frame32
	call OpenShowBmp	
	
	mov dx, offset Frame33
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame34
	call OpenShowBmp
	
	mov dx, offset Frame35
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
@@endproc:
	ret
endp LastNormalFrames

;reversing the Animation now to make it look better
proc ShowReverse30
	
	
	mov dx, offset Frame34
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame33
	call OpenShowBmp
		
	mov dx, offset Frame32
	call OpenShowBmp
	mov dx, offset Frame31
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame30
	call OpenShowBmp

	
	mov dx, offset Frame29
	call OpenShowBmp

	
	mov dx, offset Frame28
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame27
	call OpenShowBmp

	
	mov dx, offset Frame26
	call OpenShowBmp

	
	mov dx, offset Frame25
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame24
	call OpenShowBmp
		
	
	mov dx, offset Frame23
	call OpenShowBmp
		
	
	mov dx, offset Frame22
	call OpenShowBmp
		
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
@@EndProc:
	ret
endp ShowReverse30


;same
PROC ShowReverse20
	mov dx, offset Frame21
	call OpenShowBmp
	
	mov dx, offset Frame20
	call OpenShowBmp
	
	mov dx, offset Frame19
	call OpenShowBmp
			
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame18
	call OpenShowBmp
			
	
	mov dx, offset Frame17
	call OpenShowBmp

	
	mov dx, offset Frame16
	call OpenShowBmp
			
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame15
	call OpenShowBmp
			
	
	mov dx, offset Frame14
	call OpenShowBmp
			
	
	mov dx, offset Frame13
	call OpenShowBmp
			
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame12
	call OpenShowBmp
			
	
	mov dx, offset Frame11
	call OpenShowBmp
			
	
	mov dx, offset Frame10
	call OpenShowBmp
			
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
@@endproc:
	ret
endp ShowReverse20



;same
proc LastReverse
	mov dx, offset Frame9
	call OpenShowBmp
	mov dx, offset Frame8
	call OpenShowBmp
	mov dx, offset Frame7
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je @@EndProc
	
	mov dx, offset Frame6
	call OpenShowBmp

	mov dx, offset Frame5
	call OpenShowBmp
	
	mov dx, offset Frame4
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je @@EndProc
	
	mov dx, offset Frame3
	call OpenShowBmp
	mov dx, offset Frame2
	call OpenShowBmp
	mov dx, offset Frame1
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je @@EndProc
@@EndProc:
	ret
endp LastReverse

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
	call LastNormalFrames
	cmp [GotClick],1
	je	@@endproc
	call ShowReverse30
	cmp [GotClick],1
	je	@@endproc
	call ShowReverse20
	cmp [GotClick],1
	je	@@endproc
	call LastReverse
@@endproc:
	pop dx
	ret
endp ShowFrames





;draws the cannon on the screen
proc ShowCannon	near
	push dx
	call SetCannonDraw	;sets the pointer to the position of the cannon
	mov dx,offset cannon
	call OpenShowBmp
	pop dx
	call SetShowAllScreen	;restores the pointer to all screen
	ret
endp ShowCannon

proc SetShowAllScreen near
	mov [BmpLeft],0
	mov [BmpTop],0
	mov [BmpColSize], 320
	mov [BmpRowSize] ,200
ret
endp SetShowAllScreen





proc WaitTillGotClickOnSomePoint
	push si
	push ax
	push bx
	push cx
	push dx
	
	mov ax,1
	int 33h
	
	
ClickWaitWithDelay:
	mov cx,1000
ag:	
	loop ag
WaitTillPressOnPoint:

	mov ax,5h
	mov bx,0 ; quary the left b
	int 33h
	
	
	cmp bx,00h
	jna ClickWaitWithDelay  ; mouse wasn't pressed
	and ax,0001h
	jz ClickWaitWithDelay   ; left wasn't pressed

 	
	shr cx,1
	mov [CursorX],cx
	mov [CursorY],dx
	cmp cx,250
	ja ClickForExit
	mov si, cx 
	add si, [SquareSize]
	cmp si , [Xclick]
	jl WaitTillPressOnPoint
	mov si, cx 
	sub si, [SquareSize]
	cmp si , [Xclick]
	jg WaitTillPressOnPoint
	
	
	mov si, dx 
	add si, [SquareSize]
	cmp si , [Yclick]
	jl WaitTillPressOnPoint
	mov si, dx 
	sub si, [SquareSize]
	cmp si , [Yclick]
	jg WaitTillPressOnPoint
	mov [GotClick],1
	jmp @@EndProc
ClickForExit:	
	mov [GotClick],0
@@EndProc:
	mov ax,2
	int 33h
	
	pop dx
	pop cx
	pop bx
	pop ax
	pop si
	ret
endp WaitTillGotClickOnSomePoint



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
proc ShowScoreText near
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





;sets the cursor position to the cannon's place
proc SetCannonDraw near
	mov [BmpLeft],110
	mov [BmpTop],115
	mov [BmpColSize], 80
	mov [BmpRowSize] ,100
ret
endp SetCannonDraw




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




proc  MoveBallLeft
	call _25MicroSecDelay
	call putBall ; delete ball at curret locatein
	dec [XBall]	 ;decreasing to make it move left
	call putBall ; put it  at new location
	
	ret
endp MoveBallLeft

proc  MoveBallUp
	call _25MicroSecDelay
	call putBall ; delete ball at curret locatein
	dec [YBall]	 ;decreasing to move up
	call putBall ; put it  at new location
	
	ret
endp MoveBallUp

proc  MoveBallDown
	call _25MicroSecDelay
	call putBall ; delete ball at curret locatein
	inc [YBall]  ; increasing to move down
	call putBall ; put it  at new location
	
	ret
endp MoveBallDown

proc  MoveBallRight
	call _25MicroSecDelay
	call putBall ; delete ball at curret locatein
	inc [XBall]	 ; increasing to move right
	call putBall ; put it  at new location
	
	ret
endp MoveBallRight



;***************************************************
;*                                                 *
;*              NOT Finished                       *
;*                                                 *
;***************************************************
proc MoveBallToCursor
	push ax
	push bx
	push cx
	push dx
	push si

@@END:
	call putBall	
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
ret
endp MoveBallToCursor

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



;checks if Ball Reached Max of Y
;YBall - y
proc CheckBorderY

	cmp [YBall],0
	jne @@END
	mov [borderY],1
@@END:
	ret
endp CheckBorderY



;if sets to zero Ball moves to left, If Sets to one Ball moves to right
;XBall - X
proc CheckBorderX

	cmp [XBall],0
	jne @@CheckOther
	mov [borderX],1
@@CheckOther:
	cmp [XBall],320
	jne @@END
	mov [borderX],0
@@END:
	ret
endp CheckBorderX











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




;Drawing 2 lines where they are sorted unsyncly
;where the second row fills the remaingin holes in the first row to make it look better
proc SummonBubbles2Lines
	push cx
	push dx
	push ax
	push di
	push bx
	
;same as drawing one line	
	
	mov di,[MaxYForBubble]
	mov dx,6
	
    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	mov cx,23
@@draw:
	call FilledCircle
		
  	
    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	
	add dx,14
	loop @@draw
	
	
	
	mov [SizedRow],1
	
	add [MaxYForBubble],14
	mov di,[MaxYForBubble]
	mov dx,16
	
   	
    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	mov cx,22
@@draw1:
	call FilledCircle
		
   mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	
	add dx,14
	loop @@draw1
	
	add [MaxYForBubble],14
	mov [SizedRow],0
@@end:
	pop bx
	pop di
	pop ax
	pop dx
	pop cx
ret
endp SummonBubbles2Lines



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

; a proc that simply gets the same inputs as a draw ball and decreasing the radius of the ball and drawing it again which makes it look filled
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


proc BubblesFirstDraw
	push cx
	
	mov cx,3	;drawing 6 lines of sorted randomized bubbles
@@draw:
	call SummonBubbles2Lines
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



proc AddLine
	push cx
	push dx
	push ax
	push di
	push bx
	
	mov ax,02h
	int 33h
	
	
	cmp [SizedRow],0
	jne @@Sized
	
	

	mov dx,6
	
	
;--------------------------------
;Check Y
	push dx
	push ax
	push cx
	mov cx,dx
	
@@startGetY11:
	mov dx,164d
@@GetY11:
	dec dx
	mov ah,0Dh
	int 10H
	cmp al,0
	je @@GetY11
	
	mov di,dx
	
	pop cx
	pop ax
	pop dx
;--------------------------------
;End check

add di,8
	
@@cont:
     mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	mov cx,23
@@draw:
	call FilledCircle
	
	
	cmp al,0
	jne @@cont1
@@cont2:
     mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	add dx,14
	
	

;--------------------------------
;Check Y
	push dx
	push ax
	push cx
	mov cx,dx
	
	
@@startGetY1:
	mov dx,164d
@@GetY1:
	dec dx
	mov ah,0Dh
	int 10H
	cmp al,0
	je @@GetY1
	
	mov di,dx
	
	pop cx
	pop ax
	pop dx
;--------------------------------
;End check

add di,8
	
@@loop:
	
	loop @@draw
	mov [SizedRow],1
	
	add [MaxYForBubble],14
	
	mov [SizedRow],1
	jmp @@end
	
@@cont1:
	add di,16
	jmp @@cont2
	
	
	
	
	
;----------------------------------------------------------
;----------------------------------------------------------	
	
@@Sized:

	mov dx,9
	
	push dx
	push ax
	push cx
	mov cx,dx
@@startGetY22:
	mov dx,164d
@@GetY22:
	dec dx
	mov ah,0Dh
	int 10H
	cmp al,0
	je @@GetY22
	
	mov di,dx
	
	pop cx
	pop ax
	pop dx
	
	
    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	mov cx,22
@@draw1:
	call FilledCircle
	
	

	
	push dx
	push ax
	push cx
	mov cx,dx
@@startGetY2:
	mov dx,164d
@@GetY2:
	dec dx
	mov ah,0Dh
	int 10H
	cmp al,0
	je @@GetY2
	
	mov di,dx
	
	pop cx
	pop ax
	pop dx

    mov bl,9
    mov bh,0fh
	call RandomByCs
	
	mov bx,6
	
	add dx,14
	loop @@draw1
	
	add [MaxYForBubble],12
	mov [SizedRow],0
	
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
	call SetShowAllScreen
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




proc ResetMatch near
	mov [GotClick],0
	mov [MaxYForBubble],6
	mov [Xclick],160
	mov [Yclick],130
	mov [SquareSize],60
ret
endp ResetMatch


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;													;
;													;
;													;
;					Shooting						;
;													;
;													;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;a proc that draws a Bubble on Mouse click place with Ball's color
proc DrawOnMousePoint
	push si
	push ax
	push bx
	push cx
	push dx
	
	mov ax,1
	int 33h	;Show Mouse cursor
	
	
@@Press:

	mov ax,5h
	mov bx,0
	int 33h	 ;mouse input
	
	
	cmp bx,00h
	jna @@Press  ; mouse wasn't pressed
	and ax,0001h
	jz @@Press   ; left wasn't pressed

	mov ax,2h
	int 33h
	
	shr cx,5	;make the number divisble with 16 so we shift right 5 times(4 times to 16 plus 1 to fit to 320)
	shl cx,4	;get the number back after rounded to place in the screen
	
	cmp cx,0
	jne @@startGetY
	
@@startGetY:
	mov dx,164d
@@GetY:
	dec dx
	mov ah,0Dh
	int 10H
	cmp al,0
	je @@GetY

@@conti:
	add dx,8
	mov [BubCord],cx
	cmp [SizedRow],0	;checks if this row is the sized changed one or normal
	je @@cont
	add cx,4			;adds 8 to fit to sized row
	cmp cx,313
	jl @@cont1
@@SubToFit:
	sub cx,16	;in case the row place is 313 or more so there won't be ball cuts
	
	
@@cont1:
		cmp cx,7
		jg @@cont
		add cx,14	;in case the row is 7 or less so make sure no cuts
@@cont:
	
	
	mov bx,6
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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;											;
;											;
;											;
;				Animation					;
;											;
;											;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;








;================================================
; Description - Write to IntStr the num inside ax and put 13 10 after 
;			 
; INPUT: AX
; OUTPUT: IntStr 
; Register Usage: AX  
;================================================
proc int_to_str near
	   push ax
	   push bx
	   push cx
	   push dx
	   push si
	   
	   mov cx,0   ; will count how many time we did push 
	   mov bx,10  ; the divider
		xor si,si
	
@@put_mode_to_stack:
	   xor dx,dx
	   div bx
	   add dl,30h
	   ; dl is the current LSB digit 
	   ; we cant push only dl so we push all dx
	   push dx    
	   inc cx
	   cmp ax,9   ; check if it is the last time to div
	   jg @@put_mode_to_stack

	   cmp ax,0
	   jz @@pop_next  ; jump if ax was totally 0
	   add al,30h  
	   xor si, si
	   mov [IntStr], al
	   inc si
	   
		   
@@pop_next: 
	   pop ax    ; remove all rest LIFO (reverse) (MSB to LSB)
	   
	   mov [IntStr + si], al
	   inc si
	   loop @@pop_next
		
		pop si
	   pop dx
	   pop cx
	   pop bx
	   pop ax
	   
	   ret
endp int_to_str




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;A proc that checks if the ball near current is in the same color		;
;*recursion*															;
;																		;
;using var: Ball_Color													;
;																		;
;using registers:ax,bx													;
;																		;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


proc CheckSameColor
	push bp
	mov bp,sp
	sub sp,4
	
	push ax
	push bx
	push cx
	push dx
	
	
	
	mov bx,[BubCord]
	mov [bp-2],bx
	
	mov bx,[BubCord +2]
	dec bx
	mov [bp -4],bx
	

	mov cx,[bp-2]
	mov dx,[bp -4]
	mov ah,0dh
	int 10h	;readPixel
	
	cmp al,[Ball_Color]
	jne @@exit
	
	mov bx,[bp -4]
	inc bx
	mov [bp -4],bx
@@DeleteBall:

	mov di,[bp-2]
	mov dx,[bp -4]
	mov bx,6
	mov al,0
	call FilledCircle
	jmp @@exit
	
	
	Add [score],15
	
	add [BubCord],16
	call CheckSameColor
	
	sub [BubCord],32
	call CheckSameColor

	add [BubCord],16

	add [BubCord + 2],16
	call CheckSameColor
	
	sub [BubCord + 2],32
	call CheckSameColor
	
	add [BubCord + 2],16
	
@@exit:	
	pop dx
	pop cx
	pop bx
	pop ax
	
	add sp,4
	pop bp


ret
endp CheckSameColor




endgame:
END start


