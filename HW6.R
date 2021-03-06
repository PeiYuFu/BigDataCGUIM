---
    title: "1928-1969間,小兒麻痺在美國各州的發生率變化"
output: html_document
---
    
    ##資料前處理
    
polio<-read.csv("POLIO_Incidence.csv",stringsAsFactors=F)

head(polio)








#將寬表格轉為長表格,以年(YEAR)/週(WEEK)為基準,各州名column打散變長
library(reshape2)#formelt()

polio.m<-melt(polio,id.vars=c('YEAR','WEEK'))

head(polio.m)




polio.m[polio.m$value=="-",]$value<-NA#處理缺值,將"-"轉為NA

polio.m$value<-as.numeric(polio.m$value)#將value欄位轉為數字

polio.sumYear<-#各州各年度加總,計算該年度的總發生率
    
    aggregate(value~YEAR+variable,data=polio.m,FUN=sum,na.rm=F)

head(polio.sumYear)





if(!require('ggplot2')){#forfortify()
    install.packages("ggplot2");
    library(ggplot2)
}



##視覺化呈現

####因為要呈現出時間、地點以及發生率3種資訊，因此選擇用Heatmap。橫軸用時間，縱軸用地點，每個方格放發生率。值得注意的是1955年後因疫苗的出現，發生率快速下降。

ggplot(polio.sumYear, aes(YEAR, variable)) + #aes(x,y)
    geom_tile(aes(fill = value),colour = "white")+theme_bw()+ geom_vline(xintercept = 1955)+ #geom_tile: 區塊著色
    scale_fill_gradient(low = "white",high = "steelblue") #數值低：白色






