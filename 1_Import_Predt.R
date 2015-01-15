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
expdata <- read.csv("./DATA/GeoData/Clean_predt_2v.csv") # Import data

# Set columns in correct format
expdata$datetime <- parse_date_time(expdata$datetime, "%Y%m%d %H%M", 
                                      truncated = 3)
expdata$date  <- as.Date(expdata$date, format="%Y/%m/%d")
expdata$time <- as.character(expdata$time)

# Lets remove unnecessary columns
keep <- c("datetime", "dir95", "dir105", "dir115", "dir125", "dir135")
expdata <- expdata[keep]

rm(keep)
