## read data from file
df <- read.csv("household_power_consumption.txt", sep=";")
## convert to data format
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
## Select Global_active_power for the dates 2007-02-01 and 2007-02-02 where data exists (!="?")
dataPlot <- df[df$Date=="2007-02-01"|df$Date=="2007-02-02", c(1, 2, 7, 8, 9)]
## Add column DateTime wuth full date (date and time in POSIXlt)
dataPlot$DateTime <- strptime(paste(dataPlot$Date, dataPlot$Time), format="%Y-%m-%d %H:%M:%S")
## Remove Date and Time columns
dataPlot <- dataPlot[, 3:6]
## Convert factor to numeric
dataPlot$Sub_metering_1 <- as.numeric(as.character(dataPlot$Sub_metering_1))
dataPlot$Sub_metering_2 <- as.numeric(as.character(dataPlot$Sub_metering_2))
dataPlot$Sub_metering_3 <- as.numeric(as.character(dataPlot$Sub_metering_3))
## Reshape data
library(reshape)
dataPlot <- melt(dataPlot, id="DateTime")
## Open PNG device
png(filename = "plot3.png", width = 480, height = 480)
## Set margins
par(mar=c(4, 4, 2, 2))
## Set x-axis Date format to English
Sys.setlocale("LC_TIME", "en_US.UTF-8")
## Build histogram
plot(dataPlot$DateTime, dataPlot$value, type="l", xlab="", ylab="Energy sub metering")
with(subset(dataPlot, variable=="Sub_metering_1"), lines(DateTime, value, col="black"))
with(subset(dataPlot, variable=="Sub_metering_2"), lines(DateTime, value, col="red"))
with(subset(dataPlot, variable=="Sub_metering_3"), lines(DateTime, value, col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Close device
dev.off()