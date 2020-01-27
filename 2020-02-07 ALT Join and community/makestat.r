#! /usr/local/bin/Rscript --vanilla

library(docstring)
library(plyr)
library(ggplot2)

print_join_requests <- function(bugzilla_tsd) {
	#str(bugzilla_tsd)
  bugzilla_tsd$opn <- as.Date(bugzilla_tsd$Opened, format = "%Y-%m-%d")
  tab <- table(cut(bugzilla_tsd$opn, "month"))
  #str(tab)
  #str(bugzilla_tsd)
  #filtered_tsd <- count(bugzilla_tsd, vars = "opn")
  #str(filtered_tsd)

  group_tsd <- data.frame(Date = format(as.Date(names(tab)), "%Y-%m-%d"), Freq = as.vector(tab))
  group_tsd$op <- as.Date(group_tsd$Date, format = "%Y-%m-%d")
  str(group_tsd)
  
  tsd_ggplot <- ggplot2::ggplot(data = group_tsd) +
  	ggplot2::geom_line(ggplot2::aes(x = op, y = Freq)) +
  	ggplot2::labs(x = "Date", y = "Join requests", title = "Join requests") +
  	ggplot2::theme_minimal()
  print(tsd_ggplot)
}

main <- function() {
	setwd("./")
	join_requests <- read.csv(file = "join-bugs.csv", colClasses = c("NULL", NA, "NULL", "NULL", "NULL", "NULL", "NULL", NA, "NULL", NA, NA))
	print_join_requests(join_requests)
}

main()

