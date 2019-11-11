get_related_tbl<-function (LOT, TYPE, db) 
{
  if (LOT == "") {
    return(NULL)
  }
  if (is.null(LOT)) {
    return(NULL)
  }
  checkforlot <- tbl(db, "lotview") %>% select(`Lot Number`, 
                                               Type) %>% distinct() %>% filter(`Lot Number` == LOT & 
                                                                                 Type == TYPE) %>% count() %>% collect()
  if (checkforlot$n < 1) {
    return(NULL)
  }
  out <- tbl(db, "lotview") %>% filter(Type == TYPE, `Lot Number` == 
                                         LOT) %>% select(Lot = `Lot Number`, Type, ID = `Barcode Matrix ID`) 
  
  if (is.null(out)) {
    return(NULL)
  }
  out3<-left_join(out,tbl(db, "barcodematrixview")) %>% 
    select(MF = Multifluor, pH = `pH Fluor`, O2 = `Ox Fluor`,`Barcode Matrix ID`=ID) %>% 
    left_join(.,tbl(db, "lotview")) %>% 
    mutate(Lot=paste0(Type,`Lot Number`)) %>% 
    select(Lot,MF,pH,O2) %>% 
    distinct() %>% 
    collect()
  
  
  return(out3)
}
