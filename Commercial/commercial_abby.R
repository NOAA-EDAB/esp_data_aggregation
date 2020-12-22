
# read in data and wrangle (Ricky) ----

#load in the stocks managed in NEFSC
stock_list_all_strata <- read.csv("https://raw.githubusercontent.com/NOAA-EDAB/ECSA/master/data/stock_list.csv")
#lowercase all of the names
stock_list_all_strata$common_name <- stringr::str_to_lower(stock_list_all_strata$common_name)
#extract out the unique names and rename column  
stock_list<-stock_list_all_strata %>% distinct(common_name, .keep_all=TRUE)


#load commercial landings data
com_landings<-readr::read_csv(here::here("commercial","foss_ commercial_landings_NE_MA_1950_2019.csv"))
#renaming cols to aling with stocklist
com_landings<-com_landings %>% rename(common_name=`NMFS Name`)
#simplifying the names to be lowercase 
com_landings$common_name<-stringr::str_to_lower(com_landings$common_name)

#removing empty rows due to confidentiality and counting the number of records removed
confid<-com_landings %>% 
  filter(common_name =="withheld for confidentiality" | Confidentiality == "Confidential" )%>%
  group_by(Year) %>%
  summarise(count=n())
com_landings<-com_landings %>% filter(!common_name =="withheld for confidentiality" , !Confidentiality == "Confidential", !is.na(Pounds), !is.na(Dollars), Dollars >1)


# removing aggrigated landings records and counting their occurance
grouped_landings<-com_landings %>% filter(stringr::str_detect(common_name, "\\*+"))

# rearranging the species names to align with NEFSC conventions
com_landings<-com_landings %>% filter(!stringr::str_detect(common_name, "\\*+"))

#splitting off the records without a comma


single_name<-com_landings %>% filter(!stringr::str_detect(common_name, "\\,\\s"))
multipe_name<-com_landings %>% filter(stringr::str_detect(common_name, "\\,\\s"))
split_names<-multipe_name%>% separate (col=common_name,sep ="\\,\\s", into = c("first" ,"second", "third"))
#fixing plaice to remove flounder
split_names<- split_names %>% dplyr::mutate(first=replace(first, which(second=="american plaice"), NA))
#fixing the shark tag for dogfish
split_names<- split_names %>% dplyr::mutate(first=replace(first, which(second=="dogfish"), NA))
#longfin loligo into inshore
split_names<- split_names %>% dplyr::mutate(second=replace(second, which(second=="longfin loligo"), "longfin inshore"))
#shortfin illex into northern shortfin
split_names<- split_names %>% dplyr::mutate(second=replace(second, which(second=="shortfin illex"), "northern shortfin"))
#goosefish into monkfish
single_name<- single_name %>% dplyr::mutate(common_name=replace(common_name, which(common_name=="goosefish"), "monkfish"))
#adding flounder to windowpane 
single_name<- single_name %>% dplyr::mutate(common_name=replace(common_name, which(common_name=="windowpane"), "windowpane flounder"))
split_names<-split_names %>% unite(col = "last", c(third, second),sep = " ", remove = TRUE ,na.rm = TRUE)
split_names<-split_names %>% unite(col = "common_name", c(last, first),sep = " ", remove = TRUE ,na.rm = TRUE)

joined_names<- dplyr::bind_rows(split_names,single_name)
#used to check that there are no missing stocks in the data
#missing_stocks<-dplyr::anti_join(stock_list,joined_names, by= "common_name")

#final clean dataset
com_landings_clean<-dplyr::full_join(stock_list,joined_names, by= "common_name")

# plot ----
head(com_landings_clean)

plt_data <- com_landings_clean %>%
  dplyr::filter(is.na(sci_name) == FALSE &
                  is.na(State) == FALSE)

# adjust dollars for inflation
quantmod::getSymbols("CPIAUCSL", src='FRED')
avg.cpi <- xts::apply.yearly(CPIAUCSL, mean) 
cf <- avg.cpi/as.numeric(avg.cpi['2019']) # using 2019 as the base year 
cf <- cf %>%
  as.data.frame() %>% 
  tibble::rownames_to_column()
cf$Year <- cf$rowname %>% 
  stringr::str_sub(start = 1, end = 4) %>%
  as.numeric()

plt_data2 <- dplyr::left_join(plt_data, cf, by = "Year")
plt_data2$Dollars_adj <- plt_data2$Dollars / plt_data2$CPIAUCSL

head(plt_data2)

library(ggplot2)

# landings vs revenue
fig <- ggplot(plt_data2,
       aes(x = Pounds/10^6,
           y = Dollars_adj/10^6,
           color = Year))+
  geom_point()+
  geom_line()+
  facet_grid(rows = vars(common_name),
             cols = vars(State),
             scales = "free")+
  xlab("Millions of pounds")+
  ylab("Millions of dollars (adjusted to 2019)")

pdf(here::here("Commercial", "commercial.pdf"), width = 16, height = 60)
fig
dev.off()

# revenue per lb vs year
fig <- ggplot(plt_data2,
              aes(x = Year,
                  y = Dollars_adj/Pounds,
                  color = log(Pounds)))+
  geom_point()+
  geom_line()+
  facet_grid(rows = vars(common_name),
             cols = vars(State),
             scales = "free")+
  ylab("Revenue per pound (adjusted to 2019)")

pdf(here::here("Commercial", "commercial_revenue_per_lb.pdf"), width = 16, height = 60)
fig
dev.off()