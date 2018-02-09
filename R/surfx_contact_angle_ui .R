surfx_contact_angle_ui <- function() {
  require(shiny)
  shinyUI(fluidPage(
    titlePanel(h4("SURFX Contact Angle")),
    mainPanel(
      width = "100%",
      shiny::selectInput(
        'Plat',
        'platform',
        choices = c(
          'XFp' = 'C',
          'XFe24' = 'B',
          'XFe96' = 'W',
          'XF24' = 'Q'
        )
      ),
      column(
        width = 4,
        sliderInput(
          "SLIDE",
          label = h5("Range"),
          min = 1,
          max = 1,
          value = c(1, 2),
          step = 1,
          width = "100%"
        )
      ),
      shiny::checkboxInput("cktest", "individual tests"),
      plotOutput("distPlot", width = "100%")
    )
  ))
}
