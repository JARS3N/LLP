daemons_server<-function(){
E<-new.env()
E$txt<-NULL
E$funs<-list("..."=function(){print("welcome!")},"dqc"=dryqc::cron,"mv"=details::cron)
server <- function(input, output, session) {
    observeEvent(input$drop, {
        {
            E$funs[[input$drop]]()

        }
    })
}
}
