## read data from file
df <- read.csv("household_power_consumption.txt", sep=";")
## convert to data format
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
## Select Global_active_power for the dates 2007-02-01 and 2007-02-02 where data exists (!="?")
dataPlot <- df[df$Date=="2007-02-01"|df$Date=="2007-02-02", ]
## Add column DateTime wuth full date (date and time in POSIXlt)
dataPlot$DateTime <- strptime(paste(dataPlot$Date, dataPlot$Time), format="%Y-%m-%d %H:%M:%S")
## Convert factor to numeric
dataPlot$Global_active_power <- as.numeric(as.character(dataPlot$Global_active_power))
dataPlot$Global_reactive_power <- as.numeric(as.character(dataPlot$Global_reactive_power))
dataPlot$Voltage <- as.numeric(as.character(dataPlot$Voltage))
dataPlot$Sub_metering_1 <- as.numeric(as.character(dataPlot$Sub_metering_1))
dataPlot$Sub_metering_2 <- as.numeric(as.character(dataPlot$Sub_metering_2))
dataPlot$Sub_metering_3 <- as.numeric(as.character(dataPlot$Sub_metering_3))
## Open PNG device
png(filename = "plot4.png", width = 480, height = 480)
## Set x-axis Date format to English
Sys.setlocale("LC_TIME", "en_US.UTF-8")
## Set margins
par(mfcol=c(2, 2), mar=c(4, 4, 2, 2))
## Build plots 
with(dataPlot, {
  ## plot1
  plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  ## plot2
  plot(DateTime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  ## plot3
  plot(DateTime, Voltage, type="l")
  ## plot4
  plot(DateTime, Global_reactive_power, type="l")
})
## Close device
dev.off()