# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(stringi)
library(tidyverse)
# library()
# library()

# Data Import
citations <- stri_read_lines("../data/cites.txt", encoding = "Windows-1252")
citations_txt <- str_subset(citations, pattern = "\\S") # could have used something like this too: citations[!stri_isempty(citations)]
str_c("The number of blank lines eliminated was ", length(citations) - length(citations_txt)) # sum(stri_isempty(citations)) = 16
str_c("The average number of characters/citation was", mean(str_length(citations_txt))) # I noticed that the assignment called for no space after "...was"

# Data Cleaning
citations_tbl %>%
  slice_sample(n = 20) 
citations_tbl <- tibble(line = seq_along(citations_txt), cite = citations_txt) %>% 
  mutate(authors = str_extract(cite, pattern = "^\\*?([^(]+)"),
         year = str_extract(cite, pattern = "(?<=\\()\\d{4}[a-z]?(?=\\))"),
         title = str_extract(cite, pattern = "(?<=\\)\\.\\s).+?(?=\\.\\s[A-Z])"),
         journal_title = str_extract(cite, pattern = "(?<=\\.\\s)([^.]+)(?=,\\s\\d+,)"),
         book_title = str_match(cite, pattern = "In\\s.+?\\(Ed\\.?s?\\.?\\),\\s(.+?)\\s\\(")[,2],
         journal_page_start = str_extract(cite, pattern = "(?<=,\\s)\\d+(?=[-?])"),
         journal_page_end = str_extract(cite, pattern = "(?<=[-?])\\d+(?=\\.(?!\\n))"),
         book_page_start = str_extract(cite, pattern = "(?<=pp\\.)[\\s]?[\\divx]+(?=[-?])"),
         book_page_end = str_extract(cite, pattern = "(?<=[-?])[\\divx]+(?=\\))"),
         doi = str_extract(cite, pattern = "(?<=doi:).*$"),
         perf_ref = str_detect(title, pattern = "Performance|performance"),
         first_author = str_extract(authors, pattern = "^[^,\\s]+,?\\s*[A-Z]\\.?(?:[A-Z]\\.?)*")
  )
# Analysis
citations_tbl %>% 
  summarize(
    cites = n(),
    first_authors = sum(!is.na(first_author)),
    articles = sum(!is.na(journal_title)),
    chapters = sum(!is.na(book_title))
  )



citations_tbl %>% 
  filter(perf_ref, !is.na(journal_title)) %>% 
  count(journal_name = journal_title, name = "frequency") %>% 
  slice_max(frequency, n = 10, with_ties = TRUE) %>% # I included with_ties to account for those citations that went beyond the top 10 in pure counts
  arrange(desc(frequency))


citations_tbl %>% 
  count(citation = cite, name = "frequency") %>% 
  slice_max(frequency, n = 10, with_ties = TRUE) %>%  # I included with_ties to account for those citations that went beyond the top 10 in pure counts
  arrange(desc(frequency))
  
  
