seqgranularity <- function(seqdata, tspan=3, method="last"){

    n <- nrow(seqdata)
    lgth <- max(seqlength(seqdata))

    new.lgth <- ceiling(lgth/tspan)
    new.lgth.f <- floor(lgth/tspan)

    newseq <- seqdata[,1:new.lgth]
    cnames <- names(seqdata)
    newcnames <- cnames[seq(from=1, to=lgth, by=tspan)]
    
    prev <- 0
    if (method=="first") prev <- tspan - 1
    for (i in 1:new.lgth.f){
        newseq[,i] <- seqdata[,tspan*i - prev]
    }
    if (new.lgth > new.lgth.f){
        if (method=="first"){
            newseq[,new.lgth] <- seqdata[,tspan*new.lgth.f + 1]
        } else {
            newseq[,new.lgth] <- seqdata[,lgth]
        }
        newcnames[new.lgth] <- cnames[lgth]
    }
    colnames(newseq) <- newcnames
    attr(newseq,"xtstep") <- ceiling(attr(seqdata,"xtstep")/tspan)
	return(newseq)
}
