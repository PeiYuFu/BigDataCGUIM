
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

NBA1415$Efficiency <- NBA1415$TotalPoints / NBA1415$TotalMinutesPlayed

MaxEfficiency<-aggregate(Efficiency~Team,NBA1415,max)

NBA1415MaxEfficiency<-merge(NBA1415,MaxEfficiency)

FinalOutput3<-NBA1415MaxEfficiency[order(NBA1415MaxEfficiency$Efficiency,decreasing = T),c("Team","Name","Efficiency")]

library(knitr)
kable(FinalOutput3, digits=2)





#各隊三分球出手最準的球員(ThreesMade/ThreesAttempted 最高)

NBA1415$ThreesHigh <- NBA1415$ThreesMade / NBA1415$ThreesAttempted

MaxThreesHigh<-aggregate(ThreesHigh~Team,NBA1415,max)

NBA1415MaxThreesHigh<-merge(NBA1415,MaxThreesHigh)

FinalOutput4<-NBA1415MaxThreesHigh[order(NBA1415MaxThreesHigh$ThreesHigh,decreasing = T),c("Team","Name","ThreesHigh")]


library(knitr)
kable(FinalOutput4, digits=2)

