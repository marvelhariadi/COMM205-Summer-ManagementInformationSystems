# Operators -->
  TRUE & TRUE #"&" functions like AND in CPSC121 -->
  TRUE & FALSE # note: lowercase text makes objects. UPPERCASE is value
  
 # == means "enquiry into the data. Not "equal to." Issa boolean operator 
# "<-" or "=" means instantiate the object. manifests a new thing

x = 7 # aka x <- 2 
x == 2 # returns TRUE. Because x is indeed = 
x == 7 # returns false. Because x does not = 7.

#Using == and & together
name = "Fred" (x == 2) & (name == "Fred") #note that brackets are not necessary to R syntax but it helps look understandable -->

# "|" means "OR" like in CPSC121
(x == 2) (name == "Fred")

#"!" is NOT boolean operator
!TRUE <# returns FALSE
name == "Fred" # return FALSE
name != "Fred" #returns TRUE

# Vectors: a collection of data. Like an array in Java.

city <- c("Vancouver", "Victoria", "Delta", "Surrey") # note this syntax structure. the c(..) is important
                                                      # Each data piece has a index number. That is their place in line.

city_temp <- c(25, 20, 27, 30)
is_sunny <- c(FALSE, FALSE, TRUE, TRUE)
coty_tem <- c(25, FALSE, 27, 30) #you can also mix data types. but not often done in practice
heehee <- c(coty_tem , 24 , is_sunny) #you can also nest vectors.

# length function tells us how many elements are in the vector
length(city) # returns 4 bc there are 4 elements in the vector

# Subsetting (ie.extracting a data point)
city[2] #returns "Victoria" bc Victoria is the SECOND data element in the queue
city [5] #returns "NA" because it does not exist
city[1:3] #extracts data elements 1-2 
city[c(1, 3)] # extracts data elements 1 and 3 specifically (skips 2)

#lets install Tiderverse
library(tidyverse)

#making tables (ie. 2d arrays)
movies <- data_frame( 

title = c("Groundhog Day", "Mission Impossible", "Inception", "Terminator 2", "Back to the Future"),
year = c(1993, 2000, 1981, 1943, 1923),
duration = c(101, 110, 148, 137, 116),
box_office = c(105, 408, 837, 151, 2),
rating = c(96, 99, 69, 42, 59),
)

#to extract a specific vector within a data frame
movies$year
movies$year > 2000 #returns a series of boolean. Applies the function to every data element
movies$year == 1993 #
View(movies) #shows the table in visual form
movies$duration + 5 #adds 5 to each data element
movies$is.action  <- c(FALSE, TRUE, TRUE, TRUE, FALSE) #adds new column to table
movies$hours <- movies$duration/60 #applies to every data element in duration vector
range(movies$year) #outputs the smallest and largest vals
