
mpbreakdown_server<-function(){
db <- adminKraken::con_dplyr()
library(ggplot2)
library(shiny)
library(lubridate)
library(dplyr)
x <- db %>%
  tbl("projecthours") %>%
  group_by(month, project) %>%
  summarise(., sums = sum(hours, na.rm = T)) %>%
  collect() %>%
  group_by(month) %>%
  mutate(total = sum(sums, na.rm = T)) %>%
  ungroup() %>%
  mutate(., percent = 100 * (sums / total)) %>%
  filter(., total > 0)
years <- unique(x$year)
shinyServer(function(input, output, session) {
  PLOT <- NULL
  shiny::updateSelectInput(inputId = "years",
                           choices = years,
                           session = session)
  observeEvent(input$years, {
    shiny::updateSelectInput(
      inputId = "months",
      choices = unique(filter(x, year == input$years)$Months),
      session = session
    )
  })
  ### assume choice
  x2 <-
    arrange(x, percent) %>% mutate(., project = factor(project, levels = project))
  output$distPlot <- renderPlot({
    ggplot(x2, aes(project, percent)) +
      geom_col(fill = rgb(.1, .1, .9, .8),
               col = rgb(0, 0, 0.5, .75)) +
      coord_flip() +
      ggtitle(paste0("%Hours by Project for ", month.name[as.numeric(input$month)], " ", input$year)) +
      ylab("") +
      xlab("") +
      theme_minimal()
  })
})
}
