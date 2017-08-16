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


#### Plot 1
names(power2)
summary(power2$Global_active_power)
hist(power2$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red", ylim = c(0, 1250))

png(filename = './plot1.png', width = 480, height = 480, units='px')
dev.copy(png,file="geyserplot.png")
