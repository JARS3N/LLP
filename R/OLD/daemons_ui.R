daemons_ui<-function(){
shinyUI(fluidPage(
    titlePanel("force start daemons"),
    sidebarLayout(sidebarPanel(shiny::selectInput(
        "drop",
        "drop",
        c("...","search for dryqc files"="dqc","search for machine vision files"="mv")
    )),
    mainPanel(
        #verbatimTextOutput("console_text")
        )
)))
}
