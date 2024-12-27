#' Find Bible Verses from BibleGateway
#'
#' This function searches for Bible verses using the BibleGateway web site based on a text query.
#' It returns the formatted verse text with context.
#'
#' @param text_to_find A character string representing the text to search for in the Bible.
#'   Spaces will be converted to '+' for the URL.
#' @param version A character string specifying the Bible version to use (e.g., "RVR1960", "NIV", "ESV").
#'   Defaults to "RVR1960".
#'
#' @return Invisibly returns a character vector with the formatted Bible verse(s) found,
#'         or NULL if no verses are found. The formatted verses are also printed to the console.
#'
#' @examples
#' if(interactive()){
#' # Search for a single verse (printing to console)
#' find_bible_verse("el amor es pasciente")
#'
#' # Search for a verse and capture the result
#' result <- find_bible_verse("fe esperanza amor")
#' # Print result captured.
#' cat(result, sep = "\n")
#'
#' # Example of no results
#' find_bible_verse("this_is_a_non_sense_query")
#' }
#' @export
find_bible_verse <- function(text_to_find, version = "RVR1960") {
  # URL Construction and Request
  url <- paste0("https://www.biblegateway.com/quicksearch/?quicksearch=",
                gsub(x = text_to_find, pattern = "\\s+", replacement = "\\+"),
                "&version=", version)

  response <- tryCatch({
    url |>
      httr2::request() |>
      httr2::req_perform() |>
      httr2::resp_body_html()
  }, error = function(e) {
    warning("Error fetching data from Bible Gateway: ", e$message)
    return(NULL) # Return NULL on error
  })

  if (is.null(response)) {
    message("No verses found.")
    return(invisible(NULL))
  }

  # Extract Bible Verse Elements
  bible_elements <-
    rvest::html_elements(response,
                         xpath = '//*[(@class="bible-item" or @class="row bible-item") and @data-osis]')

  if (length(bible_elements) == 0) {
    message("No verses found for the given query.")
    return(invisible(NULL))
  }

  # Extract verse indices
  verse_index <-
    rvest::html_elements(bible_elements, ".bible-item-title") |>
    rvest::html_text()

  # Extract and clean verse text
  verse_text <-
    rvest::html_elements(bible_elements, ".bible-item-text") |>
    rvest::html_text() |>
    gsub(pattern = "^\n| ?In Context.*", replacement = "")

  # Format the extracted verses
  formatted_text <-
    paste0("__", verse_index, "__: ", verse_text) |>
    paste0("> *", a = _, "*")

  return(formatted_text)

}
