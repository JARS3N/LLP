cum_gsub<-function(patterns,replacemets,string){
Map(function(x,y){string<<-gsub(x,y,string)},
x=patterns,
y=replacemets
)   
return(string)    
}
