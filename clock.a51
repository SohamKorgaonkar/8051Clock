org 0h
	ljmp main
	
org 0003H
	lcall delay
	lcall incmin
	reti

org 000BH
	lcall clksec
	reti

org 0013H
	lcall delay
	mov 39H,#60
	catdog:
	lcall incmin
	djnz 39H,catdog
	reti

	
org 0050H
	main:
	mov IE,#10000111B
	mov TMOD,00010001B
	//mov T2MOD,00000010B
	mov TH0,#00
	mov TL0,#00
	setb TR0
	setb TCON.2
	setb TCON.0
	lcall initclk
	
	plop:
	jc show
	mov R5,#119
	mov 38H,#14
	setb C
	show:
	clr P0.2
	clr P0.4
	setb P0.1
	setb P0.3
	mov P1,R0
	mov P2,R2
	lcall delay
	clr P0.1
	clr P0.3
	setb P0.2
	setb P0.4
	mov P1,R1
	mov P2,R3
	lcall delay
	sjmp plop
	
	
org 0A1h
	table: DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
		
org 0BCh
	disp:
	mov 50H,R0
	mov 51H,R1
	mov 52H,R2
	mov 53H,R3
	mov DPTR, #table
	mov A,R0
	jz mat0
	fog0:inc DPTR
	djnz R0,fog0
	mat0:
	clr A
	movc A,@A+DPTR
	mov R0,A

	mov DPTR, #table
	mov A,R1
	jz mat1
	fog1:inc DPTR
	djnz R1,fog1
	mat1:
	clr A
	movc A,@A+DPTR
	mov R1,A
	
	mov DPTR, #table
	mov A,R2
	jz mat2
	fog2:inc DPTR
	djnz R2,fog2
	mat2:
	clr A
	movc A,@A+DPTR
	mov R2,A
	
	mov DPTR, #table
	mov A,R3
	jz mat3
	fog3:inc DPTR
	djnz R3,fog3
	mat3:
	clr A
	movc A,@A+DPTR
	mov R3,A
	ret
	
org 010Dh
	inct: sjmp begin
	begin:
	mov 40H,#02
	mov R0,50H
	mov R1,51H
	mov R2,52H
	mov R3,53H
	num1: djnz 40H,done
          ret
	 done:inc 41H
		  djnz 55H,num1
		  mov 41H,#0
		  mov 55H,#10
		  inc 42H
		  djnz 56H,num1
		  mov 42H,#0
		  mov 56H,#6
		  inc R0
		  djnz 57H,num1
		  mov R0,#0
		  mov 57H,#10
		  inc R1
		  djnz 58H,num1
		  mov R1,#0
		  mov 58H,#6
		  inc R2
		  djnz 45H,cont1
		  lcall initclk
		  ret
	cont1:djnz 59H,num1
		  mov R2,#0
		  mov 59H,#10
		  inc R3
		  djnz 60H,num1
		  lcall initclk
		  ret
		
org 179H
	delay:
	clr TF1
	clr TR1
	mov TH1,#0FFH
	mov TL1,#000H
	setb TR1
	bob:jnb TF1,bob
	ret
	
org 1AFH
	initclk: mov R0,#0
	mov R1,#0
	mov R2,#0
	mov R3,#0
	mov 50H,#0
	mov 51H,#0
	mov 52H,#0
	mov 53H,#0
	mov 55H,#10
	mov 56H,#6
	mov 57H,#10
	mov 58H,#6
	mov 59H,#10
	mov 60H,#3
	mov 41H,#0
	mov 42H,#0
	mov 45H,#24
	ret
	
org 21BH
	clksec:
	mov TH0,#00
	mov TL0,#00
	sjmp cat
	tree:
	mov R5,#119
	ball:
	reti
	cat: djnz R5,ball
	djnz 38H,tree
	clr C
	lcall inct
	lcall disp
	cpl P3.7
	ret

org 26CH
	incmin:mov R6,#60
	incsec: lcall inct
	lcall disp
	djnz R6,incsec
	ret
	
end