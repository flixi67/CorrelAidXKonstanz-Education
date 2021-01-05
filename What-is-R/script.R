#########################
# CorrelAid x Konstanz  #
#                       #
# What is R?            #
#########################



# Die simpelste Version von R - Ein Taschenrechner ------------------------

3 + 6 - 2 # addieren & subtrahieren
4 * 6 # multiplizieren
3 ^ 2 # potenzieren
5 / 3 # dividieren
5 * (10 - 3) # R hält sich an die gängigen Rechenregeln


# Etwas fortgeschrittener - R als Orakel -----------------------------------

5 > 3 # größer
5 < 3 # kleiner
5 <= 3 # kleiner/gleich
5 >= 3 # größer/gleich
5 == 3 # gleich
5 != 3 # ungleich

# Mehr als Zahlen und einfache Abfragen -----------------------------------

32 > 19 & 12 == 6 * 2 # und GLEICHZEITIG
'3' == 3 | 1 == 1 # ODER
'4' == 3
'rot' == 'blau'
'sieben' == 7


# Welche Grundtypen gibt es? ----------------------------------------------

7 # integer
7.2341234 # numeric
'wort' # character
TRUE # boolean


# R hat ein Gedächtnis - Zuweisungen/Assignment Operator --------------------

wort <- 'rot'
wort # aufrufen des Objekts "wort", enthaelt character-string "rot"
# alt + "-" shortcut für Zuweisungspfeil
rechnung <- 1 + 3 + 4
rechnung # aufrufen des Objekts "rechnung"


# Strapazieren wir das Gedächtnis -----------------------------------------

integers <- c(2, 5, 9, 2, 500, 7)
numerics <- c(4.2, 3.0, 8.5)
characters <- c('There', 'is', 'no', 'free', 'lunch!')
logicals <- c(TRUE, TRUE, FALSE, FALSE)

# Beachte: Nur gleiche Datentypen innerhalb eines Vektors!


# Was passiert wenn wir die Typen mischen? --------------------------------


