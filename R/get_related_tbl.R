get_related_tbl <- function(LOT, TYPE,db) {
  if (LOT == "") {
    return(NULL)
  }
  if (is.null(LOT)) {
    return(NULL)
  }
 checkforlot <-
    tbl(db, "lotview") %>% 
    select(`Lot Number`,Type) %>% 
    distinct() %>% 
    filter(`Lot Number` == LOT & Type == TYPE) %>% 
    count() %>% 
    collect()
  
  if (checkforlot$n < 1) {
    return(NULL)
  }
  out <- tbl(db, "lotview") %>%
    filter(Type == TYPE, `Lot Number` == LOT) %>%
    select(Lot = `Lot Number`, Type, ID = `Barcode Matrix ID`) %>%
    collect()
  print(out)
  if (is.null(out)) {
    return(NULL)
  }
  out2 <- tbl(db, "barcodematrixview") %>%
    filter(ID == out$ID[1]) %>%
    select(MF = `Multifluor`,
           pH = `pH Fluor`,
           O2 = `Ox Fluor`) %>%
    collect()
  print(out2)
  out3 <-
    tbl(db, "lotview") %>%
    filter(`Barcode Matrix ID` == out$ID & Type == TYPE) %>%
    select(Lot = `Lot Number`) %>%
    distinct() %>%
    collect() %>%
    mutate(Lot = paste0(TYPE, Lot))
  
  return(merge(out3, out2))
  
}
