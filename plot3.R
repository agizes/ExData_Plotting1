library(dplyr)
library(lubridate)


#Set locale to English
Sys.setlocale("LC_TIME","C")
#Read the source data
data<-read.table("household_power_consumption.txt",sep=";",
                 header = TRUE,na.strings = "?",
                 #colClasses = c("Date", "Time", "numeric", 
                 #               ,"numeric", "numeric", "numeric", "numeric", 
                 #               "numeric", "numeric")
)

#Filter records for 2007-02-01 and 2007-02-02

data_1<-filter(data,data$Date=="1/2/2007" | data$Date=="2/2/2007")


#Creation of a new column in the dataframe with the right date time conversion
data_1$DateTime<-strptime(paste(data_1$Date, data_1$Time), "%d/%m/%Y %H:%M:%S")

#Delete memory for the original bulk dataset
rm(data)

#Plot number 3

#Plot parameter according to what is expected for the output
par(mgp=c(1.2,0.5,0),mar=c(3,3,2,1),oma=c(1,1,0,2),cex=1)
with(data_1,plot(DateTime,Sub_metering_1,type="l",
                 ylab="Energy sub.mettering", xlab="",
                 cex.lab=0.6, cex.axis=0.6))
lines(data_1$DateTime,data_1$Sub_metering_2,type="l",xlab="",
      col="red")
lines(data_1$DateTime,data_1$Sub_metering_3,type="l",xlab="",
      col="blue")
legend("topright",col=c("black","red","blue"),
       legend=c("Sub_mettering_1","Sub_mettering_2","Sub_mettering_3"),
       lty=1,cex=0.5,y.intersp = 1,text.width = 50000)
dev.copy(png,file="plot3.png",width=480, height=480, res=120)
dev.off()


