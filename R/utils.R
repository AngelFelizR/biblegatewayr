fill_na <- function(x) {
  x_not_missing <- !is.na(x)
  x_not_missing_i <- which(x_not_missing)

  # Replacing value
  x <- x[x_not_missing_i][cumsum(x_not_missing)]
  return(x)
}
