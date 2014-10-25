#Reading the dataset
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds");
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds");  
#Summing emission for each year
NEI_Baltimore <- NEI[NEI[,1]=="24510",];
temp<-aggregate(NEI_Baltimore[,"Emissions"], by=list(Category=NEI_Baltimore[,"year"]), FUN=sum)
#Saving to png file
png(filename='./figure/plot2.png', width = 480, height = 480)
barplot(temp[,2]/1000,temp[,1],names.arg=c("1999", "2002", "2005","2008"),xlab="Years",ylab="PM2.5 emission in kilo-Tons",main = "Emissions of PM2.5 in Baltimore City")
dev.off()