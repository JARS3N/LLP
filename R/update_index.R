update_index<-function(){
  from<-list.files(system.file(package="LLP"),pattern='index.html',full.names=T)
  to<-"/home/jarsenault/ShinyApps/index.html"
file.copy(from = from, to = to)
}
