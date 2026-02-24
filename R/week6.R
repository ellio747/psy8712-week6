# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)
# library()
# library()

# Data Import
citations <- stri_read_lines("../data/cites.txt")
citations_txt <- str_subset(citations, pattern = "\\S")
cat("The number of blank lines eliminated was", length(citations) - length(citations_txt))
str_c("The average number of characters/citation was", mean(str_count(citations)))

# Data Cleaning