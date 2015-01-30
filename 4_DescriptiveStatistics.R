# This script is for descriptive analysis of AQandERvisit dataset
# Author: Ragnhildur G. Finnbjornsdottir and Hanne Krage Carlsen
# Date: 26. Januar 2015
# 
# Description: Here we source ./AnalysisAndScripts/3_Merge_Datasets.R which 
# contains the whole dataset.
# This script is for descrioptive analysis of AQandERvisit dataset for ER
# visits and admissions. 

# Source merging script to get dataset
source("./AnalysisAndScripts/4_ExploratoryAnalysisKomur.R")

# Plot small sample of H2S exposure estimate at two different locations 
# (direction from Hellisheidi)
plot(expdata$dir95[1:1000]) # first 1000 hours of time series
lines(expdata$dir135[1:1000], type="p", col="red")
# This shows that there is a contrast in the exposure

# Check if there is a correlation between areas
cor.test(expdata$dir95, expdata$dir105)
cor.test(expdata$dir95, expdata$dir115)
cor.test(expdata$dir95, expdata$dir125)
cor.test(expdata$dir95, expdata$dir135)

###
summary(komurdata$dir95)
summary(komurdata$dir105)
summary(komurdata$dir115)
summary(komurdata$dir125)
summary(komurdata$dir135)

summary(komurdata$age)
length(komurdata$resp1[komurdata$resp1==1])
length(komurdata$card1[komurdata$card1==1])
length(komurdata$cere1[komurdata$cere1==1])
summary(innlagnirdata$age)

length(innlagnirdata$resp1[innlagnirdata$resp1==1])
length(innlagnirdata$card1[innlagnirdata$card1==1])
length(innlagnirdata$cere1[innlagnirdata$cere1==1])
summary(innlagnirdata$age)


# Table how many ER visits there are in different areas.
table(komurdata$dir_n)

###### Create time series graphs for number of ER admissins per day #####
# Start by aggregateing number of cases by date
komurdate <- aggregate(id~date, data=komurdata, FUN=length)
innlagnirdate <- aggregate(id~date, data=innlagnirdata, FUN=length)

# Plot ER visits and admissios seperately
ggplot(komurdate,aes(x = date,y = id)) +
          geom_point(stat = "identity") + 
          ylab("Number of ER visits per day")

ggplot(innlagnirdate,aes(x = date,y = id)) +
          geom_point(stat = "identity") + 
          ylab("Number of admissions per day")

# Plot ER visits and admissions together
ggplot() +
          geom_point(data=komurdate, aes(x = date,y = id, color ="ER visits")) +
          geom_point(data=innlagnirdate, aes(x = date,y = id, color ="Admissions")) +
          ylab("Number of ER visits per day") +
          labs(color="ER visits and Admissions")

# ggplot() +
#           geom_point(data=komurmonth, aes(x = date,y = id, color ="ER visits")) +
#           geom_point(data=innlagnirmonth, aes(x = date,y = id, color ="Admissions")) +
#           ylab("Number of ER visits per day") +
#           labs(color="ER visits and Admissions")

###### Plot H2S exposure estimate (24-hour running average) for each classified 
# direction to Hellisheidi. The exposure estimate is the same for ER visits 
# and admissions therefore only the data in komurdata will be used.

# Put exposure data in convienient form 
library(reshape2)
melt_expdata <- melt(data=expdata, id.vars="datetime", 
                     value.name=c("concentration"), 
                     variable.name="direction")

# This doesn´t add to the information of the following plot
# # Add number of ER visits to dataframe to plot it with the exposure data
# # Start by aggregateing the data by datetime and direction
# komurdatetime <- aggregate(id~as.character(datetime)+dir, data=komurdata, FUN=length)
# # Set corresponding column names
# colnames(komurdatetime) <- c("datetime", "direction", "count")
# 
# # Harmonise direction classification with exposure
# komurdatetime$direction <- paste("dir", komurdatetime$direction, sep="")
# # Set correct type
# komurdatetime$datetime <- as.POSIXct(komurdatetime$datetime, "%d-%m-%Y %H:%M:%S")
# 
# komurdatetime$direction <- as.factor(komurdatetime$direction)
# komurdatetime$count <- as.numeric(komurdatetime$count)
#  
# melt_expdata <- merge(melt_expdata, komurdatetime, by= c("datetime", "direction"))

# Plot exposure data
ggplot(melt_expdata,aes(datetime, concentration, fill=direction))+
          geom_point(stat = "identity")+
          facet_grid(direction~.)+
          theme_bw() + 
          ylab("H2S exposure estimate in each area")

# Plot zones individually...
ggplot(komurdata,aes(x = date,y = dir95)) +
          geom_point(stat = "identity") + 
          ylab("H2S exposure estimate for area 95° direction from Hv")

ggplot(komurdata,aes(x = date,y = dir105)) +
          geom_point(stat = "identity") + 
          ylab("H2S exposure estimate for area 105° direction from Hv")

ggplot(komurdata,aes(x = date,y = dir115)) +
          geom_point(stat = "identity") + 
          ylab("H2S exposure estimate for area 115° direction from Hv")

ggplot(komurdata,aes(x = date,y = dir125)) +
          geom_point(stat = "identity") + 
          ylab("H2S exposure estimate for area 125° direction from Hv")

ggplot(komurdata,aes(x = date,y = dir135)) +
          geom_point(stat = "identity") + 
          ylab("H2S exposure estimate for area 135° direction from Hv")





