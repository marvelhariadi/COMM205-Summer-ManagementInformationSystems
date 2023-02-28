library(tidyverse)
companies <-readRDS("~/Desktop/COMM205/North American Stock Market 1994-2018.rds")

q1 <- companies %>%
  filter(fyear >= 2016, fyear <= 2017, at >= 10, sale >= 10) %>%
  select(gvkey, fyear, conm, at, sale)

q2 <- companies %>%
  filter(fyear >= 2017, fyear <= 2018, at >= 100, sale >= 100) %>%
  select(gvkey, fyear, tic, ni)

q12 <-  inner_join(q1, q2, by = c("gvkey", "fyear"))
q12noNA <-  na.omit(q12)

q3 <- companies %>%
  filter(at >= 50, sale >= 50, !is.na(emp), !is.na(ni)) %>%
  mutate(gvkey, ROA = ni/at) %>%
  group_by(gvkey) %>%
  summarise(ROA_avg = mean(ROA)) # why can't put gvkey here?

q5 <- companies %>%
  filter(fyear >= 1994, fyear <= 2018, !is.na(emp)) %>%
  group_by(gvkey) %>%
  summarise(emp_avg = mean(emp)) # why can't put gvkey here?

q3and5 <- inner_join(q3, q5)
