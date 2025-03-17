wetqc_lot_view_server <- function(input, output, session) {
  aLOT <- LLP::lotstore$new()

  # Use reactiveVal for table storage
  TBL <- reactiveVal(list(
    B = "xfe24wetqc",
    W = "xfe96wetqc",
    C = "xfpwetqc"
  ))

  # Establish database connection
  db <- connect_db()

  # Close database connection when session ends
  session$onSessionEnded(function() {
    if (!is.null(db)) RMySQL::dbDisconnect(db)
    stopApp()
  })

  # Reactive expression for data selection
  selectedData <- reactive({
    LLP::react_wetqc_lot_data(get(input$PLAT, envir = TBL()), input$Variable, input$Lot, db)
  })

  # Observe platform selection to update lot choices
  observeEvent(input$PLAT, {
    updateSelectInput(session, 'Lot', choices = aLOT$get(input$PLAT))
  })

  # Cache plot data
  plot_data <- reactive({
    selectedData()
  })

  # Render Plotly plot
  output$plot1 <- renderPlotly({
    ggplot(plot_data(), aes(x = factor(sn), y = var)) +
      geom_boxplot(outlier.shape = NA, outlier.alpha = 0.00001, outlier.color = 'white') +
      geom_jitter(shape = 22, alpha = .6, size = 3.5, color = "black", aes(fill = Inst)) +
      xlab("Serial Number") +
      ylab(input$Variable) +
      theme_bw() +
      ggtitle(input$Lot) +
      scale_fill_gdocs()
  })
}
