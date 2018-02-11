mv_platformview_ui<-function(){
require(shiny)
shinyUI(fluidPage(
  titlePanel("Machine Vision"),
  # Show a plot of the generated distribution
  mainPanel(
    width = "100%",
    fluidRow(column(
      width = 4,
      selectInput('platform', 'platform', c("XFp", "XFe24", "XFe96"))
    ),
    column(width = 4,
           selectInput(
             'vars',
             'vars',
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
               "num_spots"  ,
               "num_blobs"
             )
           ))),
    fluidRow(width = "100%",
             plotOutput('plot', height = '600px')),
    fluidRow(width = "100%",
             p("Currently excluding data from before 2016")),
    fluidRow(
      width = "100%",
      p(
        "Still really need to optimise database interaction as there are over a million rows in the table on 3/30/2017"
      )
    )
  )
))

}
