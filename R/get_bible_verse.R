#' Get a Specific Bible Verse from BibleGateway
#'
#' This function retrieves a specific Bible verse using the BibleGateway web site
#' based on a verse reference query. It returns the formatted verse text.
#'
#' @param search A character string representing the Bible verse reference to search for (e.g., "John 3:16", "Psalm 23").
#'   Spaces will be converted to '+' for the URL.
#' @param version A character string specifying the Bible version to use (e.g., "RVR1960", "NIV", "ESV").
#'   Defaults to "RVR1960".
#'
#' @return Invisibly returns a character string with the formatted Bible verse, or NULL if no verse is found.
#' The formatted verse is also printed to the console.
#'
#' @examples
#' if(interactive()){
#' # Get a specific verse (printing to console)
#' get_bible_verse("Juan 3:16")
#'
#' # Get a verse with a different version and capture the output
#' result <- get_bible_verse("Salmos 23")
#' cat(result)
#'
#' # Example of no results.
#' get_bible_verse("this is a non existing book 1:1")
#' }
#' @export
get_bible_verse <- function(search, version = "RVR1960") {
  # URL Construction and Request
  url <- paste0("https://www.biblegateway.com/passage/?search=",
                gsub(x = search, pattern = "\\s+", replacement = "\\+"),
                "&version=", version)

  response <- tryCatch({
    url |>
      httr2::req_url(req = httr2::request("https://www.biblegateway.com")) |>
      httr2::req_perform() |>
      httr2::resp_body_html()
  }, error = function(e) {
    warning("Error fetching data from Bible Gateway: ", e$message)
    return(NULL) # Return NULL on error
  })

  if (is.null(response)) {
    message("No verse found for the given query.")
    return(invisible(NULL))
  }

  # Extract the verse elements
  verse_elements <-
    rvest::html_elements(response, xpath = '//*[contains(@class, "result-text-style-normal")]//p//span[contains(@class, "text")]')

  if(length(verse_elements) == 0){
    message("No verse found for the given query.")
    return(invisible(NULL))
  }


  # Extract and format verse index
  verse_index <-
    rvest::html_element(verse_elements, xpath = 'sup[@class="versenum"]') |>
    rvest::html_text(trim = TRUE) |>
    (\(x) c(ifelse(is.na(x[1L]), "1", x[1L]), x[-1L]))() |>
    fill_na() |>
    paste0("^**",a =  _, "**^")

  if(length(verse_index) == 1L) verse_index <- ""


  # Extract and clean verse text
  verse_text <-
    rvest::html_elements(verse_elements,
                         xpath = './/text()[not(ancestor::sup[@class="versenum"]) and not(ancestor::sup[@class="crossreference"])]') |>
    rvest::html_text() |>
    grep(pattern = "^\\d+.$", value = TRUE, invert = TRUE) |>
    # Pasting test if starting with space
    (\(x) tapply(x,
                 INDEX = cumsum(!grepl("^\\s", x)),
                 FUN = paste0,
                 collapse = "") )()

  # Pasting if verses are split in several lines
  if(any(table(verse_index) > 1L)){

    verse_text <-
      tapply(verse_text,
             INDEX = verse_index,
             FUN = paste0,
             collapse = " ") |>
      to_sentence()

  }

  # Removing any verse duplication
  verse_index <- unique(verse_index)

  # Format the output
  formatted_text <-
    paste(verse_index, verse_text) |>
    paste0(collapse = " ") |>
    paste0("__", search, "__: ", a = _) |>
    paste0("> *", a = _, "*")

  return(formatted_text)
}
