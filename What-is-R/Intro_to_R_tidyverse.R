## ---------------------------
##
## Script name: CorrelAid-X_Konstanz_Education
##
## Purpose of script: Script to show basic usage of R
##
## Author: Philipp Bosch & Felix Kube
##
## Date Created: 28-04-2021
##
## Email: konstanz@correlaid.de
##
## ---------------------------

# R-Projekte, working directory und Pfade ----------------------------------

getwd() # zeigt unser aktuelles Verzeichnis (bei R-Projekten automatisch Verzeichnis, in dem das R-Projekt liegt)
# was hier zurück kommt, nennen wir einen absoluten Pfad (fängt mit C:/ an)
# Absolute Pfade sehen auf jedem Computer anders aus!!!
dir()   # zeigt Dateien im Verzeichnis


# packages - mehr Funktionalität --------------------------------------------
# install.packages("readr") # Installieren von R packages über einen Befehl, besser aber unter Tools -> Install packages
library(readr) # packages muss man in jeder Sitzung neu laden, am besten zu Beginn des Skripts
?readr::read_csv() # das package "readr" bietet erweiterte funktionen zum laden/schreiben von Daten

# tidyverse - abgestimmtes set an packages ----------------------------------
install.packages("tidyverse") # installiert eine Anzahl an packages, die alle aufeinander abgestimmt sind
library(tidyverse) # laden der einzelnen packages

# Um direkt mehrere Packages zu laden haben wir euch ein Skript vorbereitet

source(file = "install_packages.R") # source spielt einfach das komplette Skript ab


# Laden von Daten ---------------------------------------------------------
# Daten können in allen möglichen Formaten abgespeichert werden. Viele Datensätze
# stammen auch heutzutage noch aus Excel-Tabellen. Ein Format mit dem sowohl Excel
# als auch R gut arbeiten können ist .csv (comma-seperated values)

vote_konstanz_2016 <- readr::read_csv("data/LTW_2016_Konstanz_Stadtteile.csv")
# read delim ist eine generalisierte version von read_csv

# Um einen Überblick zu bekommen, hilft es sich die Daten anzusehen

View(vote_konstanz_2016) # auch durch klicken auf Objekt im Environment möglich!
# Vorsicht, kann bei großen Datensätzen problematisch sein!!

glimpse(vote_konstanz_2016) # tidy erste Übersicht
head(vote_konstanz_2016) # base erste Übersicht


# dplyr - select ----------------------------------------------------------

# Für ein besseres Handling empfiehlt es sich, den Datensatz auf relevante
# Variablen zu beschränken. Dies geschieht bei dplyr mit 'select()'

select(vote_konstanz_2016, Stadtteil) # wähle nur die Variable 'Stadtteil'
select(vote_konstanz_2016, Stadtteil, Wahlbezirk_Name) # funktioniert auch mit mehreren Variablen

# Einwurf base R:
# Auswählen von einzelnen Variablen mit base R erfolgt über das Dollar Sign '$'
# Oder eckige Klammern
vote_konstanz_2016$Wahl
vote_konstanz_2016[1]

# Beachte! Ohne eine Zuweisung (<-) kreieren wir nichts neues / ändert sich nichts!

# Beschränken wir nun den Datensatz auf die wichtigsten Variablen

select(vote_konstanz_2016, Wahl, Datum, ags, Stadtteil_Nr,
                            Stadtteil, Wahlbezirk_Nr, Wahlbezirk_Name,
                            Wahlberechtigte_insgesamt, `gültige Stimmen insgesamt`,
                            `Wahlbeteiligung in Prozent`,
                            starts_with("D")) # Innerhalb von select können Funktionen übergeben werden!

# Negation von einzelnen Variablen ist auch oft nützlich

select(vote_konstanz_2016, -ags) # - schließt die Variable aus


# dplyr - filter ----------------------------------------------------------
# Vergleich base R

# Nun haben wir uns auf die interessanten Variablen beschränkt. Filter hilft uns
# nun Reihen zu filtern

filter(vote_konstanz_2016, Stadtteil == "Briefwahl") # nur Briefwahl

filter(vote_konstanz_2016, Stadtteil != "Briefwahl") # keine Briefwahl



# Filter ist sehr flexibel und mächtig!

# Alle Beobachtungen mit über 800 Wahlberechtigten
filter(vote_konstanz_2016, Wahlberechtigte_insgesamt > 800)


# Bestimmte Stadtteile selektieren
filter(vote_konstanz_2016, Stadtteil == 'Altstadt' | Stadtteil == 'Petershausen-West' |
         Stadtteil == 'Staad')

# Elegantere Lösung 
filter(vote_konstanz_2016, Stadtteil %in% c('Altstadt', 'Petershausen-West', 'Staad'))




# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Beschränke den Datensatz 'vote_konstanz_2016' auf die Variablen 'Wahl', 'Stadtteil_Nr', 'Stadtteil',
# 'Wahlberechtigte_insgesamt' und 'ags' und weise das Ergebnis dem Objekt 'small_dataframe' zu

small_dataframe <- select("XXX", Wahl, "XXX", "XXX", Wahlberechtigte_insgesamt, "XXX")

# Lösche die Variable 'ags' aus dem soeben erstellten Datensatz

small_dataframe <- select("XXX", -"XXX")

# Filtere 'small_dataframe' und zeige keine Briefwahlstimmen an

filter(small_dataframe, "XXX") # keine Briefwahl

# Filtere 'small_dataframe' und zeige nur Wahlbezirke mit weniger als 1000 Wahl-
# berechtigten an

filter("XXX", Wahlberechtigte_insgesamt "XXX")

# Filtere 'small_dataframe' und behalte nur die Stadteile 'Altstadt', 'Paradies'
# und 'Königsbau'

filter(small_dataframe, Stadtteil == "XXX" | Stadtteil == "XXX" | Stadtteil "XXX")

##  /\_/\
## ( o.o )
##  > ^ <


# Select and filter in action ---------------------------------------------

clean_vote_konstanz_2016 <- select(vote_konstanz_2016,
                                   Wahl, Datum, Stadtteil_Nr,
                                   Stadtteil, Wahlbezirk_Nr, Wahlbezirk_Name,
                                   Wahlberechtigte_insgesamt, `gültige Stimmen insgesamt`,
                                   `Wahlbeteiligung in Prozent`,
                                   starts_with("D"), starts_with("KITA")) 

clean_vote_konstanz_2016 <- filter(clean_vote_konstanz_2016, Stadtteil != "Briefwahl")


# der Pipe Operator %>% ---------------------------------------------------
# Vergleich base R

# Die Pipe ermöglicht es uns schnelleren und eleganteren Code zu schreiben
# Stammt aus dem magrittr Package und wird mit dem tidyverse geladen

# Variante 1 
summary(select(head(clean_vote_konstanz_2016), Stadtteil, D1_CDU, Wahlberechtigte_insgesamt))

# Variante 2 
head_1 <- head(clean_vote_konstanz_2016)
head_2 <- select(head_1, Stadtteil, D1_CDU, Wahlberechtigte_insgesamt)
summary(head_2)

# Variante 3 
clean_vote_konstanz_2016 %>% head() %>% select(Stadtteil, D1_CDU, Wahlberechtigte_insgesamt) %>% summary()

# Variante 4 
clean_vote_konstanz_2016 %>%
  head() %>%
  select(Stadtteil, D1_CDU, Wahlberechtigte_insgesamt) %>%
  summary()

# dplyr - mutate ----------------------------------------------------------

# Bei genauerem Hinsehen bemerken wir einen Fehl in der Variable 'Wahlbeteiligung in Prozent'
# Mutate hilft uns neue Variablen auf Basis von gegebenen Variablen zu erstellen 

clean_vote_konstanz_2016 %>% 
  mutate(vote_percentage = `Wahlbeteiligung in Prozent` / 10) %>% 
  select(vote_percentage)

# Beachte: Ohne Zuweisung wieder kein speichern der neuen Variablen!

clean_vote_konstanz_2016 <- clean_vote_konstanz_2016 %>% 
  mutate(vote_percentage = `Wahlbeteiligung in Prozent` / 10) %>% 
  select(-`Wahlbeteiligung in Prozent`)

# Bei einem weiteren Blick in die Daten fällt uns auf, dass wir keine prozentualen
# Stimmenanteile gegeben haben, sondern nur Absolute Anzahl der Stimmen im Wahlbezirk pro Partei
# mutate to the rescue!

clean_vote_konstanz_2016 <- clean_vote_konstanz_2016 %>% 
  mutate(percentage_cdu = (100/`gültige Stimmen insgesamt`) * D1_CDU,
         percentage_greens = (100/`gültige Stimmen insgesamt`) * D2_GRÜNE,
         percentage_afd = (100/`gültige Stimmen insgesamt`) * D15_AfD)



# dplyr - group_by --------------------------------------------------------

# oftmals möchten wir Analysen für bestimme Subgruppen durchführen. Dabei hilft uns
# group_by
# kombinieren wir group_by mit summarise() erhalten wir einen neuen aggregierten Datensatz
# Hier erhalten wir die Anzahl der Wahlbezirke pro Stadtteil und den Mittelwert der Parteien im Stadtteil

clean_vote_konstanz_2016 %>% 
  group_by(Stadtteil) %>% 
  summarise(obs = n(), # Anzahl der Beobachtungen pro Gruppe (Wahlbezirke pro Stadtteil)
            CDU_average = mean(percentage_cdu), # Mittelwert über Wahlbezirkte im Stadtteil
            Green_average = mean(percentage_greens),
            AFD_average = mean(percentage_afd),
            vote_pop = sum(Wahlberechtigte_insgesamt)) %>% 
  arrange(desc(AFD_average)) # ohne desc wäre die Liste aufsteigend



# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Erstelle für die SPD, die FDP und die LINKE jeweils eine Variable welche die
# prozentualen Stimmenanteile zeigt und füge diese 'clean_vote_konstanz_2016' hinzu

clean_vote_konstanz_2016 <- clean_vote_konstanz_2016 %>% 
                              mutate(percentage_spd = ("XXX"/`gültige Stimmen insgesamt`) * D3_SPD,
                                     percentage_fdp = (100/"XXX") * "XXX",
                                     percentage_linke = ("XXX"/"XXX")* "XXX")


# Verwende dein Ergebnis von oben um herauszufinden, in welchem Stadtteil die
# SPD prozentual die meisten Stimmen erreicht hat (nutze dafür den Pipe Operator
# oder speichere dein Ergebnis von oben in einem Objekt)

"XXX" %>% 
  group_by("XXX") %>% 
  summarise(obs = n(),
            SPD_average = mean("XXX")) %>% 
  arrange(desc("XXX"))

# Erstelle eine neue Variable 'Kita_gesamt' welche die Summe an Kitaplätzen 
# für jede Observation/Reihe enthält
# Auf Basis dieser neuen Variable, berechne mit group_by wie viele Kitaplätze
# es pro Stadtviertel gibt

clean_vote_konstanz_2016 %>% 
  mutate(kita_gesamt = "XXX" + "XXX" + "XXX") %>% 
  group_by(Stadtteil) %>% 
  summarise(kita_pro_Stadtteil = mean("XXX"))


##  /\_/\
## ( o.o )
##  > ^ <



# mutate & group_by in action ---------------------------------------------


clean_vote_konstanz_2016 %>% 
  mutate(kita_gesamt = KITA_SCHULKIND + KITA_unter3 + KITA_3bis6) %>% 
  group_by(Stadtteil) %>% 
  summarise(kita = mean(kita_gesamt),
            CDU_average = mean(percentage_cdu),
            Green_average = mean(percentage_greens),
            AFD_average = mean(percentage_afd),
            Linke_average = mean(percentage_linke),
            SPD_average = mean(percentage_spd),
            FDP_average = mean(percentage_fdp),
            vote_pop = sum(Wahlberechtigte_insgesamt),
            kita_prop = kita/vote_pop)


# Dieser Datensatz enthält jetzt einige Informationen die nützlich sein könnten.
# Deshalb speichern wir ihn in einem neuen Objekt ab

kn_analyze <- clean_vote_konstanz_2016 %>% 
  mutate(kita_gesamt = KITA_SCHULKIND + KITA_unter3 + KITA_3bis6) %>% 
  group_by(Stadtteil) %>% 
  summarise(kita = mean(kita_gesamt),
            CDU_average = mean(percentage_cdu),
            Green_average = mean(percentage_greens),
            AFD_average = mean(percentage_afd),
            #Linke_average = mean(percentage_linke),
            #SPD_average = mean(percentage_spd),
            #FDP_average = mean(percentage_fdp),
            vote_pop = sum(Wahlberechtigte_insgesamt),
            kita_prop = kita/vote_pop) %>% 
  filter(Stadtteil != "Staad")

# Regressionen mit dem broom package --------------------------------------

# Wir alle sind natürlich nicht umsonst durch Susumus Schule gegangen. 
# We want some regression!!

# Vielleicht könnten wir ja die Wahl der Grünen im Stadtbezirk mit der Anzahl an
# Kitaplätzen im selben Stadtbezirk erklären

# Please don't do this at home. Regression mit 14 Beobachtungen ist großer Schwachsinn und Teufelszeug!


# Um einfach regression zu rechnen brauchen wir kein zusätzliches Package

summary(lm(formula = Green_average ~ kita_prop, data = kn_analyze))
summary(lm(formula = AFD_average ~ kita_prop, data = kn_analyze))

# Falls wir jedoch die Ergebnisse der Regression schön abspeichern wollen,
# sollten wir das 'broom' package benutzen

lm(formula = AFD_average ~ kita_prop, data = kn_analyze) %>% 
  broom::tidy()


# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Erstelle deine erste eigene Regression! Nutze dabei als abhängige Variable
# das SPD Wahlergebnis und als unabhängige Variable die Anzahl an Kitaplätzen 
# je Wahlberechtigtem ('kita_prop')

lm(formula = "XXX" ~ kita_prop, data = "XXX") %>% 
  summary()

# tausche nun die abhängie Variable und schau dir den Effekt von kita_prob auf
# den Anteil der FDP-Stimmen an

lm(formula = "XXX" ~ "XXX", data = "XXX") %>% 
  summary()

##  /\_/\
## ( o.o )
##  > ^ <