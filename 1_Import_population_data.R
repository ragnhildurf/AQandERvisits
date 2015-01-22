## Import H2S exposure estimate file, data cleaning and subsetting (if nessicary)
# Author: Ragnhildur G. Finnbjornsdottir
# Date: 21. January 2015
# 
# Description: Import population data for the greater Reykjavik area


# Set correct working directory - AnalysisAndScripts
# setwd("./Dropbox/AQandERvisits")

## Import data. No cleaning needed.
popdata <- read.csv("./DATA/Population//RvkPopulation_2005_2014_Use.csv") # Import data
popdatayear <- read.csv("./DATA/Population/PopDataGreaterRvk2005_2013.csv")


# Set correct format of cells
popdata$postnr <- as.factor(popdata$postnr)
popdata$totalpoppost <- as.numeric(as.character(popdata$totalpop))
popdata$adultpoppost <- as.numeric(as.character(popdata$adultpop))
popdata$malepoppost <- as.numeric(as.character(popdata$malepop))
popdata$femalepoppost <- as.numeric(as.character(popdata$femalepop))

# Merge two population datasets
popdata <- merge(popdata, popdatayear, "year")

######## Add columns defining popmunicipality and popquarters #####
popdata <- mutate(popdata,
                  postnr = as.factor(postnr),
                  # Flokka location i capital area eða rural area
                  location = ifelse(postnr %in% c("101", "103", "104", "105", 
                                                  "107", "108", "109", "110", 
                                                  "111", "112", "113", "170", 
                                                  "200", "201", "203", "210",
                                                  "220", "221", "225", "270",
                                                  "271", "276"),
                                    'capital','rural'))

# Classify by popmunicipality
popdata$popmunicipality <- "other"
popdata$popmunicipality[popdata$postnr %in% c("101", "103", "104", "105", "107", 
                                           "108", "109", "110", "111", "112", 
                                           "113")] <- "rvk"
popdata$popmunicipality[popdata$postnr %in% c("170")] <- "seltjarnanes"
popdata$popmunicipality[popdata$postnr %in% c("210", "225")] <- "gardabaer"
popdata$popmunicipality[popdata$postnr %in% c("220", "221")] <- "hafnarfjordur"
popdata$popmunicipality[popdata$postnr %in% c("270", "271", "276")] <- "moso"
popdata$popmunicipality[popdata$postnr %in% c("200", "201", "203")] <- "kop"
popdata$popmunicipality[popdata$postnr %in% c("810")] <- "hveragerdi"

# Classify by city popquarters
popdata$popquarter <- "other"
popdata$popquarter[popdata$postnr %in% c("101")] <- "rvkmid"
popdata$popquarter[popdata$postnr %in% c("103", "108")] <- "haaleiti" # Háaleitis- og Bústaðahv.
popdata$popquarter[popdata$postnr %in% c("104")] <- "laugardalur"
popdata$popquarter[popdata$postnr %in% c("105")] <- "hlidar"
popdata$popquarter[popdata$postnr %in% c("107")] <- "vesturb"
popdata$popquarter[popdata$postnr %in% c("110")] <- "arbaer"
popdata$popquarter[popdata$postnr %in% c("109", "111")] <- "breidholt"
popdata$popquarter[popdata$postnr %in% c("112")] <- "gravarv"
popdata$popquarter[popdata$postnr %in% c("113")] <- "grafarh"
popdata$popquarter[popdata$postnr %in% c("170")] <- "seltjarnanes"
popdata$popquarter[popdata$postnr %in% c("210", "225")] <- "gardabaer"
popdata$popquarter[popdata$postnr %in% c("220", "221")] <- "hafnarfjordur"
popdata$popquarter[popdata$postnr %in% c("270", "271", "276")] <- "moso"
popdata$popquarter[popdata$postnr %in% c("200", "201", "203")] <- "kop"
popdata$popquarter[popdata$postnr %in% c("810")] <- "hveragerdi"
