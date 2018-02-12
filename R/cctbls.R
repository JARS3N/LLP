cctbls<-function(u){
a<-c("XFe96LotRelease"="xfe96wetqc","XFe24LotRelease"="xfe24wetqc",
     "XFpLotRelease"="xfpwetqc","XF24LotRelease"="xf24legacy")[u]
unname(a)
}

