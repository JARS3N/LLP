coef_lots<-function(){
  require(RMySQL)
  db<-adminKraken::con_mysql()
  q1<-RMySQL::dbSendQuery(db,"Select CONCAT(Type, `Lot Number`) AS LotNumber,`Barcode Matrix ID` AS BMID from lotview;")
  x<-suppressWarnings(RMySQL::dbFetch(q1))
  RMySQL::dbClearResult(q1)
  RMySQL::dbDisconnect(db)
  return(x)
}
