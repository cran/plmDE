\name{plmDEmodel.default}
\alias{plmDEmodel.default}
\title{
Creates a class to hold Expression Data and Other Measurements
}
\description{
Given gene expression data as well as phenotypic measurements, \code{plmDEmodel} encodes them within a single object on which \code{\link{fitGAPLM}} and \code{\link{limmaPLM}} can be run.
}
\usage{
\method{plmDEmodel}{default}(genes, expressionValues, sampleInfo, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{genes}{
A vector of the genes (or probes/targets) from which each one is to be tested for differential expression.
}
  \item{expressionValues}{
A data frame or matrix containing the expression data of these genes.  Each column should represent one sample and each row one gene.
}
  \item{sampleInfo}{
Information about the samples in \code{expressionValues}.  This data frame must be specially formatted: first column must list samples (and must match the column names of expressionValues), second column must list the subgroups (i.e. 'disease', 'control') each sample belongs to, additional columns hold the measurements of some aspect of interest for each sample.  
}
  \item{\dots}{
Parameters from \code{\link{plmDEmodel}} that are unused in this method.
}
}

\value{
Returns an object of type \code{plmDE} on which \code{fitGAPLM} may be run to test for differential expression under a specified model.
}

\author{
Jonas Mueller
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
}

