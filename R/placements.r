# create data frame of requested chromosomes
placements <- function(df, chromosomes, xsize, ysize, telsize){
  targets_chr <- data.frame(targets = as.character(names(table(df$chr))[chromosomes]),
                            leftborder = as.numeric(calculate.chromosome.position(xsize, length(chromosomes))),
                            rightborder = as.numeric(calculate.chromosome.position(xsize, length(chromosomes)) + telsize),
                            size = as.numeric(tapply(df$cM, df$chr, max)[chromosomes]))
  targets_chr$height <- 900 * (targets_chr$size / max(targets_chr$size))

  # prepare main table of requested chromosomes
  df <- df[df$chr %in% targets_chr$targets, ]
  df <- merge(df, targets_chr, by.x = "chr", by.y = "targets", full = TRUE)

  # calculate marker position
  df$startabsolute <- ysize - (df$height * (df$cM / df$size))
  df$endabsolute <- ysize - (df$height * ((df$cM + 0.01) / df$size))

  return(df)
}


