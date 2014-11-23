## setwd("~/UCI HAR Dataset")
parentDir     <-getwd()

## Column Definitions
featDf        <-read.delim("features.txt",header=F, stringsAsFactors=FALSE)
featColnam    <-featDf[sapply(featDf,function(x){grepl('mean()',x,fixed=T) | grepl('std()',x,fixed=T)})]
featColnam1   <-gsub("[^A-Za-z///'-]", "", featColnam)
featColnam1   <-gsub("[-]", "_", featColnam1)
featColnam    <-c("Activity","Subject",featColnam1)
avgfColnam    <-c("Activity","Subject",paste("Avg_Of_",featColnam1,sep=""))

## Activity Names
activityDf    <-read.delim("activity_labels.txt",header=F, stringsAsFactors=FALSE)
activityName  <-sapply(activityDf[],as.character)
activityName  <-as.character(gsub("[^A-Za-z]", "", activityName))

## Get Test Datasets
setwd("./test/")
files            <-list.files(path=".", pattern="*.txt", full.names=T, recursive=FALSE)
temp             <-lapply(files, function(x) {t <- read.table(x, header=F)})
test2            <-data.frame(temp[2])
test2            <-test2[,sapply(featDf,function(x){grepl('mean()',x,fixed=T) | grepl('std()',x,fixed=T)})]
testDf           <-data.frame(data.frame(temp[3]),data.frame(temp[1]),test2)
colnames(testDf) <-featColnam
rm(temp,test2,files)

## Get Training Datasets
setwd("C:\\Users\\triciaslevin\\Desktop\\R\\Course_3\\UCI HAR Dataset\\train")
files            <-list.files(path=".", pattern="*.txt", full.names=T, recursive=FALSE)
temp             <-lapply(files, function(x) {t <- read.table(x, header=F)})
test2            <-data.frame(temp[2])
test2            <-test2[,sapply(featDf,function(x){grepl('mean()',x,fixed=T) | grepl('std()',x,fixed=T)})]
trainDf          <-data.frame(data.frame(temp[3]),data.frame(temp[1]),test2)
colnames(trainDf)<-featColnam
rm(temp,test2,files,featDf,activityDf,featColnam1)
setwd(parentDir)

##Average the data
completeDf         <-rbind(testDf,trainDf)
##completeDf$Subject <-factor(completeDf$Subject)
##completeDf$Activity<-factor(completeDf$Activity)
attach(completeDf)
avgData<-aggregate(completeDf,by=list(Activity,Subject),FUN=mean,na.rm=TRUE)
avgData<-avgData[3:70]
colnames(avgData)<-avgfColnam

## Publish data to file
write.csv(avgData,"./AVG_TIDY_DATA.txt",row.names=FALSE)