update_index<-function(){
file.copy(from = system.file(package = "LLP", pattern = 'index.html'),
          to = "/home/jarsenault/ShinyApps/index.html")
}
