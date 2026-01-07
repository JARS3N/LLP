n_lightleak_inst<-function(plat_input){
db<-adminKraken::con_mysql()
query_string<-"SELECT COUNT(DISTINCT(Serialnumber)) as res from instqcllmeta where LEFT(Serialnumber,2) = '%plat%';"
query_sent<-RMySQL::dbSendQuery(db,gsub("%plat%",plat_input,query_string))
out<-RMySQL::dbFetch(query_sent)
RMySQL::dbClearResult(query_sent)
RMySQL::dbDisconnect(db)
out$res
}
