list_cc__tbl_lots<-function(u){
T1<-gsub("%tbl%",u,'(SELECT DISTINCT(Lot) FROM %tbl%) as T1')
query_string<-gsub("%t1%",T1,'SELECT Lot,RIGHT(Lot,2) as yr,SUBSTR(Lot,2,3) as day from %t1% order by yr DESC,day DESC;')
db<-adminKraken::con_mysql()
query_sent<-RMySQL::dbSendQuery(db,query_string)
x<-RMySQL::fetch(query_sent)
RMySQL::dbClearResult(query_sent)
RMySQL::dbDisconnect(db)
x$Lot
}
