ol_ui<-function(){
  library(shiny)
    titlePanel("Outliers")
    sidebarLayout(
      sidebarPanel(
        width = 3,
        textInput(
          'exp',
          'Experiment',
          value = "",
          width = NULL,
          placeholder = NULL
        ),
        fileInput("file", label = h3("File input"), multiple = T),
        radioButtons("group", "Grouping:",
                     c("All", "byFile")),
        radioButtons("ptype", "Plot Type:",
                     c("Density", "Bar")),
        radioButtons("copy_asyrs", "include asyr files in export:",
                     c("Yes", "No")),
        downloadButton('export', "Export as Zip")

      ),
      mainPanel(plotOutput("olplot"),
             #   dataTableOutput('table')
               )
    )
  ))
}
