#Exercise 10

#Q1
mydf <- data_frame(
  a = c(1,2,3,NA,5),
  b = c(1,4,9,NA,25))

sum(is.na(mydf$a)) 
var(a, na.rm = TRUE)
var(mydf$a, na.rm = TRUE) # this one works
var(mydf$a, na.rm = FALSE)
var(a, na.rm = FALSE)

#Q2
sum(is.na(mydf$a)) #w
sum(is.na(a))
sum(mydf$a, na.rm = TRUE) #wrong num
sum(a, na.rm = TRUE)

#Q3 and beyond
companies <- readRDS("~/Downloads/North American Stock Market 1994-2018.rds")

companies %>%
  min(sale, na.rm = TRUE)

#why doesn't this work?
companies %>%
  min(companies$sale, na.rm = TRUE)

#---
#Exercise 11
companies_complete <- na.omit(companies)
companies_2001 <- filter(companies_complete, fyear == 2001, lt != 0)

#Q1
max(companies_2001$at/companies_2001$lt)

#Q2
Ex11Q2 <- select(companies_2001, gvkey, at, lt) 
max(companies_2001$at)
Ex11q2.1 <- companies_2001

#Q3
numerator1 <- companies_complete %>%
  filter(fyear == 2007, at>1000) %>%
  summarise(n())

denominator <- companies_complete %>%
  filter(fyear == 2007) %>%
  summarise(n())

round(numerator1/denominator,3)

#q4 & 5
df1 <- companies %>% select(conm, emp, fyear) %>%
  filter(!is.na(emp), fyear==2010)
max(df1$emp)-min(df1$emp)
