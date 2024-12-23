fill_na <- function(x) {
  x_not_missing <- !is.na(x)
  x_not_missing_i <- which(x_not_missing)

  # Replacing value
  x <- x[x_not_missing_i][cumsum(x_not_missing)]
  return(x)
}


to_sentence <- function(x) {

  new_x <- gsub("(?<=\\.|!|\\?|^)(\\s*)([a-z])", "\\1\\U\\2", tolower(x), perl = TRUE)
  new_x <- gsub("\\bi\\b", "I", new_x)

  return(new_x)
}
