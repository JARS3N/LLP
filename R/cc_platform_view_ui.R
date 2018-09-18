cc_platform_view_ui<-function(){
require(shiny)
require(plotly)
shinyUI(pageWithSidebar(
    headerPanel(textOutput('head')),
    mainPanel(width="100%",
              tabsetPanel(type = "tabs",
                          tabPanel("Means", plotOutput('plot1')),
                          tabPanel("Inter Uniformity(Well-Well mean uniformity across Lot)", plotOutput('plotinter')),
                          tabPanel("Intra Uniformity(Cartridge-Cartridge Mean uniformity across Lot)", plotOutput('plotintra'))
              )
    ),
    sidebarPanel(width=8,
                 sliderInput("SLIDE", label = h3("Range"), min = 1,
                             max = 1, value = c(1, 2),step=1),
                 fluidRow(
                     column(width=4,
                            selectInput("Variable", "Select Variable",
                                        c("pH.LED","Gain","pH.CalEmission","O2.LED","KSV","Ambient","F0","O2.CalEmission"), multiple = FALSE)
                     ),
                     column(width=4,
                            selectInput("INST", "Select Instrument",c('NULL'),selected=FALSE, multiple = FALSE)
                     ),
                     column(width=4,
                            selectInput("PLAT","Platform",c("XFe24"="xfe24wetqc","XFe96"="xfe96wetqc","XFp"="xfpwetqc","XF24"="xf24legacy")
                            )#end fluid row
                     )
                 )


    )
))
}
