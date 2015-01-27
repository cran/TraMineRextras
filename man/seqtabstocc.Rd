\name{seqtabstocc}
\alias{seqtabstocc}
%
\author{Gilbert Ritschard}
%
\title{Frequencies of state co-occurrence patterns}
%
\description{
  Computes the frequencies of co-occurring state patterns.
}
\usage{
  seqtabstocc(seqdata, ...)
}
\arguments{
  \item{seqdata}{ A state sequence (\code{stslist}) object as returned by \code{\link[TraMineR]{seqdef}}.}
  \item{...}{ Additional arguments to be passed to \code{\link[TraMineR]{seqtab}}.}
}
\details{
  The function extracts the list of states co-occurring in each sequence. For each sequence, the co-occurring states are extracted as the sequence of the alphabetically sorted distinct states. The frequencies of the extracted sets of states is then obtained by means of the  TraMineR \code{\link[TraMineR]{seqtab}} function.
}
\value{
  A \code{stslist.freq} object.
}
%\seealso{
%}
\examples{
## Creating a sequence object from the first 500 actcal data.
data(actcal)
actcal.seq <- seqdef(actcal[1:500,13:24])

## 10 most frequent state patterns in the data
seqtabstocc(actcal.seq)

## All state patterns
seqtabstocc(actcal.seq, tlim=0)

}
\keyword{util}
