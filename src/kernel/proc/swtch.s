.include "m328Pdef.inc"

.text

.globl swtch
swtch:
# @r25:r24 -- old context
# @r23:r22 -- new context
swtch:
	# ????????? call-saved ????????
	MOV YL, R24
	MOV YH, R25

	STD	Y+2, R2
	STD	Y+3, R3
	STD	Y+4, R4
    STD	Y+5, R5
	STD	Y+6, R6
    STD	Y+7, R7
	STD	Y+8, R8
    STD	Y+9, R9
	STD	Y+10, R10
    STD	Y+11, R11
	STD	Y+12, R12
    STD	Y+13, R13
	STD	Y+14, R14
    STD	Y+15, R15
	STD	Y+16, R16
    STD	Y+17, R17
	STD	Y+18, R28
    STD	Y+19, R29


	# ????????? ????????? ?? ????
	IN R30, SPL
	IN R31, SPH
	STD	Y+0, R30
	STD	Y+1, R31

	
	# ????????? call-saved ????????
	MOV YL, R22
	MOV YH, R23

	LDD R2, Y+2
	LDD R3, Y+3
	LDD	R4, Y+4
    LDD	R5, Y+5
	LDD	R6, Y+6
    LDD	R7, Y+7
	LDD	R8, Y+8
    LDD	R9, Y+9
	LDD	R10, Y+10
    LDD	R11, Y+11
	LDD	R12, Y+12
    LDD	R13, Y+13
	LDD	R14, Y+14
    LDD	R15, Y+15
	LDD	R16, Y+16
    LDD	R17, Y+17
#   LDD	R28, Y+18
#   LDD	R29, Y+19


	# ????????? ????????? ?? ????
	LDD R30, Y+0
	LDD R31, Y+1

 	out SPL, R30
	out SPH, R31

	ret
