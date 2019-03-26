lotstore<-R6::R6Class(
  "store_lot",
  public = list(
    LOTs = list("C"=NULL,"B"=NULL,"W"=NULL,"Q"=NULL),
    TBLs = NULL,
    initialize = function() {
      self$TBLs <-  c("C"="xfpwetqc","B"="xfe24wetqc","W"="xfe96wetqc","Q"="xf24legacy")
    },
    get= function(x){
    if(is.null(self$LOTs[[x]])){
    tbl<-unname(self$TBLs[x])
    self$LOTs[[x]]<-LLP::list_cc_tbl_lots(tbl)
    }
      self$LOTs[[x]] 
    }
  )
)
