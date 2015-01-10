## read data from file
df <- read.csv("household_power_consumption.txt", sep=";")
## convert to data format
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
## Select Global_active_power for the dates 2007-02-01 and 2007-02-02 where data exists (!="?")
dataPlot <- df[(df$Date=="2007-02-01"|df$Date=="2007-02-02")&df$Global_active_power!="?", c(1, 2, 3)]
## Convert factor to numeric
dataPlot$Global_active_power <- as.numeric(as.character(dataPlot$Global_active_power))
## Open PNG device
png(filename = "plot2.png", width = 480, height = 480)
## Set margins
par(mar=c(4, 4, 2, 2))
## Set x-axis Date format to English
Sys.setlocale("LC_TIME", "en_US.UTF-8")
## Build plot
plot(strptime(paste(dataPlot$Date, dataPlot$Time), format="%Y-%m-%d %H:%M:%S"), dataPlot$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
## Close device
dev.off()