select_surfx_platform<-function(u){
db<-adminKraken::con_mysql()
t1<-'(SELECT DISTINCT CTG_LOT from (SELECT CTG_LOT, LEFT(CTG_LOT,1) as ctype FROM surfxmeta) as T1 where ctype="%type%")'
t2<-gsub("%t1%",t1,'SELECT CTG_LOT,RIGHT(CTG_LOT,2) as yr,SUBSTR(CTG_LOT,2,3) as day from %t1% as T2 order by yr DESC, day DESC;')
send_query<-RMySQL::dbSendQuery(db,gsub("%type%",u,t2))
fetch_query<-RMySQL::dbFetch(send_query)
RMySQL::dbClearResult(send_query)
RMySQL::dbDisconnect(db)
fetch_query$CTG_LOT
}

        
