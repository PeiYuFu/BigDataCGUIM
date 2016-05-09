
library(XML)
xml<-xmlTreeParse("http://opendata.cwb.gov.tw/govdownload?dataid=E-A0015-001R&authorizationkey=rdec-key-123-45678-011121314", useInternalNodes = TRUE)
xmltop <- xmlRoot(xml)
totalVector<-NULL
for(i in 10:length(xmlChildren(xmltop))){
  tempVector<-c()
  tempList<-xmlToList(xmltop[[i]])
  #print(length(tempList))
  for(j in 1:length(tempList)){
    #print(length(tempList[[j]]))
    for(k in 1:length(tempList[[j]])){
      tempVector<-c(tempVector,tempList[[j]][[k]][[1]])
    }
  }
  totalVector<-rbind(totalVector,tempVector)
}
rownames(totalVector)<-c(1:nrow(totalVector))
head(totalVector)

A<-xmlToList(xmltop)
B<-A$dataset$earthquake$earthquakeInfo$epicenter$epicenterLat
C<-A$dataset$earthquake$earthquakeInfo$depth
B
C
