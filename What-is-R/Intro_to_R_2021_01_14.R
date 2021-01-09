## ---------------------------
##
## Script name: CorrelAid-X_Konstanz_Education
##
## Purpose of script: Script to show basic usage of R
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

# 