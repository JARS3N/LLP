alt_rfs_server<-function(){
require(LLP)
require(shiny)
require(dplyr)
require(rmarkdown)
library(shinyjs)
shinyjs::useShinyjs()
tbl<-c("XFe24LotRelease","XFe96LotRelease","XFpLotRelease")
type<-c("B","W","C")
G<-new.env()
for (i in 1:4){
  assign(
    x=tbl[i],
    val=type[i],
    envir=G
  )
}
HOLD<-new.env()
dblots<-LLP::lotstore$new()
shinyServer(function(input, output, session) {
LLP::app_exit(session,NULL)
  observeEvent(input$PLAT,
               { updateSelectInput(session, 'Lot', choices = c("..."))
                 updateSelectInput(session, 'INST', choices = c("..."))
                 updateSelectInput(session, 'Lot', choices = dblots$get(get(input$PLAT,envir=G)))
               })

  observeEvent(input$Lot, {
    shinyjs::hide("downloadData")
    updateSelectInput(session, 'INST', choices = c("..."))
    HOLD$release <- NULL
    output$lotchoice <- renderText({input$Lot})
    output$text1 <- renderText({LLP::get_notes(input$Lot)})
    output$sumtbl <- DT::renderDataTable({NULL})
    updateSelectInput(session,
                      'INST',
                      choices = LLP::get_cclot_instruments(input$Lot, LLP::cctbls(input$PLAT)))
  })
  observeEvent(input$INST,{
    shinyjs::hide("downloadData")
    output$sumtbl <- NULL
    HOLD$release <- NULL
    })
  observeEvent(input$Compiler,{
    HOLD$release <- release$new(input$Lot,input$INST)
    output$sumtbl <- DT::renderDataTable({
     HOLD$release$ctg_means
    },options = list(dom = 't',pageLength = 11),rownames=FALSE)
     shinyjs::show("downloadData")
  })
  
  output$downloadData <- downloadHandler(filename <-
                                           paste0(input$PLAT, input$Lot, ".pdf")
                                         ,
                                         content <- function(file) {
                                           if(is.null(HOLD$release$ctg_means)){
                                             HOLD$release<-value=release$new(input$Lot,input$INST)
                                           }
                                           file_name<-paste0(input$PLAT, input$Lot)
                                           rmd_name <-  paste0(file_name, ".rmd")
                                           pdf_name <-paste0(file_name, ".pdf")
                                           write(HOLD$release$get_RMD(), file = rmd_name)
                                           out <-rmarkdown::render(rmd_name, "pdf_document")
                                           file.copy(out, file)
                                           unlink(pdf_name)
                                           unlink(rmd_name)
                                         })
})

}
