\name{NEWS}
\title{NEWS file for the TraMineRextras package}

\section{Changes in version 0.4.2 [2018-02-01]}{
  \subsection{New functions}{
    \itemize{
      \item
      \code{seqprecarity()}: computes the sequence precarity index from
      a provided partial state order. The index is a
      corrected complexity index. See documentation page.
      \item
      \code{seqprecorr()}: determines the correction factor used by
        \code{seqprecarity()}.
      \item
      \code{seqprecstart()}: determines the starting precarity level
        of the sequence from the partial state order.
      \item
      \code{seqsurv()}: fits survival curves for states in state sequences.
        There is a plot method for objects returned by \code{seqsurv()}.
      \item
        \code{seqsplot()}: specific version of the TraMineR \code{seqplot()} function
        to plotting survival curves of states in sequences.
    }
  }

  \subsection{Changes in existing functions}{
    \itemize{
      \item
      \code{seqrep.grp())} renamed argument names for consistency with TraMineR.
      \item
      \code{seqrep.grp())}: when \code{diss=NULL}, the dissimilarity matrix is now
      computed by calling \code{seqdist} with the \code{method} and possibly related parameters specified among the \code{...} arguments. An error is raised when \code{diss=NULL} and no \code{method} is provided.
    }
  }

  \subsection{Bug fixes}{
    \itemize{
      \item
      \code{seqtabstocc())}: label synchronization issues.
    }
  }

  \subsection{Misc}{
    \itemize{
      \item
      Uses function \code{TraMineR.check.depr.args()} introduced in TraMineR v 2.0-8. So, depends now on version >= 2.0-8.
    }
  }


}

\section{Changes in version 0.4.1 [2017-08-16]}{
  \subsection{Changes in existing functions}{
    \itemize{
      \item
      \code{STS_to_SPELL()}: Deleted. Converting to the \code{"SPELL"} format is now a feature
      of \code{seqformat()} in TraMineR 2.0-6+.
      \item
      \code{seqrep.grp()}: Added argument \code{with.missing} to allow computing the default distances (when \code{diss = NULL}) for sequences with missing values.
    }
  }

  \subsection{Misc}{
    \itemize{
      \item
      Replaced deprecated argument names in example of \code{seqrep.grp()}.
      \item
      Now imports from RColorBrewer, survival and cluster instead of depending on those packages.
      \item
      Suppressed unused import from combinat.
      \item
      \code{init.c} file.
    }
  }

}

\section{Changes in version 0.4.0 [2017-05-13]}{

\subsection{Note}{
  \itemize{
    \item
    TraMineRextras has been adapted to and requires now TraMineR 2.0-5.
  }
}

\subsection{Bug Fixes}{
  \itemize{
    \item
    \code{TSE_to_STS()}: The two last sequences were not converted.
    }
}

\subsection{Changes in existing functions}{
  \itemize{
    \item
    \code{seqplot.rf()}, \code{seqplot.tentrop()}, \code{seqrep.grp()}, \code{dissvar.grp()}, \code{plot.seqimplic()}: adjusted argument names (main, with.legend, legend.pos, diss, ...) to conform to the TraMineR 2 naming convention.
    }
}
\subsection{Misc}{
  \itemize{
    \item
    \code{seqrep.grp()}: Removed \code{with.missing=TRUE} in a help example as \code{biofam.seq} doesn't contain missing values and to conform to TraMineR 2.0-5+.
    \item
    \code{seqeformat()}, \code{seqentrans()}, \code{seqerulesdisc()}: Renamed '\code{seqe}' as '\code{eseq}' in internal code to conform to TraMineR 2.0-5+.
    \item
    Adjusted examples in help files (\code{sortv}, \code{seqtabstocc}, \code{seqrep.grp}, \code{seqplot.tentrop}, \code{seqplot.fr}, \code{seqimplic}, \code{seqgranularity}, \code{seqgen.missing}, \code{seqedplot}, \code{seqentrans}) to conform to TraMineR 2.0-5+.
    }
}
}

\section{Changes in version 0.2.6 [2017-03-01]}{
\subsection{Misc}{
  \itemize{
    \item{Function ctplot() suppressed. It is superseded by the
       function seqpcplot() of the TraMineR package.}
    \item{C++ routines are now registered.}
}} }

\section{Changes in version 0.2.5 [2016-11-10]}{
\subsection{New functions}{
  \itemize{
    \item{\code{seqimplic()}: Identifies position wise typical states
    of groups of sequences when compared with all the others. There
    are also plot and print methods for the outcome of the function.}
}}
}

\section{Changes in version 0.2.4 [2015-07-23]}{
\subsection{New functions}{
  \itemize{
    \item{\code{seqplot.rf()}: Implements the Relative Frequency Sequence Plots
        introduced in Fasang and Liao (2014)}
}}
\subsection{Misc}{
  \itemize{
    \item{revised help page for \code{seqemlt()} (distance of Rousset et al. 2012).}
    \item{Added required basic packages to the import statements to
        comply with R v3.3 requirements.}
}}
}
\section{Changes in version 0.2.3 [2015-01-27]}{
\subsection{New functions}{
  \itemize{
    \item{\code{seqtabstocc()}: frequencies of state co-occurrence patterns}
}}
\subsection{Changes in existing functions}{
  \itemize{
    \item{\code{seqgranularity()}: new method \code{"mostfreq"}}
    \item{\code{seqedplot()}: replaced calls of TraMineR internal functions \code{seqeage}
        and \code{TraMineR.legend} with respectively
        \code{TraMineRInternalSeqeage} and \code{TraMineRInternalLegend}
        (should be transparent to the end user).}
}}}
\section{Changes in version 0.2.2 [2013-10-30]}{
\itemize{
    \item{Fixed issue with calling Rinternals from within extern "C" {}
        in seqstart.cpp (request of B. Ripley)}
}
}
\section{Changes in version 0.2.1 [2013-03-15]}{
\subsection{General}{
  \itemize{
    \item{NEWS is now in Rd format into inst/NEWS.Rd}
}}
\subsection{Bug Fixes}{
  \itemize{
    \item{
    \code{FCE_to_TSE()}: Events were not properly chronologically sorted.}
    \item{
    \code{TSE_to_STS()}: produced inconsistent results when events were not chronologically
    sorted by cases.}
}}}
\section{Changes in version 0.2 [2012-12-06]}{
\subsection{General}{
  \itemize{
    \item{
    First release on CRAN}
}}
\subsection{Changes in existing functions}{
  \itemize{
    \item{
    \code{seqplot.tentrop()} and \code{seqplot.tentrop.m()}: new argument \code{cex.legend}
        for controlling legend scaling factor.}
    \item{
    \code{seqentrans()}: new option \code{avg.occ}; when set as \code{TRUE} the table is
        completed with average number of occurrences of the subsequences
        in each sequence. The latter differs from the support for
        counting methods other than COBJ. Requires TraMineR 1.8-5 or higher.}
    \item{
    \code{dissvar.grp()} and \code{seqrep.grp()} now also accept distance objects as \code{mdis} argument.}
    \item{
    \code{group.p} has now a \code{weights} argument.}
}}
\subsection{Bug Fixes}{
  \itemize{
    \item{
    \code{seqedist()}: fixed a mix between norm and interval arguments.}
    \item{
    fixed build warning generated by calls of foreign functions.}
}}}
