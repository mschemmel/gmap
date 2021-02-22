[![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Build Status](https://travis-ci.org/mschemmel/gmap.svg?branch=master)](https://travis-ci.org/mschemmel/gmap)
[![](https://img.shields.io/github/languages/code-size/mschemmel/gmap.svg)](https://github.com/mschemmel/gmap)
[![](https://img.shields.io/github/last-commit/mschemmel/gmap.svg)](https://github.com/mschemmel/gmap/commits/master)
[![Codecov test coverage](https://codecov.io/gh/mschemmel/gmap/branch/master/graph/badge.svg)](https://codecov.io/gh/mschemmel/gmap?branch=master)

# gmap
An R package to visualize genetic maps.


## Installation
### Development version
So far, gmap is only available on GitHub because it is still in __development stage__.

```r
# use devtools to install the development version
library(devtools)
devtools::install_github("mschemmel/gmap")
```

## Usage
```r
# load package
library(gmap)

# import genetic map
# ------------------------------
# marker  | linkage group | cM
# ------------------------------
# marker1 |     lg01      | 0
# marker2 |     lg01      | 0.4
# marker3 |     lg01      | 0.8
# ...     |     ...       | ...
linmap <- read.map("inst/extdata/map.txt")

# store IDs of linkage groups to plot 
linkagegroup <- c("lg0", "lg1", "lg2", "lg3", "lg4") 

# minimal example
# plot genetic map with requested linkage groups
genmap(linmap, linkagegroup)
```

For more detailed information see the wiki (in planning).

## Examples
```r
genmap(linmap,
       linkagegroup, 
       title = "Organism", 
       marker.color = "aquamarine3",
       show.marker.count = TRUE,
       marker.count.color = "gray50",
       show.axis = TRUE)
```
<p align="center">
<img src="/inst/extdata/example.svg" width:"50%">
</p>

### Add highlighting and annotation label
```r
genmap(linmap,
       linkagegroup, 
       title = "Organism", 
       marker.color = "aquamarine3",
       show.marker.count = TRUE,
       marker.count.color = "gray50",
       show.axis = TRUE,
       label.chr = c(1:12),
       highlight.marker = list(firebrick = c("marker150", "marker222","marker250", "marker251"),
                               gold = c("marker89", "marker100"),
                               brown = linmap$marker[800:810],
                               red = linmap$marker[1100:1110]))
```
<p align="center">
<img src="/inst/extdata/example2.svg" width:"50%">
</p>

