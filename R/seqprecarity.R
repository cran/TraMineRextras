seqprecarity <- function(seqdata, correction=NULL, otto=.2, a=1, b=1.2, state.order=alphabet(seqdata), state.equiv=NULL, ...){

  if (is.null(correction)){
    correction <- 1 + seqprecorr(seqdata, state.order=state.order, state.equiv=state.equiv, ...)
  }
  stcost <- seqprecstart(seqdata, state.order=state.order, state.equiv=state.equiv)

  ##  index of complexity
  ici <- seqici(seqdata)
  lalph <- sapply(seqdata[,1],'match',alphabet(seqdata))

  prec <- otto*stcost[lalph] + (1-otto) * ici^a * correction^b

  attr(prec,'stprec') <- stcost
  colnames(prec) <- "prec"

  return(prec)
}
