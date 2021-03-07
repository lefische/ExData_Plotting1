
## I will use dplyr and lubridate for better date conversion and data filtering.

library(dplyr)
library(lubridate)

# read dataset - convert "?" to NA

hep <- read.csv("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# add new Column "DateTime"and convert "Date" and "Time"
hep <- hep %>% mutate(DateTime = dmy_hms(paste(Date, Time))) %>% mutate(Date = dmy(Date), Time = hms(Time) ) 

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
hep <- hep %>% filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02") )


png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

with(hep, {
  plot(DateTime, Global_active_power, type = "l", col = "black", xlab = "", ylab = "Global Active Power")
  plot(DateTime, Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
  plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Engergy sub metering")
  lines(hep$DateTime, hep$Sub_metering_1, type = "l", col="black")
  lines(hep$DateTime, hep$Sub_metering_2, type = "l", col="red")
  lines(hep$DateTime, hep$Sub_metering_3, type = "l", col="blue")
  legend("topright", lty = 1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DateTime, Global_reactive_power, type = "l", col = "black", xlab = "datetime")
})


dev.off()

