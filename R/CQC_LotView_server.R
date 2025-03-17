CQC_LotView_server <- function(input, output, session) {
  aLOT <- LLP::lotstore$new()
  require(shiny)
  require(ggplot2)
  require(ggthemes)
  require(plotly)
  
  TBL <- new.env()
  TBL$B <- "xfe24wetqc"
  TBL$W <- "xfe96wetqc"
  TBL$C <- "xfpwetqc"

  db <- adminKraken::con_mysql()

  session$onSessionEnded(function() {
    RMySQL::dbDisconnect(db)
    stopApp()
  })

  selectedData <- reactive({
    LLP::react_wetqc_lot_data(get(input$PLAT, envir = TBL), input$Variable, input$Lot, db)
  })

  observeEvent(input$PLAT, {
    updateSelectInput(session, 'Lot', choices = aLOT$get(input$PLAT))
  })

  output$plot1 <- renderPlotly({
    ggplot(selectedData(), aes(x = factor(sn), y = var)) +
      geom_boxplot(
        outlier.shape = NA,
        outlier.alpha = 0.00001,
        outlier.color = 'white'
      ) +
      geom_jitter(
        shape = 22,
        alpha = .6,
        size = 3.5,
        color = "black",
        aes(fill = Inst)
      ) +
      xlab("Serial Number") +
      ylab(input$Variable) +
      theme_bw() +
      ggtitle(input$Lot) +
      scale_fill_gdocs()
  })
}
