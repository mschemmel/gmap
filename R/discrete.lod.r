discrete.scale <- function(vec){
  colfunc<-colorRampPalette(rev(c("red", "lightblue", "green")))
  grp <- cut(vec, breaks=hist(vec, plot = FALSE)$breaks)
  grp <- colfunc(nrow(table(grp)))
  return(grp)
}


