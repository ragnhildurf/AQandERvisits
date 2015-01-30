## Import H2S exposure estimate file, data cleaning and subsetting (if nessicary)
# Author: Ragnhildur G. Finnbjornsdottir
# Date: 2. December 2014
# 
# Description: Import H2S exposure estimates data and set columns in correct
# format


# Set correct working directory - AnalysisAndScripts
# setwd("./Dropbox/AQandERvisits")

library(lubridate)

## Import data and clean data
expdata1 <- read.csv("./DATA/GeoData/Clean_predt_2v.csv") # Import data
expdata2 <- read.csv("./DATA/GeoData/Clean_predt_1hour.csv")

# Set columns in correct format
expdata1$datetime <- parse_date_time(expdata1$datetime, "%Y%m%d %H%M", 
                                      truncated = 3)
expdata2$datetime <- parse_date_time(expdata2$datetime, "%Y%m%d %H%M", 
                                     truncated = 3)

expdata1$date  <- as.Date(expdata1$date, format="%Y/%m/%d")
# expdata2$date  <- as.Date(expdata2$date, format="%Y/%m/%d")
expdata1$time <- as.character(expdata1$time)
# expdata2$time <- as.character(expdata2$time)

########### Merge datasets together #####################

expdata <- merge(expdata1, expdata2, by="datetime")

#################### Remove unnecessary columns ####################
keep <- c("datetime", "dir95", "dir105", "dir115", "dir125", "dir135", 
          "dir951hour", "dir1051hour", "dir1151hour", "dir1251hour", 
          "dir1351hour")

expdata <- expdata[keep]

rm(keep)
rm(expdata1)
rm(expdata2)
