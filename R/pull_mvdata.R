 pull_mvdata<-function(platform,var){
    db<-adminKraken::con_mysql()
    q<-'SELECT Lot,%var% as var,RIGHT(Lot,2) as yr,SUBSTR(Lot,2,4) as day,substr(LOT,2,1)="E" as exp from mvdata where plat="%plat%" order by yr ASC, day ASC;'
    q_str<-gsub("%plat%",platform,gsub("%var%",var,q))
    send_query<-RMySQL::dbSendQuery(db,q_str)
    fetch_query<-RMySQL::dbFetch(send_query,n=-1)
    RMySQL::dbClearResult(send_query)
    RMySQL::dbDisconnect(db)
    fetch_query$use<-c("Production","Experimental")[as.numeric(factor(fetch_query$exp,levels=c(F,T)))]
    fetch_query
  }  
