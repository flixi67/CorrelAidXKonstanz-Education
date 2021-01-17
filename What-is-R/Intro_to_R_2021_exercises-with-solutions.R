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

# Übung 2 ----------------------------------------------------------------------
# Übungsdaten installieren (Pinguine!!!)
install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)
penguins <- penguins
# Benutze die Funktionen head() und View() um dir einen Überblick über die Daten zu verschaffen
head(penguins)
View(penguins)
glimpse(penguins) # Bonus
str(penguins) # Bonus
names(penguins) # Bonus

# Reduziere das Datenset auf die uns interessierenden Variablen "sex", "flipper_length_mm", "year", "bill_length_mm" und "species"
# Lösche Beobachtungen heraus, die bei einer der Variablen "NA", alo unbekannt, angegeben hat.
smol_penguins <- penguins %>%
  select(flipper_length_mm, sex, year, bill_length_mm, species) %>%
  filter(sex != "NA", year != "NA", bill_length_mm != "NA", species != "NA", flipper_length_mm != "NA")

more_smol_penguins <- penguins %>%
  select(flipper_length_mm, sex, year, bill_length_mm, species) %>%
  filter(!is.na(sex), !is.na(year), !is.na(bill_length_mm), !is.na(species), !is.na(flipper_length_mm))

even_more_smol_penguins <- penguins %>%
  select(flipper_length_mm, sex, year, bill_length_mm, species) %>%
  drop_na() # Bonus: tidyr offers a function for this

# Check ob NAs da
which(is.na(penguins))
which(is.na(smol_penguins)) # Yay alle NAs weg

# Regressiere für jede Species die Länge des Schnabels (Bill!) auf die Länge der Schwimmflossen (flipper!) und Kontrolliere für Jahr und Geschlecht
# Haben Pinguine mit langen Schwimmflossen einen Größeren?
# Tipp: lm(abhängig ~ unabhängig + unabhängig + kontroll + kontroll)
smol_penguins %>%
  filter(species == "Adelie") %>%
  lm(bill_length_mm ~ flipper_length_mm + year + sex, data = .) %>% # wir müssen angeben, wo wir das Datenset aus der Pipe angeben (mit dem .)
  summary()                                                         # normalerweise wird das Argument als erstes in die Funktion weitergegeben

smol_penguins %>%
  filter(species == "Gentoo") %>%
  lm(bill_length_mm ~ flipper_length_mm + year + sex, data = .) %>%
  summary() 

smol_penguins %>%
  filter(species == "Chinstrap") %>%
  lm(bill_length_mm ~ flipper_length_mm + year + sex, data = .) %>%
  summary() 

# Die Arten unterscheiden sich! Bei Gentoo Pinguinen ist der Zusammenhang am größten und signifikantesten!
# Für jeden Millimeter mehr Flosse haben die Gentoo Pinguine 0,18mm mehr Schnabel
# Bei allen Sorten haben Männchen zw. 2 undd 3mm mehr Schnabel als Weibchen.


# Lass die Kontrollvariable für da Jahr weg. Merkst du einen großen Unterschied? Was heißt das?
smol_penguins %>%
  filter(species == "Gentoo") %>%
  lm(bill_length_mm ~ flipper_length_mm + sex, data = .) %>%
  summary() 
# Der Unterschied ist gering, aber vorhanden. Unsere Pinguin-Theorie müsste uns sagen, ob wir auf das Jahr kontrollieren!

# Schaue dir die Hilfe für ?lm() an. Gäbe es eine Möglichkeit, auch hier die NAs auszuschließen? (Wir haben ja bereits oben gefiltert)
?lm()
# Standardmäßig lässt lm() die NAs weg (nachzulesen unter Arguments > na.action), da es eine globale Option ist, die man auch ändenr kann, lieber NAs rausfiltern =)