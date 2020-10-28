# gmap
An R package to visualize genetic maps.


## Installation
### Development version
So far, gmap is only available on GitHub and not on CRAN.

```r
# use devtools to install the development version
devtools::install_github("mschemmel/gmap")
```

## Usage
```r
# load package
library(gmap)

# import genetic map
genmap <- read.map("/examples/map.txt")

# plot genetic map with requested linkage groups
# store IDs of linkage groups
linkagegroup <- c("lg0", "lg1", "lg2", "lg3", "lg4") 

# minimal example
plot.map(genmap, linkagegroup)

# more advanced plotting
plot.map(genmap,
         linkagegroup, 
         title = "Organism", 
         marker.color = "aquamarine3",
         show.marker.count = TRUE,
         marker.count.color = "gray50",
         show.axis = TRUE)
```

For more detailed information see the wiki.

## Example

<p align="center">
<img src="/img/example.svg" width:"50%">
</p>

## TODO:
- [ ] check y axis (show.axis = TRUE)
- [x] represent counter label as relative value (prevent to blast empty space)
