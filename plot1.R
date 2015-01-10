## read data from file
df <- read.csv("household_power_consumption.txt", sep=";")
## convert to data format
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
## Select Global_active_power for the dates 2007-02-01 and 2007-02-02 where data exists (!="?")
dataPlot <- df[(df$Date=="2007-02-01"|df$Date=="2007-02-02")&df$Global_active_power!="?", 3]
## Convert factor to numeric
dataPlot <- as.numeric(as.character(dataPlot))
## Open PNG device
png(filename = "plot1.png", width = 480, height = 480)
## Set margins
par(mar=c(4, 4, 2, 2))
## Build histogram
hist(dataPlot, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
## Close device
dev.off()