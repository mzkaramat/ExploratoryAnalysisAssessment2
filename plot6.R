#Reading the dataset
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds");
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds");  

MotorBaltimoreIndexes<-as.character(SCC[grep("[mM][oO][tT][oO][rR] | [vV][eE][hH][iI][cC][lL][eE]",SCC[,3]),1])
NEI_MotorBaltimore<-NEI[NEI[,2]%in%MotorBaltimoreIndexes,]
NEI_MotorBaltimore <- NEI_MotorBaltimore[NEI_MotorBaltimore[,1]=="24510",];

#Summing emission for each year
temp1<-aggregate(NEI_MotorBaltimore[,"Emissions"], by=list(Category=NEI_MotorBaltimore[,"year"]), FUN=sum)
temp1$label<-"Baltimore"

MotorLosAnglesIndexes<-as.character(SCC[grep("[mM][oO][tT][oO][rR] | [vV][eE][hH][iI][cC][lL][eE]",SCC[,3]),1])
NEI_MotorLosAngles<-NEI[NEI[,2]%in%MotorLosAnglesIndexes,]
NEI_MotorLosAngles <- NEI_MotorLosAngles[NEI_MotorLosAngles[,1]=="06037",];

temp2<-aggregate(NEI_MotorLosAngles[,"Emissions"], by=list(Category=NEI_MotorLosAngles[,"year"]), FUN=sum)
temp2$label<-"LosAngles"


#Saving to png file
png(filename='./figure/plot6.png', width = 480, height = 480)

par(mfcol = c(1,2));
barplot(temp1[,2],temp1[,1],names.arg=c("1999", "2002", "2005","2008"),xlab="Years",ylab="PM2.5 emission in Tons",main = "Baltimore City")

barplot(temp2[,2],temp2[,1],names.arg=c("1999", "2002", "2005","2008"),xlab="Years",ylab="PM2.5 emission in Tons",main = "LosAngles")

dev.off()