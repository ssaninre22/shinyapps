#This should detect and install missing packages before loading them - hopefully!

# packages = c("shiny","shinydashboard","plyr","dplyr","data.table","ggplot2","psymonitor")
# package.check <- lapply(packages, FUN = function(x) {
#   if (!require(x, character.only = TRUE)) {
#     install.packages(x, dependencies = TRUE)
#     library(x, character.only = TRUE)
#   }
# })

# list.of.packages <- c()
# #new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# #if(length(new.packages)) install.packages(new.packages)
# lapply(list.of.packages,function(x){library(x,character.only=TRUE)})

# require("shiny",character.only = TRUE)
# require("shinydashboard",character.only = TRUE)
# require("plyr",character.only = TRUE)
# require("dplyr",character.only = TRUE)
# require("data.table",character.only = TRUE)
# require("ggplot2",character.only = TRUE)
# require("psymonitor",character.only = TRUE)


ctrycodes <- data.table::data.table(read.csv("data/country_codes.csv",sep=";"))
df <- data.table::data.table(read.csv("data/bubble_file_new.csv",sep=";",
                          colClasses = c("POSIXct",rep("factor",5),"numeric")))
df$date <- as.Date(df$date)
