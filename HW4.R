
#讀取蔡英文粉絲團資料

install.packages("Rfacebook")  # from CRAN
library(devtools)
install_github("Rfacebook", "pablobarbera", subdir = "Rfacebook")
if (!require('Rfacebook')){
    install.packages("Rfacebook")
    library(Rfacebook)
}
token<-'CAAONRvRYQI0BAP09cCiPRonuBemgd46ow1x3rYvCzqgoSZBnjrwuWZA1vXEyoRvU0376R0VC36JVyWBP7upvivrnnsJJNpkUqGkAskKhr947Pr21alPZBC4ep5qPT5ZBneUpkxgOg3AKVfcJ01kZC1o4vTcaHQPbXKTNivK3ZAaT0B5A0cACoB89a89GRvVWCufO2rEEfO3cXQiGv4jaB3'
totalPage<-NULL
lastDate<-Sys.Date()
DateVectorStr<-as.character(seq(as.Date("2016-01-01"),lastDate,by="5 days"))
for(i in 1:(length(DateVectorStr)-1)){
    tempPage<-getPage("tsaiingwen", token,
                      since = DateVectorStr[i],until = DateVectorStr[i+1])
    totalPage<-rbind(totalPage,tempPage)
}
nrow(totalPage)

totalPage$datetime <- as.POSIXct(totalPage$created_time, 
                                 format = "%Y-%m-%dT%H:%M:%S+0000", 
                                 tz = "GMT")
totalPage$dateTPE <- format(totalPage$datetime, "%Y-%m-%d", 
                            tz = "Asia/Taipei")
totalPage$weekdays <-weekdays(as.Date(totalPage$dateTPE))


#每日發文數分析

output<-aggregate(message~weekdays+dateTPE,totalPage,length)
library(knitr)
kable(output, digits=2)


#每日likes數

output<-aggregate(likes_count~dateTPE,totalPage,mean)
library(knitr)
kable(output, digits=2)


#每日comments數

output<-aggregate(comments_count~dateTPE,totalPage,mean)
library(knitr)
kable(output, digits=2)


#每日shares數

output<-aggregate(shares_count~dateTPE,totalPage,mean)
library(knitr)
kable(output, digits=2)



