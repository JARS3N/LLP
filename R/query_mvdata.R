query_mvdata<-function(a_lot,a_var){
data_con <- adminKraken::con_mysql()
str<-'Select xvar,sn from mvdata where Lot = "xlot";'  
gsub1<-gsub("xvar",a_var,str)
data_query_string<-gsub("xlot",a_lot,gsub1)
data_query<-RMySQL::dbSendQuery(data_con,data_query_string)
fetched_data<-RMySQL::dbFetch(data_query,n=-1)
clean<-RMySQL::dbClearResult(data_query)
drop_con<-RMySQL::dbDisconnect(data_con)
fetched_data
}
