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

#plot 1
png("plot1.png",480,480,"px")
with(sub, hist(Global_active_power, main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency", col="red"))
dev.off()

