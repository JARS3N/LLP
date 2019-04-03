cellculture_ui<-function(){
library(shiny)
shinyUI(fluidPage(
    titlePanel("Cell Culture Input"),
    sidebarLayout(
        sidebarPanel(
            dateInput("date", label = h3("Date input"), value = Sys.Date()),
            shiny::textInput("operator","operator",c("...")),
            shiny::textInput("cell_line","Cell Line",value = "C2C12"),
            shiny::numericInput('count','count (M)',value = 0),
            shiny::numericInput('passage','passage',value=0),
            shiny::numericInput('viability','%viability',value=100),
            shiny::textAreaInput('notes','notes',value=NA),
            actionButton('add','add'),
            actionButton('upload','upload'),
            actionButton('clear','clear')
        ),
        mainPanel(
            h4("Upload Data queue"),
            DT::dataTableOutput("current_tbl")
        )
    )
))
}
