\name{TraMineRextras-package}
\alias{TraMineRextras-package}
\alias{TraMineRextras}
\docType{package}
\title{ TraMineR Extension }
\description{
(Version: 0.6.4) Collection of ancillary functions and utilities to be used in conjunction with the 'TraMineR' package for sequence data exploration. Includes, among others, specific functions such as state survival plots, position-wise group-typical states, dynamic sequence indicators, and dissimilarities between event sequences. Also includes contributions by non-members of the TraMineR team such as the relative frequency plot and methods for polyadic data.
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