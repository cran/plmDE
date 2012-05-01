\name{limmaPLM}
\alias{limmaPLM}
\title{
Adapt Additive Partially Linear Models for Testing via \code{\link{limma}} 
}
\description{
Uses the methods of \code{\link{fitGAPLM}} to generate linear models of the class 
\code{MArrayLM} so that the moderated t and F methods of \code{\link{limma}} may be used to test for differential gene expression. See \code{\link{fitGAPLM}} for more a more in-depth description of the inputs.
}
\usage{
limmaPLM(dataObject, intercept = TRUE, 
indicators = as.character(unique(dataObject$sampleInfo[,2])[-1]), 
continuousCovariates = NULL, 
groups = as.character(unique(dataObject$sampleInfo[,2])[-1]), 
groupFunctions = rep("AdditiveSpline", length(groups)), 
fitSplineFromData = TRUE, splineDegrees = rep(3, length(groups)),
 splineKnots = rep(0, length(groups)), splineKnotSpread = "quantile", ...)
}

\arguments{
  \item{dataObject}{
   An object of type \code{plmDE} which we wish to test for differential gene expression.
}
  \item{intercept}{
Should an intercept term be included in the model?
}
  \item{indicators}{
Same as \code{indicators.fullModel} in \code{\link{fitGAPLM}}. Note that choice of \code{intercept} should affect choice of \code{indicators}.
}
  \item{continuousCovariates}{
Same as \code{continuousCovariates.fullModel} in \code{\link{fitGAPLM}}.
}
  \item{groups}{
Same as \code{groups.fullModel} in \code{\link{fitGAPLM}}.
}
  \item{groupFunctions}{
Same as \code{groupFunctions.fullModel} in \code{\link{fitGAPLM}}.
}
  \item{fitSplineFromData}{ 
  Same as \code{fitSplineFromData} in \code{\link{fitGAPLM}}.
}
  \item{splineDegrees}{ 
  Same as \code{splineDegrees.fullModel} in \code{\link{fitGAPLM}}.
}
  \item{splineKnots}{ 
  Same as \code{splineKnots.fullModel} in \code{\link{fitGAPLM}}.
}
  \item{splineKnotSpread}{ 
  Same as \code{splineKnotSpread} in \code{\link{fitGAPLM}}.
}
  \item{\dots}{
parameters to be passed to \code{lmFit} in \code{\link{limma}}.
}
}

\value{
This method returns an \code{MarrayLM} object on which we can call \code{eBayes()} and \code{topTable()} to test for differentially expressed genes.
}

\references{
Smyth, G. K. Linear Models and empirical Bayes methods for assesing differential expression in microarray experiments. Stat Appl Genet Mol Biol. \bold{3}, Article 3 (2004).
}
\author{
Jonas Mueller}

\seealso{
\code{\link{fitGAPLM}}, \code{\link{plmDE}}, \code{\link{limma}}
}
\examples{
## create an object of type \code{plmDE} containing disease 
## with "control" and "disease" and measurements of weight and severity:
ExpressionData = as.data.frame(matrix(abs(rnorm(10000, 1, 1.5)), ncol = 100))
names(ExpressionData) = sapply(1:100, function(x) paste("Sample", x))
Genes = sapply(1:100, function(x) paste("Gene", x))
DataInfo = data.frame(sample = names(ExpressionData), group = c(rep("Control", 50), 
rep("Diseased", 50)), weight = abs(rnorm(100, 50, 20)), severity = c(rep(0, 50), 
abs(rnorm(50, 100, 20))))
plmDEobject = plmDEmodel(Genes, ExpressionData, DataInfo)

## create a linear model from which various hypotheses can be tested:
toTest = limmaPLM(plmDEobject, continuousCovariates = c("weight", "severity"),
 fitSplineFromData = TRUE, splineDegrees = rep(3, length(groups)),
 splineKnots = rep(0, length(groups)), splineKnotSpread = "quantile")

## view the coefficients/variables in the model:
toTest$coefficients[1, ]
weightCoefficients = c("DiseasedBasisFunction.weight.1", 
"DiseasedBasisFunction.weight.2", "DiseasedBasisFunction.weight.3", 
"DiseasedBasisFunction.weight.4", "DiseasedBasisFunction.weight.5", 
"DiseasedBasisFunction.weight.6", "DiseasedBasisFunction.weight.7", 
"DiseasedBasisFunction.weight.8", "DiseasedBasisFunction.weight.9")

## test the significance of weight in variation of the expression levels:
toTestCoefficients = contrasts.fit(toTest, coefficients = weightCoefficients)
moderatedTest = eBayes(toTestCoefficients)
topTableF(moderatedTest)
}
