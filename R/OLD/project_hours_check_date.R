check_date<-function(date,db){
require(dplyr)
    yr<-lubridate::year(date)
    mnth<-lubridate::month(date)
    wk<-lubridate::isoweek(date)
    tbl(db,"projecthours") %>% 
        filter(year==yr,week==wk) %>% 
        count() %>% 
        collect() %>% 
        .$n != 0
}
