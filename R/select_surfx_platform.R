select_surfx_platform<-function(u){
db<-adminKraken::con_mysql()
q_str<-'SELECT CTG_LOT,RIGHT(CTG_LOT,2) as yr,SUBSTR(CTG_LOT,2,3) as day from
(SELECT DISTINCT CTG_LOT from (SELECT CTG_LOT, LEFT(CTG_LOT,1) as ctype 
FROM surfxmeta) as T1 where ctype="%type%")as T2
order by yr DESC, day DESC;'
send_query<-RMySQL::dbSendQuery(db,gsub("%type%",u,q_str))
fetch_query<-RMySQL::dbFetch(send_query)
RMySQL::dbClearResult(send_query)
RMySQL::dbDisconnect(db)
fetch_query$CTG_LOT
}
