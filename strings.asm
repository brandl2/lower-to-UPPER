;; Author: Logan Brand and Deepthi Thumuluri
;; File: strings.asm
;; Project 6 

;; This program is designed to take an input and output that same 
;; string, as well as a capitalized version of this output.

		.ORIG x3000

;; Register usage:
; R0 = the input character
; R1 = the newline character
; R2 = base address of the array
; R3 = temporary working storage
; R4 = Temporary Variable Working Storage
; R5 = Counter

; Main program code	
	LEA	R0, PROMPT	  	; Display the prompt
	PUTS	
	LD 	R1, LF	          	; Initialize the return characters
	LD      R4, CR
	LEA 	R2, ARRAY         	; Get the base address of the array
	LD 	R5, SIZE		; Initialize the counter
	ADD	R5, R5, #-1		; Decrement address of R5

 
WHILE	GETC			  	; Read and echo a character (stored in R0)
	OUT	
	ADD 	R3, R0, R1	  	; Quit if character = LF
	BRz 	ENDWHILE
	STR 	R0, R2, #0	        ; Store that character in the array
	ADD 	R2, R2, #1	        ; Increment the address of the array cell
	ADD	R5, R5, #-1		; Decrement the address of R5
	BRz 	PLUSSIZE		; If zero, move on to PLUSSIZE
	BR 	WHILE	                ; Return to read another character
PLUSSIZE	ADD	R2, R1, #0	; Copy the Array into R2
ENDWHILE	STR 	R3, R2, #0	; Store the null character after the last input	

	LEA   R0, THANKS		; R0 <- THANKS 
       	PUTS				; Displays variable
	LEA   R0, ARRAY			; R0 <- ARRAY
        PUTS				; Displays variable
	LEA   R0, EXCLAMA		; R0 <- EXCLAMA
        PUTS				; Displays variable
	LEA   R0, UPPER			; R0 <- UPPER
        PUTS				; Displays variable 

	LD R2, SWITCH			; R2 <- SWITCH
	NOT R2, R2			; R2 <- -(R2)
	ADD R2, R2, #1
	LD R3, CHECK			; R3 <- CHECK
	NOT R3, R3			; R3 <- -(R3)
	ADD R3, R3, #1
	LEA R1, ARRAY			; R1 <- ARRAY
LOOP    LDR R0, R1, #0			; Create loop to copy R0 into R1
	BRz DONELOOP			; The loop, if zero, ends
	ADD R4, R0, R3			; R4 <- R0 + R3
	BRn OUTPUT			; If value is negative, go to output
	ADD R0, R0, R2			; R0 <- R2 + R0
OUTPUT	OUT 
	ADD R1, R1, #1			;R1 <- R1 + 1
	JSR LOOP

DONELOOP STR R0, R0, #0			;Exit loop

HALT

; Main program data
LF		.FILL 	x-000A		; The LF character (negated)
CR      	.FILL   X-000D          ; The CR character (negated)
PROMPT		.STRINGZ 		"Enter your name: "
THANKS  	.STRINGZ       		"\nThank you, "
EXCLAMA		.STRINGZ		"!"
UPPER   	.STRINGZ        	"\nYour name in uppercase is "
SIZE		.FILL #30		; Size max
ARRAY		.BLKW #3'0		; Array of 30 characters (including null)
SWITCH  	.FILL #32		; Contains the difference between the uppercase and lowercase characters
CHECK   	.FILL #97		; Checks the case of the character

.END
