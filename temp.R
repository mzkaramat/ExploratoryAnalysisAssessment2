if (!file.exists("plots"))
{
  dir.create("plots");
}

data<- read.table(pipe('grep "^[1-2]/2/2007" "./PowerData/household_power_consumption.txt"'), sep = ";", na.strings = "?");
ColNames<-read.table("./PowerData/household_power_consumption.txt",nrow=1,sep=";");
colnames(data)<-as.character(unlist(ColNames[1,]));


data[,1]<-paste(data$Date, data$Time, sep=" ");
colnames(data)[1] = "Date/Time";
data <- subset(data, select = -c(Time));
#data[,1]<-strptime(data[,1], format='%d/%m/%Y %H:%M:%S');

#plot 1
png("./plots/plot1.png", width = 480, height = 480)
hist(data$Global_active_power,xlab="Globabl Active Power(kilowatts)",col="red",main="Global Active Power");
dev.off()

#plot 2
png("./plots/plot2.png", width = 480, height = 480)
plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Global_active_power,xlab="",ylab="Globabl Active Power(kilowatts)",main="",type="n");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Global_active_power);
dev.off()

#plot 3
png("./plots/plot3.png", width = 480, height = 480)
plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_1,xlab="",ylab="Energy sub metering",main="",type="n");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_1,col="black");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_2,col="red");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_3,col="blue");
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend 
       
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue"));
dev.off()

#plot 4
png("./plots/plot4.png", width = 480, height = 480)
par(mfcol = c(2,2));

plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Global_active_power,xlab="",ylab="Globabl Active Power(kilowatts)",main="",type="n");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Global_active_power);

plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_1,xlab="",ylab="Energy sub metering",main="",type="n");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_1,col="black");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_2,col="red");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Sub_metering_3,col="blue");
legend("topright", # places a legend at the appropriate place 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend 
       
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue"));

plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Voltage,xlab="datetime",ylab="Voltage",main="",type="n");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Voltage);

plot(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",main="",type="n");
lines(strptime(data[,1], format='%d/%m/%Y %H:%M:%S'),data$Global_reactive_power);

dev.off()
