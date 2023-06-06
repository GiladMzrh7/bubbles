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
IDEAL
MODEL small
 
 

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
	
	SquareSize dw 60
	GotClick db 0
	
	BmpLeft dw ?
	BmpTop dw ?
	BmpColSize dw ?
	BmpRowSize dw ?		;variables to open BMP
	
	Xclick dw 160
	Yclick dw 130	;variables for buttons
	Color db ?
	
	Xp dw ?
	Yp dw ?
	ErrorFile           db 0
		
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 300h dup (0)
	
	
CODESEG
 


 
start:
	mov ax, @data
	mov ds, ax
	
Animation:
	call ShowAllFrames
	cmp [GotClick],1
	je	exit
	jmp Animation
	
	
	
	
	
	
	
exit:
	
	mov ah,0
	int 16h
	cmp ah,28d
	je Start
	
	
	mov ax,2
	int 10h
	cmp ah,28d
	je Start
	
	mov ax, 4c00h
	int 21h
	

	
;==========================
;==========================
;===== Procedures  Area ===
;==========================
;==========================

proc OpenShowBmp near
	
	 
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
proc OpenBmpFile	near						 
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
 
 
 



proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile




; Read 54 bytes the Header
proc ReadBmpHeader	near					
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



proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
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
proc CopyBmpPalette		near					
										
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
proc DrawHorizontalLine	near
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
proc DrawVerticalLine	near
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
 proc  SetGraphic
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic
 
 


proc ShowBMP 
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


proc setAsyncMouse 
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
		 
		retf
ENDP MyMouseHandle 





;shows first 10 frames of Animation
;had to be seperated because of the amount of the bmp files
;and for check where is the error in the bmp
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
proc	_40Frames
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
	
	mov dx, offset Frame36
	call OpenShowBmp
	
	mov dx, offset Frame37
	call OpenShowBmp
	
	mov dx, offset Frame38
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame39
	call OpenShowBmp
	
	mov dx, offset Frame40
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _40Frames

proc _50Frames
	mov dx, offset Frame41
	call OpenShowBmp
	
	mov dx, offset Frame42
	call OpenShowBmp	
	
	mov dx, offset Frame43
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame44
	call OpenShowBmp
	
	mov dx, offset Frame45
	call OpenShowBmp
	
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
	
	mov dx, offset Frame52
	call OpenShowBmp	
	
	mov dx, offset Frame53
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame54
	call OpenShowBmp
	
	mov dx, offset Frame55
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame56
	call OpenShowBmp
	
	mov dx, offset Frame57
	call OpenShowBmp
	
	mov dx, offset Frame58
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame59
	call OpenShowBmp
	
	mov dx, offset Frame60
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _60Frames

proc _70Frames
	mov dx, offset Frame61
	call OpenShowBmp
	
	mov dx, offset Frame62
	call OpenShowBmp	
	
	mov dx, offset Frame63
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame64
	call OpenShowBmp
	
	mov dx, offset Frame65
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame66
	call OpenShowBmp
	
	mov dx, offset Frame67
	call OpenShowBmp
	
	mov dx, offset Frame68
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame69
	call OpenShowBmp
	
	mov dx, offset Frame70
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _70Frames

proc _80Frames
	mov dx, offset Frame71
	call OpenShowBmp
	
	mov dx, offset Frame72
	call OpenShowBmp	
	
	mov dx, offset Frame73
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame74
	call OpenShowBmp
	
	mov dx, offset Frame75
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame76
	call OpenShowBmp
	
	mov dx, offset Frame77
	call OpenShowBmp
	
	mov dx, offset Frame78
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame79
	call OpenShowBmp
	
	mov dx, offset Frame80
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _80Frames

proc _90Frames
	mov dx, offset Frame81
	call OpenShowBmp
	
	mov dx, offset Frame82
	call OpenShowBmp	
	
	mov dx, offset Frame83
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame84
	call OpenShowBmp
	
	mov dx, offset Frame85
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame86
	call OpenShowBmp
	
	mov dx, offset Frame87
	call OpenShowBmp
	
	mov dx, offset Frame88
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame89
	call OpenShowBmp
	
	mov dx, offset Frame90
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _90Frames


proc _100Frames
	mov dx, offset Frame91
	call OpenShowBmp
	
	mov dx, offset Frame92
	call OpenShowBmp	
	
	mov dx, offset Frame93
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame94
	call OpenShowBmp
	
	mov dx, offset Frame95
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame96
	call OpenShowBmp
	
	mov dx, offset Frame97
	call OpenShowBmp
	
	mov dx, offset Frame98
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame99
	call OpenShowBmp
	
	mov dx, offset Frame100
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _100Frames


proc _110Frames
	mov dx, offset Frame101
	call OpenShowBmp
	
	mov dx, offset Frame102
	call OpenShowBmp	
	
	mov dx, offset Frame103
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame104
	call OpenShowBmp
	
	mov dx, offset Frame105
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame106
	call OpenShowBmp
	
	mov dx, offset Frame107
	call OpenShowBmp
	
	mov dx, offset Frame108
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame109
	call OpenShowBmp
	
	mov dx, offset Frame110
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _110Frames

proc _120Frames
	mov dx, offset Frame111
	call OpenShowBmp
	
	mov dx, offset Frame112
	call OpenShowBmp	
	
	mov dx, offset Frame113
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame114
	call OpenShowBmp
	
	mov dx, offset Frame115
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame116
	call OpenShowBmp
	
	mov dx, offset Frame117
	call OpenShowBmp
	
	mov dx, offset Frame118
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame119
	call OpenShowBmp
	
	mov dx, offset Frame120
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _120Frames

proc _130Frames
	mov dx, offset Frame121
	call OpenShowBmp
	
	mov dx, offset Frame122
	call OpenShowBmp	
	
	mov dx, offset Frame123
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame124
	call OpenShowBmp
	
	mov dx, offset Frame125
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame126
	call OpenShowBmp
	
	mov dx, offset Frame127
	call OpenShowBmp
	
	mov dx, offset Frame128
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame129
	call OpenShowBmp
	
	mov dx, offset Frame130
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _130Frames

proc _140Frames
	mov dx, offset Frame131
	call OpenShowBmp
	
	mov dx, offset Frame132
	call OpenShowBmp	
	
	mov dx, offset Frame133
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame134
	call OpenShowBmp
	
	mov dx, offset Frame135
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame136
	call OpenShowBmp
	
	mov dx, offset Frame137
	call OpenShowBmp
	
	mov dx, offset Frame138
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame139
	call OpenShowBmp
	
	mov dx, offset Frame140
	call OpenShowBmp
	
	call CheckLeftClickPressed	
@@endproc:
	ret
endp _140Frames

proc _150Frames
	mov dx, offset Frame141
	call OpenShowBmp
	
	mov dx, offset Frame142
	call OpenShowBmp	
	
	mov dx, offset Frame143
	call OpenShowBmp	
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame144
	call OpenShowBmp
	
	mov dx, offset Frame145
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame146
	call OpenShowBmp
	
	mov dx, offset Frame147
	call OpenShowBmp
	
	mov dx, offset Frame148
	call OpenShowBmp
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	je	@@endproc
	
	mov dx, offset Frame149
	call OpenShowBmp
	
	mov dx, offset Frame150
	call OpenShowBmp
	
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
	
	call CheckLeftClickPressed
	cmp [GotClick],1
	jnz	@@endproc
	
	mov dx, offset Frame154
	call OpenShowBmp
	
	call CheckLeftClickPressed
@@endproc:
	ret
endp LastFrames
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
@@endproc:
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

proc ShowAllFrames
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
	
	jmp @@cont
	
@@endproc:
	pop dx
	ret
	
@@cont:
	call _80Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _90Frames
	cmp [GotClick],1
	je	@@endproc
	
	call _100Frames
	cmp [GotClick],1
	je	@@endproc
	
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
	
	call LastFrames
	cmp [GotClick],1
	je	@@endproc

	

endp ShowAllFrames

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

END start


