require(reshape)
require(ggplot2)

#' Plots a contingency table.
contingency.table <- function(x, y, ...) {
	tab <- table(x, y)
	tab <- as.data.frame(tab, stringsAsFactors=FALSE)
	#TODO: check for NA names
	tab <- cast(tab, x ~ y, value='Freq')
	tot.row <- apply(tab, 1, sum)
	tot.col <- apply(tab, 2, sum)
	tot <- sum(tab)
	tab$Total <- tot.row
	tab[(nrow(tab) + 1),] <- c('Total', as.numeric(tot.col), tot)
	class(tab) <- c('contingency.table', 'data.frame')
	names(tab)[1] <- '' # TODO: use ... instead of x and y to get var names
	return(tab)
}

#' Print method.
#' @S3method print contingency.table
#' @method print contingency.table
print.contingency.table <- function(x, ...) {
	NextMethod(x, row.names=FALSE, ...)
}

plot.contingency.table <- function(x, legend='Percent', ...) {
	names(x)[1] <- 'x'
	x.long <- melt(x[1:(nrow(x)-1), 1:(ncol(x)-1)], id='x')
	x.long$value <- as.numeric(x.long$value)
	x.long$percent <- x.long$value / sum(x.long$value)
	p <- ggplot(x.long, aes(x=x, y=variable, fill=percent, 
					   label=paste0(value, ' (', round(100 * percent), '%)'))) +
		geom_tile() +
		geom_text() +
		scale_fill_gradient(legend, low='white', high='blue')
	return(p)
}
