related_lots_ui<-function(){
library(shiny)
shinyUI(fluidPage(
    # Application title
    titlePanel("Lot/Fluor Reference"),
    
    # Sidebar with a slider input for number of bins
    mainPanel(
        h5("Lots using the same flourophore and barcode coefficients"),
        hr(),
        shiny::selectInput(
            "ltype",
            label = "platform",
            choices = c("C", "B", "Q", "W"),
            selected = NULL
        ),
        shiny::textInput("Lot", "Lot",value =NULL),
        shiny::actionButton("search", "search"),
        hr(),
        DT::dataTableOutput("mftable")
    )
))
}
