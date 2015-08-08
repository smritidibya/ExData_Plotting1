getwd()

library(dplyr)

#Reading in the data
data <- read.table("c:/users/smriti/documents/R/Exploratory_data_analysis/household_power_consumption.txt", sep=";",
                   header=TRUE, na.strings = "?")
names(data)
dim(data)
str(data)

library(lubridate)

#limiting data to two days in February of 2007
dataS <- mutate(data, dd = dmy(as.character(data$Date)))
dataS$day = wday(dataS$dd, label = TRUE)

dataSS <- subset(dataS, dd >= "2007-01-31" & dd <= "2007-02-02")

dataSS$datetime <- as.POSIXct(paste(dataSS$dd,as.character(dataSS$Time)))

summary(dataSS$dd)
table(dataSS$day)

##################################################################
#Creating 2 by 2 graphics window
par(mfrow = c(2,2), mar = c(1,4,1,1), oma = c(0,0,0,0))

#First plot
plot(dataSS$datetime, dataSS$Global_active_power, type = "l", lty = 1,
     ylab = "Global Active Power (kilowatts)", xlab="")

#Second plot
plot(dataSS$Voltage, type = "l", lty = 1,
     ylab = "Voltage", xlab="")

#Third plot
plot(dataSS$datetime, dataSS$Sub_metering_1, type = "l", lty = 1,
     ylab = "Energy sub metering", xlab="")
points(dataSS$datetime, dataSS$Sub_metering_2, type="l", lty = 1, col="red")
points(dataSS$datetime, dataSS$Sub_metering_3, type="l", lty = 1, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, cex = .50, col = c("black","red","blue"))

#Fourth plot
plot(dataSS$datetime, dataSS$Global_reactive_power, type = "l", lty = 1,
     ylab = "Global Active Power (kilowatts)", xlab="")

#Creating png file
dev.cur()
png(file = "plot4.png",  width = 480, height = 480, units = "px")
dev.off()
###################################################################
