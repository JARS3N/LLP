get_cclot_instruments<-function(u,h){
    require(RMySQL)
    db<-adminKraken::con_mysql()
    query_string<-gsub("%tbl%",h,gsub("%lot%",u,'SELECT DISTINCT(Inst) from %tbl% WHERE Lot="%lot%";'))
    query_sent<-RMySQL::dbSendQuery(db,query_string)
    x<-RMySQL::fetch(query_sent)
    RMySQL::dbClearResult(query_sent)
    RMySQL::dbDisconnect(db)
   x$Inst
}
