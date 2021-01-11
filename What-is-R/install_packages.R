### install packages ###

# install pacman package if not installed -----------------------------------------------
suppressWarnings(if (!require("pacman")) install.packages("pacman"))

# load packages and install if not installed --------------------------------------------
pacman::p_load(tidyverse, broom,
               install = TRUE,
               update = FALSE)

# show loaded packages ------------------------------------------------------------------
cat("loaded packages\n")
print(pacman::p_loaded())
