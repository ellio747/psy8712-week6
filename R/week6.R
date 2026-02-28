# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)
# library()
# library()

# Data Import
citations <- stri_read_lines("../data/cites.txt")
citations_txt <- str_subset(citations, pattern = "\\S") # see if you can do stri_isempty()
str_c("The number of blank lines eliminated was ", length(citations) - length(citations_txt))
str_c("The average number of characters/citation was", mean(str_count(citations)))

# Data Cleaning
citations_tbl %>%
  select(cite) %>% 
  slice_sample( n = 20) 
citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>% 
  mutate(authors = str_extract(cite, pattern = "^[^(]+"),
         year = str_extract(cite, pattern = "(?<=\\()\\d{4}(?=\\))"),
         title = str_extract(cite, pattern = "(?<=\\).\\s).+?(?=\\.)"),
         # journal_title = str_extract(cite, pattern = "(?<=\\. )[^.]+(?=, \\d)"),
           # book_title = str_extract(cite, pattern = "\\.\\s*[^:]+:\\s*[^.]+\\.?$"),
           journal_page_start = str_extract(cite, pattern = "(?<=, )\\d+(?=-)"),
           journal_page_end = str_extract(cite, pattern = "(?<=-)\\d+(?=\\.)"),
           book_page_start = str_extract(cite, pattern = "(?<=pp\\. )\\d+(?=-)"),
           book_page_end = str_extract(cite, pattern = "(?<=-)\\d+(?=\\))")
  #          doi = 
  #          perf_ref = 
  #          first_author = str_extract(authors, pattern = )
)
# Analysis



