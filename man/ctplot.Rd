\name{ctplot}
\alias{ctplot}
\title{Plot individual trajectories of longitudinal categorical data.}
\description{
  Illustrates individual categorical trajectories in a modified
  time-series plot. The x scale represents the order position (often
  the timestamp), the y the response category (events or state).
}

\details{
  Coming soon.
}

\usage{

ctplot(x,y,id,weights=NULL,
       cov=NULL,subset=NULL,type="distinctive",
       embedding="most-frequent",x.order=FALSE,
       x.orderalign=ifelse(split=="last","last","first"),
       y.optimalphabet=FALSE,R=NULL,
       main="",sub=NULL,mtext=TRUE,
       xlab="order position",ylab="",xlim=NULL,ylim=NULL,
       grid.col="white",grid.fill="grey90",
       grid.scale=1/4,grid.shape="default",grid.lwd=0,
       cpal=NULL,alpha=1,lcourse="upwards",lorder="background",
       lweights=TRUE,lwd.min=0.5,lwd.max=2,lty=1,pch=4,
       cex=1,border=grid.col,border.lwd=grid.lwd/2,
       sf.cex=1,sf.cex.leaves=1,sf.pch=16,rotate=FALSE,
       split=NULL,layout=NULL,
       show.type=1,show=c(0,1),hide.col="grey75",
       hide.s=0.1,hide.na.cost=1,
       print=FALSE,return.data=FALSE,...)

}

\arguments{
  \item{x}{The order position vector.}
  \item{y}{The response vector (i.e events, ordinal responses etc.).}
  \item{id}{The subject identification vector. Either a factor or an
    integer vector.}
  \item{weights}{A weights vector that corresponds to the subjects
    defined by the id vector. If id is a factor, the length of weights
    must be equal to the number of levels of the id vector. The first
    value of weights is the assigned to the first id label etc.. If id
    is an integer vector, the length of weights must be equal to the number
    of distinctive numbers in id.}
  \item{cov}{A grouping vector which splits the plot into one panel per
    group. This vector must be defined analogous as the "weights"
    vector.}
  \item{subset}{An optional vector of id labels which should be
    omitted.}
  \item{type}{The type of trajectories to draw. Either "distinctive" or
    "non-embeddable".}
  \item{embedding}{Option for type="non-embeddable", the method how to
  assign trajectories having multiple corresponding non-embeddable
  trajectories. Either "most-frequent" (default) or "uniformly".}
  \item{x.order}{Logical. Transforms the x vector into individual integer
    orders}
  \item{x.orderalign}{Alignment mode for data where the order positions
    are individual integer orders. align="first" aligns the trajectories
    left hand, align="last" right hand. Assigning an y category produces
    an alinement of the first occurrences of this category.}
  \item{y.optimalphabet}{Logical. Indicates if arrangements of y
    categories should be optimized. Works only with a limited number of
    categories.}
  \item{R}{Accelerate the y order optimisation procedure. Set a number in
    case of y provides many categories.}
  \item{main}{A main title for the plot, see also "title".}
  \item{sub}{Subtitles. Used in case of multiple plot panels.}
  \item{mtext}{Logical. Print panel information or not.}
  \item{xlab}{A label for the x axis, defaults to a description of "x".}
  \item{ylab}{A label for the y axis, defaults to a description of "y".}
  \item{xlim}{The x limits (x1, x2) of the plot.}
  \item{ylim}{The y limits (y1, y2) of the plot.}
  \item{grid.col}{Color of border of underlaid rectangles.}
  \item{grid.fill}{Color of underlaid rectangles.}
  \item{grid.scale}{Expansion degree of underlaid rectangles.}
  \item{grid.shape}{Either "default" or "proportional".}
  \item{grid.lwd}{Line width or border of underlaid rectangles.}
  \item{cpal}{A colour palette to be assigned to the sequences.}
  \item{alpha}{Degree of line and symbol transparency. Choose a number
    between 0 and 1.}
  \item{lorder}{Either "background" (default) or "foreground". The first
  plots infrequent trajectories, the latter the frequent trajectories in
  the front.}
  \item{lcourse}{Handling for line connection of simultaneous
  observations. Either "upwards" or "downwards".}
\item{lweights}{logical: Should the line width be
  proportional to the represented trajectory? If \code{FALSE}, line width
  is set as \code{lwd.min}.}
  \item{lwd.min}{The minimal line width to be drawn in the plot.}
  \item{lwd.max}{The maximal line width to be drawn in the plot.}
  \item{lty}{Line type of lines connecting succeeding observations.}
  \item{pch}{"pch" the plotting symbols: see \code{"points"}. Used if
  \code{lweights=FALSE}.}
  \item{cex}{Expansion factor for the plotted squared symbols.}
  \item{border}{Color of symbol borders.}
  \item{border.lwd}{Line widths of symbol borders}
  \item{sf.cex}{Expansion factor of the center points of plotted
    sunflowers.}
  \item{sf.cex.leaves}{Expansion factor for leaves the of plotted
    sunflowers.}
  \item{sf.pch}{Plotting character to be used for points
    (\code{number[i]==1}) and center of sunflowers.}
  \item{rotate}{Logical. If \code{TRUE}, plotted sunflowers are rotated
    randomly.}
  \item{split}{Logical value for plot panel arrangement modes. If
    \code{TRUE} and \code{x.orderalign="first"}, the plot produces one plot panel per
    observed initial event and inscribes the groups which are
    initialised by the according event. The case \code{TRUE} and \code{align="last"}
    proceeds analogously but considering final events.}
  \item{layout}{Integer vector of length 2. Determines the number of
    rows and columns of the plot panels arrangement.}
  \item{show.type}{Criteria which trajectories to set in the
  foreground. Type 1 (default) shows trajectories which present relative
  frequencies between the two values assigned to the "\code{show}"
  argument. Type 2 shows segments of trajectories.}
  \item{show}{Vector of two values between 0 and 1. Indicate the minimal
    and maximal relative frequency for a trajectory to be presented in
    the foreground of the plot.}
  \item{hide.col}{color of trimmed trajectories. If set to "white"
    trajectories are not shown at all.}
  \item{hide.s}{Option for ordinal sequences. Experimental.}
  \item{hide.na.cost}{Option of for ordinal sequences. Experimental.}
  \item{print}{Prints the current step of the plot procedure.}
  \item{return.data}{Returns the plot data in a list.}
  \item{...}{Arguments to be passed to methods, such as graphical
    parameters (see \code{\link{par}}).}
}

\references{
 Bürgin, R., G. Ritschard and E. Rousseaux (2012), "Exploration graphique de données séquentielles". In Atelier Fouille Visuelle de Données : méthologie et évaluation, EGC 2012, Bordeaux. Association EGC: http://www.egc.asso.fr/sdoc-237-egc2012_atelier_fvd.pdf .
}

\examples{

## ==================
## the plot principle
## ==================

x <- c(1,2,2,2,3,4,1,2,2,2,3,4,1,1.5,2,2,3,3.5,4,4,1,2,2,2,3,4,
       1,2,3,4,3.5,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,1,2,
       1,2,3,4,1,2)

y <- factor(c("A","B","B","B","C","A","A","B","B","B","C","A","A",
              "B","B","C","C","C","C","C","A","B","B","B","C","A",
              "A","A","A","A","A","B","A","A","A","A","A","A","A",
              "A","A","A","A","A","A","A","A","A","A","A","A","A",
              "A","A","A","A","A","B","C","A","A","A"))

id <- factor(c(1,1,1,1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,3,3,4,4,4,4,4,4,
               5,5,5,5,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,
               11,11,11,11,12,12,13,13,14,14,14,14,15,15))

ctplot(x,y,id,lwd.min=5,lwd.max=12,cex=1,
                  type="non-embeddable",alpha=0.9,
                  sf.cex=0.5,sf.cex.leaves=1,grid.scale=0.4)


## ====================
## plot the biofam data
## ====================

## loading the data and defining an event sequence dataset
## =======================================================

data(biofam)
lab <- c("Parent","Left","Married",
         "Left+Marr","Child","Left+Child",
         "Left+Marr+Child","Divorced")
biofam.seq <- seqdef(data=biofam,var=10:25,labels=lab)
biofam.TSE <- seqformat(data=biofam.seq,from="STS",to="TSE",
                        tevent=seqetm(seq=biofam.seq,method="state"))
biofam.TSE$event <- factor(biofam.TSE$event,levels=lab)

## plot the data
## =============

par(mar=c(4,8,2,2))
ctplot(x=biofam.TSE$time,
                  y=biofam.TSE$event,
                  id=biofam.TSE$id,x.order=TRUE,
                  type="non-embeddable",lwd.max=10)

par(mar=c(4,8,2,2))
ctplot(x=biofam.TSE$time,y=biofam.TSE$event,
                  id=biofam.TSE$id,split="first",layout=c(2,1),
                  grid.scale=0.5,x.order=TRUE)

par(mar=c(4,8,2,2))
ctplot(x=biofam.TSE$time,y=biofam.TSE$event,
                  id=biofam.TSE$id,
                  x.order=TRUE,x.orderalign="last",split="last",
                  layout=c(4,2),lwd.max=2.5,grid.scale=0.5)


}

\keyword{plot}
