

weeklystats_server <- function() {
    db <- adminKraken::con_dplyr()
    library(ggplot2)
    library(shiny)
    library(lubridate)
    library(dplyr)
    X <- new.env()
    P <- tbl(db, "projecttasks") %>%
        filter(active == 1) %>%
        select(project) %>%
        distinct() %>%
        collect() %>%
        unlist(., use.names = F)
    shinyServer(function(input, output, session) {
        PLOT <- NULL
        shiny::updateSelectInput(
            inputId = "selproject",
            choices = c("all", P),
            session = session
        )
        
        observeEvent(input$date, {
            X$x <- db %>%
                tbl("projecthours") %>%
                filter(year == lubridate::year(input$date)) %>%
                filter(week == lubridate::isoweek(input$date)) %>%
                collect()
            
        })
        
        observeEvent(list(input$selproject, input$date), {
            # print(input$date)
            # print(week(input$date))
            if (input$selproject == "all") {
     PLOT <-  X$x %>% 
    group_by(user) %>% 
    mutate(.,total=sum(hours)) %>% 
    ungroup() %>% 
    mutate(percent=100*hours/total) %>% 
    ggplot(., aes(user,percent )) +
    geom_col(aes(fill = project)) +
    theme_bw() +
    ylim(0, 100) +
    ggtitle("%Weekly Hours by Project & User") +
    ylab("%Weekly Hours")
            } else{
                PLOT <- filter(X$x, project == input$selproject) %>%
                    ggplot(., aes(user, 100 * hours / sum(hours))) +
                    geom_col(aes(fill = task)) +
                    theme_bw() +
                    ylim(0, 100) +
                    ggtitle(paste0(input$selproject , " by task & User")) +
                    ylab("%Weekly Hours")
            }
            
            output$distPlot <- renderPlot({
                PLOT
            })
            
        })
        
        observeEvent(input$tabs , {
            print(input$tabs)
            
            if (input$tabs == "Week") {
                Q <- db %>% tbl("projecthours") %>%
                    collect() %>%
                    group_by(project, year, week) %>%
                    summarise(., total = sum(hours, na.rm = T)) %>%
                    group_by(year, week) %>%
                    mutate(percent = total / sum(total, na.rm = T) * 100) %>%
                    ungroup() %>%
                    mutate(percent = if_else(is.nan(percent), 0, percent))
                
                P2 <-
                    ggplot(Q, aes(
                        x = interaction(year, week, sep = "-w"),
                        y = percent
                    )) +
                    geom_line(aes(group = project, col = project)) +
                    theme_bw() +
                    ylab("%") +
                    ylim(0, 100)
                output$weekhours <- renderPlot({
                    P2
                })
                
            }
            
            
        })
        
        
        
    })
}
