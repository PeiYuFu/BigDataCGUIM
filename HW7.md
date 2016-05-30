乳癌預測模型
================

資料前處理
----------

#### 資料讀取

此資料來源為UCI Machine Learning Repository。

資料由威斯康星大學醫院 威斯康星州麥迪遜市Dr. Wolberg醫生提供，記載由各個醫療檢測紀錄相關，記錄到的各個探勘數值，一共有9個參數，依序有叢厚度、細胞均勻大小、細胞形狀、細胞邊際附著力、單上皮細胞尺寸、裸核、布蘭德染色質、普通核仁、有絲分裂情形。 主要由這些參數，對照紀錄，來判斷是否會得到乳癌的可能。 另外，分類結果為二元分類，良性(benign)及惡性(malignant)。

``` r
#install.packages("mlbench")
library(mlbench)
```

    ## Warning: package 'mlbench' was built under R version 3.2.5

``` r
data(BreastCancer)
str(BreastCancer)
```

    ## 'data.frame':    699 obs. of  11 variables:
    ##  $ Id             : chr  "1000025" "1002945" "1015425" "1016277" ...
    ##  $ Cl.thickness   : Ord.factor w/ 10 levels "1"<"2"<"3"<"4"<..: 5 5 3 6 4 8 1 2 2 4 ...
    ##  $ Cell.size      : Ord.factor w/ 10 levels "1"<"2"<"3"<"4"<..: 1 4 1 8 1 10 1 1 1 2 ...
    ##  $ Cell.shape     : Ord.factor w/ 10 levels "1"<"2"<"3"<"4"<..: 1 4 1 8 1 10 1 2 1 1 ...
    ##  $ Marg.adhesion  : Ord.factor w/ 10 levels "1"<"2"<"3"<"4"<..: 1 5 1 1 3 8 1 1 1 1 ...
    ##  $ Epith.c.size   : Ord.factor w/ 10 levels "1"<"2"<"3"<"4"<..: 2 7 2 3 2 7 2 2 2 2 ...
    ##  $ Bare.nuclei    : Factor w/ 10 levels "1","2","3","4",..: 1 10 2 4 1 10 10 1 1 1 ...
    ##  $ Bl.cromatin    : Factor w/ 10 levels "1","2","3","4",..: 3 3 3 3 3 9 3 3 1 2 ...
    ##  $ Normal.nucleoli: Factor w/ 10 levels "1","2","3","4",..: 1 2 1 7 1 7 1 1 1 1 ...
    ##  $ Mitoses        : Factor w/ 9 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 5 1 ...
    ##  $ Class          : Factor w/ 2 levels "benign","malignant": 1 1 1 1 1 2 1 1 1 1 ...

#### 處理資料

``` r
BreastCancerC<-BreastCancer[complete.cases(BreastCancer),
!names(BreastCancer)%in%c("Id")]
c(nrow(BreastCancer),nrow(BreastCancerC))
```

    ## [1] 699 683

#### 分成訓練組跟測試組,並紀錄各組人數

``` r
BreastCancerC$Test<-F
BreastCancerC[
sample(1:nrow(BreastCancerC),nrow(BreastCancerC)/5),]$Test<-T
c(sum(BreastCancerC$Test==F),sum(BreastCancerC$Test==T))
```

    ## [1] 547 136

隨機將4/5的資料分到訓練組（Test==F），剩下1/5為測試組（Test==T〕。 可得訓練組案例數為547，測試組案例數為136。

預測模型建立
------------

#### 模型建立

``` r
#install.packages("rpart")
library(rpart)
```

    ## Warning: package 'rpart' was built under R version 3.2.5

``` r
BreastCancerC$Class<-factor(BreastCancerC$Class,levels=c("malignant","benign"))

#set.seed(1000)          
fit<-rpart(Class~.,data=BreastCancerC[BreastCancerC$Test==F,]) 

#install.packages("rpart.plot")
library(rpart.plot)
```

    ## Warning: package 'rpart.plot' was built under R version 3.2.5

``` r
summary(fit)
```

    ## Call:
    ## rpart(formula = Class ~ ., data = BreastCancerC[BreastCancerC$Test == 
    ##     F, ])
    ##   n= 547 
    ## 
    ##           CP nsplit  rel error    xerror       xstd
    ## 1 0.80526316      0 1.00000000 1.0000000 0.05860891
    ## 2 0.04736842      1 0.19473684 0.2473684 0.03449742
    ## 3 0.03157895      2 0.14736842 0.1789474 0.02972014
    ## 4 0.01315789      3 0.11578947 0.1421053 0.02666467
    ## 5 0.01000000      5 0.08947368 0.1157895 0.02418487
    ## 
    ## Variable importance
    ##       Cell.size      Cell.shape     Bare.nuclei    Epith.c.size 
    ##              21              18              16              15 
    ## Normal.nucleoli     Bl.cromatin    Cl.thickness 
    ##              15              14               1 
    ## 
    ## Node number 1: 547 observations,    complexity param=0.8052632
    ##   predicted class=benign     expected loss=0.3473492  P(node) =1
    ##     class counts:   190   357
    ##    probabilities: 0.347 0.653 
    ##   left son=2 (205 obs) right son=3 (342 obs)
    ##   Primary splits:
    ##       Cell.size    splits as  RRLLLLLLLL, improve=181.3100, (0 missing)
    ##       Bare.nuclei  splits as  RRLLLLLLLL, improve=172.2428, (0 missing)
    ##       Cell.shape   splits as  RRRLLLLLLL, improve=172.1625, (0 missing)
    ##       Epith.c.size splits as  RRLLLLLLLL, improve=160.4867, (0 missing)
    ##       Bl.cromatin  splits as  RRRLLLLLLL, improve=155.5599, (0 missing)
    ##   Surrogate splits:
    ##       Cell.shape      splits as  RRRLLLLLLL, agree=0.916, adj=0.776, (0 split)
    ##       Epith.c.size    splits as  RRLLLLLLLL, agree=0.905, adj=0.746, (0 split)
    ##       Bare.nuclei     splits as  RRLLLLLLLL, agree=0.888, adj=0.702, (0 split)
    ##       Normal.nucleoli splits as  RRLLLLLLLL, agree=0.885, adj=0.693, (0 split)
    ##       Bl.cromatin     splits as  RRRLLLLLLL, agree=0.879, adj=0.678, (0 split)
    ## 
    ## Node number 2: 205 observations,    complexity param=0.04736842
    ##   predicted class=malignant  expected loss=0.1268293  P(node) =0.3747715
    ##     class counts:   179    26
    ##    probabilities: 0.873 0.127 
    ##   left son=4 (188 obs) right son=5 (17 obs)
    ##   Primary splits:
    ##       Cell.shape    splits as  RRLLLLLLLL, improve=15.085100, (0 missing)
    ##       Bare.nuclei   splits as  RLLLLLLLLL, improve=14.995990, (0 missing)
    ##       Cell.size     splits as  RRRLLLLLLL, improve=14.351430, (0 missing)
    ##       Bl.cromatin   splits as  RRLLLLLLLL, improve=11.501130, (0 missing)
    ##       Marg.adhesion splits as  RLLLLLLLLL, improve= 9.311812, (0 missing)
    ##   Surrogate splits:
    ##       Bl.cromatin splits as  RLLLLLLLLL, agree=0.937, adj=0.235, (0 split)
    ## 
    ## Node number 3: 342 observations,    complexity param=0.03157895
    ##   predicted class=benign     expected loss=0.03216374  P(node) =0.6252285
    ##     class counts:    11   331
    ##    probabilities: 0.032 0.968 
    ##   left son=6 (8 obs) right son=7 (334 obs)
    ##   Primary splits:
    ##       Bare.nuclei     splits as  RRRRRLLL-L, improve=11.638210, (0 missing)
    ##       Cl.thickness    splits as  RRRRRRLLLL, improve=10.277380, (0 missing)
    ##       Normal.nucleoli splits as  RRRL-LLR--, improve= 9.727366, (0 missing)
    ##       Bl.cromatin     splits as  RRRRL-L---, improve= 7.556034, (0 missing)
    ##       Epith.c.size    splits as  RRRLLLLLLL, improve= 4.509265, (0 missing)
    ##   Surrogate splits:
    ##       Cl.thickness    splits as  RRRRRRRRLL, agree=0.985, adj=0.375, (0 split)
    ##       Normal.nucleoli splits as  RRRL-LLR--, agree=0.985, adj=0.375, (0 split)
    ##       Mitoses         splits as  RRLR--RR-,  agree=0.980, adj=0.125, (0 split)
    ## 
    ## Node number 4: 188 observations,    complexity param=0.01315789
    ##   predicted class=malignant  expected loss=0.06914894  P(node) =0.3436929
    ##     class counts:   175    13
    ##    probabilities: 0.931 0.069 
    ##   left son=8 (137 obs) right son=9 (51 obs)
    ##   Primary splits:
    ##       Cell.size       splits as  RRRRLLLLLL, improve=3.863785, (0 missing)
    ##       Bare.nuclei     splits as  RLLLLLLLLL, improve=3.568602, (0 missing)
    ##       Cell.shape      splits as  RRRRLLLLLL, improve=2.872582, (0 missing)
    ##       Cl.thickness    splits as  RRRRRRLLLL, improve=2.535461, (0 missing)
    ##       Normal.nucleoli splits as  RRLLLLRLLL, improve=2.180634, (0 missing)
    ##   Surrogate splits:
    ##       Epith.c.size  splits as  RRLLLLLLLL, agree=0.803, adj=0.275, (0 split)
    ##       Cell.shape    splits as  RRRRLLLLLL, agree=0.793, adj=0.235, (0 split)
    ##       Marg.adhesion splits as  RLLLLLLLLL, agree=0.766, adj=0.137, (0 split)
    ##       Bl.cromatin   splits as  RRLLLLLLLL, agree=0.755, adj=0.098, (0 split)
    ##       Cl.thickness  splits as  RLLLLLLLLL, agree=0.739, adj=0.039, (0 split)
    ## 
    ## Node number 5: 17 observations
    ##   predicted class=benign     expected loss=0.2352941  P(node) =0.03107861
    ##     class counts:     4    13
    ##    probabilities: 0.235 0.765 
    ## 
    ## Node number 6: 8 observations
    ##   predicted class=malignant  expected loss=0.125  P(node) =0.01462523
    ##     class counts:     7     1
    ##    probabilities: 0.875 0.125 
    ## 
    ## Node number 7: 334 observations
    ##   predicted class=benign     expected loss=0.01197605  P(node) =0.6106033
    ##     class counts:     4   330
    ##    probabilities: 0.012 0.988 
    ## 
    ## Node number 8: 137 observations
    ##   predicted class=malignant  expected loss=0.00729927  P(node) =0.250457
    ##     class counts:   136     1
    ##    probabilities: 0.993 0.007 
    ## 
    ## Node number 9: 51 observations,    complexity param=0.01315789
    ##   predicted class=malignant  expected loss=0.2352941  P(node) =0.09323583
    ##     class counts:    39    12
    ##    probabilities: 0.765 0.235 
    ##   left son=18 (42 obs) right son=19 (9 obs)
    ##   Primary splits:
    ##       Bare.nuclei     splits as  RRLLL--LLL, improve=6.432306, (0 missing)
    ##       Cl.thickness    splits as  RRRRRRLLLL, improve=5.019608, (0 missing)
    ##       Normal.nucleoli splits as  RRLLLLRLLL, improve=3.033586, (0 missing)
    ##       Marg.adhesion   splits as  RRRLLLLLLL, improve=2.093682, (0 missing)
    ##       Cell.shape      splits as  RRRRLLLLLL, improve=1.843624, (0 missing)
    ## 
    ## Node number 18: 42 observations
    ##   predicted class=malignant  expected loss=0.1190476  P(node) =0.07678245
    ##     class counts:    37     5
    ##    probabilities: 0.881 0.119 
    ## 
    ## Node number 19: 9 observations
    ##   predicted class=benign     expected loss=0.2222222  P(node) =0.01645338
    ##     class counts:     2     7
    ##    probabilities: 0.222 0.778

``` r
prp(fit)
```

![](HW7_files/figure-markdown_github/unnamed-chunk-4-1.png)<!-- --> 由於變數多，且多為連續變項，而輸出為二元類別變項，故選擇決策樹演算法來建立模型。

模型說明
--------

由上述參數可知，以決策樹建立模型預測乳房腫瘤是否為陰性或良性，經最佳化後，所用到的參數為上圖的決策樹所示 使用病患資料來預測乳房腫瘤是否為陰性或良性，以決策樹模型預測是否為陰性，可得：

``` r
#install.packages("caret")
library(caret)
```

    ## Warning: package 'caret' was built under R version 3.2.5

    ## Loading required package: lattice

    ## Loading required package: ggplot2

    ## Warning: package 'ggplot2' was built under R version 3.2.5

``` r
MinePred<-predict(fit,newdata = BreastCancerC[BreastCancerC$Test==T,],type = "class")
sensitivity(MinePred,BreastCancerC[BreastCancerC$Test==T,]$Class)#敏感度
```

    ## [1] 0.9787234

``` r
specificity(MinePred,BreastCancerC[BreastCancerC$Test==T,]$Class)#特異性
```

    ## [1] 0.9775281

``` r
posPredValue(MinePred,BreastCancerC[BreastCancerC$Test==T,]$Class)#陽性預測率
```

    ## [1] 0.9583333

``` r
negPredValue(MinePred,BreastCancerC[BreastCancerC$Test==T,]$Class)#陰性預測率
```

    ## [1] 0.9886364
