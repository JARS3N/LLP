project_hours_ui<-function(){
library(shiny)
library(DT)
shinyUI(fluidPage(
titlePanel("Applied Engineering Weekly Breakdown"),

    sidebarLayout(
        # sidebarPanel(
            dateInput('dates','Select Week'),
             
        # ),

        mainPanel(
            textOutput("weekchosen"),
            DTOutput('testDT')
        )
    )
))
}
