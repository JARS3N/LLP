get_coefs<-function(BMID){
  require(RMySQL)
  db<-adminKraken::con_mysql()
  q_1<-'SELECT PH_A, PH_B, PH_C, O2_A, O2_B,CAST(CONCAT(substr(`Sensor 2 C1`, 1, 4),"e",substr(`Sensor 2 C1`, 5, 6)) as decimal(3,2)) AS BF from barcodematrixview where ID = '
  q_3<-";"
  query_string<-paste0(q_1,BMID,q_3)
  query_sent<-suppressWarnings(RMySQL::dbSendQuery(db,query_string))
  x<-RMySQL::dbFetch(query_sent)
  RMySQL::dbClearResult(query_sent)
  RMySQL::dbDisconnect(db)
  x
}
