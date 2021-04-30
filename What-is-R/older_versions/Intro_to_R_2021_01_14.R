## ---------------------------
##
## Script name: CorrelAid-X_Konstanz_Education
##
## Purpose of script: Script to show basic usage of R
##
## Author: Philipp Bosch & Felix Kube
##
## Date Created: 2021-01-09
##
## Email: konstanz@correlaid.de
##
## ---------------------------
##
## Notes:
## - Einführung in Verzeichnisse, beim Daten runterladen und in R einspielen automatisch weitere Ordner erstellen
## - diese dann wieder mit dir() zeigen/ oder in Windows
##
## ---------------------------



# R-Projekte, working directory und Pfade ----------------------------------

getwd() # zeigt unser aktuelles Verzeichnis (bei R-Projekten automatisch Verzeichnis, in dem das R-Projekt liegt)
        # was hier zurück kommt, nennen wir einen absoluten Pfad (fängt mit C:/ an)
        # Absolute Pfade sehen auf jedem Computer anders aus!!!
dir()   # zeigt Dateien im Verzeichnis
dir.create(paste0(getwd(), "/data")) # Unterordner "data" erstellen
write.csv(my_number_list, file = "data/numbers.csv") # das Objekt "integers" als Datei exportieren

dir("data")  # die Funktion dir() nimmt einen relativen Pfad, der auf dem aktuellen Arbeitsverzeichnis aufbaut
              # dadurch ist es unabhängig vom Computer, auf dem man es ausführt
              # um reproduzierbare Skripte zu produzieren, sollte man auf absolute Pfade verzichten
read.csv("data/integers.csv") # wir können den geschriebenen file auch wieder einlesen

# packages - mehr Funktionalität --------------------------------------------
# install.packages("readr") # Installieren von R packages über einen Befehl, besser aber unter Tools -> Install packages
library(readr) # packages muss man in jeder Sitzung neu laden, am besten zu Beginn des Skripts
?readr::read_csv() # das package "readr" bietet erweiterte funktionen zum laden/schreiben von Daten

# tidyverse - abgestimmtes set an packages ----------------------------------
install.packages("tidyverse") # installiert eine Anzahl an packages, die alle aufeinander abgestimmt sind
library(tidyverse) # laden der einzelnen packages


# Laden von Daten ---------------------------------------------------------
# Daten können in allen möglichen Formaten abgespeichert werden. Viele Datensätze
# stammen auch heutzutage noch aus Excel-Tabellen. Ein Format mit dem sowohl Excel
# als auch R gut arbeiten können ist .csv (comma-seperated values)

vote_konstanz_2016 <- readr::read_delim(file = "data/LTW_2016_Konstanz_Stadtteile.csv",
                delim = ";", escape_double = FALSE, trim_ws = TRUE) 
# read delim ist eine generalisierte version von read_csv

# Um einen Überblick zu bekommen, hilft es sich die Daten anzusehen

View(vote_konstanz_2016) # auch durch klicken auf Objekt im Environment möglich!
                         # Vorsicht, kann bei großen Datensätzen problematisch sein!!

glimpse(vote_konstanz_2016) # tidy erste Übersicht
head(vote_konstanz_2016) # base erste Übersicht

# dplyr - select ----------------------------------------------------------
# Vergleich base R

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

clean_vote_konstanz_2016 <- select(vote_konstanz_2016,
                                   c(Wahl, Datum, ags, Stadtteil_Nr,
                                     Stadtteil, Wahlbezirk_Nr, Wahlbezirk_Name,
                                     Wahlberechtigte_insgesamt, `gültige Stimmen insgesamt`,
                                     `Wahlbeteiligung in Prozent`),
                                   starts_with("D")) # Innerhalb von select können Funktionen übergeben werden!

# Eine Variable zu viel - negieren von select

clean_vote_konstanz_2016 <- select(clean_vote_konstanz_2016, -ags) # - schließt die Variable aus


# dplyr - filter ----------------------------------------------------------
# Vergleich base R

# Nun haben wir uns auf die interessanten Variablen beschränkt. Filter hilft uns
# nun Reihen zu filtern

filter(clean_vote_konstanz_2016, Stadtteil == "Briefwahl") # nur Briefwahl

filter(clean_vote_konstanz_2016, Stadtteil != "Briefwahl") # keine Briefwahl

clean_vote_konstanz_2016 <- filter(clean_vote_konstanz_2016, Stadtteil != "Briefwahl")

# Filter ist sehr flexibel und mächtig!

# Alle Beobachtungen mit über 800 Wahlberechtigten
filter(clean_vote_konstanz_2016, Wahlberechtigte_insgesamt > 800)


# Bestimmte Stadtteile selektieren
filter(clean_vote_konstanz_2016, Stadtteil == 'Altstadt' | Stadtteil == 'Petershausen-West' |
         Stadtteil == 'Staad')

# Elegantere Lösung (!!! Error in inital script !!!)
filter(clean_vote_konstanz_2016, Stadtteil %in% c('Altstadt', 'Petershausen-West', 'Staad'))


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

# Bei genauerem Hinsehen bemerken wir einen Fehler in der Variable 'Wahlbeteiligung in Prozent'
# Mutate hilft uns neue Variablen auf Basis von gegebenen Variablen zu erstellen 

clean_vote_konstanz_2016 %>% 
  mutate(vote_percentage = `Wahlbeteiligung in Prozent` / 10) %>% 
  select(vote_percentage)

# Beachte: Ohne Zuweisung wieder kein speichern der neuen Variablen!

clean_vote_konstanz_2016 <- clean_vote_konstanz_2016 %>% 
                              mutate(vote_percentage = `Wahlbeteiligung in Prozent` / 10) %>% 
                              select(-`Wahlbeteiligung in Prozent`)


# case_when kann sehr nützlich sein, wenn man Aufgrund von verschiedenen Konditionen
# neue Variablen befüllen möchte
# Vor der Tilde steht die Bedingung, dahinter der gewünschte Wert der neuen Variable


clean_vote_konstanz_2016 %>% 
  mutate(hood_names = case_when( # neue Variable heißt hood_names
    Stadtteil %in% "Litzelstetten" ~ "Outback", 
    Stadtteil %in% "Dingelsdorf" ~ "Not even close",
    Stadtteil %in% "Dettingen" ~ "These people vote?!",
    TRUE ~ Stadtteil # Übernehme für alle anderen Observations einfach Wert von Stadtteil
  )) %>% View()


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




# Joinen der Datensätze ---------------------------------------------------

# Oftmals müssen wir Informationen aus verschiedenen Quellen kombinieren um Forschung zu betreiben
# und insights zu generieren. Daher müssen wir lernen, wie wir verschiedene Datensätze miteinander 
# verbinden können.

# Hier fragen wir uns beispielsweise, was mögliche Hintergründe der Wahl von bestimmten Parteien sind
# Also suchen wir uns doch nach weiteren Informationen zu Konstanzer Stadtteilen

# Wir können auch direkt Daten aus dem Internet einlesen 
# Dafür übergeben wir als Dateipfad eine URL
kita_kn <- read_delim("https://offenedaten-konstanz.de/sites/default/files/Kinderbetreuung%20nach%20Stadtteile%20M%C3%A4rz%202017.csv",
           delim = ";")

# Blick in die Daten zeigt einen Fehler in den Stadteilnamen
# Dieses Mal wollen wir den Weg von Base R gehen

kita_kn$STADTTEIL[8] <- "Fürstenberg" # Element in der achten Reihe der Variablen STADTTEIL wird überschrieben
kita_kn$STADTTEIL[5] <- "Königsbau"

# Wozu das ganze? 
# Wir wollen die Information über KITAS zu den Wahldaten hinzufügen. Dafür brauchen 
# wir einen "Schlüssel" in beiden Datensätzen. Also eine Variable die zwischen den
# Datensätzen matchen kann. Diese Variable ist STADTTEIL (und Stadtteilnummer). 

# Die Kombination von zwei Datensätzen heißt join. Dazu gibt es verschiedene 
# Funktionen. Wir nutzen hier left_join() von dplyr

clean_vote_konstanz_2016 %>% 
  left_join(kita_kn, by = c("Stadtteil" = "STADTTEIL")) %>% View()

# Sinnvollerweiße kombinieren wir aber unsere oben schon aufbereiteten Daten mit
# den Kita Daten

# Erstellen eines neuen Datensatzes
kn_vote <- clean_vote_konstanz_2016 %>% 
  group_by(Stadtteil) %>% 
  summarise(obs = n(), # Anzahl der Beobachtungen pro Gruppe (Wahlbezirke pro Stadtteil)
            CDU_average = mean(percentage_cdu), # Mittelwert über Wahlbezirkte im Stadtteil
            Green_average = mean(percentage_greens),
            AFD_average = mean(percentage_afd),
            vote_pop = sum(Wahlberechtigte_insgesamt))

# Kombination von vote und Kita Daten

kn_analyze <- kn_vote %>% 
                left_join(kita_kn, by = c("Stadtteil" = "STADTTEIL"))

# Erstellen einer neuen Variablen KITA_GESAMT und einer Variable die Anteil an
# Wahlbevölkerung zeigt. Außerdem hat Staad keinerlei Kitaplätze, deshalb entfernen wir
# die Beobachtung

kn_analyze %>% 
  mutate(kita_gesamt = KITA_unter3 + KITA_3bis6 + KITA_SCHULKIND,
         kita_prob = kita_gesamt/vote_pop) %>% 
  filter(Stadtteil != "Staad")-> kn_analyze


# Regressionen mit dem broom package --------------------------------------

# Wir alle sind natürlich nicht umsonst durch Susumus Schule gegangen. 
# We want some regression!!

# Vielleicht könnten wir ja die Wahl der Grünen im Stadtbezirk mit der Anzahl an
# Kitaplätzen im selben Stadtbezirk erklären

# Please don't do this at home. Regression mit 14 Beobachtungen ist großer Schwachsinn und Teufelszeug!


# Um einfach regression zu rechnen brauchen wir kein zusätzliches Package

summary(lm(formula = Green_average ~ kita_prob, data = kn_analyze))
summary(lm(formula = AFD_average ~ kita_prob, data = kn_analyze))

lm(formula = AFD_average ~ kita_prob, data = kn_analyze) %>% 
  broom::tidy()
