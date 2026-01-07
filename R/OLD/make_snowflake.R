make_snowflake<-function(df,user="...",comment="..."){
  z <- xmlTree("ConfigOverrides")
  out<-Map(function(x,y){
    try(
      {z$addTag(x,y)}
    )
  },
  x=df$names,
  y=df$values
  )
  z$addComment("~Snowflake~")
  z$addComment("Config file update on:")
  z$addComment(as.character(Sys.time()))
  z$addComment(paste0("user: ",user))
  z$addComment("Comments:")
  z$addComment(comment)
  z$doc()
}
