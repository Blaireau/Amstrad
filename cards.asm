ORG #8000

init:
ld hl, #C000
ld de, #800

begin_loop:
ld bc,#7F8E : out (c), c ; MODE 2
call d_pique
call init
call d_coeur
call init
call d_trefle
call init
call d_carreau
call init
jp begin_loop

d_pique:
LD A,%00010000
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
LD A,%01111100
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%01101100
add hl, de
LD (hl),A
LD A,%00010000
add hl, de
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
ret

d_coeur:
LD A,%01101100
LD (hl),A
LD A,%11101110
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%01111100
add hl, de
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
LD A,%00010000
add hl, de
LD (hl),A
LD A,%00000000
add hl, de
LD (hl),A
ret

d_trefle:
LD A,%00010000
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%01101100
add hl, de
LD (hl),A
LD A,%00010000
add hl, de
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
ret

d_carreau:
LD A,%00010000
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
LD A,%01111100
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%11111110
add hl, de
LD (hl),A
LD A,%01111100
add hl, de
LD (hl),A
LD A,%00111000
add hl, de
LD (hl),A
LD A,%00010000
add hl, de
LD (hl),A
ret

SAVE 'CARDS.BIN',#100,$-#100,DSK,'cards.dsk'