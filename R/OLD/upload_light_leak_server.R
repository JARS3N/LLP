

upload_light_leak_server<-function(){
  require(shiny)
  require(lightleak)
 # require(xprt)
  shinyServer(function(input, output,session) {
    ########################
    # End processes if window is closed
    ########################
    session$onSessionEnded(function() {
      stopApp()
    })
    ########################
    observeEvent(input$send,{
      #if(exists(FLZ)){rm(FLZ)}
      FLZ<-input$send
      OUTZ<<-Map(function(x,y){
        x$meta$file<-y
        x
      },
      x=lapply(FLZ$datapath,munge),
      y=FLZ$name
      )

      })
    ### End observer input#send

  observeEvent(input$upload_button,{
    if(exists(OUTZ)){
     msgs<-upload(OUTZ)
    }
  })



  })

}
