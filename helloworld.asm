ORG #100 ; spécifie à quelle adresse on doit assembler notre programme
LD HL,message
CALL print_message
JR $ ; boucle infinie

print_message
LD A,(HL) : INC HL ; récupérer un octet et avancer dans le tableau
OR A : RET Z ; si l'octet est nul, on sort de la routine
CALL #BB5A ; afficher le caractère avec le vecteur système
JR print_message ; et on recommence

message DEFB 'roudoudou.com',0

SAVE 'HELLO.BIN',#100,$-#100,DSK,'hello.dsk'