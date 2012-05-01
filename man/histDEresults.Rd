\name{hist.DEresults}
\alias{hist.DEresults}
\title{
Create a Histogram of P-values 
}
\description{
Plots the distribution of p-values resulting from testing multiple genes for differential expression.
}
\usage{
\method{hist}{DEresults}(x, \dots)
}
\arguments{
  \item{x}{
An object of type \code{DEresults} containing the test results for each gene.
}
  \item{\dots}{
Additional parameters to be passed to \code{\link{hist}}
}
}
\references{
Pounds, S. B. Estimation and control of multiple testing error rates for microarray studies. Brief Bioinformatics \bold{7}(1), 25-36 (2006).
}
\author{
Jonas Mueller
}
