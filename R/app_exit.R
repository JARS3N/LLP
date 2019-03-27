app_exit <- function(session, db) {
  session$onSessionEnded(function() {
    stopApp()
    message("killing R process on exit")
    if(is.null(db)){return()}else{RMySQL::dbDisconnect(db)}
  })
}
