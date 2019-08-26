release_server<-function(){
require(shiny)
require(dplyr)
require(rmarkdown)
shinyServer(
    function(input, output,session) {
observeEvent(input$PLAT,
             { updateSelectInput(session,'Lot',choices=as.vector(LLP::list_cc_tbl_lots(LLP::cctbls(unname(input$PLAT)))))
                 })
observeEvent(input$Lot,
              {updateSelectInput(session,'INST',choices=LLP::get_cclot_instruments(input$Lot,LLP::cctbls(input$PLAT))
              )}

)
observeEvent(input$Lot,{
    output$text1<-renderText({LLP::get_notes(input$Lot)})

})
output$downloadData <- downloadHandler(
    filename = paste0(input$PLAT,input$Lot,".pdf"),
    content <- function(file) {
        normalizePath(paste0(input$PLAT,".rmd")) %>%
            readLines(.) %>%
            lapply(.,function(u)(gsub("XXXXX",input$Lot,u))) %>%
            lapply(.,function(u)(gsub("YYYYY",input$INST,u))) %>%
            unlist(.) %>%
            write(.,file=paste0(input$PLAT,input$Lot,".rmd"))
        out <- render(paste0(input$PLAT,input$Lot,".rmd"),"pdf_document")
        file.copy(out, file)
        unlink(paste0(input$PLAT,input$Lot,".pdf"))
        unlink(paste0(input$PLAT,input$Lot,".rmd"))
        }
)
})
}
