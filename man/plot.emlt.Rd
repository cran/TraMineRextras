\name{plot.emlt}
\alias{plot.emlt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{  Emlt Plotting
%%  ~~function to do ... ~~
}
\description{Plotting, resulting from emlt, static and dynamic states structure in a sequence analysis  - Two types of plot : The evolve in time of correlation between states and the projection of states/situations on their principal planes
%%  Generic function for
}
\usage{
\method{plot}{emlt}(x, from, to, delay=NULL, leg=TRUE, type="cor", cex=0.7, compx=1, compy=2, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a sequence analysis producted by emlt
}
  \item{type}{what type of plot should be drawn. Possible types are
"cor" for the evolve in time of correlation between states
"pca" for the projection of states/situations on their principal planes
}
  \item{from}{for type "cor" first states to compare, may be a vector
}
  \item{to}{for type "cor" second states to compare
}
  \item{delay}{for type "cor", the delay or step between "from" and "to" arguments. The correlation between state "from" at time t and "to" at t+delay. By default delay is 0.
}
  \item{compx}{for type "pca" first component, axis x
}
  \item{compy}{for type "pca" second component, axis y
}
\item{leg}{A boolean argument TRUE, FALSE for including legend}
\item{cex}{A numerical value giving the amount by which plotting text and symbols should be magnified relative to the default.}
  \item{\dots}{Arguments to be passed to methods, such as graphical parameters (see par)
}
}
\details{The evolve of the correlation reveals the evolve of the distance between situations/states index with time considering the emlt euclidean distance.
The "pca" components are the components of the emlt transformed sequences, see seqemlt.
%%  ~~ If necessary, more details than the description above ~~
}
\references{- Rousset Patrick,  Giret Jean-françois,Classifying Qualitative Time Series with SOM: The Typology of Career Paths in France Lecture Notes in computer science, vol 4507, 2007, Springer Berlin / Heidelberg -
- Rousset Patrick, Giret Jean-françois, Yvette Grelet (2012) Typologies De Parcours et Dynamique Longitudinale, Bulletin de méthodologie sociologique, issue 114, april 2012. -
- Rousset Patrick, Giret Jean-françois (2008) A longitudinal Analysis of  Labour Market Data with SOM, Encyclopedia of Artificial Intelligence, Edition Information Science Reference -
%% ~put references to the literature/web site here ~
}
\author{Patrick Rousset, Senior researcher at Cereq, rousset@cereq.fr with the help of Matthias Studer
}

\seealso{
See Also \code{\link{seqemlt}} (with examples)
}
\examples{
## See examples on 'seqemlt' help page
}
