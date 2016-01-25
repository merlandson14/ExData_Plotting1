# This program will read in Household Power Consumption data for Feb 1 and 2, 2007.
# It will then create a line plot of the Global Active Power amounts over the two days.
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
# Below is the line graph of Global Active Power over two days and saved to PNG file.
plot(housepowerData$DateTime, housepowerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()