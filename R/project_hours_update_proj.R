update_proj<-function(str){
    db2<-adminKraken::con_mysql()
    qry<- RMySQL::dbSendQuery(db2,str)
    RMySQL::dbClearResult(qry)
    dbDisconnect(db2)
}
