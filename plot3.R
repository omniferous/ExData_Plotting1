# plyr included for the mutate function
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
png(file = "plot3.png") 

# Plot the beastie
with(sampleElectric, plot(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"), Sub_metering_1, 
                          type="l",  xlab = "", ylab = "Energy sub metering"))
with(sampleElectric, lines(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"), Sub_metering_2, 
                          type="l", col = "red"))
with(sampleElectric, lines(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"), Sub_metering_3, 
                           type="l", col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), text.font = 1)


dev.off()


