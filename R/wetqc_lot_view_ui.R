wetqc_lot_view<-function(){
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
                "XFe24" = "xfe24wetqc",
                "XFe96" = "xfe96wetqc",
                "XFp" = "xfpwetqc",
                "XF24" = "xf24legacy"
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
