library(tidyverse)
companies <- readRDS("~/Desktop/COMM205/North American Stock Market 1994-2018.rds")

#Q1 ----
q1 <- companies %>%
  filter(!is.na(fyear), !is.na(conm), !is.na(at) | loc=="USA") %>%
  arrange(fyear, desc(at), conm) %>%
  select(fyear, conm, at)

#sidenote: for getting non-scientific format for calculations:
99999+1
format(99999+1, scientific = FALSE)

#Q2 ----
q2 <- companies %>%
  filter(!is.na(naicsh), naicsh > 99999) %>%
  select(gvkey, fyear, conm, naicsh)

#THIS IS SUPER WRONG LOL
#q3table1 <-  companies %>%
#  group_by(gvkey) %>%
#  filter(!is.na(naicsh)) %>%
#  select(gvkey, fyear, conm)

#q3table2 <-  companies %>%
#  group_by(gvkey) %>%
#  filter(!is.na(naicsh)) %>%
#  select(gvkey, conm, naicsh)

#q3table3 = inner_join(q3table1, q3table2)

#skipping and coming back to this later
#try again!

#Q3 ----
#anthony's version (wrong)
q3 <- unique(q2$gvkey)
length(q3)

#my version (this one is correct)
q3 <-  q2 %>%
  group_by(gvkey)   %>%
  mutate(meannaicsh = mean(naicsh)) %>%
  filter(naicsh != mean(naicsh)) %>%
  select(gvkey, fyear, conm, naicsh)

q3answer <-  unique(q3$gvkey)
length(q3answer)
 
#Q4 ----
#anthony-marvel hybrid
q4 <- companies %>%
  filter(sale >= 100, at >= 100, naicsh > 99999, !is.na(emp), !is.na(ni), loc == "USA") %>%
  group_by(naicsh, fyear) %>%
  filter(length(unique(gvkey)) >= 3) %>%

#my version messy
q4 <- companies %>% #yeilds same answer as anthony's version
  filter(sale >= 100, at >= 100, naicsh > 99999, !is.na(emp), !is.na(ni), loc == "USA") %>%
# mutate(roa = ni/at,
# industryroamedian = median(ni/at, na.rm = FALSE),
# num_of_firms = n()) %>%
  group_by(naicsh, fyear) %>%
  mutate(num_of_firms = n()) %>% #must come after the group by to work. since group_by will make all future functions apply within groups
  filter(num_of_firms >= 3)

#this si wrong answer
#q5 <- companies %>%
#  filter(sale >= 100, at >= 100, naicsh > 99999, !is.na(emp), !is.na(ni), loc == "USA") %>%
#  mutate(roa = ni/at) %>%
#  group_by(naicsh) %>%
#  mutate(industryroamedian = median(roa, na.rm = FALSE),
#         num_of_firms = n(),
#         fsp = roa - industryroamedian) %>%
#  filter(num_of_firms >= 3, fsp > 0) %>%
#  select(gvkey, fyear, conm, roa, naicsh, industryroamedian, num_of_firms)

#Q5 ----
q5 <- q4 %>%
  group_by(naicsh, fyear) %>%
  mutate(FSP = ni/at - median(ni/at, na.rm = TRUE)) %>%
  filter(FSP > 0)

#Q6 ----
q6 <- q5 %>%
  filter(fyear >= 2012, fyear <= 2018) %>%
  group_by(gvkey) %>%
  filter(length(gvkey) == 7, !duplicated(gvkey))

q6answer <- length(unique(q6$gvkey)) # mustbe unique gvkeys because we are only counting firms
#note that unique() does not work for making new tables. Instead use !duplicated()