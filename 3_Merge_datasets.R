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

# 1 Merge komur and innlagnir with gpsagg wit street name

# ER visits
komurgps <- merge(komur, gpsagg, "heiti_tgf")

# Admission
innlagnirgps <- merge(innlagnir, gpsagg, "heiti_tgf")


# 2: New dataset created in 1. will be merged with H2S exposure estimate
# date using datetime 

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