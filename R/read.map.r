#' read.map
#'
#' @description
#'
#' @param filepath
#'
#' @return datafram
#'
#' @examples genetic_map <- read.map("/path/to/genetic/map.txt)



read.map <- function(file = NULL, ...) {
    # error handling
    if (is.null(file)) {
      stop("No input file specified.")
    }

    # read file containing genetic map
    init <- read.table(file, ...)

    if (ncol(init) == 3) {
      colnames(init) <- c("marker", "chr", "cM")
      print("Information: No LOD Score provided in genetic map.")
    } else if (ncol(init) == 4) {
      colnames(init) <- c("marker", "chr", "cM", "LOD")
    } else {
      head(init)
      stop("Input table must contain at least 3 columns ('marker','lingroup','cM').")
    }

    # handle formatting errors
    #init$marker <- as.factor(init$marker)
    #init$chr <- as.character(init$chr)
    #init$cM <- as.numeric(as.character(init$cM))
    #init$LOD <- as.numeric(as.character(init$LOD))


    return(init)
}
