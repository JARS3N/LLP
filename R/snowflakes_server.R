


snowflakes_server <- function() {
  require(shiny)
  require(XML)
  
  sf <- "http://magnix/jira/secure/attachment/42236/SnowFlake.txt"
  xml <- XML::xmlInternalTreeParse(sf)
  r_list <- unlist(XML::xmlToList(xml))
  comment <- ""
  df <-
    data.frame(
      names = names(r_list),
      values = unlist(r_list),
      row.names = NULL,
      stringsAsFactors = F
    )
  shinyServer(function(input, output) {
    output$data_input <- renderUI({
      fluidRow(Map(function(x, y) {
        column(textInput(
          inputId = x,
          label = x,
          value = y,
          width = "50%"
        ),
        width = 5)
      },
      x = df$names,
      y = df$values))##fluidROw
      
    })#renderUI
    ############
    output$export <- downloadHandler(filename <-
                                       function() {
                                         "snowflake.txt"
                                       },
                                     content <- function(file) {
                                       temp <- tempfile()
                                       saveXML(LLP::make_snowflake(df, input$comment, input$user),
                                               temp,
                                               indent = T)
                                       file.copy(temp, file)
                                       # write.csv(mtcars,file)
                                     })
    #})
    
    ###########
  })
}
