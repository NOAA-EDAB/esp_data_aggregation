
fh_grouped<-allfh %>% group_by(year, season, gensci,stratum_area)

levels(allfh$pdcomnam)
fh_cod<-allfh %>% filter(pdcomnam=="ATLANTIC COD") %>% select(pynum, pyperi, pywgti, pyvoli, pylen, 
                                                              pyamtw, pyamtv, perpyv, perpyw, pdscinam, 
                                                              pdcomnam, pdcomnam, svspp, gensci, pyamtw, year, 
                                                              season,gencat, gensci, analcat, analsci)
sp.cod<-fh_cod %>% filter(season=="SPRING")


library(nmfspalette)



freq.cod<-sp.cod %>% group_by(year,analsci) %>% summarise(freq=length(analsci), occur= sum(length(analsci)))


s.cod<-fh_cod %>% dplyr::group_by(year, season, gensci) %>%  dplyr::summarise(total_weight = sum(pyamtw)) 


install.packages("ps")

hist(s.cod)
install.packages("ggridges")
library(ggridges)


t.cod<- s.cod %>% filter(year < 2000 &  year > 1990 )
ggplot(t.cod, aes(x=log10(total_weight+1), y=gensci))+ geom_density_ridges()+
  ggtitle("Log frequency of gut weight by catagory in Atlantic cod")+
  xlab("log total weight (g)")+
  ylab("General catagory of prey")

s.cod %>% filter(year < 2000 &  year > 1900 )  %>%    ggplot( aes(x=year, y=total_weight,group=gensci))+ geom_density_ridges()
, group=gensci 

library(tidyverse)


s.cod<-allfh %>% filter(year==2001 & pdcomnam=="ATLANTIC COD")


id_1<-s.cod %>%filter( pdid==1)
unique(id_1$pyamtw)

sum.cod<-s.cod %>% group_by()






twothou<- s.cod %>% filter(year==2001)
twothou
unique(length(twothou$gensci))







install.packages("vegan")
browseVignettes("vegan")
library("vegan")
data(BCI,envir = environment())
head(BCI)
bci<-load(BCI)
bci<-data(BCI)

H <- diversity(BCI)
simp <- diversity(BCI, "simpson")
invsimp <- diversity(BCI, "inv")
## Unbiased Simpson (Hurlbert 1971, eq. 5) with rarefy:
unbias.simp <- rarefy(BCI, 2) - 1
## Fisher alpha
alpha <- fisher.alpha(BCI)
## Plot all
pairs(cbind(H, simp, invsimp, unbias.simp, alpha), pch="+", col="blue")
## Species richness (S) and Pielou's evenness (J):
S <- specnumber(BCI) ## rowSums(BCI > 0) does the same...
J <- H/log(S)
## beta diversity defined as gamma/alpha - 1:
data(dune)
data(dune.env)
alpha <- with(dune.env, tapply(specnumber(dune), Management, mean))
gamma <- with(dune.env, specnumber(dune, Management))
gamma/alpha - 1








