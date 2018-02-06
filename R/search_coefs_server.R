search_coefs_server <- function(session) {

library(shiny)

lotstuff <- coef_lots()

shinyServer(function(input, output, session) {
  updateSelectInput(session, 'Lot', choices = lotstuff$Lot)
  
  
  observeEvent(input$Lot, {
    if (input$Lot != 'N/A')
      BMID <- lotstuff$BMID[lotstuff$LotNumber == input$Lot]
    info <- get_coefs(BMID)
    
    output$Lottable <- renderTable(data.frame(Lot = input$Lot))
    output$oxtable <- renderTable(select(info, contains('PH')) %>%
                                    mutate(PH_A = as.character(round(PH_A, 0))),
                                  digits = 6)
    output$pHtable <- renderTable(select(info, contains('O2')) %>%
                                    mutate(O2_A = as.character(round(O2_A, 0))),
                                  digits = 6)
    output$bftbl <-
      renderTable(select(info, Cartridge_BufferFactor = BF), digits = 6)
  })
})
}
