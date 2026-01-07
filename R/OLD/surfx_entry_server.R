surfx_entry_server<-function(){
k<-0
require(shiny)
require(dplyr)
require(RMySQL)
fixN<-function(u){
as.character(sprintf("%02d", as.numeric(u)))
}
shinyServer(function(input, output,session) {
  output$data_input<-renderUI({p("")})
  c24<-c("A1","A2","A3","A4","A5","A6","B1","B6","C1","C6","D1","D2","D3","D4","D5","D6")
  c8<-LETTERS[1:8]
  observeEvent(input$CTG_LOT,{
    ct<-toupper(substr(input$CTG_LOT,1,1))
    if (k !=ct){
      k<<-ct
      wells<<-list("W"= c8,"C"= c8,"B"= c24,"Q"= c24)[ct] %>% unlist()
      output$data_input <-renderUI({
        fluidRow(
          lapply(wells, function(i) {
            numericInput(inputId=i,label=i,
                         value=0,min=0,max=100,step=1,width="50%") %>%
              column(.,width=5)
          })#lapply
        )##fluidROw

      })#end,observeinput$CTG_LOT

    }

  })

  observeEvent(input$Submit,{
    OUT1<- data.frame(
      RAW_LOT=input$RAW_LOT,
      CTG_LOT=toupper(input$CTG_LOT),
      BTCH_NO=input$BTCH_NO,
      SURFX_DATE=input$SURFXDate,
      TIME_TREATED=paste0(input$sfxH,":",fixN(input$sfxM),input$y),
      INSP_BY=input$INSP_BY,
      DATE_MEASURED = input$mesDate,
      TIME_MEASURED = paste0(input$mesH,":",fixN(input$mesM),input$y2),
      mesH=input$mesH)

    my_db2 <- adminKraken::con_mysql()
    dbWriteTable(my_db2, name = "surfxmeta",value = OUT1,
                 append = T,overwrite = F,row.names = FALSE)
    x<-RMySQL::dbSendQuery(my_db2,'select max(ID) as ID from surfxmeta;')
    y<-RMySQL::dbFetch(x)
    RMySQL::dbClearResult(x)
    OUT2<-data.frame(Well=wells,ContactAngle=sapply(wells,function(u){input[[u]]})) %>%
      mutate(.,ID=y$ID)
    dbWriteTable(my_db2, name = "surfxdata",value = OUT2,
                 append = T,overwrite = F,row.names = FALSE)
    dbDisconnect(my_db2)
    output$data_input <-renderUI({
      fluidRow(
        lapply(wells, function(i) {
          column(numericInput(inputId=i,label=i,
          value=0,min=0,max=100,step=1,width="50%"),
          width=5)
        })#lapply
      )##fluidROw

    })
    shiny::updateTextInput(session,"BTCH_NO",value="")

  })

})
}
