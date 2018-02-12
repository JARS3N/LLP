pull_dqc_data<-function(Lot,var){
  db <-adminKraken::con_mysql()
  q_1 <-"SELECT sn,"
  q_2 <-' as var FROM dryqcxf24 where Lot = "'
  q_3 <-'";'
  query_string<-paste0(q_1,var,q_2,Lot,q_3)
  send_query<-RMySQL::dbSendQuery(db,query_string)
  fetch_query<-RMySQL::dbFetch(send_query,n=Inf)
  RMySQL::dbClearResult(send_query)
  RMySQL::dbDisconnect(db)
  fetch_query
  fetch_query$sn<-factor(as.numeric(fetch_query$sn))
  fetch_query
}
