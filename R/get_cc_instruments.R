get_cc_instruments<-function(u){
require(RMySQL)
db<-adminKraken::con_mysql()
query_string<-gsub("%tbl%",u,'SELECT DISTINCT(INST) from %tbl%;')
query_sent<-RMySQL::dbSendQuery(db,query_string)
x<-RMySQL::dbFetch(query_sent)
RMySQL::dbClearResult(query_sent)
RMySQL::dbDisconnect(db)
}
