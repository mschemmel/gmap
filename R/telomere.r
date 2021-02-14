#' Function to plot telomere on plot
#' 
#' @param location Position to plot telomere at
#' @param x Circle parameter 
#' @param y Circle parameter
#' @param r Radius of half circle
#' @param start Start value of calculation (Default: 0)
#' @param end End value of calculation (Default: pi)
#' @param nsteps Number od steps in between for calculation (Default: 1000)
#' @importFrom graphics lines
#' @export
telomere <- function(location, x, y, r, start = 0, end = pi, nsteps = 1000) {
  rs <- seq(start, end, len = nsteps)

  if(location == "top"){
    xc <- x + r * cos(rs)
    yc <- y + r * sin(rs)
  } else if(location == "bottom"){
    xc <- x - r * cos(rs)
    yc <- y - r * sin(rs)
  }
  lines(xc, yc)
}
