# Edit the ER visits and admission data
# Author: Ragnhildur G. Finnbjornsdottir
# Date: 3. December 2014
# 
# Description: Here we source Import_Innlagnir_Komur.R and edit the dataset.
# Columns added if needed. 
# Data subsetted for only living patients with diagnosis.
# Diagnosis grouped together according to respiratory diseases, cardiovascular 
# diseases etc. for the first 3 diagnoses.
# 

source("./AnalysisAndScripts/1_Import_Innlagnir_Komur.R")

# Here we create new variables as needed

# Create indicator for visit/admission in each dataset
komur$type <- as.factor("visit")
innlagnir$type <- as.factor("admission")

# Indicate whether patient is diceased or not in both datasets
komur$diceased <- ifelse(komur$street =="Látinn", 1, 0)
innlagnir$diceased <- ifelse(innlagnir$street =="Látinn", 1, 0)

# Create colums indicating just time, date, year, month, etc.
komur$date <- strftime(komur$datetime, "%d-%m-%Y")
komur$time <- strftime(komur$datetime, "%H:%M:%S")
komur$year <- strftime(komur$datetime, "%Y")
komur$month <- strftime(komur$datetime, "%m")
komur$week <- strftime(komur$datetime, "%V")
komur$day <- strftime(komur$datetime, "%e")
komur$hour <- strftime(komur$datetime, "%H")
komur$min <- strftime(komur$datetime, "%M")

innlagnir$date <- strftime(innlagnir$datetime, "%d-%m-%Y")
innlagnir$time <- strftime(innlagnir$datetime, "%H:%M:%S")
innlagnir$year <- strftime(innlagnir$datetime, "%Y")
innlagnir$month <- strftime(innlagnir$datetime, "%m")
innlagnir$week <- strftime(innlagnir$datetime, "%V")
innlagnir$day <- strftime(innlagnir$datetime, "%e")
innlagnir$hour <- strftime(innlagnir$datetime, "%H")
innlagnir$min <- strftime(innlagnir$datetime, "%M")

##################################################################

## Subset datasets for only living patients (exclude deceased) who have a 
# diagnoses (diagnosis)

# ER visits
use_komur <- subset(komur, diceased==0)
komur <- subset(use_komur, complete.cases(diagnosis))
rm(use_komur)

# admission
use_innlagnir <- subset(innlagnir, diceased==0)
innlagnir <- subset(use_innlagnir, complete.cases(diagnosis))
rm(use_innlagnir)

###################################################################

# Make an indicator for whether the first (icd1) diagnosis is respiratory
# Respiratory disease codes J20-J22, J40-J46 and J96)

# ER visits
komur$resp1 = 0

komur$resp1[komur$icd1=="J20" | komur$icd1=="J21" | komur$icd1=="J22" 
            | komur$icd1=="J40"| komur$icd1=="J41"| komur$icd1=="J42" 
            | komur$icd1=="J43"| komur$icd1=="J44"| komur$icd1=="J45" 
            | komur$icd1=="J46"| komur$icd1=="J96"] =1


# admission
innlagnir$resp1 = 0

innlagnir$resp1[innlagnir$icd1=="J20" | innlagnir$icd1=="J21" 
                | innlagnir$icd1=="J22"| innlagnir$icd1=="J40" 
                | innlagnir$icd1=="J41"| innlagnir$icd1=="J42"
                | innlagnir$icd1=="J43"| innlagnir$icd1=="J44"
                | innlagnir$icd1=="J45"| innlagnir$icd1=="J46"
                | innlagnir$icd1=="J96"] =1


# Make an indicator for whether the first (icd1) diagnosis is cardiac disease 
# ICD10 codes starting with I20-I27, I46, I48 and I50

# ER visits
komur$card1 = 0

komur$card1[komur$icd1=="I20" | komur$icd1=="I21" | komur$icd1=="I22" 
            | komur$icd1=="I23"| komur$icd1=="I24"| komur$icd1=="I25" 
            | komur$icd1=="I26"| komur$icd1=="I27"| komur$icd1=="I46" 
            | komur$icd1=="I48"| komur$icd1=="I50"] =1


# admission
innlagnir$card1 = 0

innlagnir$card1[innlagnir$icd1=="I20" | innlagnir$icd1=="I21" | innlagnir$icd1=="I22" 
                | innlagnir$icd1=="I23"| innlagnir$icd1=="I24"| innlagnir$icd1=="I25" 
                | innlagnir$icd1=="I26"| innlagnir$icd1=="I27"| innlagnir$icd1=="I46" 
                | innlagnir$icd1=="I48"| innlagnir$icd1=="I50"] =1

# Make an indicator for whether the first (icd1) diagnosis is cerebrovascular events 
# ICD10 codes starting with I61-I69 and G45-G46

# ER visits
komur$cere1 = 0

komur$cere1[komur$icd1=="I61" | komur$icd1=="I62" | komur$icd1=="I63" 
            | komur$icd1=="I64"| komur$icd1=="I65"| komur$icd1=="I66" 
            | komur$icd1=="I67"| komur$icd1=="I68"| komur$icd1=="I69" 
            | komur$icd1=="G45"| komur$icd1=="G46"] =1


# admission
innlagnir$cere1 = 0

innlagnir$cere1[innlagnir$icd1=="I61" | innlagnir$icd1=="I62"| innlagnir$icd1=="I63" 
               | innlagnir$icd1=="I64"| innlagnir$icd1=="I65"| innlagnir$icd1=="I66" 
               | innlagnir$icd1=="I67"| innlagnir$icd1=="I68"| innlagnir$icd1=="I69" 
               | innlagnir$icd1=="G45"| innlagnir$icd1=="G46"] =1

#######################################################################

# Make an indicator for whether the second (icd2) diagnosis is respiratory
# Respiratory disease codes J20-J22, J40-J46 and J96)

# ER visits
komur$resp2 = 0

komur$resp2[komur$icd2=="J20" | komur$icd2=="J21" | komur$icd2=="J22" 
            | komur$icd2=="J40"| komur$icd2=="J41"| komur$icd2=="J42" 
            | komur$icd2=="J43"| komur$icd2=="J44"| komur$icd2=="J45" 
            | komur$icd2=="J46"| komur$icd2=="J96"] =1


# admission
innlagnir$resp2 = 0

innlagnir$resp2[innlagnir$icd2=="J20" | innlagnir$icd2=="J21" 
                | innlagnir$icd2=="J22"| innlagnir$icd2=="J40" 
                | innlagnir$icd2=="J41"| innlagnir$icd2=="J42"
                | innlagnir$icd2=="J43"| innlagnir$icd2=="J44"
                | innlagnir$icd2=="J45"| innlagnir$icd2=="J46"
                | innlagnir$icd2=="J96"] =1


# Make an indicator for whether the second (icd2) diagnosis is cardiac disease 
# icd10 codes starting with I20-I27, I46, I48 and I50

# ER visits
komur$card2 = 0

komur$card2[komur$icd2=="I20" | komur$icd2=="I21" | komur$icd2=="I22" 
            | komur$icd2=="I23"| komur$icd2=="I24"| komur$icd2=="I25" 
            | komur$icd2=="I26"| komur$icd2=="I27"| komur$icd2=="I46" 
            | komur$icd2=="I48"| komur$icd2=="I50"] =1


# admission
innlagnir$card2 = 0

innlagnir$card2[innlagnir$icd2=="I20" | innlagnir$icd2=="I21" | innlagnir$icd2=="I22" 
                | innlagnir$icd2=="I23"| innlagnir$icd2=="I24"| innlagnir$icd2=="I25" 
                | innlagnir$icd2=="I26"| innlagnir$icd2=="I27"| innlagnir$icd2=="I46" 
                | innlagnir$icd2=="I48"| innlagnir$icd2=="I50"] =1

# Make an indicator for whether the second (icd2) diagnosis is cerebrovascular events 
# icd10 codes starting with I61-I69 and G45-G46

# ER visits
komur$cere2 = 0

komur$cere2[komur$icd2=="I61" | komur$icd2=="I62" | komur$icd2=="I63" 
            | komur$icd2=="I64"| komur$icd2=="I65"| komur$icd2=="I66" 
            | komur$icd2=="I67"| komur$icd2=="I68"| komur$icd2=="I69" 
            | komur$icd2=="G45"| komur$icd2=="G46"] =1


# admission
innlagnir$cere2 = 0

innlagnir$cere2[innlagnir$icd2=="I61" | innlagnir$icd2=="I62" | innlagnir$icd2=="I63" 
                | innlagnir$icd2=="I64"| innlagnir$icd2=="I65"| innlagnir$icd2=="I66" 
                | innlagnir$icd2=="I67"| innlagnir$icd2=="I68"| innlagnir$icd2=="I69" 
                | innlagnir$icd2=="G45"| innlagnir$icd2=="G46"] =1

#######################################################################

# Make an indicator for whether the third (icd3) diagnosis is respiratory
# Respiratory disease codes J20-J22, J40-J46 and J96)

# ER visits
komur$resp3 = 0

komur$resp3[komur$icd3=="J20" | komur$icd3=="J21" | komur$icd3=="J22" 
            | komur$icd3=="J40"| komur$icd3=="J41"| komur$icd3=="J42" 
            | komur$icd3=="J43"| komur$icd3=="J44"| komur$icd3=="J45" 
            | komur$icd3=="J46"| komur$icd3=="J96"] =1


# admission
innlagnir$resp3 = 0

innlagnir$resp3[innlagnir$icd3=="J20" | innlagnir$icd3=="J21" 
                | innlagnir$icd3=="J22"| innlagnir$icd3=="J40" 
                | innlagnir$icd3=="J41"| innlagnir$icd3=="J42"
                | innlagnir$icd3=="J43"| innlagnir$icd3=="J44"
                | innlagnir$icd3=="J45"| innlagnir$icd3=="J46"
                | innlagnir$icd3=="J96"] =1


# Make an indicator for whether the third (icd3) diagnosis is cardiac disease 
# icd10 codes starting with I20-I27, I46, I48 and I50

# ER visits
komur$card3 = 0

komur$card3[komur$icd3=="I20" | komur$icd3=="I21" | komur$icd3=="I22" 
            | komur$icd3=="I23"| komur$icd3=="I24"| komur$icd3=="I25" 
            | komur$icd3=="I26"| komur$icd3=="I27"| komur$icd3=="I46" 
            | komur$icd3=="I48"| komur$icd3=="I50"] =1


# admission
innlagnir$card3 = 0

innlagnir$card3[innlagnir$icd3=="I20" | innlagnir$icd3=="I21" | innlagnir$icd3=="I22" 
                | innlagnir$icd3=="I23"| innlagnir$icd3=="I24"| innlagnir$icd3=="I25" 
                | innlagnir$icd3=="I26"| innlagnir$icd3=="I27"| innlagnir$icd3=="I46" 
                | innlagnir$icd3=="I48"| innlagnir$icd3=="I50"] =1

# Make an indicator for whether the third (icd3) diagnosis is cerebrovascular events 
# icd10 codes starting with I61-I69 and G45-G46

# ER visits
komur$cere3 = 0

komur$cere3[komur$icd3=="I61" | komur$icd3=="I62" | komur$icd3=="I63" 
            | komur$icd3=="I64"| komur$icd3=="I65"| komur$icd3=="I66" 
            | komur$icd3=="I67"| komur$icd3=="I68"| komur$icd3=="I69" 
            | komur$icd3=="G45"| komur$icd3=="G46"] =1


# admission
innlagnir$cere3 = 0

innlagnir$cere3[innlagnir$icd3=="I61" | innlagnir$icd3=="I62" | innlagnir$icd3=="I63" 
                | innlagnir$icd3=="I64"| innlagnir$icd3=="I65"| innlagnir$icd3=="I66" 
                | innlagnir$icd3=="I67"| innlagnir$icd3=="I68"| innlagnir$icd3=="I69" 
                | innlagnir$icd3=="G45"| innlagnir$icd3=="G46"] =1

## Rearrange columns for more conveniency

komur <- komur[, c("id", "gender", "age", "address", "heiti_tgf", "street", "datetime", 
                   "date", "time", "year", "month", "week", "day", "hour","min",  
                   "diagnosis", "icd1", 
                   "icd2", "icd3", "icd4", "icd5", "icd6", "icd7", "icd8", 
                   "icd9", "icd10", "icd11", "icd12", "icd13", "icd14", "icd15",
                   "icd16", "ward", "admission",  "x", "y", 
                   "near_dist",  "zone", "type", "diceased", "resp1", 
                   "card1", "cere1", "resp2", "card2", "cere2", "resp3", 
                   "card3", "cere3")]

innlagnir <- innlagnir[, c("id", "gender", "age", "address", "heiti_tgf", "street", 
                           "datetime", "date", "time", "year", "month", "week", 
                           "day", "hour", "min", "dischargeday", "laydays", "diano", 
                           "diagnosis", "icd1", "icd2", "icd3", "icd4", "icd5", 
                           "icd6", "icd7", "icd8", "icd9", "icd10", "icd11", 
                           "icd12", "icd13", "icd14", "icd15", "icd16", 
                           "speciality",  "x", "y", "near_dist", 
                           "zone", "type", "diceased", "resp1", 
                           "card1", "cere1", "resp2", "card2", "cere2", "resp3", 
                           "card3", "cere3")]