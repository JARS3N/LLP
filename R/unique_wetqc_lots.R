unique_wetqc_lots<-function(table,db){
    q_string<-"select Lot,substr(Lot,2,3) as day,substr(Lot,5,2) as yr from (Select Distinct(Lot) as Lot from ###) as X order by yr DESC,day DESC;"
    q<-RMySQL::dbSendQuery(db,gsub("###",table,q_string))
    a<-RMySQL::fetch(q)
    RMySQL::dbClearResult(q)
    a$Lot<-factor(a$Lot,levels = a$Lot)
    a$day<-as.numeric(a$day)
    a$yr<-as.numeric(a$yr)
    a
}
