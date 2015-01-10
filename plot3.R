## read data from file
df <- read.csv("household_power_consumption.txt", sep=";")
## convert to date format
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
## Select data (Date and Time columns and Sub_metering_x columns) for the dates 2007-02-01 and 2007-02-02
dataPlot <- df[df$Date=="2007-02-01"|df$Date=="2007-02-02", c(1, 2, 7, 8, 9)]
## Add column DateTime with full date (date and time in POSIXlt)
dataPlot$DateTime <- strptime(paste(dataPlot$Date, dataPlot$Time), format="%Y-%m-%d %H:%M:%S")
## Remove Date and Time columns
dataPlot <- dataPlot[, 3:6]
## Convert factor to numeric
dataPlot$Sub_metering_1 <- as.numeric(as.character(dataPlot$Sub_metering_1))
dataPlot$Sub_metering_2 <- as.numeric(as.character(dataPlot$Sub_metering_2))
dataPlot$Sub_metering_3 <- as.numeric(as.character(dataPlot$Sub_metering_3))
## Open PNG device
png(filename = "plot3.png", width = 480, height = 480)
## Set margins
par(mar=c(4, 4, 2, 2))
## Set x-axis Date format to English
Sys.setlocale("LC_TIME", "en_US.UTF-8")
## Build plot
with(dataPlot, plot(DateTime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering"))
with(dataPlot, lines(DateTime, Sub_metering_2, col="red"))
with(dataPlot, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Close device
dev.off()