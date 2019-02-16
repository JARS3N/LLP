cc_platform_view_server<-function(){

require(shiny)
require(ggplot2)

my_db <- adminKraken::con_mysql()

###### Try just grabbing an entire list at the start if that pause gets annoying
shinyServer(function(input, output, session) {
    output$head <- renderText({
        input$PLAT
    })
    observeEvent(input$PLAT, {
        updateSelectInput(session,
                          'INST',
                          choices = LLP::get_cc_instruments(input$PLAT))
    })
    observeEvent(input$INST, {
        mx <- LLP::get_n_cc_lots(input$PLAT, input$INST)
        updateSliderInput(
            session,
            'SLIDE',
            max = mx,
            min = 1,
            value = c(mx - 10, mx)
        )
    })
   output$plot1 <- renderPlot({
      selectedData <- reactive({
       df<- LLP::calc_cc_means(input$PLAT, input$Variable, input$INST, my_db)[input$SLIDE[1]:input$SLIDE[2], ] 
        df$Lot<-factor(df$Lot,levels=df$Lot)
        df
      })

        ggplot(selectedData(), aes(x = Lot, y = avg)) +
            geom_line(stat = 'identity', aes(group = 1), alpha = .5) +
            geom_errorbar(aes(ymin = avg - sd, ymax = avg + sd)) +
            geom_point(
                shape = 21,
                size = 3,
                fill = "green",
                color = "black"
            ) +
            theme_bw() + ylab("") +
            theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
            ggtitle(paste0("Averages of ", input$Variable))
    })


    output$plotinter <- renderPlot({
        selectedData_inter <- reactive({
            LLP::calc_cc_intercvs(input$PLAT, input$Variable, input$INST, my_db)[input$SLIDE[1]:input$SLIDE[2], ]
        })

        ggplot(selectedData_inter(), aes(x = Lot, y = interCV)) +
            geom_line(stat = 'identity', aes(group = 1), alpha = .5) +
            geom_errorbar(aes(
                ymin = interCV - interCVsd,
                ymax = interCV + interCVsd
            )) +
            geom_point(
                shape = 21,
                size = 3,
                fill = "green",
                color = "black"
            ) +
            theme_bw() + ylab("%CV") +
            theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
            ggtitle(paste0("Inter Uniformity of ", input$Variable))

    })

    output$plotintra <- renderPlot({
        selectedData_intra <- reactive({
            LLP::calc_cc_intracvs(input$PLAT, input$Variable, input$INST, my_db)[input$SLIDE[1]:input$SLIDE[2], ]
        })

        ggplot(selectedData_intra(), aes(x = Lot, y = intraCV)) +
            geom_line(stat = 'identity', aes(group = 1), alpha = .5) +
            geom_errorbar(aes(
                ymin = intraCV - intraCVsd,
                ymax = intraCV + intraCVsd
            )) +
            geom_point(
                shape = 21,
                size = 3,
                fill = "green",
                color = "black"
            ) +
            theme_bw() + ylab("%CV") +
            theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
            ggtitle(paste0("Intra Uniformity of ", input$Variable))

    })




})


}
