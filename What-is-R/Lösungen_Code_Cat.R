### Lösungen für Code Cat ###

# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Erstelle eine Liste, die die folgenden Elemente enthält
# Einen Integer-Vektor mit den Zahlen 0 bis 10
# Einen Numeric Vektor mit deinem Alter, deiner Größe (in m) und der Anzahl deiner Persönlichkeiten
# Einen Charakter-Vektor mit den Worten "Correlaid" "ist" "sau" "cool!"

listy_list <- list(c(0:10), c(22, 1.92, 3), c("Correlaid", "ist", "sau", "cool!"))

# Indiziere (wähle aus) deine Größe und gib sie in cm an

listy_list[[2]][2] * 100

# Berechne, wieviel du pro Lebensjahr gewachsen bist

listy_list[[2]][2] * 100 / listy_list[[2]][1]

# Lass R sagen, dass Correlaid sau cool ist! (Gib den Charakter-Vektor aus)

listy_list[[3]]

# Für Experten: füge der Liste deine Vor- und Nachnamen an

listy_list[[4]] <- c("Marie", "Johanna", "Dübel")

##  /\_/\
## ( o.o )
##  > ^ <

# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Schreibe eine Funktion, die das letzte Element eines Vektors zurückgibt

last <- function(input) {
  return(input[length(input)])
}

# Schreibe eine Funktion, die alle Elemente eines Vektors, die kleiner als der
# Durchschnitt sind, zurückgibt

unterdurchschnittlich <- function(input) {
  kleiner <- input < mean(input)
  return(input[kleiner])
}

##  /\_/\
## ( o.o )
##  > ^ <


# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Beschränke den Datensatz 'vote_konstanz_2016' auf die Variablen 'Wahl', 'Stadtteil_Nr', 'Stadtteil',
# 'Wahlberechtigte_insgesamt' und 'ags' und weise das Ergebnis dem Objekt 'small_dataframe' zu

small_dataframe <- select(vote_konstanz_2016, Wahl, Stadtteil_Nr, Stadtteil, Wahlberechtigte_insgesamt, ags)

# Lösche die Variable 'ags' aus dem soeben erstellten Datensatz

small_dataframe <- select(small_dataframe, -ags)

# Filtere 'small_dataframe' und zeige keine Briefwahlstimmen an

filter(small_dataframe, Stadtteil != "Briefwahl") # keine Briefwahl

# Filtere 'small_dataframe' und zeige nur Wahlbezirke mit weniger als 1000 Wahl-
# berechtigten an

filter(small_dataframe, Wahlberechtigte_insgesamt < 1000)

# Filtere 'small_dataframe' und behalte nur die Stadteile 'Altstadt', 'Paradies'
# und 'Königsbau'

filter(small_dataframe, Stadtteil == "Altstadt" | Stadtteil == "Paradies" | Stadtteil == "Königsbau")

##  /\_/\
## ( o.o )
##  > ^ <

# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Erstelle für die SPD, die FDP und die LINKE jeweils eine Variable welche die
# prozentualen Stimmenanteile zeigt und füge diese 'clean_vote_konstanz_2016' hinzu

clean_vote_konstanz_2016 <- clean_vote_konstanz_2016 %>% 
  mutate(percentage_spd = (100/`gültige Stimmen insgesamt`) * D3_SPD,
         percentage_fdp = (100/`gültige Stimmen insgesamt`) * D4_FDP,
         percentage_linke = (100/`gültige Stimmen insgesamt`)* D5_LINKE)


# Verwende dein Ergebnis von oben um herauszufinden, in welchem Stadtteil die
# SPD prozentual die meisten Stimmen erreicht hat (nutze dafür den Pipe Operator
# oder speichere dein Ergebnis von oben in einem Objekt)

clean_vote_konstanz_2016 %>% 
  group_by(Stadtteil) %>% 
  summarise(obs = n(),
            SPD_average = mean(percentage_spd)) %>% 
  arrange(desc(SPD_average))

# Erstelle eine neue Variable 'Kita_gesamt' welche die Summe an Kitaplätzen 
# für jede Observation/Reihe enthält
# Auf Basis dieser neuen Variable, berechne mit group_by wie viele Kitaplätze
# es pro Stadtviertel gibt

clean_vote_konstanz_2016 %>% 
  mutate(kita_gesamt = KITA_unter3 + KITA_SCHULKIND + KITA_3bis6) %>% 
  group_by(Stadtteil) %>% 
  summarise(kita_pro_Stadtteil = mean(kita_gesamt))


##  /\_/\
## ( o.o )
##  > ^ <


# Code Cat! ---------------------------------------------------------------

##  /\_/\
## ( o.o )
##  > ^ <

# Erstelle deine erste eigene Regression! Nutze dabei als abhängige Variable
# das SPD Wahlergebnis und als unabhängige Variable die Anzahl an Kitaplätzen 
# je Wahlberechtigtem ('kita_prop')

lm(formula = SPD_average ~ kita_prop, data = kn_analyze) %>% 
  summary()

# tausche nun die abhängie Variable und schau dir den Effekt von kita_prob auf
# den Anteil der FDP-Stimmen an

lm(formula = FDP_average ~ kita_prop, data = kn_analyze) %>% 
  summary()

##  /\_/\
## ( o.o )
##  > ^ <