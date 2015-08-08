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
#create plot1(Histogram)
hist(dataSS$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

#Creating a png file
dev.cur()
png(file = "plot1.png",  width = 480, height = 480, units = "px")
dev.off()

##################################################################
