plyr included for the mutate function
library(plyr)

# Read data in from the file
electricData <- read.table("Project/household_power_consumption.txt", sep = ";", header = TRUE, nrows = 2075260, na.strings = "?")

# Take out dates for 1st and 2nd of Feb 2007
sampleElectric <- electricData[grep("^1/2/2007|^2/2/2007",electricData$Date),]
rm(electricData)

# Combine date and time fields and store as a date object
sampleElectric <- mutate(sampleElectric, Datetime = paste(Date,Time))
sampleElectric$Datetime<- strptime(sampleElectric$Datetime, "%d/%m/%Y %H:%M:%S")

# Open Graphic device otherwise the legend goes screwy - credit to https://class.coursera.org/exdata-011/forum/thread?thread_id=31
png(file = "plot4.png") 

# Plot the graphs - Note datetime has been omiited as a label for graphs 2 and 4 as that appeared to be an error
par(mfrow = c(2, 2))
with(sampleElectric, {
  plot(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"),Global_active_power, 
    type="l",  xlab = "", ylab = "Global Active Power (kilowatts)")
  plot(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"),Voltage, 
    type="l",  xlab = "", ylab = "Voltage")
  plot(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"), Sub_metering_1, 
    type="l",  xlab = "", ylab = "Energy sub metering")
  lines(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"), Sub_metering_2, 
    type="l", col = "red")
  lines(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"), Sub_metering_3, 
    type="l", col = "blue")
  legend("topright", lwd = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.font = 1)
  plot(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"),Global_reactive_power, 
       type="l",  xlab = "", ylab = "Global Reactive Power")
})

dev.off()

# Reset the display environmental parameter 
par(mfrow=c(1,1))
