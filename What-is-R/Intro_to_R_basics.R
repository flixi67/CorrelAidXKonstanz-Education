## ---------------------------
##
## Script name: CorrelAid-X_Konstanz_Education
##
## Purpose of script: Script to show basic usage of R
##
## Author: Philipp Bosch & Tilman Kerl & Felix Kube
##
## Date Created: 30-04-2021
##
## Email: konstanz@correlaid.de
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
'3' == 3 | 1 == 2 # ODER
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


# Vektoren - mehrere Werte in einem Objekt speichern -----------------------------------------

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



# Cool und nervig - Listen ----------------------------------------------------

# Listen sind cool

my_list <- list("This", "is", "a", "list", 5, 7, TRUE) # mischen von Typen möglich

my_number_list <- list(integers, numerics) # zusammenführen von Vektoren möglich

# Aber das finden von Elementen ist etwas nervig

my_number_list[1]
my_number_list[1][3] # geht nicht
my_number_list[[1]]
my_number_list[[1]][3] # geht

# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Erstelle eine Liste, die die folgenden Elemente enthält
# Einen Integer-Vektor mit den Zahlen 0 bis 10
# Einen Numeric Vektor mit deinem Alter, deiner Größe (in m) und der Anzahl deiner Persönlichkeiten
# Einen Charakter-Vektor mit den Worten "Correlaid" "ist" "sau" "cool!"

listy_list <- list(c(XXX:XXX), XXX, c("Correlaid", XXX))

# Indiziere (wähle aus) deine Größe und gib sie in cm an

listy_list[XXX] * XXX

# Berechne, wieviel du pro Lebensjahr gewachsen bist

XXX

# Lass R sagen, dass Correlaid sau cool ist! (Gib den Charakter-Vektor aus)

listy_list[XXX]

# Für Experten: füge der Liste deine Vor- und Nachnamen an

listy_list[XXX] <- c("Marie", "Johanna", "Dübel")

##  /\_/\
## ( o.o )
##  > ^ <


# The real shit - Funktionen ----------------------------------------------

mean(integers) # berechne den mean der Werte des Objekts integers
median(integers)
sum(integers) # summiere alle Elemente aus integers
wurzel <- sqrt(35) # berechne die Wurzel von 35

length(integers) # gib die Länge des vectors zurück (die Anzahl der Elemente)


vector1 <- c(1:10)
vector2 <- c(1:10)
cor(vector1, vector2) # berechne die correlation zweier vektoren

# es geht schwieriger
vector1 <- c(12,42,132,5312,43,212,23,32,123)
vector2 <- c(46,123,365,213,59,3421,73,134,7)
cor(vector1, vector2)

round(wurzel, digits = 1)
# es sind auch Verschachtelungen von Funktionen möglich:
round(sqrt(35), digits = 1) # ist das selbe wie 2 Zeilen weiter oben

wuerfel <- c(1:6)
sample(wuerfel) #  ändert die Reihenfolge der Elemente im Würfel
# erst durch Zuweisung wird das Ergebnis gespeichert
sample_x <- sample(wuerfel)
sample_x

# wenn wir nur eine zufällige Zahl aus unserem Würfel haben wollen können wir 
# den Parameter size mit dem Wert 1 hinzufügen
sample(wuerfel, size = 1)

# Und welche Parameter gibt es für weöche Funktion?
?sample # gibt die Dokumentation der Funktion im help-screen aus


# Eigene Funktionen - Wie & Warum --------------------------------------------

# Eigene Funktionen sind sinnvoll für für spezielle Probleme und repetitive Aufgaben
# Wir können unsere eigene simple Additionsfunktion definieren:

add <- function(a,b) {  # das hier ist der Kopf der Funktion, "add" ist der name, mit dem wir die fkt. später aufrufen können
                        # in den klammern von function() können wir parameter bestimmen, für die addition brauchen wir 2, 
                        # die können wir nennen wie wir wollen
  return(a+b)           # alles zwischen den Klammern wird der Rumpf genannt,
                        # mit dem return() geben wir das ergbenis der berechnung zurück um es später wiederverwenden zu können
}

# jetzt können wir die Funktion aufrufen (benutzen)
add(1,2)
add(13, 8)
add(200, -10)
add(-200, -10)
add(-200, 10)
add("hey ", 2) # das wird einen Fehler werfen
add("hey ", "du") # das hier auch


# Eigene Funktionen - advanced 1 -----------------------------------------------

# Vanhanen Index
vanhanen <- function(vote_share, participation, population) {
  absolute_voters <- participation * population
  P <- absolute_voters/population * 100
  C <- 100 - vote_share
  final_index <- (C * P)/100
  return(final_index)
}

# Jetzt können wir einfach den Index berechnen ohne immer alles zu tippen, es reicht:
vanhanen(32.9, 0.76, 83.6)
vanhanen(53.08, 0.51, 10.01)

# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Schreibe eine Funktion, die das letzte Element eines Vektors zurückgibt

last <- function(XXX) {
  return(XXX)
}

# Schreibe eine Funktion, die alle Elemente eines Vektors, die kleiner als der
# Durchschnitt sind, zurückgibt

unterdurchschnittlich <- function(XXX) {
  kleiner <- XXX < XXX
  return(XXX[kleiner])
}

# Für schnelle PiRRRRRRaten (oder SchnuRRRRRRkatzen): Fangt mit den Hausaufgaben an ;)

##  /\_/\
## ( o.o )
##  > ^ <

# Für morgen noch diese Zeile ausführen! Könnte etwas dauern, da ihr Packages installiert

source(file = "install_packages.R") # source spielt einfach das komplette Skript ab
