install.packages("aod")

library(here)
library(tidyverse)
library(aod)



#logtistic regression of sex ratio


#load in survdat

survdata<-readRDS(here::here("survdat_pull_bio.rds"))
#change the svspp to capitials to merge to ecsa stock list
survdata<-survdata %>% mutate(SVSPP=as.numeric(SVSPP))
stock_list_all_strata <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
stock_list_all_strata<-stock_list_all_strata %>% rename(SVSPP=svspp)
stock_list<-stock_list_all_strata %>% dplyr::distinct(SVSPP,.keep_all =T)

survdata.w.codes<-inner_join(survdata, stock_list, by= "SVSPP" )

library(survdat)
library(dbutils)
channel<-dbutils::connect_to_database("sole", uid="RTABANDERA")
sex.codes<-survdat::get_sex(channel)
sex.fcs<-survdat::get_sex_fscs(channel)

survdat::
bsb<-survdata.w.codes %>% filter(common_name == "black sea bass")
surv.maturity<-survdat::get_maturity(channel)
bsb %>% distinct(SEX)
bsb <- bsb %>% mutate(YEAR=as.numeric(YEAR))




#sex codes 1 male, 2 female, 4 transitional, 0 unsexed   
bsb.m.f<-bsb %>% filter(SEX== 1 | SEX==2, YEAR>2000)


bsb.m.f$SEX <-recode(bsb.m.f$SEX, "1"="MALE" , "2"="FEMALE")
bsb.m.f <-bsb.m.f %>% mutate(SEX= as.factor(SEX))
bsb.m.f <- bsb.m.f %>% mutate(SEX, SEX= as.numeric(bsb.m.f$SEX))

# bsb.m.f<-bsb.m.f %>% mutate(SEX=as.factor(SEX))
# bsb.m.f %>% ggplot(aes(x=SEX))+geom_histogram(stat="count")
# 
# bsb.m.f %>% ggplot(aes(x=SEX, y=LENGTH))+geom_boxplot()
# 



bsb.mod<-glm(SEX~LENGTH, data=bsb.m.f, binomial(link = "logit"))

summary(bsb.mod)

bsb.new<-data.frame(LENGTH=seq(5,60))
predict(bsb.mod, newdata=bsb.new)

bsb.new$prob<-predict(bsb.mod, data.frame(LENGTH=seq(5,60)), type="response")
bsb.new %>% ggplot(aes(x=LENGTH, y=prob))+stat_smooth()+ geom_point(data=bsb.m.f,aes(x=LENGTH, y=SEX))

bsb.demo<-merge(bsb.new,bsb.m.f, by = "LENGTH")


ggplot(data = bsb.demo,aes(x=LENGTH, y=prob))+
  geom_point(aes(x=LENGTH, y=SEX))+
  scale_y_continuous(
    
    # Features of the first axis
    name = "SEX",
    
    # Add a second axis and specify its features
    sec.axis = sec_axis( trans =~., name="Probability")
  )


ggplot(data = bsb.m.f)+geom_point(aes(x=LENGTH , y= SEX , size=AGE))+
  geom_smooth(data= bsb.new,aes(x=LENGTH,y=(prob+1)))+
  scale_y_continuous(
  
  # Features of the first axis
  name = "SEX",
  
  # Add a second axis and specify its features
  sec.axis = sec_axis( trans =~., name="Probability")
)

