BREAKPOINT
BUILDSNA : BANKSET 0
ORG #100
RUN #100

; Position initiale
ld bc, 0
ld (#7ffe), bc
ld hl, 0
ld (#7ffc), hl

loopy_loop:
ld bc,#7F8E : out (c), c ; Switch en MODE 2
; On charge les valeurs de position
ld bc,(#7ffe) : ld hl,(#7ffc)  
call CalculeAdressePixel
ld (hl),%00010000 ; écrire le pixel
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%00111000
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%01111100
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%11111110
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%11111110
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%01101100
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%00010000
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
call CalculeAdressePixel
ld (hl),%00111000
ld hl, (#7ffc)
inc hl : ld (#7ffc), hl
ld bc, (#7ffe)
inc bc : ld (#7ffe), bc
jp loopy_loop ; boucle infinie

CalculeAdressePixel
; BC=coordonnée X (0-319)
; HL=coordonnée Y (0-199)
; Renvoie la coordonée dans HL / 
ld de,tableau
add hl,hl ; adresses 16 bits, il faut indexer de 2 en 2
add hl,de
ld a,(hl) : inc hl
ld h,(hl) : ld l,a
; HL=adresse de la ligne
ld a,c ; on sauvegarde le X avant de diviser par 4
srl bc ; : srl bc :srl bc ;:srl bc : srl bc ; diviser le X par 4 pour avoir l'octet en mode 1
add hl,bc
ld c,%10000000 ; encre 1 pour le pixel mode 1 le plus à gauche dans l'octet
and 3 ; avec le modulo 4 on va savoir quel est le pixel en partant de la gauche
jr z,.noShift
.Shift
srl c
dec a
jr nz,.Shift
.noShift
ret ; HL=adresse écran aux coordonnées X/Y données et C est le pixel d'encre 1

inf_loop:
ld bc,#7F8E : out (c), c ; MODE 2
jr inf_loop

;-------------------
adresse_ecran=#C000
largeur_ecran=80
tableau
repeat 25
repeat 8
defw adresse_ecran
adresse_ecran+=#800
rend
adresse_ecran+=largeur_ecran
adresse_ecran-=#4000
rend 

SAVE 'CARDS.BIN',#100,$-#100,DSK,'cards.dsk'