wetqc_lot_view_ui <- function() {
  fluidPage(
    headerPanel("Lot QC Data"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "PLAT", "Platform",
          c("XFe24" = "B", "XFe96" = "W", "XFp" = "C"),
          selected = NULL, multiple = FALSE
        ),
        selectInput("Lot", "Select Lot", c('Lots'), selected = NULL, multiple = FALSE),
        selectInput(
          "Variable", "Select Variable",
          c("O2.LED", "O2.CalEmission", "KSV", "Ambient", "F0",
            "pH.LED", "pH.CalEmission", "Gain", "sorpH"),
          selected = NULL, multiple = FALSE
        )
      ),
      mainPanel(plotlyOutput('plot1'))
    )
  )
}
