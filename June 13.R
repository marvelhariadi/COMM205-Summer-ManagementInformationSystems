#LOAD LIBRARY
library(tidyverse) #always lload it in everytime you want to make tables and stuff

#[NA]concept: NA is a missing value. All expressions evaluate to NA. Note that "NA" is not the same as NA. Quotes matter
1 + NA #returns NA
NA/3 #returns NA

x <- c(1, 2, 3, 4, NA) #"NA" acts as an empty box. It is a placeholder. 

mean(x) #because there is an "NA", mean(x) returns "NA" Think of it like infinity in math105

#na.rm = TRUE ignores missing values (ie. the NA) and processes as normal. 
mean(x, na.rm = TRUE) #if na.rm = FALSE, then mean(x, na.rm = FALSE) will return NA


#is.na() function tells us whether there are missing values at all 
is.na(x) #returns FALSE FALSE FALSE FALSE TRUE
is.na(NA) #returns TRUE
is.na(4) #returns FALSE

#nesting an is.na() in a sum() lets us know the total number of missing values in a vector
sum(is.na(x)) #returns 1 because there is only 1 NA spot


#DATA WRANGLING YEEHAW

companies <- readRDS("~/Downloads/North American Stock Market 1994-2018.rds") #note the file path
#personal note: try to open that encrypted torrent file of Florence using path knowledge??

#select() extracts certain columns from a table. sELECTS!! columns
#database -> database
#format: filter(DATA TABLE, COLUMN OF CHOICE)
price_yr_end <- select(companies, conm, loc, tic, fyear, prcc_c) #extracts only these 5 columns

#filter() function shows us only the data rows that fit the given parameters. fILTERS OUT everything else
#database -> database
#format: filter(DATA TABLE, CRITERIA, CRITERIA...)
companies_canadian <- filter(companies, loc == "CAN") #remember that == means equivalence
companies_nonUSA <- filter(companies, loc != "USA")  #!= means not equivalent duh
companies_canadian&large <- filter(companies, loc == "CAN", at > 1000) #multiple criteria example

#nesting select with filter:
#database -> database
#the select() needs to be in the data table position, since select() returns a database
companies_Canadian_reduced <- filter(price_yr_end, loc == "CAN") 
companies_Canadian_reduced <- filter(select(companies, conm, loc, tic, fyear, prcc_c), loc == "CAN")

#Pipe operator: %>%
#conjoins functions together. Good format alternative to nesting functions
companies_canadian_v2 <- companies %>% 
  filter(loc == "CAN") %>%
  select(conm, loc, tic, fyear, prcc_c) #do not end with a pipe operator. its like an "AND"
 
#NOTE: to debug -- run one line at at time to identify syntax/functionality errors. stop BEFORE the pipe op if there are any

#mutate() function applies a change to a specific column all rows
companies_canadian_full_cash <- companies %>%
  mutate(full_ch = 1000000*ch) %>% #changes all the data in rows at once in this case: ch value for all rows is multiplied by 1000000
  filter(loc == "CAN" & fyear == 2010 & ch >= 10) %>%
  select(conm, fyear, tic, full_ch, ch)

#adding a variable
companies$samplevar <- 0.3 #adds a new column. So you need to add all the 29484 data tables by hand..or you can automate

#summarize() creates an aggregate statistic over all the data rows 
max_min_cash_Canadian_2010 <- companies %>%
  filter(loc == "CAN" & fyear == 2010) %>%
  summarise(max_cash = max(ch, na.rm = TRUE), #outputs the max and min cash and ignores empties
            min_cash = min(ch, na.rm = TRUE))

#here we output changed numbers directly into console. Not creating a new dataset. We are editing the ori. "companies" dataset:
companies %>% #do i need to make a new database?
  filter(loc == "CAN" & fyear == 2010) %>%
  summarise(max_cash = max(ch, na.rm = TRUE),
            min_cash = min(ch, na.rm = TRUE)) #HELP THIS DOESNT WORK

#rounding numbers
round(2.44243) #returns 2
round(2.64243) #returns 3
round(4) #returns 4
