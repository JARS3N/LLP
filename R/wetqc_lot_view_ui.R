wetqc_lot_view_ui<-function(){
require(shiny)
require(plotly)
shinyUI(fluidPage(
    headerPanel("Lot QC Data"),
    mainPanel(plotlyOutput('plot1')),
    sidebarPanel(
        selectInput(
            "PLAT",
            "Platform",
        c(
          "XFe24" = "B",
          "XFe96" = "W",
          "XFp" = "C",
          "XF24" = "Q"
        ),
            selected = FALSE,
            multiple = FALSE
        ),
        selectInput(
            "Lot",
            "Select Lot",
            c('Lots'),
            selected = FALSE,
            multiple = FALSE
        ),
        selectInput(
            "Variable",
            "Select Variable",
            c(
                "O2.LED",
                "O2.CalEmission",
                "KSV",
                "Ambient",
                "F0",
                "pH.LED",
                "pH.CalEmission",
                "Gain",
                "sorpH"
            ),
            multiple = FALSE
        )
        
    )
))
}
