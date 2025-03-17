wetqc_lot_view_ui <- function() {
  shiny::fluidPage(
    shiny::headerPanel("Lot QC Data"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::selectInput(
          "PLAT", "Platform",
          c("XFe24" = "B", "XFe96" = "W", "XFp" = "C"),
          selected = NULL, multiple = FALSE
        ),
        shiny::selectInput("Lot", "Select Lot", c('Lots'), selected = NULL, multiple = FALSE),
        shiny::selectInput(
          "Variable", "Select Variable",
          c("O2.LED", "O2.CalEmission", "KSV", "Ambient", "F0",
            "pH.LED", "pH.CalEmission", "Gain", "sorpH"),
          selected = NULL, multiple = FALSE
        )
      ),
      shiny::mainPanel(plotly::plotlyOutput('plot1'))
    )
  )
}
