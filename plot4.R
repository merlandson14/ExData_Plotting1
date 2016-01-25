# This program will read in Household Power Consumption data for Feb 1 and 2, 2007.
# It will then create four plots of various data amounts over the two days.
library(dplyr)
zipfileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
temp <- tempfile()                                                             
download.file(zipfileUrl, temp)                                                
housepowerData <- read.table(unz(temp, "household_power_consumption.txt"), 
                  header = TRUE, sep = ";", na.strings = "?")[66637:69516,] 
# In early examination of the data, these rows had the dates we are looking for.
# Date and Time were separate columns as factors, so we first put them together in a new var and then update to POSIX format.
housepowerData <- mutate(housepowerData, DateTime = paste(housepowerData$Date,housepowerData$Time))
housepowerData$DateTime <- strptime(housepowerData$DateTime, format = "%d/%m/%Y %H:%M:%S")
# Below is the creation of all four plots (on a two by two grid) and saved to PNG file.
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(housepowerData, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(housepowerData, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(housepowerData, {
    plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    points(DateTime, Sub_metering_2, type = "l", col = "red")
    points(DateTime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
})
with(housepowerData, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()