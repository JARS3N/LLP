dryqc_ui <- function() {
  require(shiny)
  shinyUI(pageWithSidebar(
    headerPanel(textOutput('head')),
    mainPanel(width = '100%',
              tabsetPanel(
                type = "tabs",
                tabPanel("Boxplot by Cartridge", plotOutput('plot1'))
              )),
    sidebarPanel(
      width = 20,
      selectInput("analyte", "Select analyte",
                  c("pH", "O2"), multiple = FALSE),
      selectInput(
        "Lot",
        "Select Lot",
        "select Lot",
        selected = FALSE,
        multiple = FALSE
      )
    )
  ))
}
