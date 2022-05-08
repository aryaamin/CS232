		AREA	my_code,CODE,READWRITE
start
		ADR		R0,exp_array	;R0 is now source_array pointer   
		LDR		R1,=0x40000000  	;R1 is now dest_array pointer  
		LDR		R2,=32	;R2 holds loop-Count of array-length 
		LDR		R12,=2	;R2 holds loop-Count of array-length 
		
		;copy 5 bytes from Source_ROM to dest_RAM(0x40000000)
storeexp		LDRB	R3,[R0],#01			;R3 act as temp register
		STRB	R3,[R1],#01
		SUBS	R2,R2,#01			;decrement loop counter
		BNE		storeexp		;jump to label up if loop-count Not-Equal to zero


		LDR		R1,=0x40000000  	;R1 is now dest_array pointer  
;R3 is high
;R4 is low
;R5 is arr[i]*pow
;R2 is f
				

stackofexp		LDR		R3,=31
					LDR		R4,=9
					B	convtoint

stackofexp1
					MOV	R0,R2; R0 is mantissa
					LDR		R3,=8
					LDR		R4,=1
					B	convtoint

stackofexp2		MOV	R10,R2; R10 is exp
					LDR		R11,=0x50000000 
					STRBLT	R10,[R11]
					SUB		R10,R10,#127
					LDRB	R11,[R1]; R11 is sign
					LDR		R2,=17
					SUB		R2,R2,R10;23-R10
					MOV	R1,R2
					LDR		R3,=2
					LDR		R7,=1
					B	powto
					
stackofexp3		LDR		R9,=1
						B	powto1

stackofexp4		LDR		R12,=1
					MUL		R8,R0,R12
					B div

	;	LDR		R11,=0x50000000 
	;	LDRB	R1,[R11]
	;	CMP		R1,#127
	;	LDRLT		R11,=127
		;SUBLT		R1,R1,R11		
		;BLT	pow11
	;	BLT	div3

here	b		here

;output1 		LDR		R12,=10
				;B	odiv1
				

;odiv1		LDR		R5,=0x50000000 
			;LDR		R11,=0
;odivloop1		CMP	R7,R12
		;	SUBGE R7,R7,R12
			;ADDGE R11,R11,#01
			;STRBLT	R11,[R5],#01
		;	MOVLT		R7,R11
		;	CMPLT		R11,#00
		;	STRBEQ	R7,[R5],#00
			;CMP		R7,#09
		;	BLT	output2
			;BLT odivloop1
			
;output2 		LDR		R12,=10
			;	LDR		R5,=0x60000000 
		;		B	odiv2

;odiv2		LDR		R11,=0
;odivloop2		CMP	R3,R12
			;SUBGE R3,R3,R12
		;	ADDGE R11,R11,#01
			;STRBLT	R11,[R5],#01
			;MOVLT		R3,R11
		;	CMPLT		R3,#09
		;	BLT	here1
		;	BLT odivloop2
;pow11			LDR		R12,=1
		;	LDR		R10,=1
		;	LDR		R6,=2

;powloop11		MUL		R12,R10,R6
		;	MOV R10,R12
		;	SUBS R1,R1,#01
		;	BNE	powloop11

;div3		LDR		R0,=1000000
	;	LDR		R4,=0
;divloop3		CMP	R0,R12
			;SUBGE R0,R0,R12
			;ADDGE R4,R4,#01
			;ADDLT	R3,R3,R4
			;B	divloop3
here1 b here1

div		LDR		R3,=0
divloop		CMP	R8,R9
			SUBGE R8,R8,R9
			ADDGE R3,R3,#01
			LDRLT		R12,=15625
			MULLT	R10,R8,R12
			MULLT	R11,R3,R12
			BLT	div1
			BLT here
			B	divloop
			
div1		LDR		R3,=0
divloop1		CMP	R10,R1
			SUBGE R10,R10,R1
			ADDGE R3,R3,#01
			ADDLT	R3,R3,R11
			BLT here
			B	divloop1

powto 			MUL		R8,R7,R3
				MOV	R7,R8
				SUBS	R10,R10,#01
				BNE		powto
				B	stackofexp3
				
powto1			MUL		R8,R9,R3
				MOV	R9,R8
				SUBS	R2,R2,#01
				BNE		powto1
				B	stackofexp4

pow			SUB	R6,R10,R3
			LDR	R7,=1 ;R7 is pow

pow1		MUL	R9,R7,R12
			MOV R7,R9
			SUBS R6,R6,#01
			BNE	pow1

			B	convtoint2
			
convtoint		LDR	R2,=0
				MOV R10,R3
				
convtoint1				ADD R8,R3,R1
					LDRB	R5,[R8] ;R5 is arr[i] here
					CMP R5,#01
					BEQ pow
					
convtoint2			MUL	R9,R5,R7; R5 is arr*pow
					MOV R5,R9
					ADD	R2,R2,R5
					SUB	R3,R3,#01
					CMP	R3,R4
					BGE	convtoint1
					CMP R4,#09
					BEQ stackofexp1
					B stackofexp2

exp_array		DCB		1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

		END