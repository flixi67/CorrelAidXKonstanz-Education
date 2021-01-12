## ---------------------------
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
## ---------------------------
##
## Notes:
##
## ---------------------------

# Übung 1 ----------------------------------------------------------------
# Erstelle einen Charaktervektor mit dem Namen "obst" und den Elementen "banane", "apfel", "traube" und "kiwi"
obst <- c("banane", "apfel", "traube", "kiwi")

# Erstelle einen numerischen Vektor "bewertung" mit den Zahlen 1 bis 10
bewertung <- 1:10

# Ordne die Zahlen im Vektor "bewertung" zufällig neu an und speichere die ersten 4
bewertung <- sample(bewertung, size = 4)

# Füge die beiden Vektoren "obst" und "bewertung" in einer Liste zusammen
liste <- list(obst, bewertung)

# Gib die Elemente der Liste zurück. Welches Obst wurde bei dir am besten bewertet?
liste

# Bonus: Schreibe eine Funktion, die nur das Obst mit der besten Bewertung zurück gibt.
#        Mit der Funktion which.max() kannst du die Position der größten Zahl eines Vektors bestimmen
#        Die Elemente in Listen abzurufen ist etwas tricky. Probiere ruhig etwas rum.
beste_bewertung <- function() {
  index <- which.max(liste[[2]])
  return(liste[[1]][index])
}
beste_bewertung()
