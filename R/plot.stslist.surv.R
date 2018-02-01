# Authors: Pierre-Alexandre Fonta, Matthias Studer (2016)

plot.stslist.surv <- function(x, cpal = NULL, ylab = NULL, xaxis = TRUE,
  yaxis = TRUE, xtstep = NULL, cex.axis = 1, ...) {
  if (yaxis) yaxt <- "s" else yaxt <- "n"
  if (is.null(cpal)) cpal <- attr(x, "cpal")
  if (is.null(ylab)) ylab <- "Percentage of unterminated spells"
  if (is.null(xtstep)) xtstep <- attr(x, "xtstep")
  xlab <- "Time since the start of the spell"
  c <- class(x)
  class(x) <- c[c != "stslist.surv"]
  if ("survfit" %in% class(x)) {
    plot(x, col = cpal, xlab = xlab, ylab = ylab, cex.axis = cex.axis,
      xaxt = "n", yaxt = yaxt, ...)
    if (isTRUE(xaxis)) {
      times <- sort(unique(x$time))
      time.range <- seq(1, max(times))
      tpos <- seq(1, max(times), xtstep)
      ##axis(1, at = tpos, labels = times[tpos], cex.axis = cex.axis)
      axis(1, at = tpos, labels = time.range[tpos], cex.axis = cex.axis)
    }
   } else { ## x==0 when no cases are selected, plot an empty frame
    plot(0, type = "n", col = cpal, xlab = xlab, ylab = ylab, cex.axis = cex.axis,
      xaxt = "n", yaxt = "n", ...)
   }
}
