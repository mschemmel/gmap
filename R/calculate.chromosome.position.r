calculate.chromosome.position <- function(pSize = NULL, count = NULL) {
    # Calculates the chromosome position based on actual number of chromosomes
    #
    # Args:
    #   pSize: plot size (arbitrary specified, internally)
    #   count: number of chromosomes to plot 
    # Returns:
    #   Coordinates to plot given number of chromosomes on plot area
    # set distance (arbitrary defined)
    distance <- 80
    midpoint <- pSize / 2
    
    # test if count is odd or even to calculate position
    if ((count %% 2) == 0) {
      toLeft <- count / 2
      toRight <- count / 2
      
      PositionLeft <- seq(midpoint - (distance * toLeft), midpoint, distance)
      PositionLeft <- PositionLeft[1:length(PositionLeft) - 1]
      PositionRight <- seq(midpoint, midpoint + (distance * toRight), distance)
      PositionRight <- PositionRight[2:length(PositionRight)]
      
      # the distance between two chromosomes is set to '40' (arbitrary defined)
      calculatedPosition <- c(PositionLeft + 40, PositionRight - 40)
      calculatedPosition <- calculatedPosition - 20
    
      return(calculatedPosition)
    
    } else {
      toLeft <- (count - 1) / 2
      toRight <- (count - 1) / 2
      PositionLeft <- seq(midpoint - (distance * toLeft), midpoint, distance)
      PositionLeft <- PositionLeft[1:length(PositionLeft) - 1]
      PositionRight <- seq(midpoint, midpoint + (distance * toRight), distance)
      PositionRight <- PositionRight[2:length(PositionRight)]
      
      # the distance between two chromosomes is set to '40' (arbitrary defined)
      calculatedPosition <- c(PositionLeft, midpoint, PositionRight)
      calculatedPosition <- calculatedPosition - 20
      
      return(calculatedPosition)
    }
  }
