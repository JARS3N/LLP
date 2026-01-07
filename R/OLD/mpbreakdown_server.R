
mpbreakdown_server<-function(){
db <- adminKraken::con_dplyr()
library(ggplot2)
library(shiny)
library(lubridate)
library(dplyr)
x <-
  db %>% tbl("projecthours") %>% group_by(month, project, year) %>%
  summarise(., sums = sum(hours, na.rm = T)) %>% collect() %>%
  group_by(month, year) %>% mutate(total = sum(sums, na.rm = T)) %>%
  ungroup() %>% mutate(., percent = 100 * (sums / total)) %>%
  filter(., total > 0)
years <- unique(x$year)
shinyServer(function(input, output, session) {
  PLOT <- NULL
  shiny::updateSelectInput(inputId = "years",
                           choices = years,
                           session = session)
  observeEvent(input$year, {
    shiny::updateSelectInput(
      session = session,"month",choices = unique(filter(x,year == input$year)$month)
    )
  })
 
  output$distPlot <- renderPlot({
    x2 <-x %>% filter(month==input$month) %>% 
    arrange( percent) %>% mutate(., project = factor(project, levels = project))
    ggplot(x2, aes(project, percent)) + 
   # geom_col(fill = rgb(0.1,0.1, 0.9, 0.8), col = rgb(0, 0, 0.5, 0.75)) +
    geom_col(aes(fill=project))+
      coord_flip() + ggtitle(paste0("%Hours by Project for ",
                                    month.name[as.numeric(input$month)], " ", input$year)) +
      ylab("") + xlab("") + theme_minimal()+
    ggthemes::scale_fill_calc()+
    guides(fill = FALSE, size = FALSE)
  })
    output$distPlot2 <- renderPlot({
    x3 <- filter(x,month==input$month) %>% 
      arrange(percent) %>%
      #filter(percent>0) %>% 
      mutate(., project = factor(project, levels = project))
    ggplot(x3,aes(x="",y=percent,fill=project))+
      geom_bar(stat="identity", width=1,col="white")+
      coord_polar("y", start=0)+
      geom_text(col="black",
                size=5,
                aes(label = paste0(round(percent), "%")), 
               position = position_stack(vjust = .5)
                )+
      theme_void()+
      ggthemes::scale_fill_calc()+
      guides(fill = guide_legend(reverse=TRUE))
  })
  
})
}
