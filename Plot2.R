install.packages("dplyr")
library(dplyr)

if (!file.exists("./household_power_consumption.txt")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./power_data.zip", method = "libcurl")
  unzip("./power_data.zip", overwrite = T)
}

Raw<-filter(read.table("./household_power_consumption.txt",sep=";",header=TRUE,na.strings = "?"),Date=="1/2/2007"|Date=="2/2/2007")
Raw$DateTime<-strptime(paste(Raw$Date, Raw$Time), "%d/%m/%Y %H:%M:%S")
Raw$Date<-as.Date(Raw$Date, format="%d/%m/%Y")

for (i in 3:9){Raw[,i]<-as.numeric(Raw[,i])}

plot(Raw$DateTime,Raw$Global_active_power/1000, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off
