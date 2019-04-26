## Project: Exploration of Aviation Analytics Data.
## Purpose: Explorating GE Engine Data.
## Created By:  RWS
## Created Date:  4-26-2019

databank_ge <- databank %>%
  filter(Manufacturer == "GE")

databank_ge %>% count(ID) %>% print(n = Inf)

# I want to subset the GE-90 aircraft engine.

databank_ge_ge90 <- databank_ge %>%
  filter(grepl("GE90", ID)) %>% print(n = Inf)
