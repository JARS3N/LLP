react_wetqc_lot_data<-function(platform,variable,inputLot,db){
  q_string <- c("Select well,`", variable, "` as val,sn,Inst from ", 
                platform, " where Lot=", shQuote(inputLot), 
                " AND `",variable,"` IS NOT NULL;")
  q<-RMySQL::dbSendQuery(db,paste0(q_string,collapse=""))
  a<-RMySQL::fetch(q,n=-1)
  RMySQL::dbClearResult(q)
  a$Inst<-factor(a$Inst)
  a
}
