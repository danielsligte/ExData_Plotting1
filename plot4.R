### set working directory to right location and create directory in Project
setwd('~/Desktop/RStudio/course project1_exploratory')
dir.create('Power consumption')

### download data from website and unzip 
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, 'Power consumption.zip', method='curl')
unzip('./Power consumption.zip')

### Read the data into a table
powerdata <- read.table('./household_power_consumption.txt',header = TRUE,sep=";",na.strings = "?")

### Convert the dates
powerdata$Date=as.Date(powerdata$Date,format = "%d/%m/%Y")
class(powerdata$Date)

### subset to get the relevant dates
power2 <- subset(powerdata, Date>= "2007-02-01" & Date <="2007-02-02")

### Combine date and time to new variable
datetime <- paste(power2$Date, power2$Time)
power2$Datetime <- as.POSIXct(datetime)
class(power2$Datetime)



## Generating all 4 plots
png(filename = './plot4.png', width = 480, height = 480,units = 'px')
dev.copy(png,'plot4.png')
par(mfrow=c(2,2))
#plot 1
plot(power2$Global_active_power ~ power2$Datetime, type = "l",
     ylab = "Global Active Power", xlab = "")
#plot 2
plot(power2$Voltage ~ power2$Datetime, type = "l",
     ylab = "Voltage", xlab = "datetime")
#plot 3
plot(power2$Datetime,power2$Sub_metering_1,type="l",col="black",ylab = "Energy sub metering",xlab="")
lines(power2$Datetime,power2$Sub_metering_2,col="red")
lines(power2$Datetime,power2$Sub_metering_3,col="blue")
legend(x = "topright",lty=1,lwd=1,
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,cex=0.3, pt.cex = 0.4)
#plot 4
plot(power2$Global_reactive_power ~ power2$Datetime, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png,'plot4.png')
dev.off()
dev.set(which=1)

