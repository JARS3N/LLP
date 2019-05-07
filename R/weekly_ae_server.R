weekly_ae_server<-function(){
E<-new.env()
  library(dplyr)
  library(shiny)
  library(DT)
  library(lubridate)
  ddb <- adminKraken::con_dplyr()
  shinyServer(function(input, output) {
    observeEvent(input$dates, {
      E$x<-NULL
      E$yr<-year(input$dates)
      E$wk<-week(input$dates)
      E$mnth<-month(input$dates)
      output$weekchosen <-
        renderText({
          paste0("Week ",
                 E$wk,
                 " of ",
                 month(input$dates,label=T,abbr = T),
                 " ",
                 E$yr)
        })
      E$x <- ddb %>% tbl("weeklybreakdown") %>% 
        filter(year==E$yr,month==E$mnth,week==E$wk)   %>% 
        collect()
      if(is.na(nrow(E$x))| nrow(E$x)<1){
        COLZ <- ddb %>% tbl("weeklybreakdown") %>% colnames()
        nms<-ddb %>% tbl("weeklybreakdown") %>% select(user) %>% distinct() %>% collect()
        nms$year<-E$yr
        nms$month<-E$mnth
        nms$week<-E$wk
        nms[,COLZ[-(1:4)]]<-0
        db<-adminKraken::con_mysql()
        RMySQL::dbWriteTable(db,"weeklybreakdown",nms,overwrite=F,append=T,row.names=F)
        RMySQL::dbDisconnect(db)
        E$x<-nms
        rm(nms)
      }
      output$testDT <-
        renderDT(
          E$x[,-c(2:4)],
          selection = 'none',
          rownames = E$x[,1],
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
           if(j==4){
        output$testDT <-
          renderDT(
            E$x[,-c(2:4)],
            selection = 'none',
            rownames = E$x[,1],
            editable = T,
            options = list(dom = 't',ordering=F)  #ordering resets tbl vals
          )
      }else{
      year<-year(input$dates)
      month<-month(input$dates)
      week<-week(input$dates)
      q<-LLP::create_update_string(year,month,week,v,names(E$x)[j],E$x[i,1])
      print(q)
      db<-adminKraken::con_mysql()
      snt<-RMySQL::dbSendQuery(db,q)
      RMySQL::dbClearResult(snt)
      RMySQL::dbDisconnect(db)
      }
    })
  })
}
