seqprecstart <- function(seqdata, state.order=alphabet(seqdata), state.equiv=NULL) {
  ## cost of starting state

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


  step <- 1/(length(state.order)-1)

  state.noncomp <- NULL
  if (length(unique(state.order)) < length(alphabet)){
    inoncomp <- which(is.na(match(alphabet(seqdata),unique(state.order))))
    state.noncomp <- alphabet(seqdata)[inoncomp]
    ##message(" [>] Non ranked states: ", state.noncomp)

    state.order.plus <- c(state.order, state.noncomp)
  }
  else {
    state.order.plus <- state.order
  }


  ord <- match(state.order.plus,alphabet)
  ordo <- match(alphabet,state.order.plus)

  stcost <- seq(from=0, to=1, by=step)

  ## assign mean cost to non ranked states
  stcost <- c(stcost, rep(mean(stcost),length(state.noncomp)))
  stcost <- stcost[ordo]

  ## assign the class mean cost to all states of a same equivalent class
  if(!is.null(state.equiv)){
    lc <- length(state.equiv)
    for (i in 1:lc) {
      iequiv <- match(state.equiv[[i]],alphabet)
      stcost[iequiv] <- mean(stcost[iequiv])
    }
  }

  return(stcost)
}
