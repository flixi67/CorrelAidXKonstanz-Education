## -----------------------------------------------------------------------------
##
## Script name: CorrelAid-X_Konstanz_Education Übungsaufgaben
##
## Purpose of script: Training exercises for basic R functionality
##
## Author: Felix Kube
##
## Date Created: 2021-01-09
##
## Email: konstanz@correlaid.de
##
## -----------------------------------------------------------------------------
##
## Notes:
##
## -----------------------------------------------------------------------------

# Übung 1 ----------------------------------------------------------------------
# Erstelle einen Charaktervektor mit dem Namen "obst" und den Elementen "banane", "apfel", "traube" und "kiwi"

# Erstelle einen numerischen Vektor "bewertung" mit den Zahlen 1 bis 10

# Ordne die Zahlen im Vektor "bewertung" zufällig neu an und speichere die ersten 4

# Füge die beiden Vektoren "obst" und "bewertung" in einer Liste zusammen

# Gib die Elemente der Liste zurück. Welches Obst wurde bei dir am besten bewertet?

# Bonus: Schreibe eine Funktion, die nur das Obst mit der besten Bewertung zurück gibt.
#        Mit der Funktion which.max() kannst du die Position der größten Zahl eines Vektors bestimmen
#        Die Elemente in Listen abzurufen ist etwas tricky. Probiere ruhig etwas rum.

# Übung 2 ----------------------------------------------------------------------
# Übungsdaten installieren (Pinguine!!!)
install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)
penguins <- penguins
# Benutze die Funktionen head() und View() um dir einen Überblick über die Daten zu verschaffen

# Reduziere das Datenset auf die uns interessierenden Variablen "sex", "flipper_length_mm", "year", "bill_length_mm" und "species"
# Lösche Beobachtungen heraus, die bei einer der Variablen "NA", alo unbekannt, angegeben hat.

# Regressiere für jede Species die Länge des Schnabels (Bill!) auf die Länge der Schwimmflossen (flipper!) und Kontrolliere für Jahr und Geschlecht
# Haben Pinguine mit langen Schwimmflossen einen Größeren?
# Tipp: lm(abhängig ~ unabhängig + unabhängig + kontroll + kontroll)

# Lass die Kontrollvariable für da Jahr weg. Merkst du einen großen Unterschied? Was heißt das?

# Schaue dir die Hilfe für ?lm() an. Gäbe es eine Möglichkeit, auch hier die NAs auszuschließen? (Wir haben ja bereits oben gefiltert)