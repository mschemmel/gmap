plot.map <- function(chrmap = NULL,
                      lingroup = NULL,
                      title = "",
                      chromosome.width = 0.4,
                      label.x = "Location (cM)",
                      label.chr = NULL,
                      cex.label.chr = 0.7,
                      marker.color = "deepskyblue3",
                      marker.count.color = "deepskyblue3",
                      draw.border = TRUE,
                      fill.color = c(255, 0, 0, 255),
                      highlight.peak = NULL,
                      highlight.lod = NULL,
                      show.axis = FALSE,
                      show.marker.count = FALSE,
                      cex.marker.count = 0.7,
                      color.highlight.lod = "deepskyblue1",
                      color.highlight.peak = "red",
                      show.lod = FALSE,
                      ...){

          # error handling
          if (is.null(chrmap)) {
            stop("No genome table specified")
          }

          if (length(lingroup) > length(table(chrmap$chr))) {
            lingroup <- lingroup[1:length(table(chrmap$chr))]
            warning("Requested linkage groups to draw exceeded actual number of linkage groups in table. \n Linkage groups were limited to maximum number available in provided genetic map.")
          }

          # declare default variables
          TelomereSize <- chromosome.width * 100
          plotSizeX <- length(lingroup) * 80
          plotSizeY <- 1000

          # calculate and populate original table with absolute positions of every marker and chromosome
          # the 'placements' function returns the main table used in the package
          locations <- placements(chrmap, lingroup, plotSizeX, plotSizeY, TelomereSize)
          print(head(locations))

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

          # show axis if requested
          if (show.axis == TRUE) {
            mtext(label.x,2,2)
            roundUp <- function(x,to=100) { to*(x%/%to + as.logical(x%%to)) }
            maxcm <- roundUp(max(locations$cM))
            axissteps <- 10
            axis(side = 2, at = rev(seq(0, 1000, (1000 / axissteps))), labels = seq(0, maxcm, (maxcm / axissteps)))
          }

          # add chromosome label if requested
          if (!is.null(label.chr)) {
            # check if provided chromosome labels match number of requested number of linkage groups
            # if not: restrict to first x elements
            if (length(label.chr) != length(lingroup)){
              label.chr = label.chr[1:length(lingroup)]
              warning("Provided number of chromosome labels does not match actual number of given linkage groups.")
            }
            text(x = mid, y = -100, labels = label.chr, cex = cex.label.chr, adj = 0.5)
          }

          # add marker color for highlighting and peak LOD values
          if (!is.null(highlight.lod)) {
            locations$color[locations$LOD > highlight.lod] <- color.highlight.lod
          }
          if (!is.null(highlight.peak)) {
            locations$color[locations$LOD > highlight.peak] <- color.highlight.peak
          }

          # add marker itself on plot
          rect(locations$leftborder,
               locations$startabsolute,
               locations$rightborder,
               locations$endabsolute,
               border = locations$color)

          if (draw.border){
            # add chromosome segments
            # pull chromosome coordinates out of 'locations' dataframe
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

          if (show.lod) {
            rect(locations$leftborder + 33,
                 locations$startabsolute,
                 locations$rightborder + 6,
                 locations$endabsolute,
                 border = discrete.scale(locations$LOD))
          }

          if (show.marker.count) {
            # draw numerical marker count above respective linkage groups
            marker.count.label = as.vector(table(locations$chr))[1:length(lingroup)]
            text(x = mid, y = 1050, labels = marker.count.label, cex = cex.marker.count, adj = 0.5)

            # plot visualization of numerical representation above respective linkage groups
            segments(x0 = mid,
                     y0 = plotSizeY + 100,
                     x1 = mid,
                     y1 = plotSizeY + 100 + marker.count.label,
                     lwd = 5,
                     col = marker.count.color)
          }
  }
