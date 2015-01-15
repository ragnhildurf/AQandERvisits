# ## Import GPS locations file (fjarlaegd_2010.xlsx), clean and subset (if needed)
# Author: Ragnhildur G. Finnbjornsdottir
# Date: 2. December 2014
# 
# Description: Here we import location data for each home adress in Reykjavik. 
# These are gps coordinates, distance and direction from Hellisheidi power 
# plant. Correct format of variables set and home adresses are grouped according
# to location (greater Rvk area, rural, municipalities and city qurters). 
# Mean distance and direction from Hellisheidi for each street found.

library(lubridate)
library(plyr)

## Import data and clean data
data <- read.table("./DATA/GeoData/fjarlaegd_2010.csv", header = T, sep=",",
                   dec = ".", fill= T, encoding = "UTF-8")  # Import data

names(data) <- tolower(names(data)) # Put names to lower case

# Subset by taking out unnecessary columns
gpsdata <- data[, c(1, 4:8, 12:15, 19)] # Take out unnecessary colums
rm(data)

# Set columns in correct format and classify capital area into municipalities
# and city quarters (not sure if this is the best way - if not, please edit)

gpsdata <- mutate(gpsdata,
                postnr = as.factor(postnr),
                husnr = as.factor(husnr),
                dist2hel = as.numeric(dist2hel),                
                # Flokka location i capital area eða rural area
                location = ifelse(postnr %in% c("101", "103", "104", "105", 
                                                "107", "108", "109", "110", 
                                                "111", "112", "113", "170", 
                                                "200", "201", "203", "210",
                                                "220", "221", "225", "270",
                                                "271", "276"),
                                  'capital','rural'))

# Classify by municipality
gpsdata$municipality <- "other"
gpsdata$municipality[gpsdata$postnr %in% c("101", "103", "104", "105", "107", 
                                           "108", "109", "110", "111", "112", 
                                           "113")] <- "rvk"
gpsdata$municipality[gpsdata$postnr %in% c("170")] <- "seltjarnanes"
gpsdata$municipality[gpsdata$postnr %in% c("210", "225")] <- "gardabaer"
gpsdata$municipality[gpsdata$postnr %in% c("220", "221")] <- "hafnarfjordur"
gpsdata$municipality[gpsdata$postnr %in% c("270", "271", "276")] <- "moso"
gpsdata$municipality[gpsdata$postnr %in% c("200", "201", "203")] <- "kop"
gpsdata$municipality[gpsdata$postnr %in% c("810")] <- "hveragerdi"

# Classify by city quarters
gpsdata$quarter <- "other"
gpsdata$quarter[gpsdata$postnr %in% c("101")] <- "rvkmid"
gpsdata$quarter[gpsdata$postnr %in% c("103", "108")] <- "haaleiti" # Háaleitis- og Bústaðahv.
gpsdata$quarter[gpsdata$postnr %in% c("104")] <- "laugardalur"
gpsdata$quarter[gpsdata$postnr %in% c("105")] <- "hlidar"
gpsdata$quarter[gpsdata$postnr %in% c("107")] <- "vesturb"
gpsdata$quarter[gpsdata$postnr %in% c("110")] <- "arbaer"
gpsdata$quarter[gpsdata$postnr %in% c("109", "111")] <- "breidholt"
gpsdata$quarter[gpsdata$postnr %in% c("112")] <- "gravarv"
gpsdata$quarter[gpsdata$postnr %in% c("113")] <- "grafarh"
gpsdata$quarter[gpsdata$postnr %in% c("170")] <- "seltjarnanes"
gpsdata$quarter[gpsdata$postnr %in% c("210", "225")] <- "gardabaer"
gpsdata$quarter[gpsdata$postnr %in% c("220", "221")] <- "hafnarfjordur"
gpsdata$quarter[gpsdata$postnr %in% c("270", "271", "276")] <- "moso"
gpsdata$quarter[gpsdata$postnr %in% c("200", "201", "203")] <- "kop"
gpsdata$quarter[gpsdata$postnr %in% c("810")] <- "hveragerdi"

# Now we need to aggregate the data to find the average distance and direction
# from Hellisheidi (and avg distance from main road) for every streetname 
# (in tgf). Street names in ER data are in tgf.
# Keep postnr + heiti_nf + location + municipality + quarter in dataframe.

aggdist <- aggregate(dist2hel ~ heiti_tgf + postnr + heiti_nf + location 
                     + municipality + quarter, data = gpsdata, FUN = mean)
aggdir <- aggregate(dir2hel ~ heiti_tgf, data = gpsdata, FUN = mean)
aggroad <- aggregate(near_dist ~ heiti_tgf, data = gpsdata, FUN = mean)

gpsagg <- merge(x = aggdist, y = aggdir, by="heiti_tgf")
gpsagg <- merge(x = gpsagg, y = aggroad, by = "heiti_tgf")

rm(gpsdata)
rm(aggdist)
rm(aggdir)
rm(aggroad)

          
          
          
          
          
          
          
          