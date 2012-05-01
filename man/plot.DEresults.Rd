\name{plot.DEresults}
\alias{plot.DEresults}
\title{
Plot Fit of \code{DEresults} Model
}
\description{
Given a model contained in a \code{DEresults} object, \code{plot.DEresults} plots the fit of the model on the expression data for a specified gene/probe.
}
\usage{
\method{plot}{DEresults}(x, covariate, geneNumber = 1, plmDEobject, 
loess = TRUE, legend = TRUE, legend.coor = "topright", ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
An object of type \code{DEresults} containing the model whose fitted values we wish to plot.
}
  \item{covariate}{
The covariate we wish to plot against the expression level data.
}
  \item{geneNumber}{
The index of the gene whose expression data should be plotted on the y-axis.
}
  \item{plmDEobject}{
An object of type \code{plmDE} containing all the data on expression and measurements of the covariates.
}
  \item{loess}{
Should a loess fit on the covariate and actual expression level data be plotted?}
  \item{legend}{
Should a legend be plotted?
}
  \item{legend.coor}{
the coordinates of the legend. See \code{\link{legend}} for details.
}
  \item{\dots}{
parameters to be passed to plot
}
}

\author{
Jonas Mueller
}

\seealso{
\code{\link{fitGAPLM}}, \code{\link{plmDE}}
}
\examples{
## create an object of type \code{plmDE} containing disease with "control"
## and "disease" groups with measures of weight and severity. Then fit model:
ExpressionData = as.data.frame(matrix(abs(rnorm(10000, 1, 1.5)), ncol = 100))
names(ExpressionData) = sapply(1:100, function(x) paste("Sample", x))
Genes = sapply(1:100, function(x) paste("Gene", x))
DataInfo = data.frame(sample = names(ExpressionData), group = c(rep("Control", 50), 
rep("Diseased", 50)), weight = abs(rnorm(100, 50, 20)), severity = c(rep(0, 50), 
abs(rnorm(50, 100, 20))))
plmDEobject = plmDEmodel(Genes, ExpressionData, DataInfo)
model = fitGAPLM(plmDEobject, continuousCovariates.fullModel = c("weight", "severity"),
 compareToReducedModel = TRUE, indicators.reducedModel = NULL, 
continuousCovariates.reducedModel = "weight")
plot(model, "weight", 6, plmDEobject)
}

\keyword{ ~hplot }