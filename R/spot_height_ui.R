spot_height_ui<-function() {
require(shiny)
require(shinythemes)
shinyUI(fluidPage(
  theme = shinytheme("yeti"),
  
  titlePanel("Spot Height"),
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        title = "Meta",
        width = '100%',
        column(width = 2,
               shiny::textInput(inputId = "Lot", label = "Lot")),
        column(width = 2,
               shiny::textInput(inputId = "sn", label = "sn")),
        column(
          width = 2,
          shiny::textInput(inputId = "Operator", label = "Operator")
        ),
        column(width = 2,
               shiny::dateInput(inputId = 'Date', 'Date'))
        
      ),
      
      width = '100%'
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("check"),
      textOutput("enterspec"),
      actionButton("enter", "Enter Data"),
      p(""),
      hr(),
      fluidRow(
        title = "rowO2",
        width = '100%',
        column(
          width = 2,
          shiny::numericInput(
            inputId = "OA1",
            label = "A1 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PA1",
            label = "A1 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OB1",
            label = "B1 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PB1",
            label = "B1 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OC1",
            label = "C1 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PC1",
            label = "C1 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OD1",
            label = "D1 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PD1",
            label = "D1 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          )
        ),
        column(
          width = 2,
          shiny::numericInput(
            inputId = "OA2",
            label = "A2 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PA2",
            label = "A2 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OB2",
            label = "B2 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PB2",
            label = "B2 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OC2",
            label = "C2 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PC2",
            label = "C2 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OD2",
            label = "D2 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PD2",
            label = "D2 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          )
        ),
        column(
          width = 2,
          shiny::numericInput(
            inputId = "OA3",
            label = "A3 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PA3",
            label = "A3 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OB3",
            label = "B3 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PB3",
            label = "B3 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OC3",
            label = "C3 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PC3",
            label = "C3 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OD3",
            label = "D3 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PD3",
            label = "D3 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          )
        ),
        column(
          width = 2,
          shiny::numericInput(
            inputId = "OA4",
            label = "A4 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PA4",
            label = "A4 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OB4",
            label = "B4 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PB4",
            label = "B4 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OC4",
            label = "C4 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PC4",
            label = "C4 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OD4",
            label = "D4 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PD4",
            label = "D4 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          )
        ),
        column(
          width = 2,
          shiny::numericInput(
            inputId = "OA5",
            label = "A5 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PA5",
            label = "A5 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OB5",
            label = "B5 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PB5",
            label = "B5 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OC5",
            label = "C5 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PC5",
            label = "C5 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OD5",
            label = "D5 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PD5",
            label = "D5 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          )
        ),
        column(
          width = 2,
          shiny::numericInput(
            inputId = "OA6",
            label = "A6 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PA6",
            label = "A6 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OB6",
            label = "B6 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PB6",
            label = "B6 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OC6",
            label = "C6 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PC6",
            label = "C6 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "OD6",
            label = "D6 O2",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          ),
          shiny::numericInput(
            inputId = "PD6",
            label = "D6 pH",
            value = 0.00101,
            step = 0.00001,
            min = 0,
            max = 0.01
          )
        )
        #end fluid row
      )
    )
  )
))
}
