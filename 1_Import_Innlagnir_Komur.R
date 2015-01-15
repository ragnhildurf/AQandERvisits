# Import ER visit and admission data
# Author: Ragnhildur G. Finnbjornsdottir
# Date: 3. December 2014
# 
# Description: Here we import ER visit and admission data. We set the 
# columns in correct format and snip ICD diagnosis.

library(lubridate)
library(plyr)

## Import data and clean data
komur <- read.table("./DATA/ERdata/141203_Komur_2005_2014.csv", header = T, 
                    sep=",", dec = ".", fill= T, 
                    encoding = "UTF-8")  # Import visit data


innlagnir <- read.table("./DATA/ERdata/141203_Innlagnir_2005_2014.csv", 
                        header = T, sep=",", dec = ".", fill= T, 
                        encoding = "UTF-8")  # Import admission data

names(komur) <- tolower(names(komur))             # Put names to lower case
names(innlagnir) <- tolower(names(innlagnir))

## Set columns in correct format
# Visits
komur$datetime <- parse_date_time(komur$datetime, "%d%m%Y %H%M%S", 
                                      truncated = 3)

# Admissions
innlagnir$datetime<- parse_date_time(innlagnir$datetime, "%d%m%Y %H%M%S", 
                                    truncated = 3)
innlagnir$dischargeday <- parse_date_time(innlagnir$dischargeday, 
                                          "%d%m%Y %H%M%S", truncated = 3)

## Diagnoses variable coding
# We only need three characters for the diagnosis, so keep only 
# first 3 characters

# Visits
komur$icd1 <- substr(komur$icd1, 1,3)
komur$icd2 <- substr(komur$icd2, 1,3)
komur$icd3 <- substr(komur$icd3, 1,3)
komur$icd4 <- substr(komur$icd4, 1,3)
komur$icd5 <- substr(komur$icd5, 1,3)
komur$icd6 <- substr(komur$icd6, 1,3)
komur$icd7 <- substr(komur$icd7, 1,3)
komur$icd8 <- substr(komur$icd8, 1,3)
komur$icd9 <- substr(komur$icd9, 1,3)
komur$icd10 <- substr(komur$icd10, 1,3)
komur$icd11 <- substr(komur$icd11, 1,3)
komur$icd12 <- substr(komur$icd12, 1,3)
komur$icd13 <- substr(komur$icd13, 1,3)
komur$icd14 <- substr(komur$icd14, 1,3)
komur$icd15 <- substr(komur$icd15, 1,3)
komur$icd16 <- substr(komur$icd16, 1,3)

# Admissions
innlagnir$icd1 <- substr(innlagnir$icd1, 1,3)
innlagnir$icd2 <- substr(innlagnir$icd2, 1,3)
innlagnir$icd3 <- substr(innlagnir$icd3, 1,3)
innlagnir$icd4 <- substr(innlagnir$icd4, 1,3)
innlagnir$icd5 <- substr(innlagnir$icd5, 1,3)
innlagnir$icd6 <- substr(innlagnir$icd6, 1,3)
innlagnir$icd7 <- substr(innlagnir$icd7, 1,3)
innlagnir$icd8 <- substr(innlagnir$icd8, 1,3)
innlagnir$icd9 <- substr(innlagnir$icd9, 1,3)
innlagnir$icd10 <- substr(innlagnir$icd10, 1,3)
innlagnir$icd11 <- substr(innlagnir$icd11, 1,3)
innlagnir$icd12 <- substr(innlagnir$icd12, 1,3)
innlagnir$icd13 <- substr(innlagnir$icd13, 1,3)
innlagnir$icd14 <- substr(innlagnir$icd14, 1,3)
innlagnir$icd15 <- substr(innlagnir$icd15, 1,3)
innlagnir$icd16 <- substr(innlagnir$icd16, 1,3)
