alt_rfs_ui<-function(){
library(shiny)
shinyUI(fluidPage(shinyjs::useShinyjs(),
  title = 'Download a PDF report',
  sidebarLayout(
    sidebarPanel(
      helpText(),
      selectInput("PLAT", "Platform",
                  c("XFe24"="XFe24LotRelease",
                    "XFe96"="XFe96LotRelease",
                    "XFp"="XFpLotRelease",
                    "XF24 LEGACY" ="XF24LotRelease"
                  ),selected=FALSE, multiple = FALSE),
      selectInput("Lot", "Select Lot",
                  "..." ,
                  selected=FALSE,
                  multiple = FALSE),
      selectInput("INST", "Select Instrument",c('...'),selected=FALSE, multiple
                  = FALSE),
      actionButton("Compiler","compile data"),
      shinyjs::hidden(downloadButton('downloadData', 'print PDF'))
    ),
    mainPanel(
      h3(textOutput("lotchoice")),
       DT::dataTableOutput("sumtbl"),
      h3("Notes in Database:"),
      p(textOutput(outputId="text1"))
    )
  )
))

}
