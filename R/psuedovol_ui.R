psuedovol_ui<-function(){
library(shiny)
shinyUI(fluidPage(
    titlePanel("Change Psuedo Volume"),
    mainPanel(
        numericInput("chamber", "chamber volume", NULL),
        shiny::fileInput("FILE", "upload file"),
        downloadButton("export", "export")
    )
))
}
