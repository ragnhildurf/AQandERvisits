# This script is for exporatory data analysis of AQandERvisit dataset
# Author: Ragnhildur G. Finnbjornsdottir
# Date: 22. Januar 2015
# 
# Description: Here we source ./AnalysisAndScripts/3_Merge_Datasets.R
# This script is for exporatory data analysis of AQandERvisit dataset for ER
# visits. Start with aggregating the data in various ways to f.x. see if there
# are any seasonal patterns in the data.
# Finally there will be plotting of the data to see them visually.

# Source merging script to get dataset
source("./AnalysisAndScripts/3_Merge_Datasets.R")

## Exploratory data on komurdata

# Find average population for each postalcode and timeperiod
poppost<- aggregate(cbind(totalpoppost, adultpoppost)~postnr+year, 
                    data=popdata, FUN=mean)
# Use this when female/male population is in the data
# poppost<- aggregate(cbind(totalpop, adultpop, malepop, femalepop)~postnr+year, 
#                     data=popdata, FUN=mean)


########## Aggregate data by different time strata #########
komuryear <- aggregate(id~year, data=komurdata, FUN=length)
# Find proportion compared to total pop for each year
komuryear <- merge(komuryear, popdatayear, by="year")
komuryear$percent <-komuryear$id / komuryear$popyear * 100

komurmonth <- aggregate(id~month, data=komurdata, FUN=length)
komurweek <- aggregate(id~week, data=komurdata, FUN=length)
komurday <- aggregate(id~day, data=komurdata, FUN=length)
komurweekday <- aggregate(id~weekday, data=komurdata, FUN=length)


# Look at where individals live that come to ER
######## Aggregate by postalcode, municipality and quarter ###########

# Postalcode
aggpost <- aggregate(id~postnr, data=komurdata, FUN=length)
# Find proportion of visits compared to total pop of each postalcode
aggpost <- merge(aggpost, popdata, by="postnr")
aggpost$percent <- aggpost$id / aggpost$totalpoppost * 100 


# aggpost <- merge(aggpost, popdataPost, by="postnr")

# Municipality
aggmun <- aggregate(id~municipality, data=komurdata, FUN=length)

# Find proportion of visits compared to total pop of each postalcode
aggpopmun <- aggregate(totalpoppost ~ popmunicipality, data=popdata, FUN=sum)
colnames(aggpopmun) <- c("municipality", "totalpopmunicipality")

aggmun <- merge(aggmun, aggpopmun, by="municipality")
aggmun$percent <- aggmun$id / aggmun$totalpopmunicipality * 100 

# Quarter
aggquart <- aggregate(id~quarter, data=komurdata, FUN=length)
# Find proportion of visits compared to total pop of each postalcode
aggpopquart <- aggregate(totalpoppost ~ popquarter, data=popdata, FUN=sum)
colnames(aggpopquart) <- c("quarter", "totalpopquarter")

aggquart <- merge(aggquart, aggpopquart, by="quarter")
aggquart$percent <- aggquart$id / aggquart$totalpopquarter * 100 


# aggicd1 <- aggregate(postnr~icd1, data=komurdata, FUN=length)
# aggpost
# aggmun
# aggquart
# aggicd1

# skoðaðu siðuna www.cookbook-r.com
icd_taln <- aggregate(komurdata[c("resp1","card1","cere1")], 
          by = komurdata[c("postnr")], FUN=sum)


icd_taln_quarter <- aggregate(komurdata[c("resp1","card1","cere1")], 
                      by = komurdata[c("quarter")], FUN=sum)

##### Aggregate bay month and postalcode #########
monthpost <- aggregate(komurdata[c("id")], 
                           by = komurdata[c("month","postnr")], FUN=length)
timi_month

######### Graphs ###########
library(ggplot2)
# How does 
ggplot(subset(aggicd1,postnr>1000),aes(x = icd1,y = postnr))+
          geom_bar(stat = "identity")


# Plot number of ER visits for each time strata
# Year
ggplot(komuryear,aes(x = year,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits")

ggplot(komuryear, aes(x=year, y = percent)) + 
          geom_bar(stat = "identity") +
          ylab("Percent of ER visits")

# Month
ggplot(komurmonth,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits")

# Week
ggplot(komurweek,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits")

# Day
ggplot(komurday,aes(x = day,y = id))+
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits")

# Weekday 
ggplot(komurweekday,aes(x = weekday,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits")

library(reshape2)
icd_taln_l <- melt(data = icd_taln,id.vars = "postnr",value.name = c("count"),variable.name = c("ICD"))
icd_taln_quarter_l <- melt(data = icd_taln_quarter,id.vars = "quarter",value.name = c("count"),variable.name = c("ICD"))

ggplot(icd_taln_l,aes(ICD,count,fill=ICD))+
          geom_bar(stat = "identity")+
          facet_grid(.~postnr)+
          theme_bw()

ggplot(icd_taln_quarter_l,aes(ICD,count,fill=ICD))+
          geom_bar(stat = "identity")+
          facet_grid(.~quarter)+
          theme_bw()


ggplot(timi_month,aes(month,id,fill=month))+
          geom_bar(stat = "identity")+
          facet_grid(.~postnr)+
          theme_bw()
