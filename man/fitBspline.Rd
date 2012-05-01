\name{fitBspline}
\alias{fitBspline}

\title{Compute B-Spline Basis for Data}
\description{Provides a heuristic framework for fitting a set of B-spline basis functions to a set of data points under the constraint of a limited number of degrees of freedom.}
\usage{
fitBspline(dataValues, continuousCovariates, indicators, group, covariate)
}
\arguments{
 \item{dataValues}{
A vector of data points to which the spline is to be fit.
}
 \item{continuousCovariates}{
Vector that contains all the continuous variables whose coefficients must be estimated in this model.
}
 \item{indicators}{
This vector contains all the indicator variables whose coefficients will also be estimated in the model.  The number of parameters in \code{indicators} and \code{continuousCovariates} together with the length of \code{dataValues} determine the available number of degrees of freedom for the fitting of the spline.
}
 \item{group}{
    String denoting the subgroup from which the measurements of these \code{dataValues} are coming. 
}
 \item{covariate}{
String denoting the variable that is being measured by the \code{dataValues}.
}
}
\details{
This method is intended for users who do not wish to specify B-spline properties.  It adopts the heuristic of modified equipotent arrangement put forth by Yanagihara and Ohtaki (1991) in selecting knot-placement of the splines.  
}
\value{
Uses the return format of \code{\link{bs}} in the \code{\link{splines}} package, which is a matrix corresponding to the values of each fitted B-spline basis function evaluated at each point in \code{dataValues}. 
}
\references{
Yanagihara, H. and Ohtaki, M. Knot-Placement to Avoid Over Fitting in \emph{B}-Spline Scedastic Smoothing. \emph{Communications in Statistics}, \bold{32}, 771-85 (1991). 
}
\author{Jonas Mueller}

\seealso{
\code{\link{splines}} for a basic B-spline package on which \code{fitBspline} heavily relies. 
}
\examples{

data = runif(n = 30, min = 50, max = 100)
variables = c("height", "weight", "insulin")
indicators = c("sex", "diseased")
subgroup = "diabetes"
covariate = "height"
BsplineFit = fitBspline(data, variables, indicators, subgroup, covariate)
}
\keyword{ smooth }
