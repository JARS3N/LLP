calc_cc_intercvs<-function(tbl,var,inst,db){
str_0<-"SELECT AVG(CV) as interCV,
stddev(CV) as interCVsd,
Lot ,
substr(Lot,5,2) as yr,
substr(Lot,2,3) as day
from
(select 100*(stddev(var)/AVG(var)) as CV,Lot,Well from
    (SELECT Lot,Well,Inst,`%VAR%` as var from %TBL% where Inst=%INST%)as X
    group by Lot,Well) as Y
group by Lot
ORDER by yr ASC,day ASC;"


query_string <- gsub("%INST%", inst, gsub("%TBL%", tbl, gsub("%VAR%" , var, str_0)))
                     
             query_sent<-RMySQL::dbSendQuery(db,query_string)
             x<-RMySQL::dbFetch(query_sent)
             RMySQL::dbClearResult(query_sent)
             x$Lot<-factor(x$Lot,levels = x$Lot)
             x
}
