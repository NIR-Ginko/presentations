#! /usr/local/bin/Rscript --vanilla

library(docstring)
library(plyr)
library(ggplot2)
library(rgl)
library(rayshader)

filter_data <- function(csv_data) {
  csv_data$opn <- as.Date(csv_data$Opened, format = "%Y-%m-%d")
  tab <- table(cut(csv_data$opn, "month"))
  #str(tab)
  #str(bugzilla_tsd)
  #filtered_tsd <- count(bugzilla_tsd, vars = "opn")
  #str(filtered_tsd)

  group_tsd <- data.frame(Date = format(as.Date(names(tab)), "%Y-%m-%d"), Freq = as.vector(tab))
  group_tsd$op <- as.Date(group_tsd$Date, format = "%Y-%m-%d")
  str(group_tsd)
  return(group_tsd)
}

render_ggplot <- function(tsd) {
  tsd_ggplot <- ggplot2::ggplot(data = tsd) +
    ggplot2::labs(x = "Date", y = "Join requests", title = "Join requests") +
    #ggplot2::geom_area(ggplot2::aes(x = op, y = Freq, fill="blue")) +
    ggplot2::geom_point(ggplot2::aes(x = op, y = Freq)) +
    ggplot2::scale_color_continuous()
    #ggplot2::theme_classic() +
    #ggplot2::theme(legend.position = "none")
  ggplot2::ggsave("ggplot.png")
  print(tsd_ggplot)
  return(tsd_ggplot)
}

ggplot_rayshader <- function(ggdata) {
  rayshader::plot_gg(ggdata,multicore=TRUE,width=3,height=3,scale=500)
  #filename_map = tempfile()
  #write_png(filename_map, ggp)
  #render_snapshot()
}

print_join_requests <- function(bugzilla_tsd) {
  group_tsd <- filter_data(bugzilla_tsd)
  ggtsd <- render_ggplot(group_tsd)
  ggplot_rayshader(ggtsd)
}

main <- function() {
	setwd("./")
	join_requests <- read.csv(file = "join-bugs.csv", colClasses = c("NULL", NA, "NULL", "NULL", "NULL", "NULL", "NULL", NA, "NULL", NA, NA))
	print_join_requests(join_requests)
}

main()

