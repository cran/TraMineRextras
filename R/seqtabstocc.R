# Frequencies of state co-occurrence patterns

seqtabstocc <- function(seqdata, ...){
    ssort <- t(apply(seqdata, MARGIN=1, sort))
    ssort.seq <- suppressMessages(seqdef(ssort)) ##, alphabet = alph, states=alph, labels=stlab(seqdata))
    matchlab <- match(alphabet(ssort.seq),alphabet(seqdata))
    ssort.seq <- suppressMessages(seqdef(ssort, labels=stlab(seqdata)[matchlab]))

    sdss  <- suppressMessages(seqdef(seqdss(ssort.seq), missing="%"))

    tf <- seqtab(sdss, format="STS", ...)
    t <- attr(tf,"freq")
    rownames(t) <- gsub("-\\*","",rownames(t))
    return(t)
}
