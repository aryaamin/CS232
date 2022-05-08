		AREA	my_code,CODE,READWRITE
start
		ADR		R0,source_array_ROM	;R0 is now source_array pointer  
		LDR		R1,=0x40000000  
		LDRB		R2, [R0]	
		LDRB		R7, [R0]
		ADD	R2,R2,#01
		
up		LDRB	R3,[R0],#01		
		STRB	R3,[R1],#01
		SUBS	R2,R2,#01			;decrement loop counter
		BNE		up		;jump to label up if loop-count Not-Equal to zero
		
		LDR		R8,=0x40000000  

up2 		LDR		R0,=0x40000001  
		LDR		R1,=0x40000002  
		LDR		R2,=0x40000001  	
		LDR		R3,=0x40000002  
		LDRB		R4, [R8]
		SUBS	R4,R4,#01
		B up1
		
up1		LDRB	R5,[R0],#01
		LDRB	R6,[R1],#01
		CMP R5,R6
		STRBLT	R5,[R2],#01
		STRBLT	R6,[R3],#01
		STRBGE	R5,[R3],#01
		STRBGE	R6,[R2],#01
			
		SUBS	R4,R4,#01
		BNE		up1
		SUBS R7,R7,#01
		BNE up2

here	b		here	

source_array_ROM	DCB		0x07,0x15,0x03,0x12,0x01,0x04,0x09,0x08

		END
