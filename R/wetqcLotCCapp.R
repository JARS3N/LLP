wetqcLotCCapp<-function(){
runApp(
  shiny::shinyApp(
    ui     = LLP::wetqc_lot_view_ui(),                   
    server = LLP::wetqc_lot_view_server 
  ),launch.browser=T)
  }
