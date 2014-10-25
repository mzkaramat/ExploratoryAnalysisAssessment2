library(ggplot2)

#Reading the dataset
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds");
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds");  

#Comparison of different particle types
NEI_POINT<-NEI[NEI[,5]=="POINT",]
PointMeans<-aggregate(NEI_POINT$Emissions, list(NEI_POINT$year), sum)
NEI_NONPOINT<-NEI[NEI[,5]=="NONPOINT",]
NONPointMeans<-aggregate(NEI_NONPOINT$Emissions, list(NEI_NONPOINT$year), sum)
NEI_ONROAD<-NEI[NEI[,5]=="ON-ROAD",]
ONROADMeans<-aggregate(NEI_ONROAD$Emissions, list(NEI_ONROAD$year), sum)
NEI_NONROAD<-NEI[NEI[,5]=="NON-ROAD",]
NONROADMeans<-aggregate(NEI_NONROAD$Emissions, list(NEI_NONROAD$year), sum)
labels<-c("Point","NonPoint","Road","NonRoad")
X<-rep(2004,4)
Y=c(14,15.5,12,13)

#Saving to png file
png(filename='./figure/plot3.png', width = 480, height = 480)
ggplot(PointMeans, aes(PointMeans[,1]))+
        geom_line(aes(y=log(PointMeans[,2])), colour="red",size=0.3,) +  # first layer
        geom_point(aes(y=log(PointMeans[,2])), colour="red",size=3)+
        geom_line(aes(y=log(NONPointMeans[,2])), colour="green",size=0.3)+  # first layer
        geom_point(aes(y=log(NONPointMeans[,2])), colour="green",size=3)+
        geom_line(aes(y=log(ONROADMeans[,2])), colour="blue",size=0.3)+  # first layer
        geom_point(aes(y=log(ONROADMeans[,2])), colour="blue",size=3)+
        geom_line(aes(y=log(NONROADMeans[,2])), colour="black",size=0.3)+
        geom_point(aes(y=log(NONROADMeans[,2])), colour="black",size=3)+
        ylab("log(Total Emissions)")+xlab("years")+ggtitle("Comparison of different particle types")+
        geom_text( mapping=aes(x=X, y=Y, label=labels, size=6))+
        theme(legend.position="none")
                
dev.off()

