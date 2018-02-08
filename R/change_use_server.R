change_use_server<-function(){
require(dplyr)
require(xml2)
require(base64enc)
library(shiny)
library(rvest)
n<-3333
shinyServer(function(input, output) {

  observeEvent(input$file1,{
    sm <-  xml2::read_xml(readBin(base64decode(file(
      input$file1$datapath
    )),
    "character"))

    b <- xml_node(read_xml(
      paste0(
        "<o><NumberOfTimesUsed>",
        input$n,
        "</NumberOfTimesUsed></o>"
      )
    ),
    'NumberOfTimesUsed')
    
    a<-xml_nodes(sm,'NumberOfTimesUsed')
    
    xml_replace(a,b)

    out <<- base64encode(charToRaw(paste0(sm, collapse = "\n")))

  })
  output$downloadData <- downloadHandler(
    filename = "ReplaceCartridgeBarcodes.XML" ,
    contentType = 'application/xml',
     content = function(file) {
      writeLines(out, file)
    }
  )
  }
