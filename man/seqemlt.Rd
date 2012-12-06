\name{seqemlt}
\alias{seqemlt}
\title{Euclidean Metric for Longitudinal Timelines}
\description{
Computes a Euclidean distance between sequences.
Transforms sequences such as distance beween sequences is equivalent to Euclidean distance between transformed sequences.
The transformed sequences may be used as inputs of any Euclidean algorithm (clustering algorithms, ...).
The distance is built considering the transitions between states at any step.
A step weighing mechanism allows to balance short term/long term transitions.
The background - the duality between distances between sequences and the evolution of the proximities between objects - is analysed.
}
\usage{
seqemlt(seqdata, a = 1, b = 1, weighted = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{seqdata}{ a state sequence object defined with the \code{\link{seqdef}} function.
%%     ~~Describe \code{seqdata} here~~
}
  \item{a}{optional argument for step weighing mechanism that controls the balancing between short term/long term transitions. The weighting function is \eqn{1/(a*s+b)} where \eqn{s} is the transition step.
%%     ~~Describe \code{a} here~~
}
  \item{b}{see argument \code{a}.
%%     ~~Describe \code{b} here~~
}
  \item{weighted}{optional numerical vector containing weights, which may be used by some functions to compute weighted statistics (rates of transitions).
%%     ~~Describe \code{weighted} here~~
}
}
\details{The distance emlt between two sequences is the Euclidean distance between the transformed sequences coordinates. Using \code{coord} as the data input of any clustering algorithm using a Euclidean metric is equivalent of clustering with the emlt metric.
A situation is defined as a state indexed with time, a sequence a timelines of states. The distance between situations is defined from the transitions between situations. The emlt distance between sequences takes into account the proximity between situations. Transitions are considered at any steps with a weighting balance between long/short terms. A situation may have no occurrence when the referring object is not present during all the duration. The distance between any situation and a situation with no occurrence is \code{NA}, and has no influence for the distance between sequences.
%%  ~~ If necessary, more details than the description above ~~
}
\value{
  An object of class \code{emlt} with the following componants
  \item{coord}{transformed sequences. Euclidean metric emlt between sequences is equivalent to Euclidean distance between coord. coord is the input of any clustering algorithms using a Euclidean metric}
  \item{states }{list of states}
  \item{situations }{list of situations}
  \item{sit.freq }{frequence of situations}
  \item{sit.transrate }{rate of transitions from a situation to any situation of its own future : vector of transition towards future}
  \item{sit.profil }{profil of situations. The profil is a normalized vector issued from the rate of transition including a balance of short/long term with the weight of time 1/a*s+b, where s is the step of transition }
  \item{sit.cor }{Correlation between situations. Two situations are high correlated when their profiles are similar (ie their transitions towards future are similar). }
}
\references{- Rousset Patrick,  Giret Jean-françois,Classifying Qualitative Time Series with SOM: The Typology of Career Paths in France Lecture Notes in computer science, vol 4507, 2007, Springer Berlin / Heidelberg -
- Rousset Patrick, Giret Jean-françois, Yvette Grelet (2012) Typologies De Parcours et Dynamique Longitudinale, Bulletin de méthodologie sociologique, issue 114, april 2012. -
- Rousset Patrick, Giret Jean-françois (2008) A longitudinal Analysis of  Labour Market Data with SOM, Encyclopedia of Artificial Intelligence, Edition Information Science Reference -
%% ~put references to the literature/web site here ~
}
\author{Patrick Rousset, Senior researcher at Cereq, rousset@cereq.fr with the help of Matthias Studer
}

\seealso{plot.emlt}
\examples{
library(TraMineR)

data(mvad)
mvad.seq <- seqdef(mvad[1:100, 17:41])
alphabet(mvad.seq)
head(labels(mvad.seq))
## Computing distance
mvad.emlt <- seqemlt(mvad.seq)

## typology1 with kmeans in 3 clusters
km <- kmeans(mvad.emlt$coord, 3)

##Plotting typology1 by clusters
seqdplot(mvad.seq, group=km$cluster)

## typology2 : with ward criterion in 3 clusters for large data: a two step kmeans-cluster
km<-kmeans(mvad.emlt$coord,25)
hc<-hclust(dist(km$centers, method="euclidean"), method="ward")
zz<-cutree(hc, k=3)

##Plotting typology2 by clusters

seqdplot(mvad.seq, group=zz[km$cluster])


## Plotting the evolution of the correlation between states
plot(mvad.emlt, from="employment", to="joblessness",type="cor")
plot(mvad.emlt, from=c("employment","HE", "school", "FE"), to="joblessness", delay=0, leg=TRUE)
plot(mvad.emlt, from="joblessness", to="employment", delay=6)
plot(mvad.emlt, type="pca", cex=0.4, compx=1, compy=2)

}
