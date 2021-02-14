#' Function to read genetic/linkage map
#' 
#' @param file Filepath of genetic/linkage map
#' @return Correctly formatted genetic/linkage map
#' @examples
#' read.map("your/path/map.txt")
#' @importFrom utils read.table head
#' @export
read.map <- function(file = NULL) {
    # error handling
    if (is.null(file)) {
      stop("No input file specified.")
    }

    # read file containing genetic map
    init <- read.table(file, sep = "\t", header = FALSE)

    if (ncol(init) == 3) {
      colnames(init) <- c("marker", "chr", "cM")
    } else {
      head(init)
      stop("Input table must contain at least 3 columns ('marker','lingroup','cM').")
    }
    return(init)
}
