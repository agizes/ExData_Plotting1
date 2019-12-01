
#Set locale to English
Sys.setlocale("LC_TIME","C")
#Read the source data
data<-read.table("household_power_consumption.txt",sep=";",
                 header = TRUE,na.strings = "?")

#Filter records for 2007-02-01 and 2007-02-02
data_1<-filter(data,data$Date=="1/2/2007" | data$Date=="2/2/2007")

#Delete from memory for the original bulk dataset
rm(data)

#Plot number 2
library(lubridate)
#Creation of a new column in the dataframe with the right date time conversion
data_1$DateTime<-strptime(paste(data_1$Date, data_1$Time), "%d/%m/%Y %H:%M:%S")

#Plot parameters according to what is expected for the output
par(mgp=c(1.2,0.5,0),mar=c(3,3,2,1),oma=c(1,1,0,2))
#Plot
with(data_1,plot(DateTime,Global_active_power,type="l",
                 ylab="Global Active Power (kilowatts)", xlab="",
                 cex.lab=0.6, cex.axis=0.6))
dev.copy(png,file="plot2.png",width=480, height=480, res=120)
dev.off()

