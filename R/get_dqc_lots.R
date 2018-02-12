get_dqc_lots<-function(){
  db<-adminKraken::con_mysql()
  q<-"SELECT DISTINCT(Lot) from dryqcxf24;"
  send_query<-RMySQL::dbSendQuery(db,q)
  fetch_query<-RMySQL::dbFetch(send_query,n=-1)
  RMySQL::dbClearResult(send_query)
  RMySQL::dbDisconnect(db)
  fetch_query
}
