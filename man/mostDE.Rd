\name{mostDE}
\alias{mostDE}
\title{
Find Genes with the Most Evidence for Differential Expression
}
\description{
Returns the most significant genes in a \code{DEresults} object.
}
\usage{
mostDE(results, n = 10)
}
\arguments{
  \item{results}{
  A \code{DEresults} object containing the results of a test for differential gene expression.
}
  \item{n}{
  An integer describing the number of highest-significance genes to list.
}
}

\value{
Returns a data frame of the top \code{n} genes ordered by significance along with their adjusted p-values under the test.
}
\author{
Jonas Mueller
}

\seealso{
\code{\link{fitGAPLM}}, \code{\link{topTable}}
}
\examples{
## Run a test for differential gene expression:
ExpressionData = as.data.frame(matrix(abs(rnorm(10000, 1, 1.5)), ncol = 100))
names(ExpressionData) = sapply(1:100, function(x) paste("Sample", x))
Genes = sapply(1:100, function(x) paste("Gene", x))
DataInfo = data.frame(sample = names(ExpressionData), group = c(rep("Control", 50),
 rep("Diseased", 50)), weight = abs(rnorm(100, 50, 20)), severity = c(rep(0, 50),
 abs(rnorm(50, 100, 20))))
plmDEobject = plmDEmodel(Genes, ExpressionData, DataInfo)
test = fitGAPLM(plmDEobject, continuousCovariates.fullModel = c("weight", "severity"),
 compareToReducedModel = TRUE, indicators.reducedModel = NULL, 
continuousCovariates.reducedModel = "weight")

## find 20 genes with most evidence for differential expression:
mostDE(test)
}

