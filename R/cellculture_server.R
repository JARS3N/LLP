

cellculture_server <- function() {
    library(shiny)
    # library(lubridate)
    TBL <- new.env()
    TBL$data <- data.frame()
    
    shinyServer(function(input, output) {
        observeEvent(input$add, {
            TBL$data <- dplyr::bind_rows(
                TBL$data,
                data.frame(
                    Date = input$date,
                    passage = input$passage,
                    count =  input$count,
                    viability = input$viability,
                    operator = input$operator,
                    notes = input$notes,
                    stringsAsFactors = F
                )
                
            )
            output$current_tbl = DT::renderDataTable({
                TBL$data
            }, options = list(dom = 't'))
            # print(TBL$data)
        })
        #########
        observeEvent(input$clear, {
            TBL$data <- data.frame()
            output$current_tbl = DT::renderDataTable({
                TBL$data
            })
        })
        observeEvent(input$upload, {
            print("up to kraken")
            db <- adminKraken::con_mysql()
            RMySQL::dbWriteTable(
                db,
                "cellculture",
                TBL$data,
                append = T,
                overwrite = F,
                row.names = FALSE
            )
            RMySQL::dbDisconnect(db)
            TBL$data <- data.frame()
            output$current_tbl = DT::renderDataTable({
                TBL$data
            })
        })
        
        #########
    })
}
