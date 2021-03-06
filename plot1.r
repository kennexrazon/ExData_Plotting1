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
#plot away
hist(hpc$global_active_power,11,c="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.copy(png,'plot1.png',width = 480, height=480)
dev.off()
# hpc <- read.table("household_power_consumption.txt",
 # sep=";",
 # dec=".",
 # skip =grep(pattern="^((?![1-2]/2/2007).)*$",
 # readLines("household_power_consumption.txt")))

#pwr <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

# pwr$Date <- as.Date(pwr$Date)

#hpc <- pwr[which (pwr$Date == "2007-02-02" | pwr$Date == "2007-02-01"),]

#trial <- read.table("try.txt",header=TRUE, sep=";")
