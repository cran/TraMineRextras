seqprecarity <- function(seqdata, correction=NULL,
    otto=.2, a=1, b=1.2, stprec=NULL, method = "TRATEDSS",
    state.order=alphabet(seqdata), state.equiv=NULL, ...){

	if (!inherits(seqdata,"stslist"))
		stop(call.=FALSE, "seqprecarity: data is not a state sequence object, use seqdef function to create one")
  if (!is.null(stprec) && length(stprec) != length(alphabet(seqdata)))
    stop(call.=FALSE, "seqprecarity: length(stprec) should equal length(alphabet)")

  if(is.null(stprec)){
    stprec <- seqprecstart(seqdata, state.order=state.order, state.equiv=state.equiv)
  } else {## normalize by maximum value and assign class mean value to members of equiv class
    stprec <- seqprecstart(seqdata, state.order=state.order, state.equiv=state.equiv, stprec=stprec)
  }

  if (is.null(correction)){
    correction <- 1 + seqprecorr(seqdata, method=method, state.order=state.order,
                  state.equiv=state.equiv, stprec=stprec, ...)
  }
##  index of complexity
  ici <- suppressMessages(seqici(seqdata))
  lalph <- sapply(seqdata[,1],'match',alphabet(seqdata))

  prec <- otto*stprec[lalph] + (1-otto) * ici^a * correction^b

  attr(prec,'stprec') <- stprec
  colnames(prec) <- "prec"

  return(prec)
}
