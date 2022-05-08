		AREA	my_code,CODE,READWRITE
start
		ADR		R0,adjacencymatrix	;R0 is now adjacencymatrix pointer  
		LDR		R1,=0x60000000  	;R1 is now destination of matrix pointer
		LDR		R2,=0x30000000  	;R2 stores value of N=no. of vertices
		LDR		R3,=81		;9*9 = 81
		LDRB		R7, [R0]
		
; STORING MATRIX AT 0x60000000
up		LDRB	R4,[R0],#01		
		STRB	R4,[R1],#01
		SUBS	R3,R3,#01			;decrement loop counter
		BNE		up		;jump to label up if loop-count Not-Equal to zero
	
; STORING NUMBER OF VERTICES AT 0x30000000	
		LDR		R3,=9
		STRB	R3,[R2]
		
; R4 stores Dest[v] array pointer & R5 stores sptSet[v] array pointer
		LDR		R4,=0x70000000  
		LDR		R5,=0x80000000  
		LDR		R1,=0x60000000  	
		LDR		R2,=0x30000000  	  
		LDR		R6,=99 ; Considered INT_MAX = 99

; Storing all Dist[v] as INT_MAX and sptSet[v] as False(00)
fl1		STRB R6,[R4],#01
		SUBS	R3,R3,#01	
		BNE		fl1
		
		LDRB	R3,[R2]
		LDR		R4,=0x70000000  
		LDR		R5,=0x80000000  
		LDR		R6,=0
		STRB R6,[R4]  ;dest[src]=0 (src=0)
		LDR		R6,=99 ;INT_MAX
		LDRB	R8,[R2]
		LDRB	R1,[R2]
		SUBS	R1,R1,#01	
		LDR		R11,=0

fl2		LDR		R7,=99
		B fl3

fl3		LDRB	R9,[R4],#01	;dist[v]	
				LDRB	R10,[R5],#01	;sptSet[v]
				CMP R10,#00
				BNE fl10
				CMP R9,R7
				MOVLE R7,R9  ;R7 is min
				MOVLE R6,R11

fl10				ADD	R11,R11,#01	
			SUBS	R8,R8,#01	
			BNE	fl3
				

		LDR		R4,=0x70000000  
		LDR		R11,=0x70000000  
		LDR		R5,=0x80000000  
		ADD R7,R5,R6  ;sprtset[u]
		LDR		R10,=0x01
		STRB R10,[R7]  ;sptSet[u] = true
		LDRB	R3,[R2]
		LDRB	R7,[R2]  ;R7 = 9
		LDR		R12,=0x60000000
		
fl4			LDRB	R8,[R5] ;sptset[v]
		CMP R8,#00
		BNE fl9
		ADD R8,R11,R6
		LDRB	R8,[R8]	; dist[u]
		CMP R8,#99
		BEQ fl9
		MUL R9,R7,R6
		ADD R9,R12,R9 ;9u+v
		LDRB	R9,[R9]; graph[u][v]
		CMP R9,#00
		BEQ fl9
		LDRB	R10,[R4] ;dist[v]	
		ADD R8,R8,R9
		CMP R8,R10
		BGE fl9
		STRB R8,[R4]
		
fl9		ADD R5,R5,#01
		ADD R4,R4,#01
		ADD	R12,R12,#01	
		SUBS	R3,R3,#01	
		BNE		fl4
		
		
		LDR		R4,=0x70000000  
		LDR		R5,=0x80000000  
		LDRB	R8,[R2]
		LDR		R11,=0
		SUBS	R1,R1,#01		
		BNE fl2



here	b		here	

adjacencymatrix	DCB	00,04,00,00,00,00,00,08,00,04,00,08,00,00,00,00,11,00,00,08,00,07,00,04,00,00,02,00,00,07,00,09,14,00,00,00,00,00,00,09,00,10,00,00,00,00,00,04,14,10,00,02,00,00,00,00,00,00,00,02,00,01,06,08,11,00,00,00,00,01,00,07,00,00,02,00,00,00,06,07,00

		END