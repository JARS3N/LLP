render_index <- function() {
  from <-
    list.files(system.file(package = "LLP"),
               pattern = 'index.rmd',
               full.names = T)
  to <- "/home/jarsenault/ShinyApps/index.html"
  rmarkdown::render(input = from,
                    output_format = "html_document",
                    output_file =  "/home/jarsenault/ShinyApps/index.html")
}
