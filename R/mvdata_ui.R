mvdata_ui<-function(){
require(shiny)
shinyUI(fluidPage(
  headerPanel("Machine Vision Lot QC Data"),
  mainPanel(plotOutput('plot1')),
  sidebarPanel(
    selectInput(
      "Lot",
      "Select Lot",
      c('Lots'),
      selected = FALSE,
      multiple = FALSE
    ),
    selectInput(
      "Variable",
      "Select Variable",
      c(
        "mean_diameter",
        "inner_diameter",
        "outer_diameter",
        "total_area" ,
        "circularity" ,
        "mean_intensity",
        "min_intensity",
        "max_intensity",
        "intensity_stdev",
        "optical_center_x",
        "optical_center_y",
        "optical_radius",
        "spot_center_x" ,
        "spot_center_y",
        "Port_1_diameter",
        "Port_2_diameter",
        "Port_3_diameter",
        "Port_4_diameter"
      ) ,
      multiple = FALSE
    )
    
  )
))
}
