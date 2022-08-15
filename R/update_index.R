update_index<-function(){
  rmarkdown::render(list.files(system.file(package="LLP"),pattern='index.rmd',full.names=T))
  from<-list.files(system.file(package="LLP"),pattern='index.html',full.names=T)
  to<-"/home/jarsenault/ShinyApps/index.html"
  old <-"/home/jarsenault/ShinyApps/index.html.old"
  file.rename(to,old)
  file.copy(from = from, to = to)
  unlink(old)
}
