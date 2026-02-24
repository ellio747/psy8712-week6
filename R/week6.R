# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
# library()
# library()
# library()

# Data Import
citations <- stri_read_lines("../data/cites.txt")