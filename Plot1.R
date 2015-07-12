
install.packages("dplyr")
library(dplyr)


if (!file.exists("./household_power_consumption.txt")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./power_data.zip", method = "curl")
  unzip("./power_data.zip", overwrite = T, exdir = ".")
}

Raw<-filter(read.table("./household_power_consumption.txt",sep=";",header=TRUE,na,string="?"),Date=="1/2/2007"|Date=="2/2/2007")
Raw$DateTime<-strptime(paste(Raw$Date, Raw$Time), "%d/%m/%Y %H:%M:%S")
Raw$Date<-as.Date(Raw$Date, format="%d/%m/%Y")
for (i in 3:9){Raw[,i]<-as.numeric(Raw[,i])}

hist(Raw$Global_active_power/1000, main = "Global Active Power", col="red", ylab = "Frequency", xlab="Global Active Power (kilowatts)",ylim = c(0,1200), xlim = c(0, 6),breaks=12,xaxp = c(0, 6, 3))
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off

