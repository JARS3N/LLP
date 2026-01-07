  count_surfx_lots<-function(u){
    db<-adminKraken::con_mysql()
    str<- 'SELECT COUNT(CTG_LOT) as results from (SELECT Distinct CTG_LOT,LEFT(CTG_LOT,1) as type from surfxmeta) AS X where type="%type%";'
    send_query<-RMySQL::dbSendQuery(db,gsub("%type%",u,str))
    fetch_query<-RMySQL::dbFetch(send_query)
    RMySQL::dbClearResult(send_query)
    RMySQL::dbDisconnect(db)
    fetch_query$results
  }
