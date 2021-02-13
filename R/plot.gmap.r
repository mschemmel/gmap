plot.gmap <- function(chrmap = NULL,
					  lingroup = NULL,
					  title = "",
					  linkage.width = 0.4,
					  label.x = "Distance (cM)",
					  label.chr = NULL,
					  cex.label.chr = 0.7,
					  marker.color = "deepskyblue3",
					  marker.count.color = "deepskyblue3",
					  draw.border = TRUE,
					  fill.color = c(255, 0, 0, 255),
					  highlight.peak = NULL,
					  show.axis = FALSE,
					  show.marker.count = FALSE,
					  cex.marker.count = 0.7,
					  marker.count.width = 5,
					  color.highlight.peak = "red",
					  border = FALSE,
					  border.linetype = "solid",
					  border.color = "black",
					  border.linewidth = 1,
					  ...){

		  # error handling
		  if (is.null(chrmap)) {
			stop("No marker/linkage group table specified")
		  }

		  if (length(lingroup) > length(table(chrmap$chr))) {
			lingroup <- lingroup[1:length(table(chrmap$chr))]
			warning("Requested linkage groups to draw exceeded actual number of linkage groups in table. \n Linkage groups were limited to maximum number available in provided genetic map.")
		  }

		  # declare default variables
		  TelomereSize <- linkage.width * 100
		  plotSizeX <- length(lingroup) * 80
		  plotSizeY <- 1000

		  # calculate and populate original table with absolute positions of every marker and linkage group
		  locations <- placements(chrmap, lingroup, plotSizeX, plotSizeY, TelomereSize)
		  
		  # store midpoints of drawn linkage groups
		  mid <- unique(locations$leftborder) + (TelomereSize / 2)

		  # set default marker color
		  locations$color <- marker.color

		  # plot blank area
		  plot(c(-100, plotSizeX),
			   c(-100, plotSizeY + 200),
			   xlim = c(0, plotSizeX),
			   type = "n",
			   xaxt = "n",
			   yaxt = "n",
			   bty = "n",
			   xlab = "",
			   ylab = "",
			   main = title,
			   ...)

		  # show axis
		  if (show.axis == TRUE) {
			mtext(label.x, 2, 2)
			maxcm <- max(locations$cM)
			scale(maxcm)
		  }

		  # add linkage group label
		  if (!is.null(label.chr)) {
			# check if provided linkage group labels match number of requested number of linkage groups
			# if not: restrict to first x elements
			if (length(label.chr) != length(lingroup)){
			  label.chr = label.chr[1:length(lingroup)]
			  warning("Provided number of linkage group labels does not match actual number of given linkage groups.")
			}
			# if range is specified
			if(is.numeric(label.chr)){
				label.chr = names(table(locations$chr))
			}
			else{
				label.chr = label.chr
			}
			text(x = mid, y = -100, labels = label.chr, cex = cex.label.chr, adj = 0.5)
		  }

		  # add marker itself on plot
		  rect(locations$leftborder,
			   locations$startabsolute,
			   locations$rightborder,
			   locations$endabsolute,
			   border = locations$color)

		  if (draw.border){
			# add linkage group segments
			# pull linkage group coordinates out of 'locations' dataframe
			borders <- locations[!duplicated(locations$leftborder), c("leftborder", "rightborder", "height")]

			# draw linkage groups on resulting border coordinates
			segments(borders$leftborder, plotSizeY - borders$height, borders$leftborder, plotSizeY)
			segments(borders$rightborder, plotSizeY - borders$height, borders$rightborder, plotSizeY)

			# draw telomeres on plot
			for (i in 1:length(lingroup)) {
			  telomere("top", borders$leftborder[i] + (TelomereSize / 2), plotSizeY, TelomereSize / 2)
			  telomere("bottom", borders$leftborder[i] + (TelomereSize / 2), (plotSizeY - borders$height[i]), TelomereSize / 2)
			}
		  }

		  if (show.marker.count) {
			# draw numerical marker count above respective linkage groups
			marker.count.label = as.vector(table(locations$chr))[1:length(lingroup)]
			text(x = mid, y = 1060, labels = marker.count.label, cex = cex.marker.count, adj = 0.5)
			
			# calculate relative height of marker count
			emptyspace = 100
			relcount = (marker.count.label * emptyspace) / max(marker.count.label)
			
			# plot visualization of numerical representation above respective linkage groups
			segments(x0 = mid,
					 y0 = plotSizeY + 100,
					 x1 = mid,
					 y1 = plotSizeY + 100 + relcount,
					 lwd = marker.count.width,
					 col = marker.count.color)
		  }
		  if(border){
			box(col = border.color,
				lty = border.linetype, 
				lwd = border.linewidth)
		  }
  }
