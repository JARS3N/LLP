new_data_set<-function(date,db){
require(dplyr)
    #db<-adminKraken::con_dplyr()
    A<-tbl(db,"projecttasks") %>% 
        filter(active==1) %>% 
        collect()
    B<-tbl(db,"projectusers") %>% 
        filter(active==1) %>% 
        collect()
    X<-mutate(dplyr::bind_rows(lapply(B$user,function(u){mutate(A,user=u)})),hours=0)
    X$year<-lubridate::year(date)
    X$month<-lubridate::month(date)
    X$week<-lubridate::isoweek(date)
    X$active<-NULL
    X
}
