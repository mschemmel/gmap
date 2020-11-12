calculate.chromosome.position <- function(pSize = NULL, count = NULL) {
    distance <- 80
    midpoint <- pSize / 2
    
    # test if number of requested linkage groups is odd or even to calculate position
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
    
    }
    else {
		# if only a single linkage group is requested, draw at midpoint
		if (count == 1) {
			return(midpoint - 20)
		}
		else {
			toLeft <- (count - 1) / 2
			toRight <- (count - 1) / 2
			  
			PositionLeft <- seq(midpoint - (distance * toLeft), midpoint, distance)
			PossitionLeft <- PositionLeft[1:length(PositionLeft) - 1]
			PositionRight <- seq(midpoint, midpoint + (distance * toRight), distance)
			PositionRight <- PositionRight[2:length(PositionRight)]
			  
			# the distance between two chromosomes is set to '40' (arbitrary defined)
			calculatedPosition <- c(PositionLeft, midpoint, PositionRight)
			calculatedPosition <- calculatedPosition - 20
			  
			return(calculatedPosition)
		}
    }
  }
