change_use_ui <- function() {
  require(shiny)
  shinyUI(fluidPage(
    titlePanel("Adjust Use Number"),
    sidebarLayout(
      sidebarPanel(
        numericInput(
          'n',
          'newUseNumber',
          value = 0,
          min = -9999,
          max = 999,
          step = 1
        ),
        fileInput(
          "file1",
          "upload CartridgeBarcodes.XML",
          accept = c("CartridgeBarcodes.XML",
                     ".XML")
        ),
        downloadButton('downloadData', 'Download')
      ),
      mainPanel(
        p('Upload file "CartridgeBarcodes.XML"'),
        p(
          'File should be located @ C:\\ProgramData\\Seahorse Bioscience, Inc\\Seahorse Wave\\Data\\Cartridges'
        ),
        p(
          'Replace original file with new file & rename as "CartridgeBarcodes.XML"'
        )
      )
    )
  )
}
