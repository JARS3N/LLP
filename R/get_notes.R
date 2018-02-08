get_notes<-function(B){
db<-adminKraken::con_mysql()
qry_str<-gsub("%LOT%",B,'SELECT notes FROM qclotnotes where Lot="%LOT%";')
send_query<-RMySQL::dbSendQuery(db,qry_str)
fetch_query<-RMySQL::dbFetch(send_query)
RMySQL::dbClearResult(send_query)
RMySQL::dbDisconnect(db)
fetch_query$notes
}
