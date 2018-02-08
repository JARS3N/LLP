change_use_ui<-function(){
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Adjust Use Number"),
  sidebarLayout(
    sidebarPanel(
      numericInput('n','newUseNumber',value=0,min=-9999,max=999,step=1),
      fileInput("file1", "upload CartridgeBarcodes.XML",
                accept = c(
                  "CartridgeBarcodes.XML",
                  ".XML")

      ),
      downloadButton('downloadData', 'Download')
    ),

    # Show a plot of the generated distribution
    mainPanel(
      p('Upload file "CartridgeBarcodes.XML"'),
      p('File should be located @ C:\\ProgramData\\Seahorse Bioscience, Inc\\Seahorse Wave\\Data\\Cartridges'),
      p('Replace original file with new file & rename as "CartridgeBarcodes.XML"')
    )
  )
)
}
