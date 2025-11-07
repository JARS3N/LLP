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

  dat <- as.data.frame(dat)
  dat$sn   <- factor(dat$sn)
  dat$Inst <- factor(dat$Inst)

  p <- ggplot2::ggplot(dat, ggplot2::aes(x = factor(sn), y = val, fill = Inst)) +
    ggplot2::geom_boxplot(outlier.shape = NA, outlier.alpha = 1e-5, outlier.color = "white") +
    ggplot2::geom_jitter(
      shape = 22, alpha = .6, size = 3.5, color = "black",
      width = 0.2, height = 0
    ) +
    ggplot2::xlab("Serial Number") +
    ggplot2::ylab(input$Variable) +
    ggplot2::ggtitle(input$Lot) +
    ggplot2::theme_bw() +
    ggthemes::scale_fill_gdocs()

  # Avoid brittle merge; then edit traces so only points show in legend
  g <- plotly::ggplotly(p, originalData = FALSE, tooltip = c("sn","val","Inst"))

  for (i in seq_along(g$x$data)) {
    tr <- g$x$data[[i]]
    # hide box traces from legend; keep scatter (points) in legend
    if (identical(tr$type, "box")) {
      g$x$data[[i]]$showlegend <- FALSE
    } else if (identical(tr$type, "scatter")) {
      g$x$data[[i]]$showlegend <- TRUE
      # optional: make point markers a bit clearer
      if (is.null(g$x$data[[i]]$marker)) g$x$data[[i]]$marker <- list()
      g$x$data[[i]]$marker$size <- 6
      g$x$data[[i]]$marker$opacity <- 0.6
      g$x$data[[i]]$marker$line <- list(width = 1)
    }
  }

  plotly::layout(
    g,
    legend = list(itemclick = "toggle", itemdoubleclick = "toggleothers"),
    xaxis = list(title = "Serial Number"),
    yaxis = list(title = input$Variable),
    title = list(text = input$Lot)
  )
})

}
