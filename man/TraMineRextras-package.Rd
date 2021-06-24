\name{TraMineRextras-package}
\alias{TraMineRextras-package}
\alias{TraMineRextras}
\docType{package}
\title{ TraMineR Extension }
\description{
(Version: 0.6.2) Collection of ancillary functions and utilities to be used in conjunction with the TraMineR package for sequence data exploration. Most of the functions are in test phase, lack systematic consistency check of the arguments and are subject to changes. Once fully checked, some of the functions of this collection could be included in a next release of TraMineR.

}

%\details{
%
%}

\author{ Gilbert Ritschard, Matthias Studer, Reto Buergin
}


%\references{
%    Gabadinho, A., G. Ritschard, N. S. Müller and M. Studer (2011).
%    Analyzing and Visualizing State Sequences in R with TraMineR.
%    \emph{Journal of Statistical Software} \bold{40}(4), 1-37.
%
%    Gabadinho, A., G. Ritschard, M. Studer and N. S. Müller (2009).
%    Mining Sequence Data in \code{R} with the \code{TraMineR} package:
%    A user's guide. Department of Econometrics and Laboratory of
%    Demography, University of Geneva
%}

%\examples{ ## load the mvad data library(TraMineR) data(mvad)

%## create a state sequence object from columns 17 to 86 mvad.seq <- seqdef(mvad[,17:86])

%## distribution plot by sex (male) seqdplot(mvad.seq, group=mvad$male, border=NA)

%## compute the LCS pairwise distance matrix ## among the first 10 sequences mvad.lcs <- seqdist(mvad.seq[1:10,], method="LCS") }

\keyword{ package } 