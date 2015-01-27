\name{seqemlt}
\alias{seqemlt}
\title{Euclidean Coordinates for Longitudinal Timelines}
\description{
Computes the Euclidean coordinates of sequences from which we get the EMLT  distance between sequences introduced in Rousset et al (2012).
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
\details{
The EMLT distance is the sum of the dissimilarity between the pairs of states observed at the successive positions, where the dissimilarity between states is defined at each position as the Chi-squared distance between the normalized vectors of transition rates (profiles of situations) from the current state to the next observed states in the sequence.
Transition rates are down-weighted with the time distance to avoid exaggerated importance of long term transitions.

The EMLT distance between two sequences is obtained as the Euclidean distance between the returned numerical sequence coordinates. So, providing \code{coord} as the data input to any clustering algorithm that uses the Euclidean metric is equivalent to cluster with the EMLT metric.

Each time-indexed state is called a situation, and the distance between two states at a position $t$ is derived from the transition rates to other observed situations. The EMLT distance between sequences takes into account the proximity between situations. Transitions are considered at any step with a weighting balance between long/short terms. A situation may have no occurrence when the referring object is not present during all the duration. The distance between any situation and a situation with no occurrence is \code{NA}, and has no influence for the distance between sequences.
%%  ~~ If necessary, more details than the description above ~~

The obtained numerical representations of sequences may be used as input of any Euclidean algorithm (clustering algorithms, ...).

}
\value{
  An object of class \code{emlt} with the following components
  \item{coord}{Matrix with in each row the numerical coordinates of the corresponding sequence.}
  \item{states }{list of states}
  \item{situations }{list of situations}
  \item{sit.freq }{Situation frequencies}
  \item{sit.transrate }{rates of transition from a situation to the situation of its own future: vector of transition towards future}
  \item{sit.profil }{profiles of situations. The profile is a normalized vector issued from the rate of transition including a balance of short/long term with the weight of time 1/a*s+b, where s is the step of transition }
  \item{sit.cor }{Correlation between situations. Two situations are highly correlated when their profiles are similar (i.e., when their transitions towards future are similar). }
}
\references{Rousset Patrick,  Giret Jean-François, Classifying Qualitative Time Series with SOM: The Typology of Career Paths in France, Lecture Notes in computer science, vol 4507, 2007, Springer Berlin / Heidelberg

Rousset Patrick, Giret Jean-françois, Yvette Grelet (2012) Typologies De Parcours et Dynamique Longitudinale, \emph{Bulletin de méthodologie sociologique}, issue 114, April 2012.

Rousset Patrick, Giret Jean-François (2008) A longitudinal Analysis of  Labour Market Data with SOM, Encyclopedia of Artificial Intelligence, Edition Information Science Reference.

Studer, Matthias  and Gilbert Ritschard (2014) A comparative review of sequence dissimilarity measures. LIVES Working Paper, 33 {http://www.lives-nccr.ch/sites/default/files/pdf/publication/33_lives_wp_studer_sequencedissmeasures.pdf}
%% ~put references to the literature/web site here ~
}
\author{Patrick Rousset, Senior researcher at Cereq, rousset@cereq.fr with the help of Matthias Studer
}

\seealso{plot.emlt}
\examples{

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
