## ---------------------------
##
## Script name: CorrelAid-X_Konstanz_Education
##
## Purpose of script: Script to show basic usage of R
##
## Author: Philipp Bosch & Tilman Kerl
##
## Date Created: 2021-01-05
##
## Email: konstanz@correlaid.de
##
## ---------------------------
##
## Notes:
##
##
## ---------------------------



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

weird_something <- c('There', 'is', 'no', 'free', 'lunch!', TRUE, TRUE, FALSE, FALSE)

weird_something_2 <- c(2, 5, 9, 2, 500, 7, 'There', 'is', 'no', 'free', 'lunch!', TRUE, TRUE, FALSE, FALSE)


# Operationen mit Vektoren -------------------------------------------------

large_numbers <- integers + numerics # Addition und Recycling!

characters + logicals # Magische Fehlermeldung

more_characters <- c("But", "i", "want", "kostenlosen", "Nachschlag!", "#Seezeitmafia")

characters + more_characters

sentences <- c(characters, more_characters) # Die Logik von 'c()' bleibt gleich!




# Aufspüren von Objekten in Vektoren --------------------------------------

more_characters[1] # Gibt erstes Element des Vektors

weird_something_2[3] # Gibt drittes Element des Vektors



# Spice it up - Listen ----------------------------------------------------

# Vektoren sind etwas eintönig und unflexibel - Listen to the rescue

my_list <- list("This", "is", "a", "list", 5, 7, TRUE) # mischen von Typen möglich

my_number_list <- list(integers, numerics) # zusammenführen von Vektoren möglich

# Finden von Elementen ist (fast) analog zu Vektoren

my_list[1]
my_list[[1]]

# The real shit - Funktionen ----------------------------------------------
# Eine Funktion in R kann man sich mit einer Funktion aus Mathe vorstellen,

mean(integers) # berechne den mean der werte, die in der variable integers gespeichert ist
median(integers)
sum(integers) # summiere alle elemente aus integers
wurzel <- sqrt(35) # berechne die wurzel von 35

round(wurzel, digits = 1)
# es sind auch verschachtelungen von funktionen möglich:
round(sqrt(35), digits = 1) # ist das selbe wie 2 Zeilen weiter oben

wuerfel <- c(1:6)
sample(wuerfel) # ändert die reihenfolge der elemente im würfel
# damit die änderungen aber auch persitent sind müssen wir das ergebnis wieder in der wuerfel varibale speichern:
wuerfel <- sample(wuerfel)
wuerfel

# wenn wir nur eine zufällige Zahl aus unserem Würfel haben wollen können wir den parameter size mit dem wert 1 hinzufügen
sample(wuerfel, size = 1)

# was genau es alles für funktionen gibt & was für parameter die haben findet ihr
# über eine google suche oder die dokumentation der funktionen heraus. Ansonsten geht auch:
?sample # gibt die dokumentation der funktion im help-screen aus


# Eigene Funktionen - Wie & Warum --------------------------------------------

# Eigene Funktionen sind sinnvoll für für spezielle Probleme und repetitive Aufgaben
# Wir können unsere eigene simple Additions-funktion definieren:

add <- function(a,b) {  # das hier ist der Kopf der Funktion, "add" ist der name, mit dem wir die fkt. später aufrufen können
                        # in den klammern von function() können wir parameter bestimmen, für die addition brauchen wir 2, die können wir nennen wie wir wollen
  return(a+b)           # alles zwischen den Klammern wird der Rumpf genannt,
                        # mit dem return() geben wir das ergbenis der berechnung zurück um es später wiederverwenden zu können
}

# jetzt können wir die funktion aufrufen (benutzen) indem wir add(a,b) mit a,b integers/numerics
add(1,2)
add(13, 8)
add(200, -10)
add(-200, -10)
add(-200, 10)
add("hey ", 2) # das wird einen Fehler werfen
add("hey ", "du") # das hier auch


# Eigene Funktionen - advanced 1 -----------------------------------------------

# Vanhanen's Polyarchy Dataset
vanhanen <- function(vote_share, participation) {
  contestation <- 100 - vote_share
  final_index <- (contestation * participation)/100
  return(final_index)
}

# TODO: sinvolle werte
# Jetzt können wir einfach den index berechnen ohne immer alles zu tippen, es reicht:
vanhanen(60, 40)


# Eigene Funktionen - advanced 2 -----------------------------------------------

#
round(mean(add(vanhanen(60, 40), vanhanen(80, 60)))*99.99, digits = 2)

# für mehr übersicht können wir es auch in mehrere Zeilen schreiben
round(
  mean(
    add(
      vanhanen(60, 40),
      vanhanen(80, 60))
    )
  *99.99,
  digits = 2)
