# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")
library("nycflights13")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
dim(flights)
colnames(flights)
?flights
View(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
library(dplyr)
flights <- mutate(flights, gain_while_flying = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, -gain_while_flying)
View(flights)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- flights %>% 
  mutate(gain_while_flying = arr_delay - dep_delay) %>% 
  arrange(-gain_while_flying)

View(flights)

# Make a histogram of the amount of time gained using the `hist()` function
?hist
hist(flights$gain_while_flying)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$gain_while_flying, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
to_sea_flights <- flights %>% 
  select(origin, dest, gain_while_flying) %>% 
  filter(dest == "SEA")
View(to_sea_flights)

# On average, did flights to SeaTac gain or loose time?
mean(to_sea_flights$gain_while_flying, na.rm = T)

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
filter(to_sea_flights, origin == "JFK") %>% 
summarize(
  mean_air_time = mean(gain_while_flying, na.rm = T),
  min_air_time = min(gain_while_flying, na.rm = T), 
  max_air_time = max(gain_while_flying, na.rm = T)
)
