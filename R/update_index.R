update_index<-function(){
file.copy(from = system.file(package = "LLP", pattern = 'index.rmd'),
          to = "/home/jarsenault/ShinyApps")
}
