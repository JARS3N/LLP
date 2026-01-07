snowflakes_ui <- function() {
  require(shiny)
  shinyUI(fluidPage(
    titlePanel("SnowFlake"),
    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        shiny::textInput("user", "user", value = " "),
        shiny::textInput("comments", "comments", value = " "),
        downloadButton("export", "export"),
        width = 2
      ),
      mainPanel(uiOutput("data_input"))
    )
  ))
}
