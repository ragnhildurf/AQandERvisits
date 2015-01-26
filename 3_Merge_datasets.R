#### Merging the three datasets (ER visits + admissions, H2S exposure 
#### estimates, and gps coordinates)

# Author: Ragnhildur G. Finnbjornsdottir
# Date: 3. December 2014
# 
# Description: Here we merge four datasets in one: komur, innlagnir 
# (Import_Innlagnir_Komur.R), gpsagg (Import_fjarlaegd_2010.R), and expdata 
# (Import_Predt.R).
# 1: Merge komur and innlagnir (heiti_tgf) with gpsagg (street) by streetname 
# of patients. That way, patients will be classified by capital/rural, 
# municipality, and city quarter.
# 2: New dataset created in 1. will be merged with H2S exposure estimate
# date using visit day and 

source("./AnalysisAndScripts/2_Edit_Innlagnir_Komur.R")
source("./AnalysisAndScripts/1_Import_Predt.R")
source("./AnalysisAndScripts/1_Import_fjarlaegd_2010.R")
source("./AnalysisAndScripts/1_Import_population_data.R")

############ 1 Merge komur and innlagnir with gpsagg with street name #######

# ER visits
komurgps <- merge(komur, gpsagg, "heiti_tgf")

# Admission
innlagnirgps <- merge(innlagnir, gpsagg, "heiti_tgf")


########## 2 Merge dataset from 1 with population data within areas ########

komurgps <- merge(komurgps, popdata, by=c("postnr", "year"))

innlagnirgps <- merge(innlagnirgps, popdata, by=c("postnr", "year"))

####### 3: New dataset created in 2 will be merged with H2S exposure estimate ########
# date using datetime - this should be corrected!

# ER visits
library(Hmisc)

# First, ceiling hour of datetime for komur and innlagnir since H2S 
# exposure estimate has timestamp on the hour.

# ER visits
komurgps$datetime <- ceil(komurgps$datetime, "hour")

# Admissions
innlagnirgps$datetime <- ceil(innlagnirgps$datetime, "hour")

# Second, remove rows for innlagnir and komur that preceed 1/1/2007 when
# H2S exposure estimate starts.

# ER data
komurgps <- komurgps[komurgps$datetime >= "2007-01-01 01:00:00", ]

# Admissons
innlagnirgps <- innlagnirgps[innlagnirgps$datetime >= "2007-01-01 01:00:00", ]

# Third, remove rows for expdata that exceed 2014-06-29 19:00:00 when
# the last admission occurred and 2014-06-30 21:00 when the last ER visit 
# occurred

# ER visits
expdatakomur <- expdata[expdata$datetime <= "2014-06-30 21:00", ]

# Admissions
expdatainnlagnir <- expdata[expdata$datetime <= "2014-06-29 19:00:00", ]

# Finally, merge the dataframes expdatakomur with komurgps and expdatainnlagnir
# with innlagnirgps by datetime (timestamp)

library(plyr)

# ER visits
komurdata <- join(komurgps, expdatakomur, by="datetime")

# Admissions
innlagnirdata <- join(innlagnirgps, expdatainnlagnir, by="datetime")

### Now remove unnecessary dataframes other than original datasets
rm(expdatainnlagnir)
rm(expdatakomur)
rm(gpsagg)
rm(innlagnirgps)
rm(komurgps)

######## 4 finally create single column with individual exposure ######

# ER visits

## After merging on datetime we make a variable to select exposure on
komurdata$dir[90 < komurdata$dir2hel  &  komurdata$dir2hel <= 100  ] <- 95
komurdata$dir[100 < komurdata$dir2hel  &  komurdata$dir2hel <= 110  ] <- 105
komurdata$dir[110 < komurdata$dir2hel  &  komurdata$dir2hel <= 120  ] <- 115
komurdata$dir[120 < komurdata$dir2hel  &  komurdata$dir2hel <= 130  ] <- 125
komurdata$dir[130 < komurdata$dir2hel ] <- 135

#numeric
komurdata$dir_n <- as.numeric(komurdata$dir)


#### Assign right dirXX value as exposure for each person
# the value exposure24h should contain the h2s 
# concentration from each person's dirxx at the same tima as ER visit/admission
# occurs. 

# Create empty variable with desired name exposure24h
komurdata$exposure24h <- NA

# Create single column with exposure estimate for each individual in new column

for(i in 1:nrow(komurdata)) {
          if(komurdata$dir_n[i]==95){
                    komurdata$exposure24h[i] <- komurdata$dir95[i]
          }
          else if(komurdata$dir_n[i]==105){
                    komurdata$exposure24h[i] <- komurdata$dir105[i]
          }
          else if(komurdata$dir_n[i]==115){
                    komurdata$exposure24h[i] <- komurdata$dir115[i]
          }
          else if(komurdata$dir_n[i]==125){
                    komurdata$exposure24h[i] <- komurdata$dir125[i]
          }
          else {
                    komurdata$exposure24h[i] <- komurdata$dir135[i]
          }
}

# Admissions

## After merging on datetime we make a variable to select exposure on
innlagnirdata$dir[90 < innlagnirdata$dir2hel  &  innlagnirdata$dir2hel <= 100  ] <- 95
innlagnirdata$dir[100 < innlagnirdata$dir2hel  &  innlagnirdata$dir2hel <= 110  ] <- 105
innlagnirdata$dir[110 < innlagnirdata$dir2hel  &  innlagnirdata$dir2hel <= 120  ] <- 115
innlagnirdata$dir[120 < innlagnirdata$dir2hel  &  innlagnirdata$dir2hel <= 130  ] <- 125
innlagnirdata$dir[130 < innlagnirdata$dir2hel ] <- 135

#numeric
innlagnirdata$dir_n <- as.numeric(innlagnirdata$dir)

#### Assign right dirXX value as exposure for each person
# the value exposure24h should contain the h2s 
# concentration from each person's dirxx at the same tima as ER visit/admission
# occurs. 

# Create empty variable with desired name exposure24h
innlagnirdata$exposure24h <- NA

# Create single column with exposure estimate for each individual in new column

for(i in 1:nrow(innlagnirdata)) {
          if(innlagnirdata$dir_n[i]==95){
                    innlagnirdata$exposure24h[i] <- innlagnirdata$dir95[i]
          }
          else if(innlagnirdata$dir_n[i]==105){
                    innlagnirdata$exposure24h[i] <- innlagnirdata$dir105[i]
          }
          else if(innlagnirdata$dir_n[i]==115){
                    innlagnirdata$exposure24h[i] <- innlagnirdata$dir115[i]
          }
          else if(innlagnirdata$dir_n[i]==125){
                    innlagnirdata$exposure24h[i] <- innlagnirdata$dir125[i]
          }
          else {
                    innlagnirdata$exposure24h[i] <- innlagnirdata$dir135[i]
          }
}