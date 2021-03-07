
## I will use dplyr and lubridate for better date conversion and data filtering.

library(dplyr)
library(lubridate)

# read dataset - convert "?" to NA

hep <- read.csv("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# add new Column "DateTime"and convert "Date" and "Time"
hep <- hep %>% mutate(DateTime = dmy_hms(paste(Date, Time))) %>% mutate(Date = dmy(Date), Time = hms(Time) ) 

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
hep <- hep %>% filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02") )


png("plot1.png", width = 480, height = 480)

with(hep, hist(Global_active_power, col="red", main ="Global Active Power", xlab = "Global Active Power (kilowatts)") )

dev.off()

