

upload_light_leak_ui<-function(){
require(shiny)
shinyUI(fluidPage(
  titlePanel("Seastar::Upload Instrument QC Light Leak Data"),
  mainPanel(
    p(
      "Select xlsx files from light leak utility testing"
    ),
    fileInput("send",
              "select wave files",
               accept = c("xlsx", ".xlsx"),
              multiple = T),
    actionButton(
      'Upload',
      "Upload Data",
      icon = icon("cog", lib = "glyphicon"),
      width = NULL
    )

  )
))
}
