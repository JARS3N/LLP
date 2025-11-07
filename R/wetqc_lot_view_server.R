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
  shiny::req(NROW(dat) > 0)

  dat$sn   <- factor(dat$sn)
  dat$Inst <- factor(dat$Inst)

  plotly::plot_ly(
    data = dat,
    x = ~sn, y = ~val, color = ~Inst,
    type = "box",
    boxpoints = "all",   # show the points on the same trace
    jitter = 0.3,
    pointpos = 0,
    marker = list(size = 6, opacity = 0.6, line = list(width = 1)),
    line   = list(width = 1)
  ) %>%
    plotly::layout(
      title = list(text = input$Lot),
      xaxis = list(title = "Serial Number"),
      yaxis = list(title = input$Variable),
      boxmode = "group",                   # group by Inst within each sn
      legend = list(itemclick = "toggle", itemdoubleclick = "toggleothers")
    )
})
}
