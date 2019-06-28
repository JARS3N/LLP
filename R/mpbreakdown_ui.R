mpbreakdown_ui<-function(){
library(shiny)
shinyUI(fluidPage(
  titlePanel("Applied Eng. Monthly Project Breakdown"),
  sidebarLayout(
    mainPanel(plotOutput("distPlot")),
    sidebarPanel(
      selectInput("year", "year", choices = "2019"),
      selectInput("month", "month", choices = 6)
    )
  )
))
}
