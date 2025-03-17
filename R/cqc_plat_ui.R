cqc_plat_ui <- function() {
  require(shiny)
  require(plotly)
  
  print("Loading UI...")  # Debugging step
  
  shinyUI(pageWithSidebar(
    headerPanel(textOutput('head')),
    mainPanel(width = "100%",
              tabsetPanel(type = "tabs",
                          tabPanel("Means", plotOutput('plot1')),
                          tabPanel("Inter Uniformity", plotOutput('plotinter')),
                          tabPanel("Intra Uniformity", plotOutput('plotintra'))
              )
    ),
    sidebarPanel(width = 8,
                 sliderInput("SLIDE", label = h3("Range"), min = 1, 
                             max = 1, value = c(1, 2), step = 1),
                 selectInput("Variable", "Select Variable",
                             c("pH.LED","Gain","pH.CalEmission","O2.LED","KSV","Ambient","F0","O2.CalEmission")),
                 selectInput("INST", "Select Instrument", c('NULL')),
                 selectInput("PLAT", "Platform",
                             c("XFe24" = "xfe24wetqc", "XFe96" = "xfe96wetqc", 
                               "XFp" = "xfpwetqc"))
    )
  ))
}
