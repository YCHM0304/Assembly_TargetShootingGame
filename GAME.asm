SetMode macro mode
    mov     ah,00h
    mov     al,mode
    int     10h
    endm
SetColor macro color
    mov     ah,0Bh
    mov     bh,00h
    mov     bl,color
    int     10h
    endm
WrPixel macro row,col,color
    pusha
    mov     ah,0Ch
    mov     bh,00h
    mov     al,color
    mov     cx,col
    mov     dx,row
    int     10h
    popa
    endm
GetChar macro char
    mov     ah,07h
    int     21h
    mov     char,al
    endm
PrintStr macro string
    mov    ah,09h
    lea    dx,string
    int    21h
    endm
SET_cur macro row,col
    mov    dh,row
    mov    dl,col
    mov    bx,0000h
    mov    ah,02h
    int    10h
    endm
MUS_get03 macro
    mov    ax,0003h
    int    33h
    endm
MUS_show macro
    mov    ax,0001h
    int    33h
    endm
MUS_hide macro
    mov     ax,0002h
    int     33h
    endm
setcur	macro row,col
	mov	dh,row
	mov	dl,col
	mov	bx,0000h
	mov	ah,02h
	int	10h
	endm
draw_arrow macro new_arrows_x,new_arrows_y,old_arrows_x,old_arrows_y
 local arrow,arrow2,arrow3,arrow4,Narrow,Narrow2,Narrow3,Narrow4
 mov cx,old_arrows_x
 mov dx,old_arrows_y
 mov bx,cx
 arrow:
  WrPixel dx,cx,0000b
  add cx,1
  cmp cx,bx
  jbe arrow
 arrow2:
  add dx,1
  add bx,1
  mov cx,old_arrows_x
  mov ax,bx
  sub ax,cx
  sub cx,ax
  mov ax,old_arrows_y
  add ax,8
  cmp dx,ax
  jbe arrow
  mov cx,old_arrows_x
  sub cx,4
  mov dx,old_arrows_y
  add dx,8
  mov ax,cx
  add ax,6
 arrow3:
  WrPixel dx,cx,0000b 
  add cx,1
  cmp cx,ax
  jbe arrow3
 arrow4:
  mov cx,old_arrows_x
  sub cx,3
  add dx,1
  mov bx,old_arrows_y
  add bx,21
  cmp dx,bx
  jbe arrow3
  mov cx,new_arrows_x
  mov dx,new_arrows_y
  mov bx,cx
 Narrow:
  WrPixel dx,cx,1110b
  add cx,1
  cmp cx,bx
  jbe Narrow
 Narrow2:
  add dx,1
  add bx,1
  mov ax,bx
  mov cx,new_arrows_x
  sub ax,cx
  sub cx,ax
  mov ax,new_arrows_y
  add ax,8
  cmp dx,ax
  jbe Narrow
  mov cx,new_arrows_x
  sub cx,4
  mov dx,new_arrows_y
  add dx,8
  mov ax,cx
  add ax,6
 Narrow3:
  WrPixel dx,cx,1110b
  add cx,1
  cmp cx,ax
  jbe Narrow3
 Narrow4:
  mov cx,new_arrows_x
  sub cx,3
  add dx,1
  mov bx,new_arrows_y
  add bx,21
  cmp dx,bx
  jbe Narrow3
 endm
draw_gun macro new_guns_x,old_guns_x
 local cg1,cg2,pg1,pg2,grip1,trigger1,grip2,trigger2
 mov dx,410
 mov cx,old_guns_x
 mov bx,cx
 add bx,19
 cg1:
  WrPixel dx,cx,0000b
  add cx,1
  cmp cx,bx
  jbe cg1
 cg2:
  mov cx,old_guns_x
  add dx,1
  cmp dx,458
  jz trigger1
  cmp dx,465
  jae grip1
  jmp cg1
 trigger1:
  mov bx,cx
  add bx,28
  jmp cg1
 grip1:
  mov bx,cx
  add bx,40
  cmp dx,475
  jbe cg1
  mov dx,410
  mov cx,new_guns_x
  mov bx,cx
  add bx,19
 pg1:
  WrPixel dx,cx,0111b
  add cx,1
  cmp cx,bx
  jbe pg1
 pg2:
  mov cx,new_guns_x
  add dx,1
  cmp dx,458
  jz trigger2
  cmp dx,465
  jae grip2
  jmp pg1
 trigger2:
  mov bx,cx
  add bx,28
  jmp pg1
 grip2:
  mov bx,cx
  add bx,40
  cmp dx,475
  jbe pg1
  endm
movetarget macro trax,tray
    pusha
  ;clearedge
    mov cx,trax
    sub cx,5
    mov target_x2,cx
    mov dx,tray
    add dx,3
    mov target_y2,dx
    printxy target_x2,target_y2,10,53,0000b
    ;clear sec edge
    mov cx,trax
    add cx,5
    mov target_x2,cx
    mov dx,tray
    sub dx,5
    mov target_y2,dx
    printxy target_x2,target_y2,5,35,1111b
  ;clear red mid
    mov cx,trax
    add cx,10
    mov target_x2,cx
    mov dx,tray
    sub dx,10
    mov target_y2,dx
    printxy target_x2,target_y2,5,25,1000b
  ;print edge
    mov cx,trax
    add cx,35
    mov target_x2,cx
    mov dx,tray
    add dx,0
    mov target_y2,dx
    printxy target_x2,target_y2,10,45,1111b
  ;print sec edge
    mov cx,trax
    add cx,30
    mov target_x2,cx
    mov dx,tray
    sub dx,5
    mov target_y2,dx
    printxy target_x2,target_y2,10,35,1000b
  ;print red mid
    mov cx,trax
    add cx,25
    mov target_x2,cx 
    mov dx,tray
    sub dx,10
    mov target_y2,dx
    printxy target_x2,target_y2,10,25,1100b
  ;exit
    popa
    endm
movetarget2 macro trax,tray
    pusha
  ;print edge
    mov cx,trax
    sub cx,0
    mov target2_x2,cx
    mov dx,120
    add dx,0
    mov target2_y2,dx
    printxy target2_x2,target2_y2,5,50,1111b
  ;print sec edge
    mov cx,trax
    add cx,5
    mov target2_x2,cx
    mov dx,tray
    sub dx,5
    mov target2_y2,dx
    printxy target2_x2,target2_y2,5,40,1000b
  ;print red mid
    mov cx,trax
    add cx,10
    mov target2_x2,cx
    mov dx,tray
    sub dx,10
    mov target2_y2,dx
    printxy target2_x2,target2_y2,5,30,1100b
  ;clear red mid
    mov cx,trax
    add cx,35
    mov target2_x2,cx 
    mov dx,tray
    sub dx,10
    mov target2_y2,dx
    printxy target2_x2,target2_y2,5,30,1000b
  ;clear sec edge
    mov cx,trax
    add cx,40
    mov target2_x2,cx
    mov dx,tray
    sub dx,5
    mov target2_y2,dx
    printxy target2_x2,target2_y2,5,40,1111b
  ;clear edge
    mov cx,trax
    add cx,45
    mov target2_x2,cx
    mov dx,tray
    add dx,0
    mov target2_y2,dx
    printxy target2_x2,target2_y2,5,50,0000b
  ;exit
    popa
    endm
movetarget3 macro trax,tray
    pusha
  ;clearedge
    mov cx,trax
    sub cx,5
    mov target3_x2,cx
    mov dx,tray
    add dx,3
    mov target3_y2,dx
    printxy target3_x2,target3_y2,10,65,0000b
    ;clear sec edge
    mov cx,trax
    add cx,5
    mov target3_x2,cx
    mov dx,tray
    sub dx,5
    mov target3_y2,dx
    printxy target3_x2,target3_y2,5,50,1111b
  ;clear red mid
    mov cx,trax
    add cx,10
    mov target3_x2,cx
    mov dx,tray
    sub dx,10
    mov target3_y2,dx
    printxy target3_x2,target3_y2,5,40,1000b
  ;print red mid
    mov cx,trax
    add cx,45
    mov target3_x2,cx 
    mov dx,tray
    sub dx,10
    mov target3_y2,dx
    printxy target3_x2,target3_y2,5,40,1100b
  ;print sec edge
    mov cx,trax
    add cx,50
    mov target3_x2,cx
    mov dx,tray
    sub dx,5
    mov target3_y2,dx
    printxy target3_x2,target3_y2,5,50,1000b
  ;print edge
    mov cx,trax
    add cx,55
    mov target3_x2,cx
    mov dx,tray
    add dx,0
    mov target3_y2,dx
    printxy target3_x2,target3_y2,5,60,1111b
  ;exit
    popa
    endm
draw_menu macro
 local background,bg2,startbutton,sb2,endbutton,eb2
 mov dx,120
 mov cx,0
 background: 
  WrPixel dx,cx,1011b
  add cx,1
  cmp cx,640
  ja bg2
  jmp background
 bg2:
  xor cx,cx
  add dx,1
  cmp dx,360
  jbe background
  mov dx,150
  mov cx,230
 startbutton:
  WrPixel dx,cx,1110b
  add cx,1
  cmp cx,410
  ja sb2
  jmp startbutton
 sb2:
  mov cx,230
  add dx,1
  cmp dx,225
  jbe startbutton
  SET_cur 114,150
  printstr str_start
  mov dx,255
  mov cx,230
 endbutton:
  WrPixel dx,cx,1110b
  add cx,1
  cmp cx,410
  ja eb2
  jmp endbutton
 eb2:
  mov cx,230
  add dx,1
  cmp dx,330
  jbe endbutton
  SET_cur 120,151
  printstr str_end
  SET_cur 230,199
  printstr str_A
  SET_cur 231,199
  printstr str_D
  SET_cur 232,199
  printstr str_Sp
  SET_cur 233,199
  printstr str_ESC
  SET_cur 0,102
 printstr str_TITLE1
 SET_cur 1,102
 printstr str_TITLE2
 SET_cur 2,102
 printstr str_TITLE3
 SET_cur 3,102
 printstr str_TITLE4
 SET_cur 4,102
 printstr str_TITLE5
 SET_cur 5,102
 printstr str_TITLE6
  MUS_show
 endm
draw_pause macro
 local pbackground,pbg2,pstartbutton,psb2,pendbutton,peb2
 mov dx,120
 mov cx,0
 pbackground: 
  WrPixel dx,cx,1011b
  add cx,1
  cmp cx,640
  ja pbg2
  jmp pbackground
 pbg2:
  xor cx,cx
  add dx,1
  cmp dx,360
  jbe pbackground
  mov dx,150
  mov cx,230
 pstartbutton:
  WrPixel dx,cx,1110b
  add cx,1
  cmp cx,410
  ja psb2
  jmp pstartbutton
 psb2:
  mov cx,230
  add dx,1
  cmp dx,225
  jbe pstartbutton
  SET_cur 114,150
  printstr str_resume
  mov dx,255
  mov cx,230
 pendbutton:
  WrPixel dx,cx,1110b
  add cx,1
  cmp cx,410
  ja peb2
  jmp pendbutton
 peb2:
  mov cx,230
  add dx,1
  cmp dx,330
  jbe pendbutton
  SET_cur 120,151
  printstr str_end
  MUS_show
 endm
printxy macro x,y,xlong,ylong,color
    local xy1,xy2
    pusha		;focus on left down
    mov dx,y
    mov cx,ylong
 xy1:
    push cx
    mov cx,xlong
    xy2:
        add cx,x
        WrPixel dx,cx,color
        sub cx,x
        loop xy2
    dec dx
    pop cx
    loop xy1
    popa
    endm
.8086
.model small
.stack 1024
.data
    color db 0100b
    musx dw ?
    musy dw ?
    score dw 0
    time db ?,?,?,?
    arrow_x dw 270
    arrow_y dw 395
    old_arrow_x dw 0
    old_arrow_y dw 400
    gun_x dw 260
    gun_y dw 400
    target_x dw 0
    target_x2 dw 0
    target_y2 dw 65
    oldtarget_x dw  200
    target2_x dw 590
    target2_x2 dw 590
    target2_y2 dw 120
    oldtarget2_x dw 639
    target3_x dw 260
    target3_x2 dw 260
    target3_y2 dw 190
    oldtarget3_x dw  200
    ammo dw 10
    str_start db "START",'$'
    str_end db "END",'$'
    str_resume db "RESUME",'$'
    str_score db "SCORE=",3 dup(' '),'$'
    str_A db "Press A to move gun left",'$'
    str_D db "Press D to move gun right",'$'
    str_Sp db "Press Space to shoot",'$'
    str_ESC db "Press ESC back to menu",'$'
    str_WIN db "CONGRATUATIONS",'$'
    str_TITLE1 db "   _____ _______   _______ _____",'$'
    str_TITLE2 db "  / ____|__   __|_|__   __/ ____|",'$'
    str_TITLE3 db " | (___    | | ( _ ) | | | (___",'$'
    str_TITLE4 db "  \___ \   | | / _ \/\ |  \___ \",'$'
    str_TITLE5 db "  ____) |  | || (_>  < |  ____) |",'$'
    str_TITLE6 db " |_____/   |_| \___/\/_| |_____/",'$'
    str_GUN1 db "   (                                 _",'$'
    str_GUN2 db "      )                               /=>",'$'
    str_GUN3 db "  (  +_______________________/\/\___ / /|",'$'
    str_GUN4 db "   .''.________________'._____      / /|/\",'$'
    str_GUN5 db "  : () :                 :\ ----\|    \ )",'$'
    str_GUN6 db "   '..'_________________.'0|----|      \",'$'
    str_GUN7 db "                       0_0/____/        \",'$'
    str_GUN8 db "                           |----    /----\",'$'
    str_GUN9 db "                          || -\\ --|      \",'$'
    str_GUN10 db "                          ||   || ||\      \",'$'
    str_GUN11 db "                           \\____// '|      \",'$'
    str_GUN12 db "                                   .'/       |",'$'
    str_GUN13 db "                                  .:/        |",'$'
    str_GUN14 db "                                  :/_________|",'$'
    str_FW1 db "                                  .''.",'$'
    str_FW2 db "       .''.      .        *''*    :_\/_:     .",'$'
    str_FW3 db "      :_\/_:   _\(/_  .:.*_\/_*   : /\ :  .'.:.'.",'$'
    str_FW4 db "  .''.: /\ :   ./)\   ':'* /\ * :  '..'.  -=:o:=-",'$'
    str_FW5 db " :_\/_:'.:::.    ' *''*    * '.\'/.' _\(/_'.':'.'",'$'
    str_FW6 db " : /\ : :::::     *_\/_*     -= o =-  /)\    '  *",'$'
    str_FW7 db "  '..'  ':::'     * /\ *     .'/.\'.   '",'$'
    str_FW8 db "      *            *..*         :",'$'
    str_FW9 db "        *",'$'
    str_FW10 db "        *",'$'
    str_SC1 db "  _____________  ___  ____",'$'
    str_SC2 db "  / __/ ___/ __ \/ _ \/ __/",'$'
    str_SC3 db " _\ \/ /__/ /_/ / , _/ _/ ",'$'
    str_SC4 db "/___/\___/\____/_/|_/___/",'$'
    str_GO1 db " ________   __  ___________ _   _________",'$'
    str_GO2 db " / ___/ _ | /  |/  / __/ __ \ | / / __/ _ \",'$'
    str_GO3 db "/ (_ / __ |/ /|_/ / _// /_/ / |/ / _// , _/",'$'
    str_GO4 db "\___/_/ |_/_/  /_/___/\____/|___/___/_/|_|",'$'
    str_ONE1 db " ___",'$'
    str_ONE2 db " <  /",'$'
    str_ONE3 db " / /",'$'
    str_ONE4 db "/_/",'$'
    str_TWO1 db "  ___",'$'
    str_TWO2 db "  |_  |",'$'
    str_TWO3 db " / __/",'$'
    str_TWO4 db "/____/",'$'
    str_THREE1 db "   ____",'$'
    str_THREE2 db "  |_  /",'$'
    str_THREE3 db " _/_ <",'$'
    str_THREE4 db "/____/",'$'
    str_FOUR1 db "  ____",'$'
    str_FOUR2 db " / / /",'$'
    str_FOUR3 db "/_  _/",'$'
    str_FOUR4 db " /_/",'$'
    str_FIVE1 db "   ____",'$'
    str_FIVE2 db "  / __/",'$'
    str_FIVE3 db " /__ \",'$'
    str_FIVE4 db "/____/",'$'
    str_SIX1 db "  ____",'$'
    str_SIX2 db " / __/",'$'
    str_SIX3 db "/ _ \",'$'
    str_SIX4 db "\___/",'$'
    str_SEVEN1 db " ____",'$'
    str_SEVEN2 db "/_  /",'$'
    str_SEVEN3 db " / /",'$'
    str_SEVEN4 db "/_/",'$'
    str_EIGHT1 db "  ___",'$'
    str_EIGHT2 db " ( _ )",'$'
    str_EIGHT3 db "/ _  |",'$'
    str_EIGHT4 db "\___/",'$'
    str_NINE1 db "  ___",'$'
    str_NINE2 db " / _ \",'$'
    str_NINE3 db " \_, /",'$'
    str_NINE4 db "/___/",'$'
    str_ZERO1 db "  ___",'$'
    str_ZERO2 db " / _ \",'$'
    str_ZERO3 db "/ // /",'$'
    str_ZERO4 db "\___/",'$'
    str_restart db "press [R] to restart the game.",'$'
    str_enterend db "press enter to end the game.",'$'
    str_ammo db "left ",3 dup(' ')," bullets",'$'
.code
.startup
 ;start
 SetMode 12H
 SetColor 0001b
jmp begin
pau:
draw_pause
jmp menu
begin:
 draw_menu
 menu:
 MUS_get03
 cmp cx,230
 jb menu
 cmp cx,410
 ja menu
 cmp dx,150
 jb menu
 cmp dx,225
 jb chk_start
 cmp dx,255
 jb menu
 cmp dx,330
 jb chk_quit
 jmp menu
 chk_start:
 cmp bx,1
 jz chkrel_start
 jmp menu
 chkrel_start:
 MUS_get03
 cmp bx,1
 jz chkrel_start
 jmp start
 chk_quit:
 cmp bx,1
 jz chkrel_quit
 jmp menu
 chkrel_quit:
 MUS_get03
 cmp bx,1
 jz chkrel_quit
 jmp quit
 start:
 MUS_hide
 clearmenu:
  SetMode 12H
  SetColor 0001b
  jmp cm2
 restart:
	mov arrow_x,270
	mov arrow_y,395
	mov old_arrow_x,0
	mov old_arrow_y,400
	mov gun_x,260
	mov gun_y,400
	mov target_x,0
	mov target_x2,0
	mov target_y2,65
	mov oldtarget_x,200
	mov target2_x,590
	mov target2_x2,590
	mov target2_y2,120
	mov oldtarget2_x,639
	mov target3_x,260
	mov target3_x2,260
	mov target3_y2,190
	mov oldtarget3_x,200
	mov ammo,10
	mov score,0
	printxy 0,480,640,480,0000b
 cm2:
 ;gameprogame
det:
        draw_arrow arrow_x,arrow_y,old_arrow_x,old_arrow_y
        mov ax,arrow_x      ;remeber x,y
        mov old_arrow_x,ax
        mov ax,arrow_y
        mov old_arrow_y,ax
        draw_gun gun_x,gun_y
        mov ax,gun_x
        mov gun_y,ax

det1:
	lea	di,str_ammo
	call	clear
	mov	ax,ammo
	mov	di,offset str_ammo
	call tran
	setcur	0,1
	printstr	str_ammo

	lea	di,str_score
	call	clear
	mov	ax,score
	mov	di,offset str_score
	call tran
	setcur	0,231
	printstr	str_score
 ;lag
    mov cx,00090h
 lag1:
    push cx
    mov cx,0ffffh
    lag2:
        loop lag2
    pop cx
    loop lag1

        cmp target_x,635	;target reach end
        jae  retarget
        mov ax,target_x     ;mov target
        add ax,8
        mov target_x,ax
        movetarget target_x,65
        mov ax,target_x
        mov oldtarget_x,ax

        cmp target2_x,5
        jbe  retarget2
        mov ax,target2_x     ;mov target2
        sub ax,5
        mov target2_x,ax
        movetarget2 target2_x,120
        mov ax,target2_x
        mov oldtarget2_x,ax
        
        cmp target3_x,635	;target3 reach end
        jae  retarget3
        mov ax,target3_x     ;mov target3
        add ax,3
        mov target3_x,ax
        movetarget3 target3_x,190
        mov ax,target3_x
        mov oldtarget3_x,ax
;here add target

        mov ah,0Bh		;if keyboard in
        int 21h
        cmp al,0ffh
        je getchr
        cmp arrow_y,395 	;keep shooting
        jb shoot1
        jmp det1         ;looping
retarget:
        mov ax,0
        mov target_x,ax
        jmp det
retarget2:
	printxy 0,71,50,1,0b
	printxy 45,120,5,50,0b
        mov ax,640
        mov target2_x,ax
        jmp det
retarget3:
        mov ax,0
        mov target3_x,ax
        jmp det
;here add retarget
shoot1:
        cmp arrow_y,10  ;is it at top
        jle  shoot2
        mov ax,arrow_y
        sub ax,15
        mov arrow_y,ax
        		;detect hit
 totar3:
        mov ax,target3_x
        cmp arrow_x,ax
        ja  target3hit
 totar2:
        mov ax,target2_x
        cmp arrow_x,ax
        ja  target2hit
 totar:
        mov ax,target_x
        cmp arrow_x,ax
        ja  targethit

 ;here add tardet hit
        jmp det
 shoot2:			;reset arrow
	mov ax,ammo
	dec ax
	cmp ax,0			;out of ammo
	je outammo
	mov ammo,ax
        mov ax,395      ;move back
        mov arrow_y,ax
        mov ax,gun_x
        add ax,10
        mov arrow_x,ax
        jmp det
 targethit:
        add ax,45
        cmp arrow_x,ax
        jbe  targethit2
        jmp det
 targethit2:
	cmp arrow_y,10
        jl det
        cmp arrow_y,55
        jle targethit3
        jmp det
 targethit3:
	printxy target_x,65,45,45,0000b
        mov target_x,0
        mov ax,score            ;score+10
        add ax,5
        mov score,ax
	add ammo,2
        jmp shoot2
 ;target2
 target2hit:
        add ax,50
        cmp arrow_x,ax
        jb  target2hit2
	jmp totar
 target2hit2:
	cmp arrow_y,65
        jl totar
        cmp arrow_y,120
        jle target2hit3
        jmp totar
 target2hit3:
	printxy target2_x,120,50,50,0000b
        mov target2_x,589
        mov ax,score          ;score+2
        add ax,2
        mov score,ax
	add ammo,1
        jmp shoot2
 target3hit:
        add ax,60
        cmp arrow_x,ax
        jb  target3hit2
	jmp totar2
 target3hit2:
	cmp arrow_y,120
        jbe totar2
	cmp arrow_y,190
        jbe target3hit3
        jmp totar2
 target3hit3:
        printxy target3_x,190,60,60,0000b
        mov target3_x,0
        mov ax,score          ;score++
        inc ax
        mov score,ax
	add ammo,0
        jmp shoot2
 ;here add targethit

getchr:            	;get char
        getchar	al			;detect what cin and jmp
        cmp al,41h
        je  moveleft
        cmp al,61h
        je  moveleft
        cmp al,44h
        je  moveright
        cmp al,64h
        je  moveright
        cmp al,1Bh
        je pau
        cmp al,20h
        je  shoot1
        jmp det
moveleft:
        cmp gun_x,0     ;is it left end
        je  det1
        mov ax,gun_x
        sub ax,5
        mov gun_x,ax
        cmp arrow_y,395
        jl det
        mov ax,arrow_x
        sub ax,5
        mov arrow_x,ax
        jmp det
moveright:
        cmp gun_x,595   ;right end
        je  det1
        mov ax,gun_x
        add ax,5
        mov gun_x,ax
        cmp arrow_y,395
        jl det
        mov ax,arrow_x
        add ax,5
        mov arrow_x,ax
        jmp det
outammo:
	printxy 0,480,640,480,0000b
	SET_cur 15,82
	printstr str_SC1
	SET_cur 16,82
	printstr str_SC2
	SET_cur 17,82
	printstr str_SC3
	SET_cur 18,82
	printstr str_SC4
	SET_cur 10,110
	printstr str_GO1
	SET_cur 11,110
	printstr str_GO2
	SET_cur 12,110
	printstr str_GO3
	SET_cur 13,110
	printstr str_GO4
	SET_cur 0,90
	printstr str_FW1
	SET_cur 1,90
	printstr str_FW2
	SET_cur 2,90
	printstr str_FW3
	SET_cur 3,90
	printstr str_FW4
	SET_cur 4,90
	printstr str_FW5
	SET_cur 5,90
	printstr str_FW6
	SET_cur 6,90
	printstr str_FW7
	SET_cur 7,90
	printstr str_FW8
	SET_cur 8,90
	printstr str_FW9
	SET_cur 9,90
	printstr str_FW10
	SET_cur 15,112
	printstr str_GUN1
	SET_cur 16,112
	printstr str_GUN2
	SET_cur 17,112
	printstr str_GUN3
	SET_cur 18,112
	printstr str_GUN4
	SET_cur 19,112
	printstr str_GUN5
	SET_cur 20,112
	printstr str_GUN6
	SET_cur 21,112
	printstr str_GUN7
	SET_cur 22,112
	printstr str_GUN8
	SET_cur 23,112
	printstr str_GUN9
	SET_cur 24,112
	printstr str_GUN10
	SET_cur 25,112
	printstr str_GUN11
	SET_cur 26,112
	printstr str_GUN12
	SET_cur 27,112
	printstr str_GUN13
	SET_cur 28,112
	printstr str_GUN14
	SET_cur 26,100
	printstr str_restart
	SET_cur 28,101
	printstr str_enterend
	mov ax,score
	sub ax,0
	aam
	cmp ah,0
	jz printzero2
	cmp ah,1
	jz printone2
	cmp ah,2
	jz printtwo2
	cmp ah,3
	jz printthree2
	cmp ah,4
	jz printfour2
	cmp ah,5
	jz printfive2
	cmp ah,6
	jz printsix2
	cmp ah,7
	jz printseven2
	cmp ah,8
	jz printeight2
	cmp ah,9
	jz printnine2
printzero2:
	SET_cur 20,12
	printstr str_ZERO1
	SET_cur 21,12
	printstr str_ZERO2
	SET_cur 22,12
	printstr str_ZERO3
	SET_cur 23,12
	printstr str_ZERO4
	jmp digit1
printone2:
	SET_cur 20,12
	printstr str_ONE1
	SET_cur 21,12
	printstr str_ONE2
	SET_cur 22,12
	printstr str_ONE3
	SET_cur 23,12
	printstr str_ONE4
	jmp digit1
printtwo2:
	SET_cur 20,12
	printstr str_TWO1
	SET_cur 21,12
	printstr str_TWO2
	SET_cur 22,12
	printstr str_TWO3
	SET_cur 23,12
	printstr str_TWO4
	jmp digit1
printthree2:
	SET_cur 20,12
	printstr str_THREE1
	SET_cur 21,12
	printstr str_THREE2
	SET_cur 22,12
	printstr str_THREE3
	SET_cur 23,12
	printstr str_THREE4
	jmp digit1
printfour2:
	SET_cur 20,12
	printstr str_FOUR1
	SET_cur 21,12
	printstr str_FOUR2
	SET_cur 22,12
	printstr str_FOUR3
	SET_cur 23,12
	printstr str_FOUR4
	jmp digit1
printfive2:
	SET_cur 20,12
	printstr str_FIVE1
	SET_cur 21,12
	printstr str_FIVE2
	SET_cur 22,12
	printstr str_FIVE3
	SET_cur 23,12
	printstr str_FIVE4
	jmp digit1
printsix2:
	SET_cur 20,12
	printstr str_SIX1
	SET_cur 21,12
	printstr str_SIX2
	SET_cur 22,12
	printstr str_SIX3
	SET_cur 23,12
	printstr str_SIX4
	jmp digit1
printseven2:
	SET_cur 20,12
	printstr str_SEVEN1
	SET_cur 21,12
	printstr str_SEVEN2
	SET_cur 22,12
	printstr str_SEVEN3
	SET_cur 23,12
	printstr str_SEVEN4
	jmp digit1
printeight2:
	SET_cur 20,12
	printstr str_EIGHT1
	SET_cur 21,12
	printstr str_EIGHT2
	SET_cur 22,12
	printstr str_EIGHT3
	SET_cur 23,12
	printstr str_EIGHT4
	jmp digit1
printnine2:
	SET_cur 20,12
	printstr str_NINE1
	SET_cur 21,12
	printstr str_NINE2
	SET_cur 22,12
	printstr str_NINE3
	SET_cur 23,12
	printstr str_NINE4
	jmp digit1
digit1:
	mov ax,score
	sub ax,0
	aam
	SET_cur 100,5
	cmp al,0
	jz printzero1
	cmp al,1
	jz printone1
	cmp al,2
	jz printtwo1
	cmp al,3
	jz printthree1
	cmp al,4
	jz printfour1
	cmp al,5
	jz printfive1
	cmp al,6
	jz printsix1
	cmp al,7
	jz printseven1
	cmp al,8
	jz printeight1
	cmp al,9
	jz printnine1
printzero1:
	SET_cur 20,19
	printstr str_ZERO1
	SET_cur 21,19
	printstr str_ZERO2
	SET_cur 22,19
	printstr str_ZERO3
	SET_cur 23,19
	printstr str_ZERO4
	jmp endinput
printone1:
	SET_cur 20,19
	printstr str_ONE1
	SET_cur 21,19
	printstr str_ONE2
	SET_cur 22,19
	printstr str_ONE3
	SET_cur 23,19
	printstr str_ONE4
	jmp endinput
printtwo1:
	SET_cur 20,19
	printstr str_TWO1
	SET_cur 21,19
	printstr str_TWO2
	SET_cur 22,19
	printstr str_TWO3
	SET_cur 23,19
	printstr str_TWO4
	jmp endinput
printthree1:
	SET_cur 20,19
	printstr str_THREE1
	SET_cur 21,19
	printstr str_THREE2
	SET_cur 22,19
	printstr str_THREE3
	SET_cur 23,19
	printstr str_THREE4
	jmp endinput
printfour1:
	SET_cur 20,19
	printstr str_FOUR1
	SET_cur 21,19
	printstr str_FOUR2
	SET_cur 22,19
	printstr str_FOUR3
	SET_cur 23,19
	printstr str_FOUR4
	jmp endinput
printfive1:
	SET_cur 20,19
	printstr str_FIVE1
	SET_cur 21,19
	printstr str_FIVE2
	SET_cur 22,19
	printstr str_FIVE3
	SET_cur 23,19
	printstr str_FIVE4
	jmp endinput
printsix1:
	SET_cur 20,19
	printstr str_SIX1
	SET_cur 21,19
	printstr str_SIX2
	SET_cur 22,19
	printstr str_SIX3
	SET_cur 23,19
	printstr str_SIX4
	jmp endinput
printseven1:
	SET_cur 20,19
	printstr str_SEVEN1
	SET_cur 21,19
	printstr str_SEVEN2
	SET_cur 22,19
	printstr str_SEVEN3
	SET_cur 23,19
	printstr str_SEVEN4
	jmp endinput
printeight1:
	SET_cur 20,19
	printstr str_EIGHT1
	SET_cur 21,19
	printstr str_EIGHT2
	SET_cur 22,19
	printstr str_EIGHT3
	SET_cur 23,19
	printstr str_EIGHT4
	jmp endinput
printnine1:
	SET_cur 20,19
	printstr str_NINE1
	SET_cur 21,19
	printstr str_NINE2
	SET_cur 22,19
	printstr str_NINE3
	SET_cur 23,19
	printstr str_NINE4
	jmp endinput
endinput:
	getchar al
	cmp al,72h
	jz restart
	cmp al,0Dh
	jz quit
	jmp endinput
;quit
quit:
 MUS_hide
 SetMode 03h
.exit
clear proc near
	mov	cx,3
 cl1:
	mov	al,' '
	mov	[di+6],al
	inc	di
	loop	cl1
	ret
 clear endp
tran proc near
	mov	cx,0
 hex2dec:
	inc	cx
	mov	bx,10
	mov	dx,0
	div	bx
	push	dx
	cmp	ax,0
	jne	hex2dec
 dec2ascii:
	pop	ax
	add	al,30h
	mov	[di+6],al
	inc	di
	loop	dec2ascii
	ret
 tran endp
end
