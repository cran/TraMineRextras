## ====================================================
## Function for survplot of state sequence objects
## Based on seqplot
## ====================================================

seqsplot <- function(seqdata, group = NULL, main = NULL, cpal = NULL,
  missing.color = NULL, ylab = NULL, yaxis = TRUE, axes = "all", xtlab = NULL,
  cex.axis = 1, with.legend = "auto", ltext = NULL, cex.legend = 1,
  use.layout = (!is.null(group) | with.legend != FALSE), legend.prop = NA,
  rows = NA, cols = NA, which.states = NULL, title, cex.plot, withlegend, ...) {

  TraMineR.check.depr.args(alist(main = title, cex.axis = cex.plot, with.legend = withlegend))
  type = "s" ## here this is the only type,

	if (!inherits(seqdata,"stslist"))
		stop(call.=FALSE, "seqplot: data is not a state sequence object, use seqdef function to create one")

	## Storing original optional arguments list
	oolist <- list(...)

  	leg.ncol <- if ("ncol" %in% names(oolist)) { oolist[["ncol"]] } else { NULL }
    oolist <- oolist[names(oolist) != "ncol"]



  ## Specific preparation for surv plot

     ## survfit accepts a subset argument to produce the survival curves for a subset
     ## this will be used for each group value when a separate plot is desired for each
     ## of the group levels. (straighforward with the original seqplot)

     ## to get superposed curves, we give the strata variable (typically the alphabet
     ## or a subset of it) as a right hand variable in the survfit formula (see seqsurv.R)

     ## If (per.state == TRUE) we want a separate plot for each state label and
     ## for each state superposed curves by groups in the same plot.
     ## We set in that case the alphabet as group variable and need a special handling to
     ## draw the curves by group in a same plot.

  per.state <- FALSE
  if (type == "s") {

       if ("per.state" %in% names(oolist))
          per.state <- oolist[["per.state"]]

       obs.states <- seqstatl(seqdata)
       sel.states <- which(alphabet(seqdata) %in% obs.states)
       if ("state" %in% names(oolist))
          message("'state' argument will be ignored")
          ##   which.states <- oolist[["state"]]

        if (is.null(which.states)) {
          which.states <- alphabet(seqdata)[sel.states]
        }
        sel.obs.states <- sel.states
        good.states <- which(which.states %in% obs.states)
        if (length(good.states) > 0){
          sel.states <- which(alphabet(seqdata) %in% which.states[good.states])
          sel.states <- sel.states[sel.states %in% sel.obs.states]
        }
        else
          sel.states <- vector() # empty vector of length 0
        if (length(sel.states) > 0 & length(which.states) - length(good.states) > 0){
          badstates <- paste(which.states[-good.states],sep=" ", collapse=" ")
          message("[!!] Unvalid or unobserved state(s): ", badstates)
        }

       if (length(sel.states) < 1)
          stop(call.=FALSE, "Only unvalid or unobserved selected states!")
       oolist[["state"]] <- which.states[good.states]
       if (!per.state){
            if (is.null(cpal))
              cpal <- cpal(seqdata)[sel.states]
            if (is.null(ltext))
              ltext <- attr(seqdata,"labels")[sel.states]
       }
  }

	## ========================================
	## Defing a single group when group is null
	## ========================================

  if (is.null(group)) group <- factor(rep("Unique group",nrow(seqdata)))


   if (per.state) {

     group.ori <- group
     ## we specify the levels to keep them in same order as in orginal alphabet
     group <- factor(alphabet(seqdata)[sel.states], levels = alphabet(seqdata)[sel.states])

     if (is.null(group.ori)) group.ori <- factor("All cases")
     else group.ori <- factor(group.ori)

     ##if(!is.null(group.ori)){
     levels.num <- nlevels(group.ori)
     if (is.null(cpal)){
       ## We use Dark2 from brewer.pal, which has 8 colors
       ## Moreover, min n for brewer.pal is 3
       cpal.grp <-
            if (levels.num < 2) {
              brewer.pal(3, "Dark2")[3]
            } else if (levels.num == 2) {
              brewer.pal(3, "Dark2")[-3]
            } else if (levels.num < 9) {
              brewer.pal(levels.num, "Dark2")
            } else {
              message(" [!] too many groups (> 8), no automatic color palette assignation")
              NULL
            }
       cpal <- cpal.grp
     }
     else {
      cpal.grp <- cpal
     }
     if (is.null(ltext)){
        if (levels.num >0) ltext.grp <- levels(group.ori)
        else ltext.grp <- "All cases"
     }
     else {
      ltext.grp <- ltext
     }
     ##}
   }
   else { # per.state == FALSE

     group <- TraMineR:::group(group)
     levels.num <- nlevels(group)

   }



      ## Check length when !per.state
      if (length(group)!=nrow(seqdata) & !per.state)
        stop(call.=FALSE, "group must contain one value for each row in the sequence object")

      nplot <- nlevels(group)
      gindex <- vector("list",nplot)

      for (s in 1:nplot){
        if (per.state)
          gindex[[s]] <- 1:nrow(seqdata)
        else
          gindex[[s]] <- which(group==levels(group)[s])
      }

      ## Title of each plot
      if (per.state){
            group.lab <- attr(seqdata,'labels')[sel.states]
      }
      else
          group.lab <- levels(group)
      if (!is.null(main))
        main <- paste(main,"-",group.lab)
      else
        main <- group.lab
	## } else { # single group
  ##        nplot <- 1
  ##        gindex <- vector("list",1)
  ##        gindex[[1]] <- 1:nrow(seqdata)
	##}

	## ===================
	## Defining the layout
	## ===================
	## if (type =="s" & per.state) { with.legend=FALSE }

	## IF xaxis argument is provided
	## it interferes with axes argument
	if ("xaxis" %in% names(oolist)) {
		tmpxaxis <- oolist[["xaxis"]]
		if (tmpxaxis==TRUE) {axes="all"}
		else if (tmpxaxis==FALSE) {axes=FALSE}
		oolist <- oolist[!names(oolist) %in% "xaxis"]
	}

	if (use.layout | !is.null(group) ) {
		## Saving graphical parameters
		savepar <- par(no.readonly = TRUE)

		lout <- TraMineR:::TraMineR.setlayout(nplot, rows, cols, with.legend, axes, legend.prop)
	  	layout(lout$laymat, heights=lout$heights, widths=lout$widths)

		## Should axis be plotted or not ?
		xaxis <- 1:nplot==lout$axisp

		legpos <- lout$legpos
	}
	else {
		if (axes!=FALSE) {xaxis <- TRUE}
		else {xaxis <- FALSE}
		legpos <- NULL
	}

	## ========
	## Plotting
	## ========
	for (np in 1:nplot) {
		## Storing ... arguments in a list
		olist <- oolist

		plist <- list(main=main[np], cpal=cpal, missing.color=missing.color,
			ylab=ylab, yaxis=yaxis, xaxis=xaxis[np],
			xtlab=xtlab, cex.axis=cex.axis)

		## Selecting sub sample for x
		## according to 'group'
		subdata <- seqdata[gindex[[np]],]

    ## Survival plot
    if (type=="s") {
      f <- seqsurv
      if (per.state) {
        olist[["state"]] <- as.character(group[np])
        olist[["groups"]] <- group.ori
        ## Here, we check whether all groups have the considered state
        lcpal <- vector()
        for (g in 1:levels.num){
          lcpal[g] <- (as.character(group[np]) %in% as.character(seqstatl(subdata[group.ori==levels(group.ori)[g],])))
        }
        plist[["cpal"]] <- cpal[lcpal]
      }
      else { # per.state=FALSE
        plist[["cpal"]] <- cpal[alphabet(subdata)[sel.states] %in% seqstatl(subdata)]
      }
    }
		else
			stop("Unknown 'type' argument.")

		## Calling appropriate function and plotting
		flist <- names(formals(f))

		if ("with.missing" %in% names(olist)) {
			with.missing <- olist[["with.missing"]]
		} else if ("with.missing" %in% flist) {
			with.missing <- formals(f)$with.missing
		}

		## Xlim when plotting individual sequences
		if (type %in% c("i", "I", "f")) {
			if (!"xlim" %in% names(olist)) {
				olist <- c(olist, list(xlim=c(0, ncol(seqdata))))
			}
		}

		match.args <- names(olist) %in% flist
		fargs <- olist[match.args]
		fargs <- c(list(seqdata=subdata), fargs)
    #msg(paste("do.call(",f, fargs,")"))
		res <- do.call(f, args=fargs)
    if (type=="s" & per.state) attr(res,"cpal") <- cpal.grp

		olist <- olist[!match.args]
    ## suppress non plot arguments if necessary
    olist <- olist[!names(olist) %in% c("with.missing")]
    if (!(type %in% c("i","I"))) olist <- olist[!(names(olist) %in% c("sortv","weighted"))]
    if (type != "r") olist <- olist[!(names(olist) %in% c("dmax","stats"))]

		plist <- c(list(x=res), plist, olist)
		do.call(plot, args=plist)
	}

	## Plotting the legend
	if (!is.null(legpos)) {
		## Extracting some sequence characteristics
		nr <- attr(seqdata,"nr")

		if (is.null(ltext)) ltext <- attr(seqdata,"labels")

		if (is.null(missing.color)) missing.color <- attr(seqdata,"missing.color")

		if (is.null(cpal)) cpal <- attr(seqdata,"cpal")

		density <- if ("density" %in% names(oolist)) { oolist[["density"]] } else { NULL }
		angle <- if ("angle" %in% names(oolist)) { oolist[["angle"]] } else { NULL }

		## Adding an entry for missing in the legend
		if (with.missing & any(seqdata==nr)) {
			cpal <- c(cpal,missing.color)
			ltext <- c(ltext,"missing")
		## statl <- c(statl,nr)
		## nbstat <- nbstat+1
		}

    if (type == "s" & per.state){ # we need group legend instead of state legend
      cpal <- cpal.grp
      ltext <- ltext.grp
    }

    ## if (is.null(leg.ncol))  ## for backward compatibility
    if (packageVersion("TraMineR") < '2.0.9')  ## for backward compatibility
		  TraMineR:::TraMineR.legend(legpos, ltext, cpal, cex=cex.legend, density=density, angle=angle)
    else
		  TraMineR:::TraMineR.legend(legpos, ltext, cpal, cex=cex.legend, density=density, angle=angle, leg.ncol=leg.ncol)
	}

	## Restoring graphical parameters
	if (use.layout | !is.null(group)) {par(savepar)}
}
