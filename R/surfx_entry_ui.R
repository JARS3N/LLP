surfx_entry_ui<-function(){
require(shiny)
shinyUI(fluidPage(
  titlePanel("SURFX Entry"),
  sidebarLayout(
    sidebarPanel(width=3,
                 shiny::textInput("INSP_BY","Inspector"),
                 shiny::textInput("RAW_LOT","Raw Lot"),
                 shiny::textInput("CTG_LOT","Cartridge Lot"),
                 shiny::textInput("BTCH_NO","Batch number"),
                 h3("SURFX Date"),
                 shiny::dateInput("SURFXDate",""),
                 fluidRow(column(width=4,offset=-1,shiny::numericInput("sfxH","hour",value=5,min=1,max=12,step=1)),
                          column(width=4,offset=0,shiny::numericInput("sfxM","min",value=0,min=0,max=60,step=1)),
                          column(width=4,shiny::selectInput("y","",c("AM","PM")))
                 ),#endRow
                 h3("Measure Date"),
                 fluidRow(shiny::dateInput("mesDate",""),
                          column(width=4,offset=-1,shiny::numericInput("mesH","hour",value=5,min=1,max=12,step=1)),
                          column(width=4,offset=0,shiny::numericInput("mesM","min",value=00,min=00,max=60,step=1)),
                          column(width=4,shiny::selectInput("y2","",c("AM","PM")))
                 ),
                 actionButton("Submit","Submit")
    ),
    
    mainPanel(
      uiOutput("data_input")
    )
  )
))
}
