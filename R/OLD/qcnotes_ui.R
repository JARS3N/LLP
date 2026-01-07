qcnotes_ui <- function() {
library(shiny)
shinyUI(fluidPage(title = 'QCLOTNOTES',
                  sidebarLayout(
                    sidebarPanel(
                      helpText(),
                      selectInput(
                        "PLAT",
                        "Platform",
                        c(
                          "XF24" = "Q",
                          "XFe24" = "B",
                          "XFe96" = "W",
                          "XFp" = "C"
                        ),
                        selected = FALSE,
                        multiple = FALSE
                      ),
                      selectInput(
                        "Lot",
                        "Select Lot",
                        "NULL" ,
                        selected = FALSE,
                        multiple = FALSE
                      ),
                      actionButton('button', "Enter Data", icon = NULL, width = NULL)
                    ),
                    mainPanel(
                      h1("Add Notes"),
                      
                      textInput(
                        'txtnotes1',
                        "Notes",
                        value = "",
                        width = '100%',
                        placeholder = 'Notes,each entry can be 255 characters in length.
                          If you need to add more enter another line.'
                      ),
                      textInput(
                        'txtnotes2',
                        "",
                        value = "",
                        width = '100%',
                        placeholder = ''
                      ),
                      textInput(
                        'txtnotes3',
                        "",
                        value = "",
                        width = '100%',
                        placeholder = ''
                      ),
                      h2("Notes in Database:"),
                      p(textOutput(outputId = "text1"))
                      
                      
                    )
                  )))

}
