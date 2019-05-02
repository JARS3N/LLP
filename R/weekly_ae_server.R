weekly_ae_server<-function(){

library(dplyr)
library(shiny)
library(DT)
library(lubridate)
ddb <- adminKraken::con_dplyr()
shinyServer(function(input, output) {
  observeEvent(input$dates, {
    x<-NULL
    yr<-year(input$dates)
    wk<-week(input$dates)
    mnth<-month(input$dates)
    output$weekchosen <-
      renderText({
        paste0("Week ",
               wk,
               " of ",
               month(input$dates,label=T,abbr = T),
               " ",
               yr)
      })
    x <- ddb %>% tbl("weeklybreakdown") %>% 
      filter(year==yr,month==mnth,week==wk)   %>% 
      collect()
    if(is.na(nrow(x))| nrow(x)<1){
      COLZ <- ddb %>% tbl("weeklybreakdown") %>% colnames()
      nms<-ddb %>% tbl("weeklybreakdown") %>% select(user) %>% distinct() %>% collect()
      nms$year<-yr
      nms$month<-mnth
      nms$week<-wk
      nms[,COLZ[-(1:4)]]<-0
      db<-adminKraken::con_mysql()
      RMySQL::dbWriteTable(db,"weeklybreakdown",nms,overwrite=F,append=T,row.names=F)
      RMySQL::dbDisconnect(db)
      x<-nms
      rm(nms)
    }
    output$testDT <-
      renderDT(
        x[,-c(2:4)],
        selection = 'none',
        rownames = x[,1],
        editable = T,
        options = list(dom = 't',ordering=F)  #ordering resets tbl vals
      )
    proxy <- dataTableProxy('testDT')
  })
  observeEvent(input$testDT_cell_edit, {
    info <- input$testDT_cell_edit
    i <- info$row
    j <- info$col + 4  # column index offset by 1
    v <- info$value
    year<-year(input$dates)
    month<-month(input$dates)
    week<-week(input$dates)
 q<-create_update_string(year,month,week,v,names(x)[j],x[i,1])
 print(q)
 db<-adminKraken::con_mysql()
 snt<-RMySQL::dbSendQuery(db,q)
 RMySQL::dbClearResult(snt)
 RMySQL::dbDisconnect(db)
  })
  
})
}
