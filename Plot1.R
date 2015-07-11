if (!file.exists("./household_power_consumption.txt")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./power_data.zip", method = "curl")
  unzip("./power_data.zip", overwrite = T, exdir = ".")
}

Raw<-read.table("./household_power_consumption.txt",sep=";",header=TRUE)
Raw$DateTime<-strptime(paste(Raw$Date, Raw$Time), "%d/%m/%Y %H:%M:%S")

Raw$Date<-as.Date(Raw$Date, format="%d/%m/%Y")
Raw2<-Raw[(Raw$Date=="2007-02-01") | (Raw$Date=="2007-02-02"),]
for (i in 3:9){Raw2[,i]<-as.numeric(Raw2[,i])}

hist(Raw2$Global_active_power/1000, main = "Global Active Power", col="red", ylab = "Frequency", xlab="Global Active Power (kilowatts)",ylim = c(0,1200), xlim = c(0, 6),breaks=12,xaxp = c(0, 6, 3))
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off


