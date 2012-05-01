\name{info.plmDE}
\alias{info.plmDE}
\title{
Obtain Information about \code{plmDE} object
}
\description{
Returns a short overview of the data contained \code{plmDE} objects.
}
\usage{
\method{info}{plmDE}(Object, \dots)
}
\arguments{
  \item{Object}{
An object of type \code{plmDE}.
}
  \item{\dots}{
Parameters from \code{\link{info}} left unused. 
}
}
\author{
Jonas Mueller
}
\seealso{
\code{\link{info}}
}
\examples{
## create an object of type \code{plmDE} containing disease 
## with "control" and "disease" and measurements of weight and severity:
ExpressionData = as.data.frame(matrix(abs(rnorm(10000, 1, 1.5)), ncol = 100))
names(ExpressionData) = sapply(1:100, function(x) paste("Sample", x))
Genes = sapply(1:100, function(x) paste("Gene", x))
DataInfo = data.frame(sample = names(ExpressionData), group = c(rep("Control", 50), rep("Diseased", 50)), weight = abs(rnorm(100, 50, 20)), severity = c(rep(0, 50), abs(rnorm(50, 100, 20))))
plmDEobject = plmDEmodel(Genes, ExpressionData, DataInfo)

## get information:
info(plmDEobject)
}

\keyword{ ~print}