% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/R_codes.R
\name{cappmx_fit}
\alias{cappmx_fit}
\title{Fit CAPPMx Model}
\usage{
cappmx_fit(
  cat_cov_trt = NULL,
  cont_cov_trt = NULL,
  response_trt,
  surv_ind_trt,
  cat_cov_rwd = NULL,
  cont_cov_rwd = NULL,
  response_rwd,
  surv_ind_rwd,
  nmix = 15,
  nrun = 5000,
  burn = 1000,
  thin = 5,
  del_range_response = c(0.005, 0.02) * 15,
  nleapfrog_response = 3,
  del_range_alp1 = c(0.1, 0.3) * 5,
  nleapfrog_alp1 = 4,
  del_range_alp2 = c(0.1, 0.3) * 3,
  nleapfrog_alp2 = 3
)
}
\arguments{
\item{cat_cov_trt}{The matrix of categorical variables in the Treatment arm.}

\item{cont_cov_trt}{The matrix of continuous variables in the Treatment arm.}

\item{response_trt}{The vector of \strong{\code{log}-transformed} survival times in the Treatment arm.}

\item{surv_ind_trt}{A logical vector of the same length as \code{response_trt} indicating whether the corresponding survival times is an observed failure or right-censored.}

\item{cat_cov_rwd}{The matrix of categorical variables in the RWD.}

\item{cont_cov_rwd}{The matrix of continuous variables in the RWD.}

\item{response_rwd}{The vector of \strong{\code{log}-transformed} survival times in the RWD.}

\item{surv_ind_rwd}{A logical vector of the same length as \code{response_rwd} indicating whether the corresponding survival times is an observed failure or right-censored.}

\item{nmix}{Number of mixture components.}

\item{nrun}{Number of MCMC iterations.}

\item{burn}{Number of burn-in iterations.}

\item{thin}{The thinning interval.}

\item{del_range_response}{A vector of length 2 indicating the range of the Hamiltonian Monte Carlo (HMC) tuning parameter \eqn{\Delta t}  in the Leapgrog step for updating the hyperparameters of the response model. The lower bound MUST be positive.}

\item{nleapfrog_response}{A positive integer indicating the number of Leapfrog steps in the  HMC update step for updating the hyperparameters of the response model.}

\item{del_range_alp1}{A vector of length 2 indicating the range of the HMC tuning parameter \eqn{\Delta t}  for updating the Dirichlet concentration parameter \eqn{\alpha_1} in the mixture model of Treatment arm.}

\item{nleapfrog_alp1}{A positive integer indicating the number of Leapfrog steps in the  HMC update step for updating \eqn{\alpha_1}.}

\item{del_range_alp2}{A vector of length 2 indicating the range of the HMC tuning parameter \eqn{\Delta t}  for updating the Dirichlet concentration parameter \eqn{\alpha_2} in the mixture model of Treatment arm.}

\item{nleapfrog_alp2}{A positive integer indicating the number of Leapfrog steps in the  HMC update step for updating \eqn{\alpha_2}.}
}
\value{
A list with the following elements:
\describe{
\item{\code{pimat1}}{A matrix of MCMC samples of mixture weights \eqn{(\pi_{1,1},\dots,\pi_{1,\texttt{nmix}})} of the Treatment arm. Each row corresponds to a MCMC sample.}
\item{\code{pimat2}}{A matrix of MCMC samples of mixture weights \eqn{(\pi_{2,1},\dots,\pi_{2,\texttt{nmix}})} of the RWD. Each row corresponds to a MCMC sample.}
\item{\code{pimat2} }{A matrix of MCMC samples of mixture weights \eqn{(\pi_{2,1},\dots,\pi_{2,\texttt{nmix}})} of the RWD. Each row corresponds to a MCMC sample.}
\item{Weights2}{A matrix of MCMC samples of impotance resampling weights attached to the samples in the RWD. Each row corresponds to a MCMC sample. \code{ncol(Weights2)=} the  number of samples in the RWD.}
\item{Lognormal_params1}{A list of length 2-- the first element of the list is a \code{n_mc}\eqn{\times\texttt{nmix}}  matrix of MCMC samples containing the location parameters \eqn{(\mu_{1,1},\dots,\mu_{1,\texttt{nmix}})} of the location-scale mixture of normals  on the \code{log}-survival outcomes in the Treatment arm;
   the second element of the list is a \code{n_mc}\eqn{\times\texttt{nmix}} matrix of MCMC samples containing the scale parameters \eqn{(\sigma_{1,1}^{2},\dots,\sigma_{1,\texttt{nmix}}^{2} )} of the location-scale mixture of normals  on the \code{log}-survival outcomes in the Treatment arm. 
 We let \code{n_mc} denote the number of MCMC samples returned by the \code{cappmx_fit} function.}
\item{Lognormal_params2}{A list of length 2--organized in the same manner as \code{Lognormal_params1} but  corresponds to the mixture model on the survival outcomes of the RWD.}
\item{Unifs}{A \code{n_mc}\eqn{\times} \code{n} matrix for assessing model fit where \code{n=(length(response_trt)+length(response_rwd))}. 
In case the model fit is good, the distribution of the elements of each row of the \code{Unifs} should approximately be \eqn{Unif(0,1)}.}
\item{Lognormal_hyperparams}{A \code{n_mc}\eqn{\times}2 matrix of MCMC samples of the hyperparameters shared across the two arms in the response models.}
\item{Dirichlet_params}{A \code{n_mc}\eqn{\times}2 matrix of MCMC samples of \eqn{(\alpha_1,\alpha_2)}.}
\item{Acceptance rates}{A vector of length 3 indicating the acceptance rates of \eqn{\alpha_1}, \eqn{\alpha_2} and the \code{Lognormal_hyperparams}, respectively.}
}
}
\description{
An implementation of the CAPPMx by \insertCite{chandra_GBM22;textual}{CAPPMx}.
}
\details{
Fit the CAPPMx on treatment arm and RWD with survival endpoints.
 Currently the package only supports right-censored outcomes.
}
\note{
The following \strong{MUST BE} ensured 
\itemize{
\item{\code{nrow(cat_cov_trt)=nrow(cont_cov_trt)=length(response_trt)=length(surv_ind_trt)}}
\item{\code{nrow(cat_cov_rwd)=nrow(cont_cov_rwd)=length(response_rwd)=length(surv_ind_rwd)}}
\item{\code{ncol(cont_cov_trt)=ncol(cont_cov_rwd)}}
\item{\code{ncol(cat_cov_trt)=ncol(cat_cov_rwd)}}
\item{The category indicators of \code{cat_cov_trt} and \code{cat_cov_rwd} \strong{MUST BE} non-negative integers starting from 0. 
For example, a covariate with three categories must be indicated using 0,1 and 2.}
}
The package is under development. The user must format the inputs according to the above.

The HMC tuning parameters may need to be adjusted manually if the default settings  yield low acceptance rates.
}
\references{
\insertAllCited{}
}
