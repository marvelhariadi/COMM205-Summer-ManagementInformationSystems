#na.omit() vs. na.rm
#na.omit() is like a sledgehammer. If there is any NAs in the row, the whole row is thrown away from the data set
#na.rm = TRUE ignores missing values in a row used in //the context of summarise or mutute/.. Temporarily ignores NA values for the purpose of the function running

library(tidyverse)

companies <- readRDS("~/Desktop/COMM205/North American Stock Market 1994-2018.rds")

#two versions:
firm_cash_avg_wSUM <- companies %>%
  group_by(gvkey) %>%
  summarise(cash_avg = mean(ch, na.rm = TRUE)) # do not use with select. mutuate and select go together
  
firm_cash_avg_wMUT <- companies %>%
  group_by(gvkey) %>%
  mutate(cash_avg = mean(ch, na.rm = TRUE)) %>%
  select(gvkey, fyear, conm, ch, cash_avg)
#note that mutate has a lot of companies repeating. different rows for statistics for the same company across years.

#using n()
example <- companies %>%
  group_by(gvkey) %>%
  summarise(years_in_dataset = n()) #counts how many observations by group variable. doesnt need input
#this one outputs the number of years of data recording per company(of which is identified by gvkey)
#this is bc we group_by gvkey

example <- companies %>%
  group_by(gvkey, fyear) %>%
  summarise(years_in_dataset = n()) #each combo of gvkey and fyear returns 1 becasuse gvkey & fyear are the unique identifier variables