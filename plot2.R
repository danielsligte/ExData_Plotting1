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

## Generating Plot 2
plot(power2$Global_active_power ~ power2$Datetime, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")

png(filename = './plot2.png', width = 480, height = 480, units='px')
dev.copy(png,'plot2.png')
dev.off()
dev.set(which=2)
