
eye_exam_ui<-function(){

library(shiny)

shinyUI(fluidPage(titlePanel("Can spock see?"),
                  mainPanel(
                            textOutput("sdfsdf"),
                            imageOutput( 'spock_true.jpeg')
                            )
                  )
        )
}
