\name{hoods2dsmooth}
\alias{hoods2dsmooth}
\alias{gauss2dsmooth}
\alias{disk2dsmooth}
\alias{identity2dsmooth}
\title{
Wrapper Functions for kernel2dsmooth
}
\description{
Wrapper functions for kernel2dsmooth to perform specific convolution smooths of 2-d fields.
}
\usage{
hoods2dsmooth(x, lambda, W = NULL, setup = FALSE, ...)
gauss2dsmooth(x, lambda, W = NULL, setup = FALSE, ...)
disk2dsmooth(x, lambda, W = NULL, setup = FALSE, ...)
identity2dsmooth(x, lambda = 0, W = NULL, setup = FALSE, ...)
}
\arguments{
  \item{x}{
numeric matrix giving the field to be smoothed.
}
  \item{lambda}{
single numeric giving the smoothing parameter.  In the case of \code{hoods2dsmooth}, this is the neighborhood length so that the result is that each point is an average over the nearest lambda^2 neighbors.  For \code{gauss2dsmooth}, this is the sigma parameter, and for \code{disk2dsmooth}, this is the radius of the disk.  Not used by \code{identity2dsmooth}.
}
  \item{W}{
(optional) if the FFT of the kernel weights have already been calculated for the smooth, they can be passed here.  Not used by \code{identity2dsmooth}.
}
  \item{setup}{
logical, should only the FFT of the kernel weights be returned (i.e., instead of the smoothed x field)?  Should not be used if \code{W} is supplied, or you may not get what you want (i.e., precedence is given to \code{W}'s being supplied).  Not used by \code{identity2dsmooth}.
}
  \item{\dots}{

optional arguments to the specific kernel type in the call to \code{kernel2dsmooth}, or really, to \code{kernel2dmeitsjer}.  Not used by \code{identity2dsmooth}.  Note that for \code{gauss2dsmooth}, both \code{nx} and \code{ny} must be provided.

}

}

\details{

This is a wrapper function to \code{kernel2dsmooth}.  See its help file for more details.  These functions can be useful for functions that allow a user to smooth a field with a choice of smoothing functions.  Makes use of the convolution theorem with the fast Fourier transform for computational efficiency (Ritter and Wilson, 2001; Barrett and Myers, 2004).  Missing values are set to zero, and borders are zero-padded to an optimal amount.  See Hastie and Tibshirani (1990) for smoothing functions in the context of statistical analysis.

\code{hoods2dsmooth} is a wrapper to \code{kernel2dsmooth} that employs the boxcar kernel with neighborhood length as the smoothing parameter, \code{lambda}.  This is the type of kernel smoothing, for example, proposed by Roberts and Lean (2008) and used in Ebert (2008) in the context of spatial weather forecast verification (and used by the \pkg{SpatialVx} package).  The smoothing parameter lambda should be an odd positive integer (though it need not be an actual integer recognized by R).  If it is not, then one of several things will happen depending on its value, and a warning is generated.  If it is not an integer (i.e., if floor(lambda) != lambda), the floor of lambda is taken. If it is even (possibly after flooring), one is subtracted from it.  If it is less than one (possibly after flooring and/or subtracting one), it is set to one (note that if lambda = 1, the field x is returned untouched).

\code{gauss2dsmooth} is a wrapper to \code{kernel2dsmooth} that employs the Gaussian kernel with smoothing parameter, \code{lambda}, equal to the \code{sigma} parameter.  This is the type of smoothing applied originally for the practically perfect hindcast method in the context of spatial weather forecast verification (see Ebert, 2008).  If \code{W} is not specified, then one of either \code{h} or both \code{nx} and \code{ny} must be given (see the help file for \code{kernel2dmeitsjer}).

\code{disk2dsmooth} is a wrapper to \code{kernel2dsmooth} that calls the disk kernel with smoothing parameter r (the radius of the disk).  This is the type of smoothing applied in Davis et al. (2006a, 2006b) in the context of feature-based spatial weather forecast verification.

\code{identity2dsmooth} simply returns the field without smoothing it.  Provided for convenience.

}

\value{

If \code{W} is not supplied and \code{setup} is TRUE, then a matrix is returned with dimensions chosen to optimize computational efficiency.  Otherwise, a matrix of the same dimension as \code{x} is returned giving the smoothed version of the field.

}

\references{

Barrett, H. H. and Myers, K. J. (2004) \emph{Foundations of Image Science}.  Wiley Series in Pure and Applied Optics, Editor: B. E. A. Saleh, Hoboken, New Jersey, 1540pp.

Davis, C. A., Brown, B. G. and Bullock, R. G. (2006a) Object-based verification of precipitation forecasts, Part I: Methodology and application to mesoscale rain areas. \emph{Mon. Wea. Rev.}, \bold{134}, 1772--1784.

Davis, C. A., Brown, B. G. and Bullock, R. G. (2006b) Object-based verification of precipitation forecasts, Part II: Application to convective rain systems. \emph{Mon. Wea. Rev.}, \bold{134}, 1785--1795.

Ebert, E. E. (2008) Fuzzy verification of high resolution gridded forecasts: A review and proposed framework. \emph{Meteorol. Appl.}, \bold{15}, 51--64. doi:10.1002/met.25.  Available at \url{http://www.ecmwf.int/newsevents/meetings/workshops/2007/jwgv/METspecialissueemail.pdf}

Hastie, T. J. and Tibshirani, R. J. (1990) \emph{Generalized Additive Models}. Chapman \& Hall/CRC Monographs on Statistics and Applied Probability 43, 335pp.

Ritter, G. X. and Wilson, J. N. (2001) \emph{Handbook of Computer Vision Algorithms in Image Algebra}.  2nd Edition, CRC Press, Boca Raton, Florida, U.S.A., 417pp.

Roberts, N. M. and Lean, H. W. (2008) Scale-selective verification of rainfall accumulations from high-resolution forecasts of convective events.  \emph{Mon. Wea. Rev.}, \bold{136}, 78--97.  doi:10.1175/2007MWR2123.1.

}

\author{

Eric Gilleland

}

\seealso{

\code{\link{kernel2dsmooth}}, \code{\link{kernel2dmeitsjer}}, \code{\link{fft}}

}
\examples{
x <- y <- matrix( 0, 50, 50)
x[ sample(1:50,10), sample(1:50,10)] <- rexp( 100, 0.25)
y <- disk2dsmooth( x=x, lambda=6.5)
x <- gauss2dsmooth( x=x, lambda=3, nx=25, ny=25)
\dontrun{
##
## The following examples are specific to the SpatialVx package.
##
par( mfrow=c(1,2))
image.plot( x, col=tim.colors(256))
image.plot( y, col=tim.colors(256))

hold <- make.SpatialVx(x, y, thresholds=c(0.1, 0.5))
look <- hoods2d( hold, which.methods=c("fss"), levels=c(1, 3, 20),
        smooth.fun="gauss2dsmooth", smooth.params=list(nx=601, ny=501))
plot( look)

data(pert000)
data(pert004)
data(ICPg240Locs)
# Do the neighborhood methods with averaging performed over
# a radius instead of the lambda^2 nearest neighbors.
# The smoothing parameters are determined by the levels argument,
# and the others are passed via smooth.params.
hold <- make.SpatialVx( pert000, pert004, thresholds=c(1,2,5,10,20,50),
            loc=ICPg240Locs, projection=TRUE, map=TRUE,
            field.type="Precipitation", units="mm/h",
            data.name=c("ICP Fake", "pert000", "pert004"))

look <- hoods2d(hold, levels=c(1, 3, 9, 17, 33, 65, 129, 257),
            smooth.fun="disk2dsmooth", verbose=TRUE)
look
}
}
\keyword{ math }
\keyword{ manip }
