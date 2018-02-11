get_n_cc_lots<-function(tbl,inst){
require(RMySQL)
db<-adminKraken::con_mysql()
str<-'SELECT COUNT(DISTINCT(Lot)) as n from %tbl% where Inst=%inst%;'
query_string<-gsub("%tbl%",tbl,gsub("%inst%",inst,str))
query_sent<-RMySQL::dbSendQuery(db,query_string)
x<-RMySQL::dbFetch(query_sent)
RMySQL::dbClearResult(query_sent)
RMySQL::dbDisconnect(db)
x$n
}
