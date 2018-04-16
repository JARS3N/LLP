search_coefs_server <- function() {

require(shiny)
require(dplyr)
lotstuff <- LLP::coef_lots()

shinyServer(function(input, output, session) {
  updateSelectInput(session, 'Lot', choices = lotstuff$Lot)
  
  
  observeEvent(input$Lot, {
   if (input$Lot != 'SELECT')
      BMID <- lotstuff$BMID[lotstuff$LotNumber == input$Lot]
    print(BMID)
    info <- LLP::get_coefs(BMID)
    
    output$Lottable <- renderTable(data.frame(Lot = input$Lot))
    output$oxtable <- renderTable(select(info, contains('PH')) %>%
                                    mutate(PH_A = as.character(round(PH_A, 0))),
                                  digits = 6)
    output$pHtable <- renderTable(select(info, contains('O2')) %>%
                                    mutate(O2_A = as.character(round(O2_A, 0))),
                                  digits = 6)
   
    if(info$BF==0){
       output$bftbl <-  renderTable(data.frame( Cartridge_BufferFactor =  NA),digits=0)
      }else{
    output$bftbl <-
      renderTable(select(info, Cartridge_BufferFactor =  BF), digits = 6)
      }
    }
  })
})
}
