retreive_note_lots<-function(u){
db<-adminKraken::con_mysql()
qry<-gsub("%TB%",u,'SELECT DISTINCT(Lot) from %TB%;')
send_query<-RMySQL::dbSendQuery(db,qry)
fetch_query<-RMySQL::dbFetch(send_query)
RMySQL::dbClearResult(send_query)
RMySQL::dbDisconnect(db)
fetch_query$yr<-as.numeric(substr(fetch_query$Lot,5,6))
fetch_query$day<-substr(fetch_query$Lot,2,4)
fetch_query<-fetch_query[order(fetch_query$yr,fetch_query$day,decreasing = c(TRUE,TRUE),method='radix'),]
factor(fetch_query$Lot,levels=fetch_query$Lot)
}
