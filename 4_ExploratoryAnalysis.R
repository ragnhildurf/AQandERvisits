# This script is for exporatory data analysis of AQandERvisit dataset

# Source merging script to get dataset
source("./AnalysisAndScripts/3_Merge_Datasets.R")

## Exploratory data begins with komurdata

# Plot ER visits per week
komurdata$date <- as.Date(komurdata$date)
komurweek <- aggregate(id~datetime, data=komurdata, FUN=lenght)


# Look at where individals live that come to ER
# Lets start by aggregateing by postalcode, municipality and quarter
aggpost <- aggregate(id~postnr, data=komurdata, FUN=length)
aggmun <- aggregate(id~municipality, data=komurdata, FUN=length)
aggquart <- aggregate(id~quarter, data=komurdata, FUN=length)
aggicd1 <- aggregate(postnr~icd1, data=komurdata, FUN=length)
aggpost
aggmun
aggquart
aggicd1

# skoðaðu siðuna www.cookbook-r.com
icd_taln <- aggregate(komurdata[c("resp1","card1","cere1")], 
          by = komurdata[c("postnr")], FUN=sum)


icd_taln_quarter <- aggregate(komurdata[c("resp1","card1","cere1")], 
                      by = komurdata[c("quarter")], FUN=sum)

##### Timi #########
timi_month <- aggregate(komurdata[c("id")], 
                           by = komurdata[c("month","postnr")], FUN=length)


######### Gröf ###########
library(ggplot2)
ggplot(subset(aggicd1,postnr>1000),aes(x = icd1,y = postnr))+
          geom_bar(stat = "identity")

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
