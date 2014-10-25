#Reading the dataset
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds");
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds");  

CoalRelatedIndexes<-as.character(SCC[grep("[cC][oO][aA][lL]",SCC[,3]),1])
NEI_COAL<-NEI[NEI[,2]%in%CoalRelatedIndexes,]

#Summing emission for each year
temp<-aggregate(NEI_COAL[,"Emissions"], by=list(Category=NEI_COAL[,"year"]), FUN=sum)
#Saving to png file
png(filename='./figure/plot4.png', width = 480, height = 480)
barplot(temp[,2]/1000,temp[,1],names.arg=c("1999", "2002", "2005","2008"),xlab="Years",ylab="PM2.5 emission in kiloTons",main = "Emissions from coal comb. sources")
dev.off()