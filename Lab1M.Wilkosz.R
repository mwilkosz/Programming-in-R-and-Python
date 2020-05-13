rm(list=ls())

#### TASK 1 ####
library(ISLR)
data("Credit")
attach(Credit)

head(Credit)

###a###
summary(Credit)
###b###
function1<-function(vec=c(seq(1:400))){
  if(all(vec==row.names(Credit))){
    return(print("identi-cal"))
    print("identi_call")
  }
  else{
    return(print("different"))
  }
}
vec<-c(seq(1:10))###sequence of 1,2,3,4,5,6,7,8,9,10 returns "different"
vec2<-(seq(1:400))##sequence of 1....400 returns"identi-call"

function1(vec)
function1(vec2)
###c###
lapply(Credit, function1)
###d###
Credit$ID<-as.character(Credit$ID)
typeof(Credit$ID)
###e###
lapply(Credit, function1)
###f###
Credit$ID<-NULL

head(Credit)
##### TASK2 #####

library(ISLR)
data("Credit")
attach(Credit)

head(Credit)

####PREPARING DATAFRAME####
Credit$Gender<-NULL
Credit$Student<-NULL
Credit$Married<-NULL
Credit$Ethnicity<-NULL
head(Credit)

####a####
library(ggplot2)
library(ggcorrplot)

Credit$ID<-NULL
correl <- cor(Credit)
print(correl)
####b####
ggcorrplot(correl,
           lab=TRUE,
           method="circle",
           lab_size=3,
           colors= c("green","yellow","red"))

####c####

g1<-ggplot(Credit,aes(Balance,Rating,color=Income))+
  geom_point()+
  geom_smooth(color="orange")+
  labs(title="Correlation between Balance and Rating",
       subtitle="from Credit dataframe",
       caption="What a wonderful plot !",
       x="X - Balance",
       y="Y - Rating")

plot(g1)


####TASK 3####
rm(list=ls())
library(ISLR)
data("Credit")
attach(Credit)

head(Credit)
levels(Credit$Ethnicity)
length(levels(Credit$Ethnicity))

mean<-aggregate(Credit$Income, by=list(Ethnicity), FUN=mean)
std<-aggregate(Credit$Income, by=list(Ethnicity), FUN=sd)
print(mean)
print(std)

g2<-ggplot(Credit,aes(Income))+
  geom_density(aes(fill=factor(Ethnicity)),alpha=0.7)

plot(g2)

####TASK 4####
rm(list=ls())
library(ISLR)
data("Credit")
attach(Credit)
library(dplyr)

sorted <- arrange(Credit,Balance,desc(Income))
head(sorted)
#The person with the highest income and balance equal to 0 is 32 years old.


####TASK 5####
rm(list=ls())
library(ISLR)
data("Credit")
attach(Credit)
Credit$Old <- ifelse(Credit$Age >60,
                              "Old",
                              "Young")

means<-aggregate(list(Credit[,2:7],Credit[12]), by=list(Credit$Old), FUN=mean)
print(means)
####TASK 6####
rm(list=ls())
library(ISLR)
library(ggplot2)
data("Credit")
attach(Credit)
g3<-ggplot(Credit,aes(Student,Balance))+
  geom_boxplot(aes(fill=Gender))+
  scale_fill_brewer(palette='Accent')+
  labs(title="Credit card balance for students vs non-students")
  theme_bw()

plot(g3)

