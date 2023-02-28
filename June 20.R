library(tidyverse)
#Topic: MERGING TABLES

companies <- readRDS("~/Desktop/COMM205/North American Stock Market 1994-2018.rds")

example1 <- companies %>%
  filter(fyear >= 2014 , fyear <= 2016) %>%
  select(gvkey, fyear, conm, ni)

example2 <- companies %>%
  filter(fyear >= 2016, fyear <= 2018) %>%
  select(gvkey, fyear, at, sale)

#these two tables have similar but not the same data elements. Some are the same, some are not

#note: fyear and gvkey need to be selected TOGETHER because they make the key unique identifier.
#Bc there are no repeats of the combos of gvkey and fyear

#merge example1 & example2 using gvkey 

#when not specifying the key variables to conduct the emerge, R will merge (by default) the variables IN COMMON in both data sets.
#In this case, it is gvkey and fyear. 

#merging function: inner_join()
merged1 <- inner_join(example1, example2) #brings example1 & example2 data sets together with no duplicates
#outputs overlapping data

#SPECIFYING the merge variables -- gvkey & fyear -- which results in the same outcome as merged1
merged2 <-inner_join(example1, example2, by = c("gvkey","fyear")) #NOTE FORMAT. THIS IS HOW WE SPECIFY VARS
#THESE ARE THE UNIQUE IDENTIFIERS IN GREEN

#merged1 & merged2 output the overlapping data elements btw example1 & example2

#left_join() keeps all observations from example 1 and then merges matching data values from example 2 to each row
merged3 <-left_join(example1, example2) #has same number of observations as example 1
# bolts the example1 dataset to place
merged4 <-left_join(example2, example1) #has same number of observations as example 2

#doing marges that are not 1-to-1:
#example3: 2016 data with nonmissing historical NAICS codes

example3 <- companies %>%
  filter(fyear == 2016, !is.na(naicsh)) %>%
  select(gvkey, fyear, conm, naicsh)

naics_codes <- readRDS("~/Desktop/COMM205/NAICS_2_6_digit_codes.rds")

#lets merge naisch columb on companies data table with the NAICS column in naics_codes:
merged5 <-  left_join(example3, naics_codes, by = c("naicsh" = "NAICS")) #c("naicsh" = "NAICS") makes NAICS from naics_codes equivalent to naicsh