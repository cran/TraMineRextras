\encoding{latin1}
\name{convert}
\alias{convert.g}

\title{Converting between graphical formats}


\description{
Wrapper function for converting graphics with ImageMagick}

\usage{
convert.g(path = NULL, fileroot= "*", from = "pdf",
    to = "png", create.path = TRUE, options = NULL)
}

\arguments{
  \item{path}{String: The path to the from graphic files.}

  \item{fileroot}{String: Graphic root name; default is "*" for all files with the \code{from} extension.}

  \item{from}{File type extension specifying the from format.}

  \item{to}{File type extension specifying the to format.}

  \item{create.path}{Logical: Should the output files be placed in a \code{to} subfolder.}
  
  \item{options}{Additional options to be passed to the ImageMagick \code{mogrify} function}

}

\details{
    Conversion is done through a call to ImageMagick \code{mogrify} function. This means that ImageMagick should be installed on your system. It must also be listed in the path.
    
    for some values such as \code{"pdf"} and \code{"eps"} of the \code{from} or \code{to} arguments ImageMagick works in conjunction with Gostscript. The latter should, therefore, also be accessible.
}

\seealso{
\code{\link{png}}, \code{\link{pdf}} 
}

\examples{
\dontrun{
## Convert all .pdf graphics in the "figSW" directory
## into .png files and put the files in a "png" subfolder.
convert.g(path="figSw", from="pdf", to="jpg")

## Same, but convert to .jpg files.
convert.g(path="figSw", to="jpg")

## convert file "example.eps" in current path to ".pdf"
## and put it in same folder.
convert.g(fileroot = "example", create.folder=FALSE)
}


}
\keyword{util}
