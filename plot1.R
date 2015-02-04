# Read data in from the file
electricData <- read.table("Project/household_power_consumption.txt", sep = ";", header = TRUE, nrows = 2075260, na.strings = "?")

# Take out dates for 1st and 2nd of Feb 2007
sampleElectric <- electricData[grep("^1/2/2007|^2/2/2007",electricData$Date),]
rm(electricData)

# Plot the data to appear like plot 1 of the project 
hist(sampleElectric$Global_active_power, col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Copy to a file - note that 480 * 480 is default
dev.copy(png, file = "plot1.png")
dev.off()
