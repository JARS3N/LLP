qcnotes_server <- function() {
  require(shiny)
require(RMySQL)
aLOT<-LLP::lotstore$new()
shinyServer(function(input, output, session) {
  observeEvent(input$PLAT,
               {
                 updateSelectInput(session,
                                   'Lot',
                                   choices = aLOT$get(input$PLAT))
               })
  
  observeEvent(input$Lot, {
    output$text1 <- renderText({
      LLP::get_notes(input$Lot)
    })
  })
  
  
  observeEvent(input$button, {
    notes <- c(input$txtnotes1,
               input$txtnotes2,
               input$txtnotes3)
    
    len <- sapply(notes, nchar)
    
    if (sum(len) < 253) {
      notes <- paste(notes, collapse = " ")
    }
    
    DF_0 <- data.frame(
      Lot = as.character(input$Lot),
      plat = as.character(input$PLAT),
      notes = as.character(notes)
    )
    DF <- DF_0[, DF_0$notes != '']
    
    if (nrow(DF) > 0) {
      my_db <- adminKraken::con_mysql()
      dbWriteTable(
        my_db,
        name = "qclotnotes",
        value = DF,
        append = TRUE,
        overwrite = FALSE,
        row.names = FALSE
      )
      dbDisconnect(my_db)
      updateTextInput(session, "txtnotes1", value = "")
      updateTextInput(session, "txtnotes2", value = "")
      updateTextInput(session, "txtnotes3", value = "")
      
    }
    
  })
  
})
}
