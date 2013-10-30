\name{STS_to_SPELL}
\alias{STS_to_SPELL}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Data conversion from STS to SPELL format.
}
\description{
Convert data from STS to vertical SPELL format.
}
\usage{
STS_to_SPELL(seqdata, id=NULL, pdata=NULL, birthdate=NULL, with.missing=TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{seqdata}{
a state sequence object of type \code{"stslist"} (see \code{\link[TraMineR]{seqdef}}).
}
  \item{id}{Either a
vector of sequence id's or name of the id column in \code{pdata}. If \code{NULL},  \code{rownames(seqdata)} are used.
}
  \item{pdata}{
Data frame with id and birth dates.
}
  \item{birthdate}{
Either a
vector of sequence birth dates or name of the birth date column in \code{pdata}.
}
    \item{with.missing}{Logical. Should explicit spells of missing states be included?}
}
\details{
SPELL format is a vertical format with one row per spell, each spell being specified with four variables: an id, a begin date, a end date, and the state.
}
\value{
A \code{data.frame} with the sequences in vertical SPELL format.
}
\author{
Matthias Studer
}

\seealso{
See Also \code{\link[TraMineR]{seqformat}}.
}
\note{This function is a pre-release and further testing is still needed, please report any problems.}
\examples{
data(biofam)
biofam <- biofam[1:20,]

## Create the sequence object
bfstates <- c("Parent", "Left", "Married", "Left/Married", "Child",
            "Left/Child", "Left/Married/Child", "Divorced")
bf.shortlab <- c("P","L","M","LM","C","LC", "LMC", "D")
bf.seq <- seqdef(biofam[,10:25], alphabet=0:7, states=bf.shortlab, labels=bfstates)

spell <- STS_to_SPELL(bf.seq, birthdate=biofam$birthyr)
head(spell)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{data format}
