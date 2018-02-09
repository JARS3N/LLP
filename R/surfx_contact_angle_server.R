surfx_contact_angle_server <- function() {
  require(shiny)
  require(ggplot2)
  require(ggthemes)
  require(dplyr)
  my_db <- adminKraken::con_dplyr()
  shinyServer(function(input, output, session) {
    observeEvent(input$Plat, {
      mx <- LLP::count_surfx_lots(input$Plat)
      updateSliderInput(
        session,
        'SLIDE',
        max = mx,
        min = 1,
        value = c(mx - 10, mx)
      )
    })
    
    observeEvent(c(input$SLIDE, input$cktest), {
      X2 <- LLP::select_surfx_platform(input$Plat) %>%
        filter(row_number() >= input$SLIDE[1] &
                 row_number() <= input$SLIDE[2])
      
      X3 <-
        tbl(my_db, "surfxmeta") %>%
        select(., ID, CTG_LOT, BTCH_NO) %>%
        inner_join(., X2, by = "CTG_LOT", copy = TRUE)
      X4 <- tbl(my_db, "surfxdata")
      
      if (input$cktest == FALSE) {
        PLOT_DATA <- inner_join(X4, X3, by = 'ID') %>%
          collect() %>%
          arrange(., yr, day) %>%
          mutate(., CTG_LOT = factor(CTG_LOT, levels = unique(CTG_LOT)))
        
        PLOT <-  ggplot(PLOT_DATA, aes(CTG_LOT, ContactAngle)) +
          geom_hline(yintercept = 60,
                     col = 'red',
                     size = 2) +
          geom_boxplot() +
          theme_light() +
          scale_color_tableau() +
          theme(text = element_text(size = 10),
                axis.text.x = element_text(angle = 90, hjust = 1))
        output$distPlot <- renderPlot({
          PLOT
        })
      } else{
        PLOT_DATA <- inner_join(X4, X3, by = 'ID') %>%
          collect() %>%
          arrange(., yr, day) %>%
          mutate(., CTG_LOT = factor(CTG_LOT, levels = unique(CTG_LOT))) %>%
          group_by(CTG_LOT) %>%
          mutate(test = as.numeric(factor(BTCH_NO))) %>%
          ungroup() %>%
          mutate(test = factor(test))
        
        PLOT <- ggplot(PLOT_DATA, aes(CTG_LOT, ContactAngle)) +
          geom_hline(yintercept = 60,
                     col = 'red',
                     size = 2) +
          geom_boxplot(aes(fill = test)) +
          theme_light() +
          scale_fill_tableau() +
          theme(text = element_text(size = 10),
                axis.text.x = element_text(angle = 90, hjust = 1))
        output$distPlot <- renderPlot({
          PLOT
        })
      }
    })
  })
}
