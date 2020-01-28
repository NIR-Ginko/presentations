#! /usr/local/bin/Rscript --vanilla

#require(devtools)

main <- function() {
	install.packages("docstring", repos = "http://cran.rstudio.com/")
	install.packages("plyr", repos = "http://cran.rstudio.com/")
	install.packages("ggplot2", repos = "http://cran.rstudio.com/")
	install.packages("RcppArmadillo", repos = "http://cran.rstudio.com/")
	install.packages("magick", repos = "http://cran.rstudio.com/")
	install.packages("rayshader", repos = "http://cran.rstudio.com/")
	#devtools::install_github("tylermorganwall/rayshader")
}

main()

