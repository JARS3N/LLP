
search_coefs_ui <- function() {
  require(shiny)
  
  shinyUI(
    fluidPage(
      titlePanel("Retrieve Barcode Coefficients"),
      selectInput(
        "Lot",
        "Select Lot",
        c('N/A'),
        selected = FALSE,
        multiple = FALSE
      ),
      p("Start typing the Lot in the dropdown to filter choices."),
      tableOutput('Lottable'),
      tableOutput('oxtable'),
      tableOutput('pHtable'),
      tableOutput('bftbl')
    )
  )
}
