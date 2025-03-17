CQC_LotView_ui<- function() {
  library(shiny)
  library(plotly)
  fluidPage(
    headerPanel("Lot QC Data"),
    mainPanel(plotlyOutput('plot1')),
    sidebarPanel(
      selectInput(
        "PLAT",
        "Platform",
        c(
          "XFe24" = "B",
          "XFe96" = "W",
          "XFp" = "C"
        ),
        selected = NULL,  # `FALSE` is not valid here
        multiple = FALSE
      ),
      selectInput(
        "Lot",
        "Select Lot",
        c('Lots'),
        selected = NULL,  # `FALSE` is not valid
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
        selected = NULL,  # Ensure this is set correctly
        multiple = FALSE
      )
    )
  )
}
