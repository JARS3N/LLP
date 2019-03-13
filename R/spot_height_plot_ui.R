spot_height_plot_ui<-function(){
library(shiny)
shinyUI(fluidPage(
  titlePanel("Spot Height Data"),
  
  
  sidebarLayout(
    sidebarPanel(
      shiny::selectInput(
        "analyte",
        "select analyte",
        choices = c("O2" = "oHeight", "pH" = "pHeight")
      ),
      shiny::selectInput("year",
                         "select year",
                         choices = 1999)
    ),
    
    mainPanel(plotOutput("spot_plot"))
  )
))
}
