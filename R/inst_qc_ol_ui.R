inst_qc_ol_ui<-function(){
require(shiny)
shinyUI(fluidPage(
  titlePanel("Instrument QC Outliers"),
  mainPanel(width = "100%",
            fluidRow(
              selectInput("plat", "platform", c("XFp", "XFe24", "XFe96")),

              plotOutput('plot1')
            ))
))
}
