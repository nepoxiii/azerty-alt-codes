#Requires AutoHotkey v2.0
; ==============================================================================
; Émulation robuste des Alt-Codes avec la touche Alt gauche (Clavier AZERTY)
; Fonctionne même si la touche Alt est maintenue plusieurs secondes !
;
; Utilisation :
; 1. Maintenez la touche Alt gauche enfoncée (aussi longtemps que vous voulez).
; 2. Tapez le ou les chiffres souhaités sur la rangée supérieure (sans Shift).
; 3. Relâchez la touche Alt gauche : le symbole apparaît instantanément !
; ==============================================================================

global altBuffer := ""

; Table des symboles (Alt-Codes 1 à 30 de la table OEM / CP437)
global SymbolTable := Map(
    1, "☺",  2, "☻",  3, "♥",  4, "♦",  5, "♣",  6, "♠",  7, "•",  8, "◘",  9, "○",
    10, "◙", 11, "♂", 12, "♀", 13, "♪", 14, "♫", 15, "☼", 16, "►", 17, "◄", 18, "↕",
    19, "‼", 20, "¶", 21, "§", 22, "▬", 23, "↨", 24, "↑", 25, "↓", 26, "→", 27, "←",
    28, "∟", 29, "↔", 30, "▲", 31, "▼"
)

; Ajoute un chiffre au tampon mémoire et attend le relâchement de la touche (anti-répétition)
AddDigit(digit, key) {
    global altBuffer
    altBuffer .= digit
    KeyWait(key)
}

; Rangée supérieure AZERTY (Alt gauche uniquement pour préserver AltGr)
$<!&::AddDigit("1", "&")
$<!é::AddDigit("2", "é")
$<!"::AddDigit("3", '"')
$<!'::AddDigit("4", "'")
$<!(::AddDigit("5", "(")
$<!-::AddDigit("6", "-")
$<!è::AddDigit("7", "è")   ; Alt + è = 7 -> • (Puce)
$<!_::AddDigit("8", "_")
$<!ç::AddDigit("9", "ç")
$<!à::AddDigit("0", "à")

; Touche Échap pendant Alt pour annuler la saisie en cours
$<!Esc:: {
    global altBuffer := ""
}

; Dès que la touche Alt gauche est relâchée, on envoie le symbole correspondant
~*LAlt Up:: {
    global altBuffer
    if (altBuffer != "") {
        val := altBuffer
        altBuffer := ""
        try {
            code := Integer(val)
            if SymbolTable.Has(code) {
                Send("{Blind}{vkE8}")
                SendText(SymbolTable[code])
            } else if (code > 0 && code <= 0x10FFFF) {
                Send("{Blind}{vkE8}")
                SendText(Chr(code))
            }
        }
    }
}

; ==============================================================================
; TABLE DES COMBINAISONS POSSIBLES (ALT-CODES DE 1 À 30)
; Maintenez Alt gauche, tapez les touches dans l'ordre, puis relâchez Alt :
;
;  Code | Touche(s) AZERTY       | Symbole | Description
; ------|------------------------|---------|------------------------------------
;    1  | Alt + &                |    ☺    | Visage souriant blanc
;    2  | Alt + é                |    ☻    | Visage souriant noir
;    3  | Alt + "                |    ♥    | Cœur
;    4  | Alt + '                |    ♦    | Carreau
;    5  | Alt + (                |    ♣    | Trèfle
;    6  | Alt + -                |    ♠    | Pique
;    7  | Alt + è                |    •    | Puce (bullet point)
;    8  | Alt + _                |    ◘    | Puce carrée inversée
;    9  | Alt + ç                |    ○    | Cercle blanc
;   10  | Alt + & puis à         |    ◙    | Cercle inverse
;   11  | Alt + & puis &         |    ♂    | Symbole masculin (Mars)
;   12  | Alt + & puis é         |    ♀    | Symbole féminin (Vénus)
;   13  | Alt + & puis "         |    ♪    | Note de musique simple
;   14  | Alt + & puis '         |    ♫    | Double note de musique
;   15  | Alt + & puis (         |    ☼    | Soleil rayonnant
;   16  | Alt + & puis -         |    ►    | Flèche droite pleine
;   17  | Alt + & puis è         |    ◄    | Flèche gauche pleine
;   18  | Alt + & puis _         |    ↕    | Double flèche verticale
;   19  | Alt + & puis ç         |    ‼    | Double point d'exclamation
;   20  | Alt + é puis à         |    ¶    | Pied-de-mouche (paragraphe)
;   21  | Alt + é puis &         |    §    | Symbole paragraphe / section
;   22  | Alt + é puis é         |    ▬    | Rectangle noir horizontal
;   23  | Alt + é puis "         |    ↨    | Flèche verticale avec base
;   24  | Alt + é puis '         |    ↑    | Flèche vers le haut
;   25  | Alt + é puis (         |    ↓    | Flèche vers le bas
;   26  | Alt + é puis -         |    →    | Flèche vers la droite
;   27  | Alt + é puis è         |    ←    | Flèche vers la gauche
;   28  | Alt + é puis _         |    ∟    | Angle droit
;   29  | Alt + é puis ç         |    ↔    | Double flèche horizontale
;   30  | Alt + " puis à         |    ▲    | Triangle plein vers le haut
;  (31  | Alt + " puis &         |    ▼    | Triangle plein vers le bas)
; ==============================================================================