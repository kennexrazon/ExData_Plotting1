## download file if it doesn't exist yet
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("power.zip")){
	download.file(fileUrl,destfile="power.zip")	
}
fname<-dir( pattern="\\.zip$")

# unzip file
unzip(fname)

# read only dates Feb 1,2007 and Feb 2,2007
hpc<-read.table("household_power_consumption.txt",
header=FALSE,
sep=";",
skip=66637,
nrows=69517-66637)

# rename columns
colnames(hpc)[1] <- "date"
colnames(hpc)[2] <- "time"
colnames(hpc)[3] <- "global_active_power"
colnames(hpc)[4] <- "global_reactive_power"
colnames(hpc)[5] <- "voltage"
colnames(hpc)[6] <- "global_intensity"
colnames(hpc)[7] <- "sub_metering_1"
colnames(hpc)[8] <- "sub_metering_2"
colnames(hpc)[9] <- "sub_metering_3"

# plot away
hpc$datetime <- strptime(paste(hpc$date,hpc$time),format='%d/%m/%Y %H:%M:%S')
hpc$days <- weekdays(hpc$datetime)

par(mfrow=c(2,2))
plot(hpc$global_active_power,type='l',ylab="Global Active Power",xlab="")

plot(hpc$datetime,hpc$voltage,type='l',xlab="datetime",ylab="Voltage")

plot(hpc$datetime,hpc$sub_metering_1,type='l',xlab="",ylab="Energy sub metering")
lines(hpc$datetime,hpc$sub_metering_2,col="red")
lines(hpc$datetime,hpc$sub_metering_3,col="blue")
legend("topright",legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),col=c('black','red','blue'),lty=1,bty='n')

plot(hpc$datetime,hpc$global_reactive_power,type='l',xlab="datetime",ylab="Global_reactive_power")

dev.copy(png,'plot4.png',width = 480, height=480)
dev.off()
