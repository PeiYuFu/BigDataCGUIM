
#把資料讀進來的程式碼
if(!require('SportsAnalytics')){
    
    install.packages("SportsAnalytics")
    
    library(SportsAnalytics)
    
}

NBA1415<-fetch_NBAPlayerStatistics("14-15")

NBA1415



#各隊最辛苦球員(出戰分鐘數最多)
FinalOutput<-NULL
MaxTime<-aggregate(TotalMinutesPlayed~Team,NBA1415,max)

NBA1415MaxTime<-merge(NBA1415,MaxTime)
FinalOutput<-NBA1415MaxTime[order(NBA1415MaxTime$TotalMinutesPlayed,decreasing = T),c("Team","Name","TotalMinutesPlayed")]

library(knitr)
kable(FinalOutput, digits=2)




#各隊得分王
FinalOutput2<-NULL
MaxPoint<-aggregate(TotalPoints~Team,NBA1415,max)

NBA1415MaxPoint<-merge(NBA1415,MaxPoint)
FinalOutput2<-NBA1415MaxPoint[order(NBA1415MaxPoint$TotalPoints,decreasing = T),c("Team","Name","TotalPoints")]

library(knitr)
kable(FinalOutput2, digits=2)




#各隊最有效率的球員(總得分/出戰分鐘數)

efficiency <- NBA1415$TotalPoints /NBA1415$TotalMinutesPlayed

Maxefficiency<-aggregate(efficiency~Team,NBA1415,max)

NBA1415Maxefficiency<-merge(NBA1415,Maxefficiency)

FinalOutput3<-NBA1415Maxefficiency[order(NBA1415Maxefficiency$efficiency,decreasing = T),c("Team","Name","efficiency")]


library(knitr)
kable(FinalOutput3, digits=2)





#各隊三分球出手最準的球員(ThreesMade/ThreesAttempted 最高)

Highest<- NBA1415$ThreesMade / NBA1415$ThreesAttempted

MaxHighest<-aggregate(Highest~Team,NBA1415,max)

NBA1415MaxHighest<-merge(NBA1415,MaxHighest)

FinalOutput4<-NBA1415MaxHighest[order(NBA1415MaxHighest$Highest,decreasing = T),c("Team","Name","Highest")]


library(knitr)
kable(FinalOutput4, digits=2)

