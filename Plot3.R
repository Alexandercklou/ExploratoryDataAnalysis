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

plot(Raw$DateTime,Raw$Sub_metering_1, type="l",ylab="Energy sub metering")
lines(Raw$DateTime,Raw$Sub_metering_2,col="red")
lines(Raw$DateTime,Raw$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))
dev.copy(png, file="plot3.png", width=480, height=480 )
dev.off


