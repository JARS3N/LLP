write_hours_index<-function(){
c("---", "title: \"Project Hours\"", "output: html_document", 
"---", "", "```{r setup, include=FALSE}", "knitr::opts_chunk$set(echo = TRUE)", 
"```", "", "+ [Monthly Breakdown](/jarsenault/month_breakdown)   ", 
"%Monthly hours per Project", "+ [Project Hours Logging](/jarsenault/weekly_ae)  ", 
"project hour logging  ", "+ [Project Hours stats](/jarsenault/project_hour_stats)  ", 
"%other stats  ", "...")
}

render_hours_index<-function(){
writeLines(write_hours_index(),"index.rmd")
rmarkdown::render("index.rmd")
}
