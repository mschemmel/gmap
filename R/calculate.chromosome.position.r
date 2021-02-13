calculate.chromosome.position <- function(plotSize = NULL, count = NULL) {
    if(is.null(plotSize)){
      error("Size of plot is missing.")
    }
    if(is.null(count)){
      error("Number of chromosomes missing.")
    }
    
    distance <- 80
    midpoint <- plotSize / 2
    offset <- 20
    lgsize <- 40

    position.left <- function(x) {
      posLeft <- head(seq(midpoint - (distance * x), midpoint, distance), n = -1)
      return(posLeft)
    }
    position.right <- function(x) {
      posRight <- tail(seq(midpoint, midpoint + (distance * x), distance), n = -1)
      return(posRight)
    }

    # if single linkage group is requested -> draw at midpoint
    if (count == 1) {
      return(midpoint - offset)
    }

    # if count is even
    if ((count %% 2) == 0) {
      perGroup <- count / 2
      coordinates <- c(position.left(perGroup) + lgsize, position.right(perGroup) - lgsize) - offset
      return(coordinates)
    }
    # if count is odd
    else {
      perGroup <- (count - 1) / 2
      coordinates <- c(position.left(perGroup), midpoint, position.right(perGroup)) - offset
      return(coordinates)
    }
  }
