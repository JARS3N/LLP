psuedovol_server<-function(){
library(shiny)
shinyServer(function(input, output,session) {

  observeEvent(input$FILE, {
    X <-
      adjust_chamber_vol(input$FILE$datapath, input$FILE$name, input$chamber)
    XML::saveXML(doc = X$xml, file = X$name_xml)
  })
  output$export <-
    downloadHandler(
      filename = X$new_asyr_name,
      content = function(file) {
        R.utils::gzip(X$name_xml,file)
        rm(X)
      }
    ) 
  
})
}
