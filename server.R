
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(maps)
library(mapproj)
counties <- read.csv("census-app/mostly Sorted.csv")
source("census-app/helpersMap.R")
source("census-app/GeneralHelper.R")

shinyServer(function(input, output,session) {
  
  reactiveDF <- reactive({
    if (is.null(inputFile())) {
      read.csv("census-app/mostly Sorted.csv")
    } else {
      read.csv(inputFile()$datapath)
    }
  })
  
  
  inputFile <- reactive({
    if (is.null(input$file1)) {
      return(NULL)
    } else {
      input$file1
    }
  })
  
  
  observe({
    updateSelectInput(
      session,
      "var",
      #choices =  names(getNumericValues(sapply(counties,class)))
      choices =  names(getNumericValues(sapply(reactiveDF(),class)))
    )
    
  })
  
    output$map <- renderPlot({
      df <- reactiveDF()
      
      if (is.null(df)) {
        return(NULL)
      }
      var=input$var
      mapType=input$mapType
      bins=input$bins
      lowerIsBetter=input$lowerBetter
      if (lowerIsBetter=="Yes") {
        lowerIsBetter=TRUE
      }
      else {
        lowerIsBetter=FALSE
      }
      
      #mapType=input$mapType
      #data <- switch(input$var, 
      #               "Percent White" = counties$white,
      #               "Percent Black" = counties$black,
      #               "Percent Hispanic" = counties$hispanic,
      #               "Percent Asian" = counties$asian)
      #counties=counties[order(counties$County),]
      if (mapType=="Percentage Map") {
        percent_map(df[,var],legend.title = "NI Counties", "darkgreen",limitRegion = df$County,bins=bins) 
      }
      #else {
      #  colorsByTwenties("stuf and what not")
        
    #  }
    })
  }
)
