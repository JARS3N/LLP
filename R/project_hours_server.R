
project_hours_server<-function(){
E<-new.env()
library(shiny)
library(DT)
library(lubridate)
library(shiny)

shinyServer(function(input, output,session) {
    db<-adminKraken::con_dplyr()
    observeEvent(input$dates,{
    #print(input$dates)
    ##############
        output$weekchosen <-
            renderText({
                paste0(
                    lubridate::month(input$dates,label=T,abbr = T),
                    "  Week ",
                       lubridate::week(input$dates),
                       " of ",
                       lubridate::year(input$dates)
                       )
            })
    ##############
     E$df<-NULL  
     E$df <- pull_or_create(input$dates,db)  
        output$testDT <-renderDT(E$df,
                                 editable = T,
                                 options = list(ordering=F,dom = 't',pageLength = nrow(E$df))
                                 )
    })
        
    observeEvent(input$testDT_cell_edit, {
        info <- input$testDT_cell_edit
        i <- info$row
        j <- info$col +1
        v <- info$value
        E$df[info$row,info$col] <-v
        project<-E$df$project[i]
        task<-E$df$task[i]
        usr<-names(E$df)[j-1]
        str <- update_string(v, 
                             usr,
                             project, 
                             task, 
                             lubridate::year(input$dates), 
                             lubridate::month(input$dates), 
                             lubridate::week(input$dates))
        print(str)
        update_proj(str)
        rm(str)
    })
    
    

})
}