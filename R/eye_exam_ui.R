eye_exam_server<-function(){
library(shiny)

shinyServer(function(input, output) {
  output$sdfsdf <- renderText({
    daemons::check_remote()
  })
 outimg<- c('spock_false.jpg','spock_true.jpeg')[
    as.numeric(daemons::check_remote())+1
    ]
  output$spockstate <- renderImage({
    'spock_false.jpg'
  })

})

}
