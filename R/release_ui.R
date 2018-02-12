release_ui<-function(){
library(shiny)
shinyUI(fluidPage(
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
                        "NULL" ,
                        selected=FALSE,
                        multiple = FALSE),
            selectInput("INST", "Select Instrument",c('s'),selected=FALSE, multiple = FALSE),
            downloadButton('downloadData', 'Download')
            ),
        mainPanel(
                  h2("Notes in Database:"),
                  p(textOutput(outputId="text1"))
                  )
    )
))
}
