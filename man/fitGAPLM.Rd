\name{fitGAPLM}
\alias{fitGAPLM}

\title{
Fit a Generalized Additive Partially Linear Model on Gene Expression Data
}
\description{
Given an \code{\link{plmDE}} object containing preprocessed/normalized measures of the expression of a set of genes under different conditions as well as related values of quantitatively-measured covariates of interest, \code{fitGAPLM} tests each gene for differential expression under a model specified by the user.  The test is conducted based on the significance of a full Model fit to the expression data when compared with the fit of a reduced model (F statistic).  The variables of interest should be present in the full model and absent in the reduced.  This method is very flexible and can fit count data (eg. expression measures from high-throughput sequencing) as well as microarray data. Using \code{fitGAPLM}, the user can choose to model the gene expression measures by any mixture of additive functions of the numerical variables with linear terms of the factorial information available. Each of these functions is approximated through a B-spline fit with the intercept of the spline constrained at zero for identifiability.  Although \code{fitGAPLM} seems to take in a daunting amount of input, many of the inputs already set to sensible defaults, and models of the complexity represented in this class must be well thought out and each parameter requires careful consideration.
}
\usage{
fitGAPLM(dataObject, generalizedLM = FALSE, family = poisson(link = log),
 NegativeBinomialUnknownDispersion = FALSE, test = "LRT", weights = NULL, 
offset = NULL, pValueAdjustment = "fdr", significanceLevel = 0.05, 
indicators.fullModel = as.character(unique(dataObject$sampleInfo[,2])[-1]), 
continuousCovariates.fullModel = NULL, 
groups.fullModel = as.character(unique(dataObject$sampleInfo[,2])[-1]), 
groupFunction.fullModel = rep("AdditiveSpline", length(groups.fullModel)), 
fitSplineFromData.fullModel = TRUE, 
splineDegrees.fullModel = rep(3, length(groups.fullModel)), 
splineKnots.fullModel = rep(0, length(groups.reducedModel)), 
compareToReducedModel = FALSE, 
indicators.reducedModel = as.character(unique(dataObject$sampleInfo[,2])[-1]), 
continuousCovariates.reducedModel = NULL, 
groups.reducedModel = as.character(unique(dataObject$sampleInfo[,2])[-1]),
 groupFunction.reducedModel = rep("AdditiveSpline", 
length(groups.reducedModel)), fitSplineFromData.reducedModel = TRUE,
 splineDegrees.reducedModel = rep(3, length(groups.reducedModel)), 
splineKnots.reducedModel = rep(0, length(groups.reducedModel)), 
splineKnotSpread = "quantile")
}
\arguments{
 \item{dataObject}{
Object of type \code{plmDE} containing the gene expression and sample information.
}
 \item{generalizedLM}{
If \code{TRUE}, a link function is introduced to generalize the linear model. Use for gene-level count data.
}
 \item{family}{
One of the distribution families that may be used in the function \code{\link{glm}}.  For gene-level count data, the negative binomial (see \code{\link{negative.binomial}}) is recommended to account for over dispersion.
}
 \item{NegativeBinomialUnknownDispersion}{
In the case of a negative binomial fit, has the dispersion of the data been estimated or does it remain unknown?
If \code{TRUE}, then \code{\link{glm.nb}} from the MASS package is called, which includes routines for fitting the GLM and estimating the dispersion parameter.
}
 \item{test}{
The test that should be used in the case that a GLM is requested to estimate the significance of the model.  See \code{\link{stat.anova}} for details.
}
 \item{weights}{
an optional vector of prior weights to be used in the fitting of the (generalized) linear model. Should be \code{NULL} or a numeric factor.
}
 \item{offset}{
an optional \emph{a priori} known component to be included in the fitting of the (generalized) linear model.  One or more \code{\link{offset}} terms may be included in the model.
}
 \item{pValueAdjustment}{
Choice of multiple testing correction method to be passed to \code{\link{p.adjust}}
}
 \item{significanceLevel}{
The significance level at which genes should be identified as differentially expressed.
}
 \item{indicators.fullModel}{
The indicator terms which should go into the full model.  These must match the groups in the second column of the sample information in \code{dataObject}. Under the default setting, the indicators will consist of all groups except for the first one (used as the baseline for comparison).
}
 \item{continuousCovariates.fullModel}{The quantitative covariates that should go into the full model. These must match the column names of the sample information in \code{dataObject}.
}
 \item{groups.fullModel}{The subgroups of our sample for which we wish to estimate a function relating their measurement of \code{continuousCovariates} to their expression levels in \code{dataObject}.
}
 \item{groupFunction.fullModel}{
A vector of the same length as \code{groups.fullModel} which contains consists of strings matching: "AdditiveSpline", "AdditiveLinear", "CommonSpline", or "CommonLinear".  If AdditiveSpline is chosen, then a B-spline basis is fitted to the \code{continuousCovariate} values of the corresponding group in \code{groups.fullModel} to estimate a function that represents the effect of this group's \code{continuousCovariate} values on their measured expression levels. This function implicitly assumes an indicator term so it evaluates to 0 for the measurements of \code{continuousCovariate} from other groups, and its overall effects are assumed to be additive with respect to the other parameters being estimated.  If "AdditiveLinear" is selected, then this function is taken to be the identity function (no spline basis fit) times a parameter to be fit by the model.  To estimate one function to account for the same effect across multiple groups, they must all be listed in \code{groups.fullModel} and their corresponding index in \code{goupFunction} must be set to "CommonSpline".  Likewise to assume a linear effect across multiple groups, they must also be listed in \code{groups.fullModel} and the corresponding indices of \code{groupFunction} must read "CommonLinear",
}
 \item{fitSplineFromData.fullModel}{
Should the B-spline functions in the full model be automatically fitted based on the heuristic in \code{fitBspline}? 
}
 \item{splineDegrees.fullModel}{ 
If \code{fitSplineFromData.fullModel} has not been selected, then the user may specify, in a vector format, the degree of each B-spline basis that is fitted to the groups.
}

 \item{splineKnots.fullModel}{
If \code{fitSplineFromData.fullModel} has not been selected, then the user may also specify, in a vector, the number of knots to include in each corresponding basis.
}
 \item{compareToReducedModel}{
If \code{TRUE}, then the user must specify a model that the full model should be tested against. Otherwise, the all terms (besides intercept) of the full model are simultaneously tested for significance.
}
 \item{indicators.reducedModel}{
See corresponding parameter for full model.
}
 \item{continuousCovariates.reducedModel}{
See corresponding parameter for full model.
}
 \item{groups.reducedModel}{
See corresponding parameter for full model.
}
 \item{groupFunction.reducedModel}{
See corresponding parameter for full model.
}
 \item{fitSplineFromData.reducedModel}{
See corresponding parameter for full model.
}
 \item{splineDegrees.reducedModel}{
See corresponding parameter for full model.
}
 \item{splineKnots.reducedModel}{
See corresponding parameter for full model.
}
 \item{splineKnotSpread}{
Determines whether B-spline knots are uniformly spread over the range of the data or over the quartiles of the data (takes values: "uniform" or "quantile"), but does not affect the \code{fitBSpline} method.
}
}
\value{
Returns an object of type \code{DEresults} containing various information about the analysis.
  \item{allgenes}{Data frame consisting of information on all the genes, their p-values and adjusted p-values, and whether or not this test identifies them as differentially expressed.
}
  \item{DEgenes}{
Data frame consisting of the genes which were expressed at significantly differing levels according to this model.
}
  \item{PredictorFormula.fullModel}{contains the formula followed by the predictors in the B-spline-approximated linear model, but leaves the dependent variable term out. 
}

  \item{PredictorFormula.reducedModel}{contains the formula followed by the predictors in the reduced model (leaving out the dependent variable term).
}
  \item{modelForm.fullModel}{contains the indicators and covariates incorporated into the full model.
}
  \item{modelForm.reducedModel}{contains the indicators and covariates incorporated into the reduced model.
}
  \item{GLMinfo}{tracks the glm parameters used in the fitting of this model (for plotting purposes).
}
}

\references{
Wang, L., Liu, X., Liang, H., and Carroll, R. J. Generalized Additive Partial Linear Models- Polynomial Spline Smoothing Estimation and Variable Selection Procedures. The Annals of Statistics \bold{39}:4, 1827-1851 (2011)
}
\author{
Jonas Mueller
}
\note{
Because \code{fitGAPLM} is implemented in R rather than a compiled language, it tends to run slowly for larger expression assays (takes ~20 min to run an analysis on  65 samples of ~50,000 probes from the HG-U133 array).  If the GAPLM is intended to be fit to Microarray data, the \code{\link{limmaPLM}} function should be used instead.  However,  \code{fitGAPLM} must be used if un-moderated F-test statistics or plots of the fitted functions are desired.
}

\seealso{
\code{\link{limmaPLM}} for analysis of microarray data.
\code{\link{fitBspline}} for default spline fitting heuristic.
}  
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
test = fitGAPLM(plmDEobject, continuousCovariates.fullModel = 
c("weight", "severity"), compareToReducedModel = TRUE, 
indicators.reducedModel = NULL, continuousCovariates.reducedModel = "weight")
}

\keyword{ models }
\keyword{ regression } 
