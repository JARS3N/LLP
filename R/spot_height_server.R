
spot_height_server<-function() {
require(shiny)
require(RMySQL)
cleanInputs <- c(
  "PA1",
  "PA2",
  "PA3",
  "PA4",
  "PA5",
  "PA6",
  "PB1",
  "PB2",
  "PB3",
  "PB4",
  "PB5",
  "PB6",
  "PC1",
  "PC2",
  "PC3",
  "PC4",
  "PC5",
  "PC6",
  "PD1",
  "PD2",
  "PD3",
  "PD4",
  "PD5",
  "PD6",
  "OA1",
  "OA2",
  "OA3",
  "OA4",
  "OA5",
  "OA6",
  "OB1",
  "OB2",
  "OB3",
  "OB4",
  "OB5",
  "OB6",
  "OC1",
  "OC2",
  "OC3",
  "OC4",
  "OC5",
  "OC6",
  "OD1",
  "OD2",
  "OD3",
  "OD4",
  "OD5",
  "OD6"
)

shinyServer(function(input, output, session) {
  shiny::observeEvent(input$enter, {
    DF <<- data.frame(
      Well = c(
        "A1",
        "A2",
        "A3",
        "A4",
        "A5",
        "A6",
        "B1",
        "B2",
        "B3",
        "B4",
        "B5",
        "B6",
        "C1",
        "C2",
        "C3",
        "C4",
        "C5",
        "C6",
        "D1",
        "D2",
        "D3",
        "D4",
        "D5",
        "D6"
      ),
      pHeight = c(
        input$PA1,
        input$PA2,
        input$PA3,
        input$PA4,
        input$PA5,
        input$PA6,
        input$PB1,
        input$PB2,
        input$PB3,
        input$PB4,
        input$PB5,
        input$PB6,
        input$PC1,
        input$PC2,
        input$PC3,
        input$PC4,
        input$PC5,
        input$PC6,
        input$PD1,
        input$PD2,
        input$PD3,
        input$PD4,
        input$PD5,
        input$PD6
      ),
      oHeight = c(
        input$OA1,
        input$OA2,
        input$OA3,
        input$OA4,
        input$OA5,
        input$OA6,
        input$OB1,
        input$OB2,
        input$OB3,
        input$OB4,
        input$OB5,
        input$OB6,
        input$OC1,
        input$OC2,
        input$OC3,
        input$OC4,
        input$OC5,
        input$OC6,
        input$OD1,
        input$OD2,
        input$OD3,
        input$OD4,
        input$OD5,
        input$OD6
      ),
      Lot = input$Lot,
      sn = input$sn,
      operator = input$Operator,
      date = input$Date
    )#,#end DF
    
    if (all(DF$pHeight > 0 &&
            DF$pHeight <= 0.01 && DF$oHeight > 0 && DF$oHeight <= 0.01)) {
      for (i in seq_along(cleanInputs)) {
        updateNumericInput(session = session,
                           inputId = cleanInputs[i],
                           value = 0.0010)
      }
      updateTextInput(session = session,
                      inputId = 'Lot',
                      value = "")
      updateTextInput(session = session,
                      inputId = 'sn',
                      value = "")
      updateTextInput(session = session,
                      inputId = 'Operator',
                      value = "")
      updateDateInput(session = session,
                      inputId = 'Date',
                      value = NULL)
      
      
      output$check <- renderText("")
      print("Kudos to you!")
      my_db <- adminKraken::con_mysql()
      dbWriteTable(
        my_db,
        name = "xf24spotheight",
        value = DF,
        append = TRUE,
        overwrite = FALSE,
        row.names = FALSE
      )
      dbDisconnect(my_db)
    } else{
      output$check <-
        renderText(
          "A value appears to have been entered incorrectly \n please check them and submit again."
        )
      output$enterspec <-
        renderText("Valid values are >0 & <= 0.01 ")
    }
    
  })
  
  
})
}
