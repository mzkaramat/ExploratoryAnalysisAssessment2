#Reading the dataset
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds");
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds");  

MotorBaltimoreIndexes<-as.character(SCC[grep("[mM][oO][tT][oO][rR] | [vV][eE][hH][iI][cC][lL][eE]",SCC[,3]),1])
NEI_MotorBaltimore<-NEI[NEI[,2]%in%MotorBaltimoreIndexes,]
NEI_MotorBaltimore <- NEI_MotorBaltimore[NEI_MotorBaltimore[,1]=="24510",];

#Summing emission for each year
temp<-aggregate(NEI_MotorBaltimore[,"Emissions"], by=list(Category=NEI_MotorBaltimore[,"year"]), FUN=sum)
#Saving to png file
png(filename='./figure/plot5.png', width = 480, height = 480)
barplot(temp[,2],temp[,1],names.arg=c("1999", "2002", "2005","2008"),xlab="Years",ylab="PM2.5 emission in Tons",main = " Emissions from motor veh. src in Baltimore")
dev.off()