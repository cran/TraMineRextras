\encoding{latin1}
\name{seqrep.grp}
\alias{seqrep.grp}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Finding representative sets by group and their quality statistics.
}
\description{
This function determines representative sequences by group and returns the representatives by group and/or the quality statistics of the representative sets. The function is a wrapper for the TraMineR \code{\link{seqrep}} function.
}
\usage{
seqrep.grp(seqdata, group = NULL, diss = NULL, ret="stat", mdis=diss,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{seqdata}{
        state sequence object as defined by \code{\link{seqdef}}.
        }
  \item{group}{
        group variable. If \code{NULL} a single group is assumed.
        }
  \item{diss}{
        dissimilarity matrix. If \code{NULL} the "LCS" dissimilarity matrix is computed.
        }
  \item{ret}{
        What should be returned? One of \code{"stat"} (default), \code{"rep"} or \code{"both"}.   }
  \item{mdis}{
        Deprecated, use \code{"diss"} instead.}
  \item{...}{
        additional arguments passed to \code{\link{seqrep}} .
        }
}

\details{
The function is a wrapper for running \code{\link{seqrep}} on the different groups defined by the \code{group} variable.
}
\value{
If \code{ret="stat"}, a list with the quality statistics for the set of representatives of each group.

If \code{ret="rep"}, a list with the set of representatives of each group.

If \code{ret="both"}, a list with the two previous outcomes.
}

\note{This function is a pre-release and further testing is still needed, please report any problems.}
\author{
Gilbert Ritschard
}

\seealso{
\code{\link{seqrep}}
}
\examples{
data(biofam)
biofam <- biofam[1:100,]
biofam.lab <- c("Parent", "Left", "Married", "Left+Marr",
"Child", "Left+Child", "Left+Marr+Child", "Divorced")
biofam.short <- c("P","L","M","LM","C","LC","LMC","D")
biofam.seq <- seqdef(biofam[,10:25], alphabet=0:7, states=biofam.short, labels=biofam.lab)
dist <- seqdist(biofam.seq, method="HAM")

seqrep.grp(biofam.seq, group=biofam$plingu02, diss=dist, coverage=.2, pradius=.1)
seqrep.grp(biofam.seq, group=biofam$plingu02, diss=dist, ret="rep", coverage=.2, tsim=.1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{state sequences}

