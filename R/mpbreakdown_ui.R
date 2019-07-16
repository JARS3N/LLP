mpbreakdown_ui<-function(){
library(shiny)
shinyUI(fluidPage(
  titlePanel("Applied Eng. Monthly Project Breakdown"),
  fluidRow(
    column(width = 6, selectInput("year",
                                  "year", choices = "2019")),
    column(
      width = 6,
      selectInput(
        inputId = "month",
        label = "month",
        choices = "6"
      )
    ),
    fluidRow(column(width = 6,
                    plotOutput("distPlot"))
             ,
             column(
               width = 6,
               plotOutput("distPlot2", width = "100%")
             ))
  )
))
}
