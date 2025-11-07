cartridge_qc_platform<-function(){
shiny::runApp(
shinyApp(LLP::cc_platform_view_ui(),LLP::cc_platform_view_server()),
launch.browser=T)
}
