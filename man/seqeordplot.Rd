\name{seqeordplot}
\alias{seqeordplot}
\title{Plot the order of event sequences.}
\description{
  Illustrates the order of event sequences in a modified time-series
  plot. The x axis presents the position in the sequence the y axis the
  event.
}

\usage{

seqeordplot(seqe,group=NULL,weighted=TRUE,weights=NULL,
            alphabet=NULL,
            type="distinctive",embedding="most-frequent",
            show=c(0,1),hide.col="grey75",
            cpal=NULL,alpha=1,
            lcourse="upwards",lorder="background",
            lweights=TRUE,lwd.min=0.5,lwd.max=4,lty=1,
            cex=1,border=grid.col,border.lwd=grid.lwd/2,
            grid.col="white",grid.fill="grey90",
            grid.scale=1/4,grid.shape="default",grid.lwd=0,
            orderalign=ifelse(split=="last","last","first"),
            split=NULL,layout=NULL,return.data=FALSE,
            main="",sub=NULL,mtext=TRUE,
            xlab="order position",ylab="",
            xlim=NULL,ylim=NULL,...)
}

\arguments{
  \item{seqe}{an event sequence object as defined by the
    \code{\link{seqecreate}} function.}
  \item{group}{A grouping vector.}
  \item{weighted}{Logial. Use of weights in the seqe object.}
  \item{weights}{A weight vector. Overwrites the weights in the seqe
  object.}
  \item{alphabet}{A vector with event names. Defines the arrangement in
    the y axis.}
  \item{type}{The trajectories type to draw. Either "distinctive" or
    "non-embeddable".}
  \item{embedding}{Option for type="non-embeddable", the method how to
    assign trajectories having multiple corresponding non-embeddable
    trajectories. Either "most-frequent" (default) or "uniformly".}
  \item{show}{Vector of two values between 0 and 1. Indicate the minimal
  and maximal relative frequency for a trajectory to be presented in the
  foreground of the plot.}
  \item{hide.col}{color of trimmed trajectories. If set to "white"
  trajectories are not shown at all.}
  \item{cpal}{A colour palette to be assigned to the sequences.}
  \item{alpha}{Degree of line and symbol transparency. Choose a number
  between 0 and 1.}
  \item{lcourse}{Handling for line connection of simultaneous
  observations. Either "upwards" or "downwards".}
  \item{lorder}{Either "background" (default) or "foreground". The first
  plots infrequent trajectories, the latter the frequent trajectories in
  the front.}
  \item{lweights}{logical. Should the line width be proportional to the
  represented trajectory? If `FALSE`, line width is set as "lwd.min".}
  \item{lwd.min}{The minimal line width to be drawn in the plot.}
  \item{lwd.max}{The maximal line width to be drawn in the plot.}
  \item{lty}{Line type of lines connecting succeeding observations.}
  \item{cex}{Expansion factor for the plotted squared symbols.}
  \item{border}{Color of symbol borders.}
  \item{border.lwd}{Line widths of symbol borders.}
  \item{grid.col}{Color of border of underlaid rectangles.}
  \item{grid.fill}{Color of underlaid rectangles.}
  \item{grid.scale}{Expansion degree of underlaid rectangles.}
  \item{grid.shape}{Either "default" or "proportional".}
  \item{grid.lwd}{Line width or border of underlaid rectangles.}
  \item{orderalign}{Alignment mode for data where the order positions
    are individual integer orders. align="first" aligns the trajectories
    left hand, align="last" right hand. Assigning an y category produces
    an alinement of the first occurrences of this category.}
  \item{split}{Logical value for plot panel arrangement modes. If `TRUE`
  and `x.orderalign="first"`, the plot produces one plot panel per
  observed initial event and inscribes the trajectories which are
  initialised by that event. The case `TRUE` and `align="last"` proceeds
  analogously but considering final events.}
  \item{layout}{Integer vector of length 2. Determines the number of
  rows and columns of the plot panels arrangement.}
  \item{return.data}{Returns a summary of the plotted trajectories.}
  \item{main}{A main title for the plot, see also "title".}
  \item{sub}{Subtitles. Used in case of multiple plot panels.}
  \item{mtext}{Logical. Print panel information or not.}
  \item{xlab}{A label for the x axis, defaults to a description of "x".}
  \item{ylab}{A label for the y axis, defaults to a description of "y".}
  \item{xlim}{The x limits (x1, x2) of the plot.}
  \item{ylim}{The y limits (y1, y2) of the plot.}
  \item{...}{Arguments to be passed to methods, such as graphical
    parameters (see "par").}
}

\examples{


## ====================
## plot the biofam data
## ====================

## loading the data and defining an event sequence dataset
## =======================================================

data(biofam)
lab <- c("Parent","Left","Married",
         "Left+Marr","Child","Left+Child",
         "Left+Marr+Child","Divorced")
biofam.seq <- seqdef(data=biofam[,10:25], alphabet=0:7, labels=lab)
## For this example, we consider only a sample of 200 cases
##set.seed(23653)
##sple <- sample(1:nrow(biofam.seq), size=200)
sple <- 500:700  ## need a sample with all elements of the alphabet
##seqstatl(biofam[sple,10:25])
biofam <- biofam[sple,]
biofam.seq <- biofam.seq[sple,]
bf.seqestate <- seqecreate(biofam.seq, tevent = "state")
head(bf.seqestate)

## plot the data
## =============

## distinctive event sequences

\dontrun{
par(mar=c(4,8,2,2))
seqeordplot(seqe=bf.seqestate,alphabet=lab)

par(mar=c(4,8,2,2))
seqeordplot(seqe=bf.seqestate,alphabet=lab,
                       lwd.max=6,cex=0.9,show=c(0.05,1))

## non-embeddable sequences

par(mar=c(4,8,2,2))
seqeordplot(seqe=bf.seqestate,alphabet=lab,
                       lwd.max=6,cex=0.9,show=c(0.05,1),
                       type="non-embeddable")

## some additional options

par(mar=c(4,8,2,2)) # how the sequences end
seqeordplot(seqe=bf.seqestate,alphabet=lab,
                       type="non-embeddable",lwd.max=2,
                       orderalign="last",split="last")

par(mar=c(4,8,2,2)) # sequences involving Left+Marr+Child
seqeordplot(seqe=bf.seqestate,alphabet=lab,
                       type="non-embeddable",
                       orderalign="Left+Marr+Child")

par(mar=c(4,8,2,2)) # gender differences
seqeordplot(seqe=bf.seqestate,group=biofam$sex,show=c(0.05,1),
                       alphabet=lab)
}
}

\keyword{Plot}
