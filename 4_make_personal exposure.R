###HKC jan 2015
##after merging on datetime we make 
#a variable to select exposure on
komurdata$dir[90 < komurdata$dir2hel  &  komurdata$dir2hel < 100  ] <- 95
komurdata$dir[100 < komurdata$dir2hel  &  komurdata$dir2hel < 110  ] <- 105
komurdata$dir[110 < komurdata$dir2hel  &  komurdata$dir2hel < 120  ] <- 115
komurdata$dir[120 < komurdata$dir2hel  &  komurdata$dir2hel < 130  ] <- 125
komurdata$dir[130 < komurdata$dir2hel ] <- 135

#numeric
komurdata$dir_n <- as.numeric(komurdata$dir)

####assign right dirXX value as exposure for each person
#the value exposure_h2s should contain the h2s 
#concentrion from each person's dirxx
#this almost works, but there is an error, and resulting variable 
#exposure_h2s is not correct
#Made based on example on this page
#http://rprogramming.net/recode-data-in-r/ EXAMPLE 9ish

#create empty variable
komurdata$exposure_h2s <- NA

#then replace values of the variable 
#with values of the relevant dirXX variable

if (komurdata$dir_n=='95'){
  komurdata$exposure_h2s <- komurdata$dir95
} else if (komurdata$dir_n=='105'){
  komurdata$exposure_h2s <- komurdata$dir105
} else if (komurdata$dir_n=='115'){
  komurdata$exposure_h2s <- komurdata$dir115
} else if (komurdata$dir_n==125){
  komurdata$exposure_h2s <- komurdata$dir125
} else (komurdata$dir_n==135){
  komurdata$exposure_h2s <- komurdata$dir135 
}

