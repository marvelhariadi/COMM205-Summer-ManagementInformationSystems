library(tidyverse)
companies <- readRDS("~/Desktop/COMM205/North American Stock Market 1994-2018.rds")

#what was Amazon's average cash holdings in the dataset?
#This will display the answer directly in the console
companies %>%
  filter(tic == "AMZN") %>%
  summarise(average_ch = mean(ch, na.rm = TRUE)) #note: what does na.rm do again?

#REMINDER: na.rm = TRUE means "no RA. disregard NAs)

#View command
View(companies)

#The group_by() function:
#reorders data based on specified variables. All future operations will apply in groups. Useful for means and mediums.
companies_w_avg_ch <- companies %>%
  group_by(gvkey) %>%
  mutate(cash_avg = mean(ch, na.rm = TRUE)) %>%  #condensing the variable manifestation here
  select(gvkey, fyear, conm, ch, cash_avg)

#summarise by itself squishes everything into a single value:
gvkey_cash_avg <-  companies %>%
group_by(gvkey) %>% #without this here, it outputs a single cell table
  summarize(cash_avg = mean(ch, na.rm = TRUE)) #this by itself outputs a single cell table

#here we use mutate()
median_emp <- companies %>%
  group_by(gvkey) %>%
  mutate(emp_med = median(emp, na.rm = TRUE), #this is a single funct. so mutates BOTH emp_med and emp_avg. 
         emp_avg = mean(emp, na.rm = TRUE)) %>%
  select(gvkey, conm, fyear, emp, emp_med, emp_avg)

#version with summarize()
median_emp_2 <- companies %>%
  group_by(gvkey) %>%
  summarize(emp_med = median(emp, na.rm = TRUE), #this is a single funct. so mutates BOTH emp_med and emp_avg. 
            emp_avg = mean(emp, na.rm = TRUE),
            conm) #mutates emp_med and emp_avg and simultaneously only shows emp_med and emp_avg variable columns

#group_by() with two variables
#group by BOTH industry and year
at_summary <-  companies %>% 
  filter(!is.na(naicsh), !is.na(fyear)) %>%  #note: remember that is.na() returns [a series] of TRUE if the value(s) are NA.   #so !is.na shows us the values that are NOT NA. ie. are filled
  select(gvkey, conm, fyear)

at_summary_2 <-  companies %>% 
  filter(!is.na(naicsh), !is.na(fyear)) %>%  #note: remember that is.na() returns [a series] of TRUE if the value(s) are NA.   #so !is.na shows us the values that are NOT NA. ie. are filled
  group_by(naicsh, fyear) %>%
  summarise(
  min_at = min(at, na.rm = TRUE),
  avg_at = mean(at, na.rm = TRUE),
  max_at = max(at, na.rm = TRUE))

#if summarize follows group_by, it will output all variables in group by AND in summarize (if relevant)

#arrange() funct lets you order the dataset
#in this example we are ordering low to high. Within each year we are going to arrange by cash in ascending order (high to low).
#note that the default sort order is ascending (low to high) unless stated otherwise in the function
ordered  = companies %>%
  filter(!is.na(fyear), !is.na(ch)) %>%
  arrange(fyear, desc(ch)) %>% #!!!!
  select(fyear, ch, gvkey, conm)

#IN CLASS EXERCISE 12 & 13
Q12.1 <- companies %>%
  group_by(fyear) %>%
  summarize( median(at, na.rm = TRUE))

Q12.2 <- companies %>%
  filter(at>100)

length(Q12.2$at)

Q12.3 <- companies %>%
  #group_by(gvkey)  %>%
  filter(at>100, sale>100, na.rm = TRUE, loc == "USA") %>%
  mutate(gvkey = !duplicated(gvkey))

#length(Q12.3$gvkey)  

Q12.3NoFalse <- Q12.3 %>%
  filter(gvkey == TRUE)

length(Q12.3NoFalse$gvkey)

#Q13.1
new_dataset <-companies %>%
  filter(!is.na(fyear), !is.na(loc), !is.na(sale)) %>%
  group_by(fyear, loc) %>%
  summarise(max_sale = max(sale))
 
