BUILDSNA : BANKSET 0
ORG #100
RUN #100
debut

ld bc,160 : ld hl,100 ; en plein milieu de l'écran
call CalculeAdressePixel
ld (hl),c ; écrire le pixel
jr $ ; boucle infinie

CalculeAdressePixel
; BC=coordonnée X (0-319)
; HL=coordonnée Y (0-199)
ld de,tableau
add hl,hl ; adresses 16 bits, il faut indexer de 2 en 2
add hl,de
ld a,(hl) : inc hl
ld h,(hl) : ld l,a
; HL=adresse de la ligne
ld a,c ; on sauvegarde le X avant de diviser par 4
srl bc : srl bc ; diviser le X par 4 pour avoir l'octet en mode 1
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

SAVE 'SCREX.BIN',#100,$-#100,DSK,'screx.dsk'