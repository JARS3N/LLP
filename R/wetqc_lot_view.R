
wetqc_lot_view<-function(){
require(shiny)
require(ggplot2)
require(ggthemes)
require(plotly)

# require(RMySQL)
db<-adminKraken::con_mysql()

shinyServer(function(input, output,session) {
    session$onSessionEnded(function() {
        RMySQL::dbDisconnect(db)
        stopApp()
    })


    selectedData <- reactive({
        LLP::react_wetqc_lot_data(input$PLAT,input$Variable,input$Lot,db)
    })


    observeEvent(input$PLAT,{
        updateSelectInput(session,'Lot',choices=LLP::unique_wetqc_lots(input$PLAT,db)$Lot)
    }
    )

    output$plot1 <- renderPlotly({
     ggplot(selectedData(),aes(x=factor(sn),y=var))+
    geom_boxplot(outlier.shape = NA,outlier.alpha = 0.00001,outlier.color = 'white') +
         geom_jitter(shape=22,alpha=.6,size=3.5,color="black",aes(fill=Inst))+
     xlab("Serial Number") +
         ylab(input$Variable)+
       theme_bw() +
         ggtitle(input$Lot)+
        scale_fill_gdocs()
    })

})
}
