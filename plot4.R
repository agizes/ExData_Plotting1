library(dplyr)
library(lubridate)


#Set locale to English
Sys.setlocale("LC_TIME","C")
#Read the source data
data<-read.table("household_power_consumption.txt",sep=";",
                 header = TRUE,na.strings = "?")

#Filter records for 2007-02-01 and 2007-02-02
data_1<-filter(data,data$Date=="1/2/2007" | data$Date=="2/2/2007")

#Creation of a new column in the dataframe with the right date time conversion
data_1$DateTime<-strptime(paste(data_1$Date, data_1$Time), "%d/%m/%Y %H:%M:%S")

#Delete memory for the original bulk dataset
rm(data)

#Plot number 4
#First we set a 2:2 matrix with the mfrow parameter
#keep same output format that worked for the previous graphs

#Plot parameter according to what is expected for the output
par(mfrow=c(2,2),mgp=c(1.2,0.5,0),mar=c(3,3,2,1),oma=c(1,1,0,2))
#Plots
with(data_1,{
  #Top left: plot#2
  plot(DateTime,Global_active_power,type="l",
       ylab="Global Active Power (kilowatts)", xlab="",
       cex.lab=0.6, cex.axis=0.6)
  
  #Top right: new plot, equal to the previous one with a different variable
  plot(DateTime,Voltage,type="l",
       xlab="datetime",
       cex.lab=0.6, cex.axis=0.6)
  
  #Bottom left: plot #3 removing outer box of the legend
  plot(DateTime,Sub_metering_1,type="l",
       ylab="Energy sub.mettering", xlab="",
       cex.lab=0.6, cex.axis=0.6)
  lines(data_1$DateTime,data_1$Sub_metering_2,type="l",xlab="",
        col="red")
  lines(data_1$DateTime,data_1$Sub_metering_3,type="l",xlab="",
        col="blue")
  legend("topright",col=c("black","red","blue"),
         legend=c("Sub_mettering_1","Sub_mettering_2","Sub_mettering_3"),
         lty=1,cex=0.5,y.intersp = 0.8,text.width = 90000,bty="n" )
  
  #Bottom right: equal to the top right plot but with a different variable
  plot(DateTime,Global_reactive_power,type="l",
       xlab="datetime",
       cex.lab=0.6, cex.axis=0.6)
  
})

dev.copy(png,file="plot4.png",width=480, height=480, res=120)
dev.off()