list_mvlots <- function() {
  nms_con <- adminKraken::con_mysql()
  nms <- RMySQL::dbSendQuery(nms_con, 'Select Distinct(Lot) from mvdata;')
  x <- RMySQL::dbFetch(nms)
  RMySQL::dbClearResult(nms)
  RMySQL::dbDisconnect(nms_con)
  x
}
