## =====================================
## Number of transitions in the sequence
## =====================================

seqprecorr <- function(seqdata, state.order=alphabet(seqdata), state.equiv = NULL,
      tr.type="TRATEDSS", weight.type="ADD", penalized="BOTH", with.missing=FALSE) {

  ## weight.type == "ADD"  : additive, i.e. 1-tr
  ##             == "INV"  : inverse, i.e. 1/tr
  ##             == "LOGINV"  : log inverse, i.e. log(1/tr)
  ##             == "NO"   : no weight, i.e., unique weight of 1

  ## tr.type == "FREQ"     : overall frequency of the transition
  ## tr.type == "TRATEDSS" : transition prob in DSS sequences
  ## tr.type == "TRATE"    : transition probabilities

  ## penalized == "NEG" (default) negative transitions are penalized
  ##           == "POS" positive transition are negatively penalized
  ##           == "BOTH"

	if (!inherits(seqdata,"stslist"))
		stop("data is NOT a sequence object, see seqdef function to create one")

  if (!(weight.type %in% c('ADD','INV','LOGINV','NO',FALSE)))
    stop("bad weight.type argument")

  if (!(tr.type %in% c('FREQ','TRATE','TRATEDSS')))
    stop("bad tr.type argument")

  if (!(penalized %in% c('NEG','POS','BOTH',TRUE)))
    stop("bad penalized argument")
  if (is.logical(penalized)){
    if(penalized) penalized<-'BOTH' ##else penalized<-'NO'
  }

  ## Checking that listed states are in alphabet

  alphabet <- alphabet(seqdata)
  inexistant_al <- which(is.na(match(state.order, alphabet)))
  ## Check that the listed inexistant state is not NA
  if(length(inexistant_al)>0 && !is.numeric(seqdata)) {
    if(length(inexistant_al)>1 || !is.na(state.order[inexistant_al])) {
      stop(" [!] Bad state.order, states not in the alphabet: ", paste(state.order[inexistant_al], sep=" "))
    }
  }

  if (!is.null(state.equiv)){
    if(!is.list(state.equiv)){
      stop(" [!] Bad state.equiv. A list is expected!")
    }
    equiv_al <- unlist(state.equiv)
    inexistant_al <- which(is.na(match(equiv_al, alphabet)))
    ## Check that the listed inexistant state is not NA
    if(length(inexistant_al)>0 && !is.numeric(seqdata)) {
      if(length(inexistant_al)>1 || !is.na(equiv_al[inexistant_al])) {
        stop(" [!] Bad state.equiv, states not in the alphabet: ", paste(equiv_al[inexistant_al], sep=" "))
      }
    }
  }


  pweight <- (weight.type %in% c('ADD','INV','LOGINV'))

	
	###################################
	## setting signs according to the rank order of the states
	## reorder rows and colunms according to state.order

	alph=length(alphabet)
	signs <- matrix(0, nrow=alph, ncol=alph)
	state.order.plus <- state.order
  state.noncomp <- NULL
	
	if (penalized %in% c('NEG','POS','BOTH'))	{
	
	  ## list of non-comparable states
	  if (length(unique(state.order)) < length(alphabet)){
	    inoncomp <- which(is.na(match(alphabet,unique(state.order))))
	    state.noncomp <- alphabet[inoncomp]
	
	    if(!is.null(state.equiv)){
	      ii.noncomp.equiv <- match(state.noncomp,equiv_al)
	      if(!is.na(ii.noncomp.equiv[1])){
	        state.noncomp.equiv <- equiv_al[ii.noncomp.equiv]
	
	        for (i in 1:length(state.noncomp.equiv)){
	          for (k in 1:length(state.equiv)){
	            if (state.noncomp.equiv[i] %in% state.equiv[[k]] ){
	              ## insert the equiv state next to first state of the class in state.order
	                  ii <- match(state.equiv[[k]],state.order)
	                  state.order.new <- c(state.order[1:ii[1]],state.noncomp.equiv[i])
	                  if (length(state.order)>ii[1]) {
	                    state.order.new <- c(state.order.new, state.order[(ii[1]+1):length(state.order)])
	                  }
	                  state.order <- state.order.new
	                  break
	            }
	
	          }
	        }
	        state.noncomp <- state.noncomp[-match(state.noncomp.equiv,state.noncomp)]
	        if (length(state.noncomp)==0) {
	          state.noncomp <- NULL
	        }
	        else {
	          inoncomp <- which(is.na(match(alphabet,unique(state.order))))
	        }
	      }
	    }
	    if (!is.null(state.noncomp)) {
  	    message(" [>] Non ranked states: ", state.noncomp)
  	    state.order.plus <- c(state.order, state.noncomp)
	    } else {
	      state.order.plus <- state.order
	    }
	
	  }
	

	  ## Now we replace the uncomprable state with the previous state
	
	  seqdata.ori <- seqdata ## just in case we would need the original later
	
	  ii <- as.matrix(which(seqdata=="I", arr.ind =TRUE))
	  iii <- ii[ii[,2]>1,]
	  if(!is.matrix(iii)) iii <- as.matrix(t(iii))
	  continue <- TRUE
	  nstep <- ncol(seqdata)
	  step <- 1
	
	  while(nrow(iii)>0 && step < nstep) {
	    iin <- iii
	    iin[,2] <- iin[,2] - 1
	    iin
	
	    seqdata[iii] <- seqdata[iin]
	
	    ii <- which(seqdata=="I", arr.ind =TRUE)
	    if(!is.matrix(ii)) ii <- as.matrix(t(ii))
	    iii <- ii[ii[,2]>1,]
	    if(!is.matrix(iii)) iii <- as.matrix(t(iii))
	    step <- step + 1
	  }
	
#######	

	  ## Number of transitions
	  dss <- seqdss(seqdata, with.missing=with.missing)
	  dssl <- seqlength(dss)
	  nbseq <- nrow(dss)
	
	  ####################################
	  if (tr.type == "FREQ") {
	    ##tr <- seqtfreq(dss)  ## Here we compute the proportion of each observed transition
	    tr <- seqtrate(dss, count=TRUE)  ## Here we compute the counts of the transitions
      tr <- tr / sum(tr) ## and now the proportion of each observed transition
	  }
	  else if (tr.type == "TRATEDSS") {
	    tr <- seqtrate(dss)
	  }
	  else if (tr.type == "TRATE") {
	    tr <- seqtrate(seqdata)
	  }
	
  	ord <- match(state.order.plus,alphabet(seqdata))
  	ordo <- match(alphabet(seqdata),state.order.plus)

  	tr <- tr[ord,ord]

  	if (penalized=="NEG"){
  	  signs[upper.tri(signs, diag = FALSE)] <- 1
  	} else if (penalized=="POS"){
  	  signs[lower.tri(signs, diag = FALSE)] <- -1
  	} else if (penalized=='BOTH'){
  	  signs[upper.tri(signs, diag = FALSE)] <- 1
  	  signs[lower.tri(signs, diag = FALSE)] <- -1
  	}

  	## resetting original order
  	tr <- tr[ordo,ordo]
  	signs <- signs[ordo,ordo]
  	
    ## equivalence classes
  	if(!is.null(state.equiv)){
  	  lc <- length(state.equiv)
  	  for (i in 1:lc) {
  	    iequiv <- match(state.equiv[[i]],alphabet)
  	    signs[iequiv,iequiv] <- 0
  	  }
  	}
  	
  	## non-comparable states
  	if (!is.null(state.noncomp)){
  	  signs[,inoncomp] <- 0
  	  signs[inoncomp,] <- 0
  	}
	}	
	else { ## should not occur
	  signs <- signs + 1
	}
	
	eps <- .000001
	if (pweight) { ## lacks a definition of tr for pweight=="NO" or FALSE?
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
  else {
    tr[] <- 1L ## if pweight==FALSE
  }	
	dss.num <- TraMineR:::seqasnum(dss)+1
	transw <- matrix(0, nrow=nbseq, ncol=1)
	rownames(transw) <- rownames(seqdata)
	transnegw <- transw
	prop.transnegw <- transw
	
	## sum of transition weights in the sequence
	for (i in 1:nbseq) {
		if (dssl[i]>1) {
			for (j in 2:dssl[i]) {
			  transw[i] <- transw[i] + tr[dss.num[i,j-1], dss.num[i,j]]
			  transnegw[i] <- transnegw[i] + tr[dss.num[i,j-1], dss.num[i,j]] * signs[dss.num[i,j-1], dss.num[i,j]]
			  if(transw[i]>0){
			    prop.transnegw[i] <- transnegw[i]/transw[i]
			  }
			  ## else prop.transnegw[i] <- 1
			}
		}
	  ## else prop.transnegw[i] <- 1 ## we leave it at 0
	}
	#}
	#else {
	#	transw <- dssl-1
	#	if (any(dssl==0)) {
	#		transw[dssl==0] <- 0
	#	}
	#	tr <- NULL
	#}

## tentative normalization. Needs more checking
#		if (norm) {
#		seql <- seqlength(seqdata)
#		transw <- transw/(seql-1)
#		if (any(seql==1)) {
#			transw[seql==1] <- 0
#		}
#	}

	
	dimnames(signs) <- dimnames(tr)
	colnames(prop.transnegw) <- "Prop neg/pos trans"
	attr(prop.transnegw,"tr") <- tr
	attr(prop.transnegw,"signs") <- signs
	##attr(prop.transnegw,"ord") <- ord
	##attr(prop.transnegw,"ordo") <- ordo
	attr(prop.transnegw,"state.noncomp") <- state.noncomp
	attr(prop.transnegw,"state.order") <- state.order.plus
	attr(prop.transnegw,"seqdata") <- seqdata
	
	
	return(prop.transnegw)
}
