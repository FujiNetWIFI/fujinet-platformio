	;; The N: device
	;; Using Stefan D. Dorndorf's assembler porting
	;; as a pattern.
	;;
	;; Author:
	;;   <thom.cherryhomes@gmail.com>
	
	.opt list

	.include "src/sysequ.inc"
	
	*=$2000

run	ldy #$00
?1	lda hatabs,y
	beq found
	cmp #'N
	beq found
	iny
	iny
	iny
	cpy #11*3
	bcc ?1
	;; TODO: HATABS FULL, print error message?
	rts

	;; Empty slot found, insert handler
found	lda #'N
	sta hatabs,y
	lda #<drvhdl
	sta hatabs+1,y
	lda #>drvhdl
	sta hatabs+2,y
	;; Reset memlo
	lda #<end
	sta memlo
	lda #>end
	sta memlo+1
	rts

	;; N: drvhdl
drvhdl	.word open-1, close-1, read-1, write-1, status-1, special-1

open	rts
close	rts
read	rts	
write	rts	
status	rts
special	rts

end
	
	*=$02E0
	.word run		; Run address