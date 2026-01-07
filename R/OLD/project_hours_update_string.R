update_string<-function(val,user,proj,task,yr,mnth,wk){
    paste0('UPDATE projecthours set hours = ',
           val,
           ' where user = ',
           shQuote(user),
           ' AND project = ',
           shQuote(proj),
           ' AND task = ',
           shQuote(task),
           ' AND  year = ',
           yr,
           ' AND month = ',
           mnth, 
           ' and week =',
           wk,
           ';')
}
