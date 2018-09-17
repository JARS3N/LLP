calc_cc_intracvs<-function(tbl,var,inst,db){
str_0<-"SELECT AVG(CV)as intraCV,stddev(CV) as intraCVsd,substr(Lot,4,2) as yr,substr(Lot,2,3) as day,Lot from
(SELECT (100*(stddev(var)/AVG(var))) as CV,Lot from
(SELECT Lot,sn,Inst,Gain as var from xfpwetqc where Inst=430029) as x
group by Lot,sn) as Y
group by Lot
ORDER by yr DESC,day DESC;"


query_string <- gsub("%INST%", inst, gsub("%TBL%", tbl, gsub("%VAR%" , var, str_0)))
                     
             query_sent<-RMySQL::dbSendQuery(db,query_string)
             x<-RMySQL::dbFetch(query_sent)
             RMySQL::dbClearResult(query_sent)
             x$Lot<-factor(x$Lot,levels = x$Lot)
             x
}
