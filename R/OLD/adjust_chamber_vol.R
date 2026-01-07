adjust_chamber_vol<-function(file,name,chamber=NULL){
if(is.null(chamber)){
  message("No parameters chosen")
  return(NULL)
}
require(XML)
X<-new.env()
X$chamber_str<-paste0("_psuedovol_",chamber)
X$file<-name
X$xml<-XML::xmlParse(file)
if(!is.null(chamber)){
  node_chamber<-xpathApply(X$xml, "//ChamberVolume//text()")
  sapply(node_chamber,function(n){xmlValue(n)<-chamber})
}
X$new_asyr_name<-gsub("[.]asyr",paste0(X$chamber_str,".asyr"),X$file)
X$name_xml <- gsub("asyr", "xml", X$file)
return(X)
}
