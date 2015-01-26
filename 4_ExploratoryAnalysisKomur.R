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


########## Aggregate data by different time strata for whole time period #######
komuryear <- aggregate(id~year, data=komurdata, FUN=length)
# Find proportion compared to total pop for each year
komuryear <- merge(komuryear, popdatayear, by="year")
komuryear$percent <-komuryear$id / komuryear$popyear * 100

komurmonth <- aggregate(id~month, data=komurdata, FUN=length)
komurweek <- aggregate(id~week, data=komurdata, FUN=length)
komurday <- aggregate(id~day, data=komurdata, FUN=length)
komurweekday <- aggregate(id~weekday, data=komurdata, FUN=length)

komuryear
komurmonth
komurweek
komurday
komurweekday

####### Graphs to see if any seasonal trend of total time period ########
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


####### Subset data for each year #########

y2007 <- subset(komurdata, komurdata$year == "2007")
y2008 <- subset(komurdata, komurdata$year == "2008")
y2009 <- subset(komurdata, komurdata$year == "2009")
y2010 <- subset(komurdata, komurdata$year == "2010")
y2011 <- subset(komurdata, komurdata$year == "2011")
y2012 <- subset(komurdata, komurdata$year == "2012")
y2013 <- subset(komurdata, komurdata$year == "2013")
y2014 <- subset(komurdata, komurdata$year == "2014")

###### Look at each year seperatly ######
# 2007
month2007 <- aggregate(id~month, data=y2007, FUN=length)
week2007 <- aggregate(id~week, data=y2007, FUN=length)
month2007$year <- "2007"
week2007$year <- "2007"


# Month
ggplot(month2007,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2007")

# Week
ggplot(week2007,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2007")

# 2008   
month2008 <- aggregate(id~month, data=y2008, FUN=length)
week2008 <- aggregate(id~week, data=y2008, FUN=length)
month2008$year <- "2008"
week2008$year <- "2008"


# Month
ggplot(month2008,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2008")

# Week
ggplot(week2008,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2008")

# 2009   
month2009 <- aggregate(id~month, data=y2009, FUN=length)
week2009 <- aggregate(id~week, data=y2009, FUN=length)
month2009$year <- "2009"
week2009$year <- "2009"


# Month
ggplot(month2009,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2009")

# Week
ggplot(week2009,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2009")

# 2010   
month2010 <- aggregate(id~month, data=y2010, FUN=length)
week2010 <- aggregate(id~week, data=y2010, FUN=length)
month2010$year <- "2010"
week2010$year <- "2010"


# Month
ggplot(month2010,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2010")

# Week
ggplot(week2010,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2010")

# 2011   
month2011 <- aggregate(id~month, data=y2011, FUN=length)
week2011 <- aggregate(id~week, data=y2011, FUN=length)
month2011$year <- "2011"
week2011$year <- "2011"


# Month
ggplot(month2011,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2011")

# Week
ggplot(week2011,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2011")

# 2012   
month2012 <- aggregate(id~month, data=y2012, FUN=length)
week2012 <- aggregate(id~week, data=y2012, FUN=length)
month2012$year <- "2012"
week2012$year <- "2012"


# Month
ggplot(month2012,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2012")

# Week
ggplot(week2012,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2012")

# 2013   
month2013 <- aggregate(id~month, data=y2013, FUN=length)
week2013 <- aggregate(id~week, data=y2013, FUN=length)
month2013$year <- "2013"
week2013$year <- "2013"


# Month
ggplot(month2013,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2013")

# Week
ggplot(week2013,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2013")

# 2014   
month2014 <- aggregate(id~month, data=y2014, FUN=length)
week2014 <- aggregate(id~week, data=y2014, FUN=length)
month2010$year <- "2014"
week2010$year <- "2014"


# Month
ggplot(month2014,aes(x = month,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in 2014")

# Week
ggplot(week2014,aes(x = week,y = id)) +
          geom_bar(stat = "identity") + 
          ylab("Number of ER visits in each week in 2014")

# Lets bind each year together to see it more visually - THIS IS NOT CORRECT
timeseries <- rbind(month2007, month2008, month2009, month2010, month2011, month2012, month2013, month2014)


######## Aggregate by postalcode, municipality and quarter ###########
# Look at where individals live that come to ER

#### No. of ER visits per postalcode 
aggpost <- aggregate(id~postnr, data=komurdata, FUN=length)

# Find proportion of ER visits compared to total pop of each postalcode
aggpost <- merge(aggpost, poppost, by="postnr")
aggpost$percent <- aggpost$id / aggpost$totalpoppost * 100 


# aggpost <- merge(aggpost, popdataPost, by="postnr")

#### No. of ER visits per Municipality
aggmun <- aggregate(id~municipality, data=komurdata, FUN=length)

# Find proportion of visits compared to total pop of each postalcode
aggpopmun <- aggregate(totalpoppost ~ popmunicipality, data=popdata, FUN=sum)
colnames(aggpopmun) <- c("municipality", "totalpopmunicipality")

aggmun <- merge(aggmun, aggpopmun, by="municipality")
aggmun$percent <- aggmun$id / aggmun$totalpopmunicipality * 100 

#### No. of ER visits per Quarter
aggquart <- aggregate(id~quarter, data=komurdata, FUN=length)
# Find proportion of visits compared to total pop of each postalcode
aggpopquart <- aggregate(totalpoppost ~ popquarter, data=popdata, FUN=sum)
colnames(aggpopquart) <- c("quarter", "totalpopquarter")

aggquart <- merge(aggquart, aggpopquart, by="quarter")
aggquart$percent <- aggquart$id / aggquart$totalpopquarter * 100 

####### Graphs for location
ggplot(aggpost,aes(x= postnr, y= percent))+
          geom_bar(stat = "identity")+
          facet_grid(.~postnr)+
          theme_bw()

ggplot(aggpost,aes(x = postnr,y = percent))+
          geom_bar(stat = "identity") + 
          ylab("Percent of ER visits within each postalcode")

ggplot(aggmun,aes(x = municipality,y = percent))+
          geom_bar(stat = "identity") + 
          ylab("Percent of ER visits within each municipality")

ggplot(aggquart,aes(x = quarter,y = percent))+
          geom_bar(stat = "identity") + 
          ylab("Percent of ER visits within each city quarter")


# aggicd1 <- aggregate(postnr~icd1, data=komurdata, FUN=length)
# aggpost
# aggmun
# aggquart
# aggicd1

####### Count how many in each location have either a respiratory, cardio or 
# cerebrevacular diagnosis as a first diagnosis #####

# Aggregate diagnosis by postalcode
icd_taln <- aggregate(komurdata[c("resp1","card1","cere1")], 
          by = komurdata[c("postnr")], FUN=sum)

# Aggregate diagnosis by municipality
icd_taln_mun <- aggregate(komurdata[c("resp1","card1","cere1")], 
                              by = komurdata[c("municipality")], FUN=sum)

# Aggregate diagnosis by city quarter
icd_taln_quarter <- aggregate(komurdata[c("resp1","card1","cere1")], 
                      by = komurdata[c("quarter")], FUN=sum)

# Graph by location and first diagnosis

library(reshape2)
icd_taln <- melt(data = icd_taln,id.vars = "postnr",value.name = c("count"),
                 variable.name = c("ICD"))

icd_taln_mun <- melt(data = icd_taln_mun, id.vars = "municipality", 
                     value.name = "count", variable.name = "ICD")

icd_taln_quarter <- melt(data = icd_taln_quarter,id.vars = "quarter",
                         value.name = c("count"),variable.name = c("ICD"))

ggplot(icd_taln,aes(ICD,count,fill=ICD))+
          geom_bar(stat = "identity")+
          facet_grid(.~postnr)+
          theme_bw() + 
          ylab("No. of ER visits within each postalcode")

ggplot(icd_taln_mun,aes(ICD,count,fill=ICD))+
          geom_bar(stat = "identity") +
          facet_grid(.~municipality) +
          theme_bw() +
          ylab("No. of ER visits within each municipality")

ggplot(icd_taln_quarter,aes(ICD,count,fill=ICD))+
          geom_bar(stat = "identity") +
          facet_grid(.~quarter) +
          theme_bw() +
          ylab("No. of ER visits within each city quarter")

##### Aggregate by month and postalcode #########
monthpost <- aggregate(komurdata[c("id")], 
                           by = komurdata[c("month","postnr")], FUN=length)
