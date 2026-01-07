weekly_ae_ui<-function(){
library(shiny)
library(DT)
shinyUI(fluidPage(
    titlePanel("Applied Engineering Weekly Breakdown"),
        mainPanel(
            p('%Time per Project'),
            h4(textOutput("weekchosen")),
            dateInput('dates','dates'),
            DTOutput('testDT') 
        )
    
))
}
