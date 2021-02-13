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
