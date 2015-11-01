
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("censusVis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
               information from the 2010 US Census."),
      
      fileInput('file1', 'Choose file to upload',
                accept = c('.csv')),
      
      selectInput("mapType",
                  label="Choose a type of map to display",
                  choices=c("Percentage Map","Group by Twenties"),
                  selected="Percentage Map"),
      
      selectInput("var", 
                  label = "Choose a variable to display",""),
                
      
      sliderInput("bins", 
                  label = "Number of bins:",
                  min = 1, max = 100, value = 5),
      selectInput("lowerBetter",
                  label="Is lower better for this measure",
                  choices=c("Yes","No"),
                  selecte="No"),
      
      sliderInput("range", 
                  label = "Number of bins:",
                  min = 1, max = 25, value = c(0, 100))
      ),
    
    mainPanel(plotOutput("map"))
  )
))
