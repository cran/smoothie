\name{smoothie-package}
\alias{smoothie-package}
\alias{smoothie}
\docType{package}
\title{
Two-dimensional Field Smoothing
}
\description{
\pkg{smoothie} contains code originally contained as part of the package, \pkg{SpatialVx}; a package for performing weather forecast verification spatially.  However, the code is potentially useful for much wider purposes than spatial weather forecast verification.  It contains functions to perform convolution smoothing using several different types of kernels.
}

\details{

The manual for this package is given by Gilleland (2013).

Primary functions include:

\code{Fourier2d}, \code{kernel2dsmooth} and \code{kernel2dmeitsjer}

As well as the following wrapper functions, which can be useful in the context of having functions that take the same set of arguments (e.g., with the smoothing parameter as the second argument with the name \code{lambda}) for ease of allowing a user to supply their own desired kernel to a function as is utilized, for example, in the \pkg{SpatialVx} package.

\code{hoods2dsmooth} (neighborhood or boxcar kernel)

\code{gauss2dsmooth} (Gaussian kernel)

\code{disk2dsmooth} (Disk kernel)

\code{identity2dsmooth} (No smoothing, just returns the field)

See their help files for more information.

The functions utilize the convolution theorem along with the Fast Fourier Transform (FFT) to smooth the field (Hastie and Tibshirani, 1990; Souza, 2010)
}

\author{
Eric Gilleland
}
\references{

Gilleland, E. (2013) Two-dimensional kernel smoothing: Using the R package smoothie.  \emph{NCAR Technical Note}, TN-502+STR, 17pp., \doi{10.5065/D61834G2}.

Hastie, T. J. and Tibshirani, R. J. (1990) \emph{Generalized Additive Models}. Chapman \& Hall/CRC Monographs on Statistics and Applied Probability 43, 335pp.

Souza, C. R. (2010) \emph{Kernel Functions for Machine Learning Applications}. 17 Mar 2010. Web. \url{http://crsouza.blogspot.com/2010/03/kernel-functions-for-machine-learning.html}.

}
\examples{
## See help files for above named functions and datasets
## for specific examples.
}
\keyword{ package}
