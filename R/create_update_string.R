create_update_string <- function(year, month, week, val, nms, user) {
  paste0(
    'Update weeklybreakdown set ',
    nms,
    ' = ',
    val,
    ' where user =',
    shQuote(user) ,
    ' AND year = ',
    year,
    ' AND month =',
    month,
    ' AND ',
    'week = ',
    week,
    ';'
  )
}
