[![Build Status](https://travis-ci.org/mschemmel/gmap.svg?branch=master)](https://travis-ci.org/mschemmel/gmap)
"[![](https://img.shields.io/github/languages/code-size/mschemmel/gmap.svg)](https://github.com/mschemmel/gmap)"

# gmap
An R package to visualize genetic maps.


## Installation
### Development version
So far, gmap is only available on GitHub because it is still in __development stage__.

```r
# use devtools to install the development version
devtools::install_github("mschemmel/gmap")
```

## Usage
```r
# load package
library(gmap)

# import genetic map
linmap <- read.map("inst/extdata/map.txt")

# plot genetic map with requested linkage groups
# store IDs of linkage groups
linkagegroup <- c("lg0", "lg1", "lg2", "lg3", "lg4") 

# minimal example
genmap(linmap, linkagegroup)

# more advanced example
genmap(linmap,
       linkagegroup, 
       title = "Organism", 
       marker.color = "aquamarine3",
       show.marker.count = TRUE,
       marker.count.color = "gray50",
       show.axis = TRUE)
```

For more detailed information see the wiki (in planning).

## Example

<p align="center">
<img src="/inst/extdata/example.svg" width:"50%">
</p>
