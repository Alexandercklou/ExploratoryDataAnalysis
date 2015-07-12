
install.packages("dplyr")
library(dplyr)

if (!file.exists("./household_power_consumption.txt")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./power_data.zip", method = "curl")
  unzip("./power_data.zip", overwrite = T, exdir = ".")
}

Raw<-filter(read.table("./household_power_consumption.txt",sep=";",header=TRUE),Date=="1/2/2007"|Date=="2/2/2007")
Raw$DateTime<-strptime(paste(Raw$Date, Raw$Time), "%d/%m/%Y %H:%M:%S")
Raw$Date<-as.Date(Raw$Date, format="%d/%m/%Y")
for (i in 3:9){Raw[,i]<-as.numeric(Raw[,i])}

par(mfrow = c(2, 2))

#Chart1
plot(Raw$DateTime,Raw$Global_active_power/1000, type="l",ylab="Global Active Power",xlab="")
#Chart2
plot(Raw$DateTime,Raw$Voltage, type="l", xlab="datetime", ylab="Voltage")
#Chart3
plot(Raw$DateTime,Raw$Sub_metering_1, type="l", ylab="Energy sub metering",xlab="")
lines(Raw$DateTime,Raw$Sub_metering_2,col="red")
lines(Raw$DateTime,Raw$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
#Chart 4
plot(Raw$DateTime,Raw$Global_active_power/1000, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480 )
dev.off


