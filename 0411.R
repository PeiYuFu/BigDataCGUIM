totalComment<-NULL
for(i in 1:nrow(totalPage)){ ##會跑很久.....建議先跑十筆就好(1:10)
    post<-getPost(totalPage$id[i],token,
                  n.comments = totalPage$comments_count[i])
    tempComment<-cbind(post$post$id,post$comments$from_name)
    totalComment<-rbind(totalComment,tempComment)
}







if (!require('reshape2')){
    install.packages("reshape2")
    library(reshape2)
}
head(mtcars)


mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),
                measure.vars=c("mpg","hp"))
head(carMelt,n=3)
tail(carMelt,n=3)



cylData <- dcast(carMelt, cyl ~ variable)
cylData


cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData



library(SportsAnalytics) #install.packages("SportsAnalytics")
NBA1415<-fetch_NBAPlayerStatistics("14-15")
boxplot(Blocks~Position,data=NBA1415)




library(ggplot2) #install.packages("ggplot2")
qplot(TotalPoints, TotalMinutesPlayed,
      facets = .~Position, data = NBA1415)+
    stat_smooth(method="glm")



#library(ggplot2) #install.packages("ggplot2")
qplot(TotalRebounds, TotalMinutesPlayed,
      facets = .~Position, data = NBA1415)+
    stat_smooth(method="glm")


if(!require('datasets')){
    
    install.packages("datasets")
    
    library(datasets)
    
}




if (!require('datasets')){
    install.packages("datasets")
    library(datasets)
}
data(cars)
plot(cars$speed, cars$dist)


if (!require('lattice')){
    install.packages("lattice")
    library(lattice)
}
state <- data.frame(state.x77, region = state.region)
state





library(lattice)

xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

xyplot(Life.Exp ~ Income | region, data = state, layout = c(2, 2))




if (!require('ggplot2')){
    install.packages("ggplot2")
    library(ggplot2)
}

qplot(Life.Exp, Income,facets = .~region, data = state)
qplot(Life.Exp, Income,facets = region~., data = state)


library(ggplot2)

data(mpg)
qplot(displ, hwy, data = mpg)



library(datasets)
hist(airquality$Ozone)  ## Draw a new plot



library(datasets)
with(airquality, plot(Wind, Ozone))



library(datasets)
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")




