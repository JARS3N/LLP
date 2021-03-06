pull_or_create <- function(date, db) {
require(dplyr)
    ck_date <- check_date(date, db)
    print(ck_date)
    if (ck_date == FALSE) {
        message("starting new date block")
        tmp <-  new_data_set(date, db)
        db2 <- adminKraken::con_mysql()
        RMySQL::dbWriteTable(
            db2,
            "projecthours",
            tmp,
            overwrite = FALSE,
            append = TRUE,
            row.names = FALSE
        )
        dbDisconnect(db2)
    }
    tbl(db,"projecthours") %>% 
        filter(year==lubridate::year(date),week==lubridate::isoweek(date)) %>% 
        collect() %>% tidyr::spread(., user, hours) %>%
        select(-week,-month,-year)
}
