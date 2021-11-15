; Target assembler: cc65 v2.18.0 [--target none -C battleship.bin_cc65.cfg]
;***************************************
;* BATTLESHIP GAME for the KIM-1       *
;* (c) 1979 Ronald Kushnier (original) *
;* KIM User Notes 6                    *
;* (c) 1979 Jody Nelis (bugfixed)      *
;* KIM User Notes 11                   *
;***************************************
         .setcpu "6502"
PRESS    =       $1efe
SCANDS   =       $1f1f
GETKEY   =       $1f6a

         .org    $0200
         lda     #$02
         sta     $00
         lda     #$00
         sta     $e8
         ldx     #$99
L020A:   lda     #$02
         sta     $00,x
         dex
         bne     L020A
@L0211:  lda     #$11
         sta     $e7
         sta     $e3
         ldx     #$07
@L0219:  clc
         ldy     #$07
         lda     #$00
@L021E:  sta     ($e7),y
         dey
         bpl     @L021E
         sed
         lda     $e7
         adc     #$10
         sta     $e7
         dex
         bpl     @L0219
@L022D:  sed
         sec
         lda     $ea
         adc     $ed
         adc     $ee
         sta     $e9
         ldx     #$04
@L0239:  lda     $e9,x
         sta     $ea,x
         dex
         bpl     @L0239
         sec
         sbc     #$99
         bcs     @L022D
         lda     $eb
         and     #$06
         cmp     #$00
         beq     @L028E
         cmp     #$02
         beq     @L0287
         cmp     #$04
         beq     @L026E
         clc
         ldy     #$02
         ldx     $e9
@L025A:  lda     $00,x
         cmp     #$02
         beq     @L0211
         lda     #$01
         sta     $00,x
         txa
         adc     #$09
         tax
         dey
         bpl     @L025A
         jmp     @L0295

@L026E:  ldy     #$02
         ldx     $e9
@L0272:  lda     $00,x
         cmp     #$02
         beq     @L0211
         lda     #$01
         sta     $00,x
         txa
         sec
         sbc     $e3
         tax
         dey
         bpl     @L0272
         jmp     @L0295

@L0287:  lda     #$10
         sta     $e3
         jmp     @L026E

@L028E:  lda     #$01
         sta     $e3
         jmp     @L026E

@L0295:  lda     #$20
         sta     $fa
         lda     #$00
         sta     $f9
         sta     $e4
         sta     $fb
         sta     $e6
@L02A3:  cld
         jsr     SCANDS
         jsr     GETKEY
         cmp     #$0f
         beq     @L02E5
         cmp     #$09
         bpl     @L02A3
         cmp     #$00
         beq     @L02A3
         sta     $e5
         lda     $e6
         cmp     #$01
         beq     @L02D4
         inc     $e6
         asl     $e5
         asl     $e5
         asl     $e5
         asl     $e5
         lda     $e5
         sta     $fb
@L02CC:  jsr     PRESS
         bne     @L02CC
         jmp     @L02A3

@L02D4:  clc
         lda     $e5
         adc     $fb
         sta     $fb
         dec     $e6
@L02DD:  jsr     PRESS
         bne     @L02DD
         jmp     @L02A3

@L02E5:  lda     $fb
         cmp     $e4
         beq     @L02F2
         tax
         lda     $00,x
         cmp     #$01
         beq     @L0309
@L02F2:  sed
         lda     $fa
         sec
         sbc     #$01
         beq     @L0330
         sta     $fa
         cld
         lda     $fb
         sta     $e4
@L0301:  jsr     PRESS
         bne     @L0301
         jmp     @L02A3

@L0309:  inc     $f9
         lda     $f9
         cmp     #$03
         beq     @L0319
@L0311:  jsr     PRESS
         bne     @L0311
         jmp     @L02F2

@L0319:  sed
         lda     #$21
         sec
         sbc     $fa
         sta     $f9
         cld
         lda     #$de
         sta     $fb
         lda     #$ad
         sta     $fa
@L032A:  jsr     SCANDS
         jmp     @L032A

@L0330:  ldy     #$02
         ldx     #$99
@L0334:  lda     $00,x
         cmp     #$01
         beq     @L0340
@L033A:  dex
         bne     @L0334
         jmp     @L0348

@L0340:  txa
         sta     $00f9,y
         dey
         jmp     @L033A

@L0348:  jsr     SCANDS
         jmp     @L0348

