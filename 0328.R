mat1 <- data.frame(1:4,5:8,9:12,13:16) #4個Columns，執行4次
mat1
sapply(mat1, function(x, y) {sum(x) + y}, y = 5)

lapply(1:3, function(a, b) {a*b}, b=2) #3個數字的向量，執行3次


list1<-list(1,1:2,1:3,1:4,1:5); list2<-list(2,2:3,2:4,2:5,2:6)
lapply(1:length(list2), function(i, x, y) {x[[i]] + y[[i]]},
       x = list1, y = list2) #5個數字的向量，執行5次





if(!require('jsonlite')){
    
    install.packages("jsonlite")
    
    library(jsonlite)
    
}

if(!require('RCurl')){
    
    install.packages("RCurl")
    
    library(RCurl)
    
}

WaterData<-fromJSON(getURL("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=190796c8-7c56-42e0-8068-39242b8ec927"))
names(WaterData)  

# WaterData$result$results



names(WaterData$result)
WaterDataFrame<-WaterData$result$results
WaterDataFrame$longitude<-as.numeric(WaterDataFrame$longitude)
WaterDataFrame$latitude<-as.numeric(WaterDataFrame$latitude)
WaterDataFrame$qua_cntu<-as.numeric(WaterDataFrame$qua_cntu)
WaterDataFrame


myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)




curl -i -X GET \
"https://graph.facebook.com/v2.5/tsaiingwen?fields=posts.limit(10)%7Bcomments%2Clikes%2Cmessage%7D&access_token=CAACEdEose0cBAJ4AvZCZAZAr19afGL1nE4LLA9giON9dTOSvPC6GmAAZBUGvf5ygh6uEMRLQk76Sol9lZA5ZAidVNB5QPBKtZBawHhS5uvvhipjfVvZA1GbaMT79isjdJJZAuuvCrYu4D6gMZC9bRiw3PKE6nJrOqvAbCLOYOcIVJ9FIWngrGzYZBUfDoFfaPZAAvTsZD"



if (!require('httr')){
    install.packages("httr")
    library(httr)
}
#put your token
token<-"CAACEdEose0cBAJ4AvZCZAZAr19afGL1nE4LLA9giON9dTOSvPC6GmAAZBUGvf5ygh6uEMRLQk76Sol9lZA5ZAidVNB5QPBKtZBawHhS5uvvhipjfVvZA1GbaMT79isjdJJZAuuvCrYu4D6gMZC9bRiw3PKE6nJrOqvAbCLOYOcIVJ9FIWngrGzYZBUfDoFfaPZAAvTsZD" #put your token
FBData = GET(
    paste0("https://graph.facebook.com/v2.5/tsaiingwen?fields=
           posts{message,likes.summary(true)}&access_token=",
           token))
names(FBData)


if (!require('Rfacebook')){
    install.packages("Rfacebook")
    library(Rfacebook)
}


getPage("tsaiingwen", token,n = 30)



totalPage<-NULL
lastDate<-Sys.Date()
numberOfPost<-30
DateVector<-seq(as.Date("2016-01-01"),lastDate,by="5 days")
DateVectorStr<-as.character(DateVector)
DateVectorStr


token<-'CAACEdEose0cBAJ4AvZCZAZAr19afGL1nE4LLA9giON9dTOSvPC6GmAAZBUGvf5ygh6uEMRLQk76Sol9lZA5ZAidVNB5QPBKtZBawHhS5uvvhipjfVvZA1GbaMT79isjdJJZAuuvCrYu4D6gMZC9bRiw3PKE6nJrOqvAbCLOYOcIVJ9FIWngrGzYZBUfDoFfaPZAAvTsZD'
for(i in 1:(length(DateVectorStr)-1)){
    tempPage<-getPage("tsaiingwen", token,
                      since = DateVectorStr[i],until = DateVectorStr[i+1])
    totalPage<-rbind(totalPage,tempPage)
}
nrow(totalPage)
























