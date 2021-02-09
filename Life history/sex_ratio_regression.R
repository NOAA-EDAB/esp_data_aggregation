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
#get discriptions of codes of sex and maturity
sex.codes<-survdat::get_sex(channel)
sex.fcs<-survdat::get_sex_fscs(channel)
sex.maturity<-survdat::get_maturity(channel)


bsb<-survdata.w.codes %>% filter(common_name == "black sea bass")
#change year from char to numeric 
bsb <- bsb %>% mutate(YEAR=as.numeric(YEAR))

#recode sexed fish to readable names
#sex codes 1 male, 2 female, 4 transitional, 0 unsexed/unknown   
bsb$SEX <-recode(bsb$SEX, "1"="male" , "2"="female", "0"="unknown", "4"= "transitional")
#change sex from chr to factor
bsb <-bsb %>% mutate(SEX= as.factor(SEX))
#filter out just m anf f fish for analysis and plotting
bsb.m.f<-bsb %>% filter(SEX== "male" | SEX=="female")



#remove unaged fish
#bsb<-bsb %>% drop_na(AGE)


#bin the years of fish into decades to compare if model parameters are chaging 
bsb.m.f<-bsb.m.f %>% mutate(decade=cut_width(YEAR, width = 10, boundary = 1980))
#levels(bsb.m.f$decade)
levels(bsb.m.f$decade)<-c( "1980","1990", "2000","2010")





#sex ratio plot
#calculate ratio as m/f for each length class 
bsb.ratio<-bsb.m.f %>%  group_by(LENGTH) %>% mutate(sex.ratio=((sum(SEX=="male")/length(SEX))*100), fish.count=length(SEX))

ggplot(data = bsb.ratio)+
  geom_point(aes(x=LENGTH,y=sex.ratio, size=fish.count))+
  xlab("Body Length (cm)")+
  ylab("Percent male  (%) ")+
  guides(size=guide_legend(title=" n"))+
  ggtitle("Male across bodysize ")+
  theme_minimal()
  

#Using a binonmial generalized linear model of body size and sex

library(boot)

bsb.mod<-glm(SEX~LENGTH+decade+LENGTH*decade, data=bsb.m.f, binomial(link = "logit"))
summary(bsb.mod)

boot::inv.logit(bsb.mod$coefficients)
exp(-1.566383)/(1+exp(-1.566383))
exp(-1.566383-0.218066)/(1+exp(-1.566383-0.218066))

((bsb.mod$null.deviance-bsb.mod$deviance)/bsb.mod$null.deviance)
exp(confint(bsb.mod))

ggplot(data= bsb.m.f)+geom_point(aes( x=jitter(LENGTH), y=SEX ,size=AGE)  )



newdata1 <- with(bsb.m.f, data.frame(LENGTH=mean(LENGTH)))
newdata1$ratio<-predict(bsb.mod, newdata = newdata1, type = "response")
#make a new dataset with range of lengths that are observed
bsb.new<-data.frame(LENGTH=seq(min(bsb.m.f$LENGTH),max(bsb.m.f$LENGTH)))


p(male)=1/e^(-2.084707*length)
bsb.new$prob<-predict(bsb.mod, data.frame(LENGTH=seq(min(bsb.m.f$LENGTH),max(bsb.m.f$LENGTH))), type="response")

bsb.demo<-merge(bsb.new,bsb.m.f, by = "LENGTH")
bsb.demo$SEX<-bsb.demo %>% mutate(SEX, as.numeric(SEX))

bsb.demo %>%
  ggplot(aes(x=LENGTH, y=prob))+
  geom_smooth(size=3)+
  geom_point(aes(x=LENGTH,y=SEX))
  xlab("Length (cm)")+
  ylab("Probablity of being male ")+
  geom_text(aes(10,1,label = "Male", vjust = -.5))+
  geom_text(aes(11,0,label = "Female", vjust = -.5))+
  geom_hline(yintercept=c(1,0))+
  annotate("text",x=20,y=.8,label="p(male)=1/e^(-2.084707*length),  P-value= <<0.001")+
  theme_minimal()
  
  plot(bsb.mod)

bsb.demo<-merge(bsb.new,bsb.m.f, by = "LENGTH")



ggplot(data= bsb.demo)+geom_point(aes(x=LENGTH,y=SEX, color=SEX))


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











  
  
  
  dplyr::summarise(sex.ratio= length())









