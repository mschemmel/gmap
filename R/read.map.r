#' @export
read.map <- function(file = NULL, ...) {
    # error handling
    if (is.null(file)) {
      stop("No input file specified.")
    }

    # read file containing genetic map
    init <- read.table(file, ...)

    if (ncol(init) == 3) {
      colnames(init) <- c("marker", "chr", "cM")
    } else {
      head(init)
      stop("Input table must contain at least 3 columns ('marker','lingroup','cM').")
    }
    return(init)
}
