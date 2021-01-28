library(FSA)
library(tidyverse)
library(FSA)
library(FSAdata)
library(nlstools)

 vb <- vbFuns(param="Typical")
 
f.starts<-FSA::vbStarts(LENGTH~AGE ,data =selected.surv )

f.fit <- nls(LENGTH~vb(age,Linf,K,t0),data=selected.surv,start=f.starts)
