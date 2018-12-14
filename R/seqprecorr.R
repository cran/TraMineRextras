## =====================================
## Correction term
## =====================================

seqprecorr <- function(seqdata, state.order=alphabet(seqdata), state.equiv = NULL,
      penalized="BOTH", method="TRATEDSS", weight.type="ADD", stprec=NULL,
      with.missing=FALSE, tr.type) {

  TraMineR.check.depr.args(alist(method = tr.type))

	if (!inherits(seqdata,"stslist"))
		stop(" [!] seqdata is NOT a sequence object, see seqdef function to create one")

  if(is.null(stprec) && method=="RANK"){
    stprec <- suppressMessages(seqprecstart(seqdata, state.order=state.order, state.equiv=state.equiv))
  }

  if (is.logical(penalized)){
    if(penalized) penalized<-'BOTH' else penalized<-'NO'
  }
  if (penalized=="NO")
    return(0L)
  else
    seqprecorr.tr(seqdata, state.order=state.order, state.equiv = state.equiv,
      method=method, weight.type=weight.type, penalized=penalized,
      stprec=stprec, with.missing=with.missing)

}


seqprecorr.tr <- function(seqdata, state.order=alphabet(seqdata), state.equiv = NULL,
      method="TRATEDSS", weight.type="ADD", penalized="BOTH", stprec=NULL, with.missing=FALSE) {

  ## weight.type == "ADD"  : additive, i.e. 1-tr
  ##             == "INV"  : inverse, i.e. 1/tr
  ##             == "LOGINV"  : log inverse, i.e. log(1/tr)

  ## method == "FREQ"     : overall frequency of the transition
  ## method == "TRATEDSS" : transition prob in DSS sequences
  ## method == "TRATE"    : transition probabilities
  ## method == "RANK"    : diff of start costs
  ## method == "ONE"

  ## penalized == "NEG" (default) negative transitions are penalized
  ##           == "POS" positive transition are negatively penalized
  ##           == "BOTH"
  ##           == "NO"  return a zero correction

	if (!inherits(seqdata,"stslist"))
		stop("seqdata is NOT a sequence object, see seqdef function to create one")


  method.names <- c("FREQ","TRATE","TRATEDSS","RANK","ONE")
  if (!(method %in% method.names))
		stop(" [!] method should be one of ", paste(method.names, collapse=", "))

  if (method %in% c("FREQ","TRATE","TRATEDSS")){
    weight.names <- c('ADD','INV','LOGINV')
    if (!(weight.type %in% weight.names))
  		stop(" [!] weight.type should be one of ", paste(weight.names, collapse=", "))
  }

  pen.names <- c('NEG','POS','BOTH','NO')
  if (!(penalized %in% pen.names))
		stop(" [!] penalized should be one of ", paste(method.names, collapse=", "))

  ## Checking that listed states are in alphabet
  state.order <- states.check(seqdata, state.order, state.equiv)
	
	###################################
	## setting signs according to the rank order of the states

	alph=length(alphabet(seqdata))
  tr <- matrix(1, nrow=alph, ncol=alph)
  diag(tr) <- 0
  signs <- matrix(0, nrow=alph, ncol=alph)
	state.order.plus <- state.order
  state.noncomp <- NULL
	
  if (length(unique(state.order)) < alph){
    inoncomp <- which(is.na(match(alphabet(seqdata),unique(state.order))))
    state.noncomp <- alphabet(seqdata)[inoncomp]
    message(" [>] Non ranked states: ", paste(state.noncomp, collapse=', '))
    state.order.plus <- c(state.order, state.noncomp)
  } else {
    state.order.plus <- state.order
  }

  ## To count an an indirect transition through incomparable states as
  ## a transition from the first to the last state
  ## we replace incomparable states with the previous state
  ## No need to replace initial incomparable state
  ## since transitions from incomparable state will be ignored

  seqdata.ori <- seqdata ## just in case we would need the original later

  ##print(seqdata)	
  ##ii <- as.matrix(which(seqdata=="I", arr.ind =TRUE))
  identnoncomp <- function(seqdata, noncomp){
    sm <- as.matrix(seqdata)
    ii <- which(sm %in% noncomp)
    im <- matrix(0,nrow=length(ii),ncol=2)
    im[,2] <- (ii-1) %/% nrow(sm) + 1
    im[,1] <- (ii-1) %% nrow(sm) + 1
    return(im)
  }

  ii <- identnoncomp(seqdata, state.noncomp)
  if(!is.matrix(ii)) ii <- as.matrix(t(ii)) ## when ii has only one row
  iii <- ii[ii[,2]>1,]
  if(!is.matrix(iii)) iii <- as.matrix(t(iii)) ## when iii has only one row
  continue <- TRUE
  nstep <- ncol(seqdata)
  step <- 1

  while(nrow(iii)>0 && step < nstep) {
    iin <- iii
    iin[,2] <- iin[,2] - 1
    #iin

    seqdata[iii] <- seqdata[iin]

    ##ii <- which(seqdata=="I", arr.ind =TRUE)
	  ii <- identnoncomp(seqdata, state.noncomp)
    if(!is.matrix(ii)) ii <- as.matrix(t(ii))
    iii <- ii[ii[,2]>1,]
    if(!is.matrix(iii)) iii <- as.matrix(t(iii))
    step <- step + 1
  }
	
  ## Number of transitions
  ##print(seqdata)
  dss <- seqdss(seqdata, with.missing=with.missing)
  dssl <- seqlength(dss)
  nbseq <- nrow(dss)


	##  default tr set above as 1s
  if (method %in% c('FREQ','TRATE','TRATEDSS')) {
	
    ## Computing transition probabilities

	  if (method == "FREQ") { ## default tr set above as 1s (no transition weight)
	    tr <- suppressMessages(seqtrate(dss, count=TRUE))  ## Here we compute the counts of the transitions
      tr <- tr / sum(tr) ## and now the proportion of each observed transition
	  }
	  else if (method == "TRATEDSS") {
	    tr <- suppressMessages(seqtrate(dss))
	  }
	  else if (method == "TRATE") {
	    tr <- suppressMessages(seqtrate(seqdata))
	  }

	  ## Computing transition weights from transition probabilities

    eps <- .000001

		if (weight.type == "ADD") {
		  tr <- 1 - tr
		}
		else if (weight.type == "INV"){
		  tr <- (1 + eps)/(tr + eps)
		}
		else if (weight.type == "LOGINV"){
		  tr <- log((1 + eps)/(tr + eps))
		}
  	tr <- tr/tr[1,1] ## normalize by diagonal value
  }
  else if (method == "RANK"){
      for (j in 1:length(stprec))
        tr[,j] <- abs(stprec - stprec[j])
      rownames(tr) <- colnames(tr) <- alphabet(seqdata)
  }

	## reorder rows and colunms according to state.order
	
	ord <- match(state.order.plus,alphabet(seqdata.ori))
	ordo <- match(alphabet(seqdata.ori),state.order.plus)

  #tr <- tr[ord,ord]
	signs <- signs[ord,ord]	

	if (penalized=="NEG"){
	  signs[upper.tri(signs, diag = FALSE)] <- 1
	} else if (penalized=="POS"){
	  signs[lower.tri(signs, diag = FALSE)] <- -1
	} else if (penalized=='BOTH'){
	  signs[upper.tri(signs, diag = FALSE)] <- 1
	  signs[lower.tri(signs, diag = FALSE)] <- -1
	}

	## resetting original order
	#tr <- tr[ordo,ordo]
	signs <- signs[ordo,ordo]	


  ## ignore transitions within equivalence classes
	if(!is.null(state.equiv)){
	  lc <- length(state.equiv)
	  for (i in 1:lc) {
	    iequiv <- match(state.equiv[[i]],alphabet(seqdata))
	    signs[iequiv,iequiv] <- 0
	    tr[iequiv,iequiv] <- 0
	  }
	}

	## ignore transitions to and from incomparable states
	if (!is.null(state.noncomp)){
	  signs[,inoncomp] <- 0
	  signs[inoncomp,] <- 0
	  tr[,inoncomp] <- 0
	  tr[inoncomp,] <- 0
	}

  diag(tr) <- 0

  	
	transw <- matrix(0, nrow=nbseq, ncol=1)
	rownames(transw) <- rownames(seqdata)
	transpen <- transw
	prop.transpen <- transw
	
  if (penalized != 'NO') {
	  dss.num <- TraMineR:::seqasnum(dss)+1
	  ## sum of transition weights in the sequence
  	for (i in 1:nbseq) {
  		if (dssl[i]>1) {
  			for (j in 2:dssl[i]) {
  			  transw[i] <- transw[i] + tr[dss.num[i,j-1], dss.num[i,j]]
  			  transpen[i] <- transpen[i] + tr[dss.num[i,j-1], dss.num[i,j]] * signs[dss.num[i,j-1], dss.num[i,j]]
  			  if(transw[i]>0){
  			    prop.transpen[i] <- transpen[i]/transw[i]
  			  }
  			  ## else leave prop.transpen[i] <- 0
  			}
  		}
  	  ## else leave prop.transpen[i] <- 0
  	}
  }
	
	dimnames(signs) <- dimnames(tr)
	colnames(prop.transpen) <- "Penalty"
	attr(prop.transpen,"tr") <- tr
	attr(prop.transpen,"signs") <- signs
	##attr(prop.transpen,"ord") <- ord
	##attr(prop.transpen,"ordo") <- ordo
	attr(prop.transpen,"state.noncomp") <- state.noncomp
	attr(prop.transpen,"state.order") <- state.order.plus
	##attr(prop.transpen,"seqdata") <- seqdata
	
	return(prop.transpen)
}
