
spock_wetqc_server<-function(){
require(shiny)
require(RMySQL)
require(asyr)
require(XML)
require(DT)

remove_deselected<-function(data, deselection) {
  if (is.null(deselection)) {
    return(data)
  }
  else {
    return(data[-1 * deselection])
  }
}

shinyServer(function(input, output, session) {
  session$onSessionEnded(function() {
    stopApp()
  })
  clean_selections <-
    DT::renderDataTable(
      NULL,
      selection = list(selected = NULL),
      server = F,
      options = list(dom = "t"),
      rownames = FALSE
    )
  output$foo <- clean_selections
  observeEvent(input$Quit, {
    stopApp(returnValue = invisible())
  })
  observeEvent(input$goButton, {
    output$MSG <- renderText("Ready")
    if (length(input$goButton$name) > 0) {
      output$MSG <- renderText("Select Directory")
      output$MSG <- renderText("Munging Data...")
      procd <- lapply(
        lapply(
          input$goButton$datapath,
          XML::xmlTreeParse,
          useInternalNodes = T
        ),
        asyr::process
      )
      DATA <- lapply(procd, extract_wetQC)
      output$foo2 <- DT::renderDataTable(do.call("rbind",
                                                 DATA))
      sum_tbl <- asyr::process_summary(procd)
      sum_tbl <- sum_tbl[order(sum_tbl$sn, method = "radix"),]
      if (exists("sum_tbl")) {
        sum_tbl$use <- T
        output$foo <- DT::renderDataTable(
          sum_tbl,
          selection = list(selected = which(sum_tbl$valid ==
                                              FALSE)),
          server = F,
          options = list(dom = "t",
                         pageLength = nrow(sum_tbl)),
          rownames = F
        )
      }
      observeEvent(input$foo_rows_selected, {
        sum_tbl
        sum_tbl$use <- T
        sum_tbl$use[input$foo_rows_selected] <- F
        output$foo <- DT::renderDataTable(
          sum_tbl,
          selection = list(selected = input$foo_rows_selected),
          server = F,
          options = list(dom = "t", pageLength = nrow(sum_tbl)),
          rownames = FALSE
        )
        last <- input$foo_rows_selected
      })
      observeEvent(input$desel, {
        sum_tbl$use <- T
        output$foo <- output$foo <- DT::renderDataTable(
          sum_tbl,
          selection = list(selected = NULL),
          server = F,
          options = list(dom = "t", pageLength = nrow(sum_tbl)),
          rownames = FALSE
        )
      })
      ########################
      #  export
      ########################

        output$exprt <- downloadHandler(
          filename <- function() {
            paste("data-", Sys.Date(), ".csv", sep="")
          },
          content <- function(file) {
            OUT <- do.call("rbind",
                           remove_deselected(DATA,input$foo_rows_selected)
            )
            OUT <- OUT[order(OUT$sn, OUT$Well, method = "radix"),]
            write.csv(OUT, file,row.names = F)
          }
        )
      observeEvent(input$upload, {
        asyr::upload_process_summary(sum_tbl)
        asyr::UploadsCC(
          remove_deselected(DATA,input$foo_rows_selected)
          )
      })
    }
  })
})
}
