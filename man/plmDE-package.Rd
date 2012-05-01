\name{plmDE-package}
\alias{plmDE-package}
\alias{plmDE}
\docType{package}
\title{
Generalized Additive Partially Linear Models for Gene Expression Data
}
\description{
This package is intended for the analysis of gene expression data which is accompanied by  some quantitative measurements (such as weight or tumor size) for each sample.  It provides a very flexible framework for testing numerous differential-expression-related hypotheses regarding such data.  To properly formulate such hypotheses, one must have a solid grasp of the models on which they are founded, and I therefore provide an introduction to this methodology, which should facilitate successful use of the package.


In a disease for which severity level (or any specific trait of interest) can be numerically expressed by some measure \eqn{S}, it is reasonable  to suppose the measured expression level of a gene \eqn{Y} in a profiling experiment (where \eqn{I_D} indicates the presence of the disease) can be described by the following generalized additive partially linear model: 
\deqn{
g(E[Y | I_{D}, S]) = \beta_0 + \beta_1 I_{D}  + I_{D}f(S)
}
where \eqn{g} is some specified link function and \eqn{f} is a function (with an intercept = 0) which describes the effects of interaction between the disease and its severity level on the expression of the gene. Because of the complex nature of the interactions between genes and their environment, few assumptions are placed on \eqn{f}.  Given a expression profiling dataset of this sort, if we identify differentially expressed genes as those for
which \eqn{\beta_1 = f(S) = 0}, we presumably obtain a set of genes whose differential expression is more likely to be attributed to their effect on \eqn{S} in the course of the disease than the set of genes identified as differentially expressed through only testing \eqn{\beta_1 = 0} in a simpler model where \eqn{f} is set to 0.  

Generalizing this scenario, suppose we now have groups \eqn{D_1, \dots D_G} and baseline group \eqn{N} into which each sample can be classified, as well as numerous quantitative covariates \eqn{S_1, \dots S_C} which are measured from each sample.  Then, \eqn{Y_j}, the expression level of gene \eqn{j} in a sample \eqn{X} can be modeled as:
\deqn{
g(E[Y_{j} \mid data \ on \ X]) = \beta_{N,j} + \sum_{i = 1} ^ {G} {\beta_{i,j} I_{D_i} (X) } + \sum_{i = 1} ^ {C} {I_{D_i} f_{i,j}(S_{i,X})}
}

From such a model, we can test a number of hypotheses.  An example of one that might be of interest would be: For each gene \eqn{j}, simultaneously test whether \eqn{I_{D_r} f_{2,j} = I_{D_s} f_{2,j}} and \eqn{\beta_{r,j} = \beta_{s,j}}. The genes whose expression levels are rejected by this test would be candidate members of the set whose expression is involved in changes in \eqn{S_2} between groups \eqn{D_r} and \eqn{D_s}.

To test such a model, we first express \eqn{f_{i,j}} in terms of a linear combination of predefined basis functions.  Then, we can fit a reduced model to the data in which we select one set of coefficients for these basis functions that best fits the expression level data of both groups at gene \eqn{j}, and we fit a full model which adds on top of the reduced model another subset of basis coefficients to better fit the expression levels from the second group.  Since both the full and reduced model have been transformed into generalized linear models through the basis approximation, the significance of the additional coefficients in the full model over the reduced can easily be tested (using for example Chi-square or F tests).

This package contains methods to perform such tests, using B-splines as the basis functions, and methods for viewing the fit of the estimated functions on the expression data.  All it requires from the user is the specification of the full and reduced models representing the test to be conducted on a dataset of gene expression measurements. 
}

\details{
\tabular{ll}{
Package: \tab plmDE\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2012-05-01\cr
License: \tab GPL Version 2 or newer \cr
}
}
\author{
Jonas Mueller

Maintainer: <jonasmueller303@hotmail.com>
}
\references{
Wang, L., Xiang, L., Liang, H., and Carroll, R. Estimation and variable selection for generalized additive partial linear models. \emph{Annals of Statistics} \bold{39}, 1827-51 (2011).
}

\keyword{ package }

\examples{
## create an object of type \code{plmDE} containing disease with 
## "control" and "disease" and measures of weight and severity:
ExpressionData = as.data.frame(matrix(abs(rnorm(10000, 1, 1.5)), ncol = 100))
names(ExpressionData) = sapply(1:100, function(x) paste("Sample", x))
Genes = sapply(1:100, function(x) paste("Gene", x))
DataInfo = data.frame(sample = names(ExpressionData), group = c(rep("Control", 50), 
rep("Diseased", 50)), weight = abs(rnorm(100, 50, 20)), severity = c(rep(0, 50), 
abs(rnorm(50, 100, 20))))
plmDEobject = plmDEmodel(Genes, ExpressionData, DataInfo)

## test whether severity and the indicator variable
## for disease are simultaneously significant:
test = fitGAPLM(plmDEobject, continuousCovariates.fullModel 
= c("weight", "severity"), compareToReducedModel = TRUE, 
indicators.reducedModel = NULL, continuousCovariates.reducedModel = "weight")

## find genes with most evidence for differential expression under the model:
mostDE(test)

## plot the model's fit on the expression data of the 5th gene:
plot(test, "weight", 5, plmDEobject)
}
