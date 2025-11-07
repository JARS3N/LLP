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
    ggplot2::labs(x = "Serial Number", y = input$Variable, title = input$Lot) +
    ggplot2::theme_bw() +
    ggthemes::scale_fill_gdocs()

  # convert without fragile merge
  g <- plotly::ggplotly(p, originalData = FALSE, tooltip = c("sn","val","Inst"))

  # post-process traces: hide boxes from legend, points stay in legend only
  for (i in seq_along(g$x$data)) {
    tr <- g$x$data[[i]]
    if (identical(tr$type, "box")) {
      # keep boxes always visible, never in legend, and in a different legendgroup
      g$x$data[[i]]$showlegend   <- FALSE
      g$x$data[[i]]$legendgroup  <- paste0(tr$name, "_box")
    } else if (identical(tr$type, "scatter")) {
      # points are the only legend items; make sure they don't toggle the boxes
      g$x$data[[i]]$showlegend   <- TRUE
      g$x$data[[i]]$legendgroup  <- paste0(tr$name, "_pts")
      # (optional cosmetics)
      if (is.null(g$x$data[[i]]$marker)) g$x$data[[i]]$marker <- list()
      g$x$data[[i]]$marker$size    <- 6
      g$x$data[[i]]$marker$opacity <- 0.6
      g$x$data[[i]]$marker$line    <- list(width = 1)
    }
  }

  plotly::layout(
    g,
    legend = list(itemclick = "toggle", itemdoubleclick = "toggleothers"),
    xaxis  = list(title = "Serial Number"),
    yaxis  = list(title = input$Variable),
    title  = list(text = input$Lot)
  )
})
}
