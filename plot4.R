#Read the full set of data
dat <- read.csv("EPC.txt",header = T,sep = ";",stringsAsFactor=F, na.strings = "?")

#Trim the data set to the proper size
tmp <- dat[dat$Date == "1/2/2007" | dat$Date =="2/2/2007",]

#Copy data set for manipulation
sub <- tmp

#Add new column, combine data and time, convert to POSIX object
sub$DateTime <- as.POSIXct(paste(sub$Date, sub$Time), format="%d/%m/%Y %H:%M:%S")

#make columns numeric
sub[,3:8] <- lapply(sub[,3:8], as.numeric)

#open device
png("plot4.png",480,480,"px")
par(mfrow = c(2,2)) #set grid
#plot 1
with(sub, plot( DateTime,Global_active_power,type="l",ylab = "Global Active Power (kilowatts)", xlab= ""))
#plot 2
with(sub, plot(DateTime, Voltage, type = "l"))
#plot 3
with(sub, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab=""))
lines(sub$DateTime, y = sub$Sub_metering_2,col="red")
lines(sub$DateTime, y= sub$Sub_metering_3, col="blue")
legend("topright",lty=c(1,1),cex= .5,col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#plot 4
with(sub, plot(DateTime, Global_reactive_power, type="l"))
dev.off()