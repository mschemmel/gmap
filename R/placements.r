# create data frame of requested chromosomes
placements <- function(df, chromosomes, xsize, ysize, telsize){
  targets_chr <- data.frame(targets = as.character(names(table(df$chr))[chromosomes]),
                            leftborder = as.numeric(calculate.chromosome.position(xsize, length(chromosomes))),
                            rightborder = as.numeric(calculate.chromosome.position(xsize, length(chromosomes)) + telsize),
                            size = round(as.numeric(tapply(df$cM, df$chr, max)[chromosomes])), 1)
  targets_chr$height <- round(900 * (targets_chr$size / max(targets_chr$size)), 1)	

  # prepare main table of requested chromosomes
  df <- df[df$chr %in% targets_chr$targets, ]
  df <- merge(df, targets_chr, by.x = "chr", by.y = "targets", full = TRUE)

  # calculate marker position
  df$startabsolute <- round(ysize - (df$height * (df$cM / df$size)), 1)
  df$endabsolute <- round(ysize - (df$height * ((df$cM + 0.01) / df$size)), 1)

  return(df)
}


