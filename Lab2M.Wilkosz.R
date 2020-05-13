##### TASKS #####
rm(list=ls())

#1
setwd("/Users/michalwilkosz/Desktop/RLaboratories")
beer <- read.csv("beer.csv")
head(beer)
beer_seasons <- subset(beer, season == "summer" | season == "winter")
beer_seasons$season <- droplevels(beer_seasons$season)

#a
tt <- t.test(consumption~season,data=beer_seasons)
tt
boxplot(consumption~season,data=beer_seasons) 
tt$statistic
tt$p.value
#There is a small difference in consumpiton between summer and winter.
#b
tt2 <- t.test(consumption~weekend, data = beer)
tt2
tt2$statistic
tt2$p.value
boxplot(consumption~weekend, data = beer)
#There is a significant difference in beer consumpiton between summer and winter.
#c 
beer_medium <- subset(beer, month == 5 | month == 6)
tt3 <- t.test(medium_temp~month, data = beer_medium)
tt3$statistic
tt3$p.value
boxplot(medium_temp~month, data = beer_medium)
#There is no a significant difference in medium temperature between may and june.



#2
rm(list=ls())
setwd("/Users/michalwilkosz/Desktop/RLaboratories")
beer <- read.csv("beer.csv")
attach(beer)
train <- sample(365,292)

#a
length(train)
lm.fit1 <- lm(consumption~min_temp, data = beer, subset=train)
mean((consumption-predict(lm.fit1,beer))[-train]^2)
#MSE: 17.92458
#b
length(train)
lm.fit2 <- lm(consumption~max_temp, data = beer, subset=train)
mean((consumption-predict(lm.fit2,beer))[-train]^2)
#MSE: 11.32353
#c
length(train)
lm.fit3 <- lm(consumption~medium_temp, data = beer, subset=train)
mean((consumption-predict(lm.fit3,beer))[-train]^2)
#MSE: 11.88738 

#The best predictor for linear model is max_temp becouse it has lowest MSE.

library(boot)
glm.fit <- glm(consumption~max_temp,data=beer)
loocv <- cv.glm(beer,glm.fit)
loocv$delta
#ERROR RATES: 11.44854 11.44837

kfold <- c()
for(i in 1:5){
  glm.fit <- glm(consumption~poly(max_temp,i),data=beer)
  kfold[i] <- cv.glm(beer,glm.fit,K=10)$delta[1]
}
kfold
#ERROR RATES: 11.45085 11.54455 11.57788 11.70700 11.63244

#Error rates in LDO Crossvalidation and K-fold Crossvalidation are
#similar to error obtained in manually splitted dataset. 

#3
rm(list=ls())
setwd("/Users/michalwilkosz/Desktop/RLaboratories")
beer <- read.csv("beer.csv")
attach(beer)

sadata <- subset(beer, season == "summer" | season == "autumn")
levels(sadata$season)
sadata$season <- droplevels(sadata$season)
levels(sadata$season)
levels(sadata$season)<-c(0,1) #SUMMER - 1, AUTUMN - 0

#LENGTH 182 
#TRAIN 146
#TEST 36
train <- sample(182,146)

glm.fit <- glm(season~consumption+min_temp, data = sadata, family = "binomial", subset = train)
print(summary(glm.fit))

#Check corectness 
season_summer <- data.frame(consumption = 25.5, min_temp = 24)
check <- predict(glm.fit, season_summer)

#Check all corectness
glm.resp <- predict(glm.fit,type="response") 
contrasts(sadata$season)
glm.pred <- rep(1,146)
glm.pred[glm.resp>0.5]=0
t <- table(glm.pred,sadata$season[train])  
1-sum(diag(t))/sum(t)

#SVM
library(e1071)
set.seed(104)

x = matrix(c(consumption[train],min_temp[train]),ncol=2) #consumption,min_temp
y = sadata$season[train] # seasons 
dat = data.frame(x=x, y=as.factor(y)) # dataframe
svmfit = svm(y~.,data=dat,kernel="radial",cost=10,scale=F) #SVM
plot(svmfit,dat)

glm_resp <- predict(svmfit,type="response")
glm.pred <- rep(1,146)
glm.pred[glm_resp=0]=0
t <- table(glm.pred,sadata$season[train])
1-sum(diag(t))/sum(t)

#Logistic regression classifier has got better performance. 

#4
#a
rm(list=ls())
setwd("/Users/michalwilkosz/Desktop/RLaboratories")
fish <- read.csv("fish.csv")
attach(fish)

fishdist <- dist(fish, method="euclidean")
hc.fish <- hclust(fishdist,method = "average")
plot1<-plot(hc.fish, labels=Species, main="Average", col="orange")

#b
clusters <- kmeans(fish[,c(6,7)],5)
clusters$cluster
plot2<-plot(fish[,c(6,7)], col=clusters$cluster, main="5 clusters")

#Comparing
par(mfrow=c(1,2))
plot(hc.fish, labels=Species, main="Average", col="orange")
plot(fish[,c(6,7)], col=clusters$cluster, main="5 clusters")

#Comment
#The graphs show that 2 variables are not enough to achieve satisfactory grouping.
#In the case of clusters, individual groups mix together a little bit, 
#but we can specify which cluster corresponds to the given species
#In the case of hierarchical clustering, additional scaling would have to be added, 
#which would make it easier to read the chart
 


