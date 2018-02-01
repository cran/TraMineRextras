\name{seqsplot}
\alias{seqsplot}

\title{Plot survival curves of the states in sequences}

\description{
High level plot function for state sequence objects that produces survival curves of states in sequences. Usage is similar to the generic \code{seqplot} function of TraMineR, with a special handling of the \code{group} argument when \code{per.state=TRUE} is included in the \code{...} list.
}

\usage{
seqsplot(seqdata, group = NULL, main = NULL, cpal = NULL,
  missing.color = NULL, ylab = NULL, yaxis = TRUE, axes = "all",
  xtlab = NULL, cex.axis = 1, with.legend = "auto", ltext = NULL,
  cex.legend = 1, use.layout = (!is.null(group) | with.legend != FALSE),
  legend.prop = NA, rows = NA, cols = NA, which.states, title, cex.plot, withlegend, ...)
}

\arguments{
    \item{seqdata}{State sequence object created with the \code{\link{seqdef}} function.}

    \item{group}{Grouping variable of length equal to the number of sequences. When \code{per.state = FALSE} (default), a distinct plot is generated for each level of \code{group}. When \code{per.state = TRUE}, the curves for each group level are drawn in a same plot for each distinct value of \code{alphabet(seqdata)}.}

    \item{main}{Character string. Title for the graphic. Default is \code{NULL}.}

    \item{cpal}{Vector. Color palette used for the states or the groups when \code{per.state=TRUE} is given along the \code{...} list. Default is \code{NULL}, in which case the \code{cpal} attribute of the \code{seqdata} sequence object is used (see \code{\link{seqdef}}) or the default colors assigned to groups when \code{type="s"} and \code{per.state=TRUE}. If user specified, a vector of colors of length and order corresponding to \code{alphabet(seqdata)} or, if for groups, the number of levels of the group variable.}

    \item{missing.color}{Color for representing missing values inside the sequences. By default, this color is taken from the \code{missing.color} attribute of \code{seqdata}.}

    \item{ylab}{Character string. an optional label for the y-axis. If set as \code{NA}, no label is drawn.}

    \item{yaxis}{Logical. Should the y-axis be plotted?}

    \item{axes}{Character string or logical. If set as \code{"all"} (default value) x-axes are drawn for each plot in the graphic. If set as \code{"bottom"} and \code{group} is used, axes are drawn only under the plots located at the bottom of the graphic area. If \code{FALSE}, no x-axis is drawn.}

    \item{xtlab}{Vector of length equal to the number of columns of \code{seqdata}. Optional labels for the x-axis tick labels. If unspecified, the column names of the \code{seqdata} sequence object are used (see \code{\link{seqdef}}).}

  \item{cex.axis}{Real. Axis annotation magnification. See \code{\link{par}}.}

  \item{with.legend}{Character string or logical. Defines if and where the legend of the state colors is plotted. The default value \code{"auto"} sets the position of the legend automatically. Other possible value is \code{"right"}. Obsolete value \code{TRUE} is equivalent to \code{"auto"}.}

  \item{ltext}{Vector of character strings of length and order corresponding to  \code{alphabet(seqdata)} or, when for groups, to the levels of the group variable. Optional description for the color legend. If unspecified, the \code{label} attribute of the \code{seqdata} sequence object is used (see \code{\link{seqdef}}) or, when for groups, the levels of the group variable.}

  \item{cex.legend}{Real. Legend magnification. See \code{\link{legend}}.}

  \item{use.layout}{Logical. Should \code{\link[graphics]{layout}} be used to arrange plots when using the group option or plotting a legend? When layout is activated, the standard '\code{\link[graphics]{par}(mfrow=....)}' for arranging plots does not work. With \code{with.legend=FALSE} and \code{group=NULL}, layout is automatically deactivated and '\code{par(mfrow=....)}' can be used.}

  \item{legend.prop}{Real in range [0,1]. Proportion of the graphic area devoted to the legend plot when \code{use.layout=TRUE} and \code{with.legend=TRUE}. Default value is set according to the place (bottom or right of the graphic area) where the legend is plotted.}

  \item{rows,cols}{Integers. Number of rows and columns of the plot panel when \code{use.layout=TRUE}.}
  \item{which.states}{Vector of short state names. List of the states for which survival curves should be plotted.}
  \item{title}{Deprecated. Use \code{main} instead.}
  \item{cex.plot}{Deprecated. Use \code{cex.axis} instead.}
  \item{withlegend}{Deprecated. Use \code{with.legend} instead.}
  
  \item{\dots}{arguments to be passed to the function called to produce the appropriate statistics and the associated plot method (see details), or other graphical parameters. For example \code{per.spell} argument will typically be used for survival plots.  
      %the \code{weighted} argument can be passed to control whether (un)weighted statistics are produced or \code{with.missing} argument to take missing values into account when computing transversal or longitudinal state distributions.
      }
}



\details{
This is a specific version of \code{seqplot} for type="s". It implements a dedicated handling of the group variable passed as \code{group} argument when \code{per.sate=TRUE} is included in the \code{...} list.

Invalid or non observed states are removed the list given as \code{which.states} argument. When \code{which.states = NULL}, \code{which.states} will be defined as the list of states present in the data.

When \code{per.sate=TRUE}, a distinct plot is generated for each state in the \code{which.states} list and, when a grouping variable is provided, the survival curves of all groups are plotted in each plot.

When \code{per.state=FALSE}, a distinct plot is generated for each group and the survival curves of all states listed as \code{which.states} are plotted in each plot.

}

\seealso{
 \code{\link{plot.stslist.surv}}, \code{\link{seqsurv}}, \code{\link[TraMineR]{seqplot}}, }

\references{
Gabadinho, A., G. Ritschard, N. S. Müller and M. Studer (2011). Analyzing and Visualizing State Sequences in R with TraMineR. \emph{Journal of Statistical Software} \bold{40}(4), 1-37.
}
\examples{
## ======================================================
## Creating state sequence objects from example data sets
## ======================================================

data(biofam)
biofam.lab <- c("Parent", "Left", "Married", "Left+Marr",
                "Child", "Left+Child", "Left+Marr+Child", "Divorced")
biofam.short <- c("P","L","M","LM","C","LC","LMC","D")

sple <- 1:200  ## only the first 200 sequences
seqstatl(biofam[sple,10:25]) ## state 4 not present
biofam <- biofam[sple,]

biofam.seq <- seqdef(biofam[,10:25], alphabet=0:7, states=biofam.short, labels=biofam.lab)

## defining two birth cohorts
biofam$wwii <- factor(biofam$birthyr > 1945, 
  labels=c("Born Before End of Word War II","Born After Word War II"))

## ==============================
## Plots of state survival curves 
## ==============================

seqsplot(biofam.seq) ## all states, no group
seqsplot(biofam.seq, group=biofam$wwii, lwd=2) ## all states for each group
seqsplot(biofam.seq, group=biofam$wwii, per.state=TRUE, lwd=2) ## groups for each state

## For a selection of states only

seqsplot(biofam.seq, group=biofam$wwii, which.states= c('LM'), lwd=2)
## changing default color
seqsplot(biofam.seq, group=biofam$wwii, which.states= c('LM'), 
  cpal="orange", lwd=2)
seqsplot(biofam.seq, group=biofam$wwii, which.states= c('LM','LMC'), 
  cpal=c("orange","brown"), lwd=2) 
seqsplot(biofam.seq, group=biofam$wwii, which.states= c('LM','LMC'), per.state=TRUE)
}

\author{Gilbert Ritschard (based on TraMineR seqplot function)}

\keyword{Plot}
