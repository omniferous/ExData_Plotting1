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

# Plot the beastie
with(sampleElectric, plot(as.POSIXct(Datetime, format="%Y-%m-%d %H:%M:%S"),Global_active_power, 
                          type="l",  xlab = "", ylab = "Global Active Power (kilowatts)"))

# Copy to a file - note that 480 * 480 is default
dev.copy(png, file = "plot2.png")
dev.off()