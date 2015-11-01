library(ggplot2)
#This contains general helper functions which I use for select inputs across shiny apps


getFactorValues <-function(colClasses) {
  return(colClasses[colClasses=="factor"])
}

getFactorAndIntegerValues <- function(colClasses) {
  return(colClasses[colClasses=="factor" | colClasses=="integer" ])
}


getNumericValues <- function(colClasses) {
  return(colClasses[colClasses=="integer" | colClasses=="numeric"])
  
}


getGGPlotHistHelper <- function(df,hist_input,bin_width) {
  
  
}




