library(FSA)
library(tidyverse)
library(FSA)
library(nlstools)
install.packages("nlstools")


#only take records with age associated
selected.surv.clean<-selected.surv %>% drop_na(AGE)
#define the type of von b model
vb <- vbFuns(param="Typical")
#define starting parameters based on the avalible data 
f.starts<-FSA::vbStarts(LENGTH~AGE ,data = selected.surv.clean,methLinf="oldAge" )

#fit a non-linear least squares model based on the data and starting values 
f.fit <- nls(LENGTH~vb(AGE,Linf,K,t0),data=selected.surv.clean, start=f.starts)
#store the fit parameters for later investigation
f.fit.summary<-summary(f.fit,correlation=TRUE)

#define the range of age values that will be used to generate points from the fitted model
#roughly by 0.2 year steps
newages<- data.frame(AGE=seq(0, 50, length = 250))
#predict(f.fit,newdata=newages) this funtion uses the model from f.fit to generate new lengths 
#make a dataset with the values from the model
selected.surv.vonb<-data.frame(AGE=seq(1, 50, length = 250), LENGTH=predict(f.fit,newdata=newages))



selected.surv.vonb %>%
  ggplot(aes(x=AGE, y=LENGTH))+
  geom_line(color= "blue",size=1.4)+
  xlab("Age")+
  ylab(" Total length (cm)")+
  labs(color="Common name of stock")+
  ggtitle(str_to_sentence(params$stock), subtitle = "Length at age")+
  theme_minimal()+
  geom_point(data=selected.surv,aes(x=AGE, y=LENGTH), color="red")+
  xlim(0,(1.5*max(selected.surv$AGE, na.rm = TRUE)))

ggplot()
new.data<-

predict.nls(f.fit)
predict(f.fit,data.frame(age=2:25))
library(car) 

predict2 <- function(x) predict(x,data.frame(age=ages))
ages <- 2:25
predict2(f.fit)  # demonstrates same result as predict() above
ages <- seq(-1,25,by=0.2)

f.boot2 <- Boot(f.fit,f=predict2)  # Be patient! Be aware of some non-convergence

preds1 <- data.frame(ages,
                     predict(f.fit,data.frame(age=ages)),
                     confint(f.boot2))
names(preds1) <- c("age","fit","LCI","UCI")
headtail(preds1)
 