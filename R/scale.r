# still in progress, NOT working by now

scale <- function(maxval) {
    roundto = 100
	roundup <- function(maxval, to = roundto) { to*(maxval%/%to + as.logical(maxval%%to)) }

			
	scalerange = seq(100,1000,900/(roundup(maxval)/roundto))	
	scalelabels = rev(seq(0,roundup(maxval), roundto)) 	
	
	# show main vertical scale line	
	segments(x0 = -10, y0 = 0, x1 = -10, y1 = 1000, col = "black")
	
	# show ticks
	segments(x0 = -10,
             y0 = scalerange, 
             x1 = -20, 
             y1 = scalerange,
             col = "black")

    text(-50, scalerange, scalelabels, cex = 0.5)	
}
