
weeklystats_ui<-function(){
library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel("Weekly Project Breakdown"),
    tabsetPanel(id='tabs',
        tabPanel(id="PU",
            "Project & User",
            shiny::selectInput("selproject", "Project", c("...")),
            shiny::dateInput('date', 'Week', value = Sys.Date()),
            plotOutput("distPlot")
        ),
        tabPanel("Week",
                 id="hrwk",
                 plotOutput("weekhours")
                 )
    )
))
}
