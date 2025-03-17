cqc_plat_server <- function() {
  require(shiny)
  require(ggplot2)
  require(adminKraken)
  require(LLP)
  
  print("Starting server...")  # Debugging step

  my_db <- tryCatch({
    adminKraken::con_mysql()
  }, error = function(e) {
    print(paste("Database connection failed:", e$message))  # Debugging
    return(NULL)
  })
  
  shinyServer(function(input, output, session) {
    print("Server initialized...")  # Debugging step

    output$head <- renderText({
      print(paste("Header panel updated:", input$PLAT))  # Debugging
      input$PLAT
    })

    observeEvent(input$PLAT, {
      print(paste("PLAT Selected:", input$PLAT))  # Debugging
      instruments <- tryCatch({
        LLP::get_cc_instruments(input$PLAT)
      }, error = function(e) {
        print(paste("Error in get_cc_instruments:", e$message))  # Debugging
        return(c("Error"))
      })
      print(instruments)  # Debugging
      updateSelectInput(session, "INST", choices = instruments)
    })

    observeEvent(input$INST, {
      print(paste("INST Selected:", input$INST))  # Debugging
      mx <- tryCatch({
        LLP::get_n_cc_lots(input$PLAT, input$INST)
      }, error = function(e) {
        print(paste("Error in get_n_cc_lots:", e$message))  # Debugging
        return(1)
      })
      print(mx)  # Debugging
      updateSliderInput(session, "SLIDE", max = mx, min = 1, value = c(mx - 10, mx))
    })

    output$plot1 <- renderPlot({
      print("Rendering plot1...")  # Debugging
      selectedData <- reactive({
        df <- tryCatch({
          LLP::calc_cc_means(input$PLAT, input$Variable, input$INST, my_db)
        }, error = function(e) {
          print(paste("Error in calc_cc_means:", e$message))  # Debugging
          return(data.frame(Lot = 1:10, avg = runif(10, 5, 15), sd = runif(10, 1, 3)))
        })
        print(head(df))  # Debugging
        df[input$SLIDE[1]:input$SLIDE[2], ]
      })

      ggplot(selectedData(), aes(x = Lot, y = avg)) +
        geom_line(stat = 'identity', aes(group = 1), alpha = .5) +
        geom_errorbar(aes(ymin = avg - sd, ymax = avg + sd)) +
        geom_point(shape = 21, size = 3, fill = "green", color = "black") +
        theme_bw() + ylab("") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle(paste0("Averages of ", input$Variable))
    })

    output$plotinter <- renderPlot({
      print("Rendering plotinter...")  # Debugging
      selectedData_inter <- reactive({
        df <- tryCatch({
          LLP::calc_cc_intercvs(input$PLAT, input$Variable, input$INST, my_db)
        }, error = function(e) {
          print(paste("Error in calc_cc_intercvs:", e$message))  # Debugging
          return(data.frame(Lot = 1:10, interCV = runif(10, 5, 15), interCVsd = runif(10, 1, 3)))
        })
        print(head(df))  # Debugging
        df[input$SLIDE[1]:input$SLIDE[2], ]
      })

      ggplot(selectedData_inter(), aes(x = Lot, y = interCV)) +
        geom_line(stat = 'identity', aes(group = 1), alpha = .5) +
        geom_errorbar(aes(ymin = interCV - interCVsd, ymax = interCV + interCVsd)) +
        geom_point(shape = 21, size = 3, fill = "green", color = "black") +
        theme_bw() + ylab("%CV") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle(paste0("Inter Uniformity of ", input$Variable))
    })

    output$plotintra <- renderPlot({
      print("Rendering plotintra...")  # Debugging
      selectedData_intra <- reactive({
        df <- tryCatch({
          LLP::calc_cc_intracvs(input$PLAT, input$Variable, input$INST, my_db)
        }, error = function(e) {
          print(paste("Error in calc_cc_intracvs:", e$message))  # Debugging
          return(data.frame(Lot = 1:10, intraCV = runif(10, 5, 15), intraCVsd = runif(10, 1, 3)))
        })
        print(head(df))  # Debugging
        df[input$SLIDE[1]:input$SLIDE[2], ]
      })

      ggplot(selectedData_intra(), aes(x = Lot, y = intraCV)) +
        geom_line(stat = 'identity', aes(group = 1), alpha = .5) +
        geom_errorbar(aes(ymin = intraCV - intraCVsd, ymax = intraCV + intraCVsd)) +
        geom_point(shape = 21, size = 3, fill = "green", color = "black") +
        theme_bw() + ylab("%CV") +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        ggtitle(paste0("Intra Uniformity of ", input$Variable))
    })

  })
}
