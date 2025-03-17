wetqc_lot_view_server <- function(input, output, session) {
  aLOT <- LLP::lotstore$new()

  # Use reactiveVal for table storage
  TBL <- shiny::reactiveVal(list(
    B = "xfe24wetqc",
    W = "xfe96wetqc",
    C = "xfpwetqc"
  ))

  # Database connection with error handling
  db <- tryCatch(
    adminKraken::con_mysql(),
    error = function(e) {
      message("Database connection failed: ", e)
      NULL
    }
  )
  if (is.null(db)) stop("Could not connect to the database.")

  # Close database connection when session ends
  session$onSessionEnded(function() {
    if (!is.null(db)) RMySQL::dbDisconnect(db)
    shiny::stopApp()
  })

  # Reactive Data Selection
  selectedData <- shiny::reactive({
    LLP::react_wetqc_lot_data(get(input$PLAT, envir = TBL()), input$Variable, input$Lot, db)
  })

  shiny::observeEvent(input$PLAT, {
    shiny::updateSelectInput(session, 'Lot', choices = aLOT$get(input$PLAT))
  })

  output$plot1 <- plotly::renderPlotly({
    ggplot2::ggplot(selectedData(), ggplot2::aes(x = factor(sn), y = var)) +
      ggplot2::geom_boxplot(outlier.shape = NA, outlier.alpha = 0.00001, outlier.color = 'white') +
      ggplot2::geom_jitter(shape = 22, alpha = .6, size = 3.5, color = "black", ggplot2::aes(fill = Inst)) +
      ggplot2::xlab("Serial Number") +
      ggplot2::ylab(input$Variable) +
      ggplot2::theme_bw() +
      ggplot2::ggtitle(input$Lot) +
      ggthemes::scale_fill_gdocs()
  })
}
