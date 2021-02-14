#' Conclude position of linkage group on plot area
#' 
#' @param dfori Original data frame
#' @param chromosomes Character vector of requested linkage groups
#' @param xsize X size of plot area
#' @param ysize Y size of plot area
#' @param telsize Value of telomere size (Default = 40)
#' @return Modified data frame extended by positional values
#' @examples
#' placements(dfori, chromosomes, xsize, ysize, telsize)
#' @export
placements <- function(dfori, chromosomes, xsize, ysize, telsize){
  # prepare data frame of calculated locations
  targets_chr <- data.frame(targets = as.character(chromosomes),
                            leftborder = as.numeric(linkage.group.position(xsize, length(chromosomes))),
                            rightborder = as.numeric(linkage.group.position(xsize, length(chromosomes)) + telsize),
                            size = round(as.numeric(tapply(dfori$cM, dfori$chr, max)[chromosomes]),1))
  
  targets_chr$height <- round((900 * (targets_chr$size / max(targets_chr$size))), 1)	
   
  # prepare main table of requested chromosomes
  df <- merge(dfori, targets_chr, by.x = "chr", by.y = "targets")
  df <- df[df$chr %in% targets_chr$targets, ]

  # calculate marker position
  df$startabsolute <- round((ysize - (df$height * (df$cM / df$size))), 1)
  df$endabsolute <- round((ysize - (df$height * ((df$cM + 0.01) / df$size))), 1)

  # format conversion NEEDED to display correct linkage groups afterwards 
  df$chr <- as.character(df$chr)
  df$marker <- as.character(df$marker)

  return(df)
}


