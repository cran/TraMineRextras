\encoding{utf8}

\name{seqprecarity}

\alias{seqprecarity}
\alias{seqprecorr}

\title{Precarity index}

\description{
The precarity index returned by the function \code{seqprecarity} is a modified complexity index that takes account of the ordinal order (possibly only partial order) of the states and data-driven correction factors derived from the overall frequencies of the transitions occurring in the sequence. The signed proportions (transition-based weighted proportions of negative transitions) used for the correction factor can be extracted per se by means of the function \code{seqprecorr}. (See details.)
}

\usage{
seqprecarity(seqdata, correction=NULL, otto=.2, a=1, b=1.2,
    state.order=alphabet(seqdata), state.equiv=NULL, ...)

seqprecorr(seqdata, state.order=alphabet(seqdata), state.equiv=NULL,
    tr.type="TRATEDSS", weight.type="ADD", penalized="BOTH",
    with.missing=FALSE)
}

\arguments{
  \item{seqdata}{a state sequence object (class \code{stslist}) as returned by the \code{\link[TraMineR]{seqdef}} function.}

  \item{correction}{Vector of non-negative correction factor values. If \code{NULL}, the correction factors are computed by means of the \code{seqprecorr} function.}

  \item{otto}{Scalar in the range [0,1]. Trade-off weight between the precarity level of the initial state and the corrected complexity. Default is \code{otto=.2}.}

  \item{a}{Non-negative real value. Exponent weight of the complexity. Default is 1.}

  \item{b}{Non-negative real value. Exponent weight of the correction factor. Default is 1.2. }

  \item{state.order}{Vector of short state labels defining the order of the states. First the less precarious (most positive) state and then the other states in increasing precariousness order. States of the alphabet that are not included here define the non-comparable states.}

  \item{state.equiv}{List of state equivalence classes. The classes in the list are each set as the vector of the short labels of the states forming the class. }

  \item{tr.type}{One of \code{'FREQ'}, \code{'TRATE'}, or \code{'TRATEDSS'} (default). Type of transition probabilities used for deriving the weights: \code{'FREQ'} overall frequency of the transitions, \code{'TRATE'} transition probabilities, and \code{'TRATEDSS'} transition probabilites in the DSS sequences.}

  \item{weight.type}{One of \code{'ADD'} (default), \code{'INV'}, \code{'LOGINV'}, or \code{'NO'}. How weights are derived from the transition probabilities: \code{'ADD'} additive (1-p), \code{'INV'} inverse (1/p), and \code{'LOGINV'} log of inverse. When \code{'NO'}, weights do not account for the transition probabilities.}

  \item{penalized}{One of \code{'BOTH'} (default), \code{'NEG'}, \code{'POS'}, or \code{'NO'}. What should be penalized or rewarded? \code{'NEG'} only negative transitions, \code{POS} only positive transitions (with negative penalization), \code{'BOTH'} penalize negative transitions and reward positive ones, \code{NO} no penalization. Can also be logical with \code{TRUE} equivalent to \code{'BOTH'} and \code{FALSE} equivalent to \code{'NO'}.}

  \item{with.missing}{Logical. Should the missing state be considered as an element of the alphabet?
    }

%  \item{norm}{Logical. Should the weights be normalized by the maximal number of transitions.
%      Not a true normalization because, depending on the transition weights, their sum in a sequence can exceed the number of transitions.}

  \item{...}{Arguments passed to \code{seqprecorr}}
}


\details{The precarity index of a sequence \eqn{x} is based on the complexity index  (\cite{Gabadinho et al., 2010}) \eqn{c(x)} (See the \code{\link[TraMineR]{seqici}} function from \pkg{TraMineR}) and is defined as

 \deqn{prec(x) = \lambda a(x_1) + (1-\lambda) (1 + q(x))^\beta c(x)^\alpha}{prec(x) = lambda * a(x_1) + (1 - lambda)*(1 + q(x))^b*c(x)^a}

where \eqn{a(x_1)} is the level of precarity of the starting state in sequence \eqn{x}, \eqn{q(x)} is the weighted proportion of negative transitions (or, with a negative sign, of the positive transitions) in the sequence. The \eqn{\lambda}{lambda} parameter (argument \code{otto}) determines the trade-off between the importance of the precarity of the starting state and of the corrected complexity index. Parameters \eqn{\alpha}{a} and \eqn{\beta}{b} (argument \code{a} and \code{b}) are exponent weights of respectively the complexity and the correction factor.

The weighted proportion of negative transitions \eqn{q(x)} can be obtained separately by means of the function \code{seqprecorr}. The type of probabilities used to determine the transition weights can be controlled with \code{tr.type}. Likewise, the way how theses probabilites are transformed into weights is controlled with \code{weight.type}. The argument \code{penalized} allows to chose between three strategies: only penalizing negative weights, only rewarding (with negative penalties) positive transitions, and applying both positive and negative penalties.

When equivalent classes are provided, the transitions between states of a same class are ignored and the class mean starting precarity level is assigned to each state of the class (see \code{\link{seqprecstart}}).

As for non-comparable states (those not listed on the \code{state.order} argument), the transition to or from such states is ignored and they all receive the mean level (.5) as starting precarity.

}



\value{

For \code{seqprecarity}, a vector with the value of the precarity index for each sequence. The returned vector has an attribute \code{stprec} that contains the state precarity level used at the starting position.


For \code{seqprecorr}, the vector of the weighted proportions \eqn{q(x)} with as additional attributes: \code{tr} the used transition probabilities; \code{signs} the transitions signs; \code{state.noncomp} the non-comparable states; and \code{state.order} the used state order.


}

\seealso{
 \code{\link[TraMineR]{seqici}} and \code{\link{seqprecstart}}.
}

\references{
Ritschard, G., Bussi, M., and O'Reilly, J. (forthcoming), "An index of precarity for
measuring early employment insecurity", in G. Ritschard, and M. Studer, \emph{Sequence Analysis and Related Approaches: Innovative Methods and Applications}, Series Life Course Research and Social Policies, Cham: Springer.

Gabadinho, A., Ritschard, G., Studer, M. and Müller, N.S. (2010), "Indice de complexité pour le tri et la comparaison de séquences catégorielles", In Extraction et gestion des connaissances (EGC 2010), \emph{Revue des nouvelles technologies de l'information RNTI}. Vol. E-19, pp. 61-66.

}

\examples{
## Defining a sequence object with columns 13 to 24
## in the 'actcal' example data set
data(actcal)
actcal <- actcal[1:200,] ## Here, only a subset
actcal.seq <- seqdef(actcal[,13:24])

## precarity using the original state order
prec <- seqprecarity(actcal.seq)
ici <- seqici(actcal.seq) ## complexity

seqn <- seqformat(actcal.seq, to="SPS", compress=TRUE)
tab <- data.frame(seqn,ici,prec)
names(tab) <- c("seq","ici","prec")
head(tab)

## Assuming A and B as equivalent regarding precarity
prec2 <- seqprecarity(actcal.seq, state.equiv=list(c('A','B')))
tab <- cbind(tab,prec2)
names(tab)[ncol(tab)] <- "prec2"

## and letting C be non-comparable
prec3 <- seqprecarity(actcal.seq, state.order=c("A","B","D"), 
  state.equiv=list(c('A','B')))
tab <- cbind(tab,prec3)
names(tab)[ncol(tab)] <- "prec3"
head(tab)

## Extracting the q(x) used for the correction factor (1-q(x))
q <- seqprecorr(actcal.seq, state.order=c("A","B","D"), 
  state.equiv=list(c('A','B')))
## correction factor
corr.f <- 1 + q
## number of non neutral correction factors
length(corr.f[corr.f != 1])


}

\author{Gilbert Ritschard}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Sequence analysis}
