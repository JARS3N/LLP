wetqc_lot_view_server <- function(input, output, session) {
  aLOT <- LLP::lotstore$new()

  TBL <- shiny::reactiveVal(list(
    B = "xfe24wetqc",
    W = "xfe96wetqc",
    C = "xfpwetqc"
  ))

  db <- tryCatch(
    adminKraken::con_mysql(),
    error = function(e) { message("Database connection failed: ", e); NULL }
  )
  if (is.null(db)) stop("Could not connect to the database.")

  session$onSessionEnded(function() {
    if (!is.null(db)) DBI::dbDisconnect(db)
    shiny::stopApp()
  })

  shiny::observeEvent(input$PLAT, {
    shiny::req(input$PLAT)
    shiny::updateSelectInput(session, "Lot", choices = aLOT$get(input$PLAT))
  }, ignoreInit = TRUE)

  selectedData <- shiny::reactive({
    shiny::req(input$PLAT, input$Variable, input$Lot)
    tbl_name <- TBL()[[as.character(input$PLAT)]]   # <-- key fix
    validate(need(!is.null(tbl_name), "Unknown platform code."))
    LLP::react_wetqc_lot_data(tbl_name, input$Variable, input$Lot, db)
  })

  output$plot1 <- plotly::renderPlotly({
    dat <- selectedData()
    ggplot2::ggplot(dat, ggplot2::aes(x = factor(sn), y = var)) +
      ggplot2::geom_boxplot(outlier.shape = NA, outlier.alpha = 1e-5, outlier.color = "white") +
      ggplot2::geom_jitter(shape = 22, alpha = .6, size = 3.5, color = "black",
                           ggplot2::aes(fill = Inst)) +
      ggplot2::xlab("Serial Number") +
      ggplot2::ylab(input$Variable) +
      ggplot2::theme_bw() +
      ggplot2::ggtitle(input$Lot) +
      ggthemes::scale_fill_gdocs()
  })
}
