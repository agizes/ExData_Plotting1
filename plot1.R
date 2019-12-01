library(dplyr)
library(lubridate)

#Set locale to English
Sys.setlocale("LC_TIME","C")
#Read the source data
data<-read.table("household_power_consumption.txt",sep=";",
                 header = TRUE,na.strings = "?")

#Filter records for 2007-02-01 and 2007-02-02
data_1<-filter(data,data$Date=="1/2/2007" | data$Date=="2/2/2007")

#Delete from memory for the original bulk dataset
rm(data)

#Plot number 1
par(mgp=c(1.2,0.5,0),mar=c(3,3,2,1),oma=c(1,1,0,2))
hist(data_1$Global_active_power,col="red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)",cex.lab=0.6, cex.axis=0.6,cex.main=0.7)
dev.copy(png,file="plot1.png",width=480, height=480, res=120)
dev.off()
