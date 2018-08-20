
eye_exam_server<-function()(

library(shiny)

shinyUI(fluidPage(titlePanel("Can spock see?"),
                  mainPanel(
                            textOutput("sdfsdf"),
                            imageOutput( 'spock_true.jpeg')
                            )
                  )
        )
)
