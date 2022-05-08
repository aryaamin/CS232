		AREA	my_code,CODE,READWRITE
start
		LDR	R1,=0x09  	;R1 is now dest_array pointer  
		LDR	R2,=0x06
		
		CMP R1, R2
		MOVLT R3,R1
		MOVLT R1, R2
		MOVLT R2, R3
				
		MOV R4,#01		
		


up		MOV R5, R1

modu1		CMP R5, R4
			SUBGE R5,R5,R4
			BGE modu1
			
		MOV R6, R2

modu2		CMP R6, R4
			SUBGE R6,R6,R4
			BGE modu2
			
		CMP R5,R6
		CMPEQ R5,#0
		MOVEQ R3,R4
		ADDS	R4,R4,#01
		CMP R4,R2
		BLT		up

here	b		here	

		END