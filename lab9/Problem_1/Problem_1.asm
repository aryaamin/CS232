		AREA	my_code,CODE,READWRITE
start
		ADR		R0,exp_array	;R0 is now source_array pointer  
		ADR		R1,var_array	;R0 is now source_array pointer  
		LDR		R2,=0x40000000  	;R1 is now dest_array pointer  
		LDR		R3,=0x50000000  	;R1 is now dest_array pointer  
		LDR		R4,=18	;R2 holds loop-Count of array-length 
		LDR		R5,=3		;R2 holds loop-Count of array-length 
		
		
		
		;copy 5 bytes from Source_ROM to dest_RAM(0x40000000)
storeexp		LDRB	R6,[R0],#01			;R3 act as temp register
		CMP	R6,#48
		BLT storeexp1
		CMPGE R6,#57
		SUBLE	R6,R6,#48

storeexp1
		STRB	R6,[R2],#01
		SUBS	R4,R4,#01			;decrement loop counter
		BNE		storeexp		;jump to label up if loop-count Not-Equal to zero
	
storevars		LDRB	R6,[R1],#01			;R3 act as temp register
		STRB	R6,[R3],#01
		SUBS	R5,R5,#01			;decrement loop counter
		BNE		storevars		;jump to label up if loop-count Not-Equal to zero	
	
		LDR		R0,=0x40000000  	;R1 is now dest_array pointer  
		LDR		R1,=0x50000000  	;R1 is now dest_array pointer  
		LDR		R2,=0x60000000  	;R1 is now dest_array pointer  

stackofexp		LDRB	R3,[R0],#01
		CMP	R3,#35
		BEQ	here	
		CMP	R3,#41
		STRBNE	R3,[R2],#01
		BNE		stackofexp
		SUB	R2,R2,#01
		LDRB 	R4,[R2]
		CMP R4,#120
		ADDGE R7,R1,R4
		SUBGE R7,R7,#120
		LDRBGE	R4,[R7]
		;SUBLT	R4,R4,#48
		SUB	R2,R2,#01
		LDRB	R5,[R2]
		SUB	R2,R2,#01
		LDRB	R6,[R2]
		CMP R6,#120
		ADDGE R7,R1,R6
		SUBGE R7,R7,#120
		LDRBGE	R6,[R7]
		;SUBLT	R6,R6,#48
		CMP	R5,#43
		ADDEQ	R3,R4,R6
		CMP	R5,#42
		MULEQ	R3,R4,R6
		CMP	R5,#45
		SUBEQ	R3,R6,R4
		CMP	R5,#47
		BEQ	div
		SUB	R2,R2,#01
		STRB	R3,[R2],#01
		BNE		stackofexp	



here	b		here	

div		LDR		R3,=0
divloop		CMP	R6,R4
			SUBGE R6,R6,R4
			ADDGE R3,R3,#01
			B	divloop

;x = 5, y = 2, z = 2
;(((x+3)-(y*z))+5)
exp_array		DCB		40,40,40,120,43,51,41,45,40,121,42,122,41,41,43,53,41,35
var_array		DCB		5,2,2

		END