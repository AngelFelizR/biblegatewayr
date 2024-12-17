test_that("find_bible_verse works correctly", {
  # Test case 1: Mock a successful response with one verse
  mock_response_success_single <- function(req) {
    if (grepl("quicksearch=el\\+amor\\+es\\+pasciente", req$url)) {
      httr2::response(
        status_code = 200,
        headers = "Content-Type: text/html",
        body = '
<div class="content-section">
                        <div class="search-tools">
                            <input type="hidden" name="quicksearch" value="el amor es pasciente"><input class="dropdowns" type="submit" value="Change">                                                                                    <div class="mobile-rpp">
                                <div class="js-dropdowns">
                                    <span class="mobile-rpp-display"></span>
                                    <span class="dropdown-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 11.5 6.5" width="11.5" height="6.5"><title>dropdown</title><use xlink:href="#icon-dropdown"></use></svg>
</span>
                                </div>
                                <span> results per page</span>
                            </div>
                        </div>
                                            <div class="search-suggested-result"><h4 class="search-result-heading">Suggested result<div class="vote" data-osis="1Cor.13.4"><span class="btn helpful" data-key="093cd3592eaa09ff213ae3f3a122aade">Helpful</span><span class="btn unhelpful" data-key="093cd3592eaa09ff213ae3f3a122aade">Not Helpful</span></div><div class="vote-message">Thank you for your feedback. <span class="undo" data-key="093cd3592eaa09ff213ae3f3a122aade">Undo</span>.</div></h4><div class="text-html"><article class="bible-item" data-osis="1Cor.13.4"><span class="bible-item-title-wrap"><a class="bible-item-title" href="/passage/?search=1%20Corintios%2013%3A4&amp;version=RVR1960">1 Corintios 13:4</a></span><br>
<div class="bible-item-text"><b>El</b> <b>amor</b> <b>es</b> sufrido, <b>es</b> benigno; <b>el</b> <b>amor</b> no tiene envidia, <b>el</b> <b>amor</b> no <b>es</b> jactancioso, no se envanece; <div class="bible-item-extras"><a href="/passage/?search=1 Corintios%2013%3A3%2D5&amp;version=RVR1960">In Context</a>
 | <a href="/passage/?search=1%20Corintios%2013&amp;version=RVR1960">Full Chapter</a>
 | <a href="/verse/en/1%20Corintios%2013%3A4">Other Translations</a>
</div><!-- .bible-item-extras -->
</div><!-- .bible-item-text --></article>
</div></div><!-- .search-suggested-result --><p>Sorry, we didn’t find any results for your search. Please try the following:</p><ul><li>Double-check spelling, especially people and place names.</li><li>Make sure there are spaces between words. Bible Gateway treats “nameoftheFather” and “name of the Father” differently.</li><li>Use fewer words in your search, especially if you’re unsure of the exact phrase. For example, “baptizing name Father” and “baptizing them in the name of the Father” will both return Matthew 28:19; however, the latter leaves a greater chance for spelling and syntax errors.</li><li>Retry your search in another translation.</li></ul><br>                      <div class="info-viewer-footer d-flex">
                          <div class="iv-prev-page">
                                                      </div>
                          <div class="iv-next-page">
                                                      </div>
                        </div>
                      </div>
      '
      )
    } else {
      NULL
    }
  }


  httr2::with_mocked_responses(mock_response_success_single, {
    result <- find_bible_verse("el amor es pasciente")
    expect_type(result, "character")
    expect_length(result, 1)
    expect_match(result, "> \\*__1 Corintios 13:4__: El amor es sufrido, es benigno; el amor no tiene envidia, el amor no es jactancioso, no se envanece;\\*")
  })


  # Test case 2: Mock a successful response with multiple verses
  mock_response_success_multiple <- function(req) {
    if (grepl("quicksearch=fe\\+esperanza\\+amor", req$url)) {
      httr2::response(
        status_code = 200,
        headers = "Content-Type: text/html",
        body = '
<div class="search-result-list"><div class="text-html"><ol start="1"><li class="row bible-item" data-osis="1Cor.13.13"><div class="bible-item-title-wrap col-sm-3"><a class="bible-item-title" href="/passage/?search=1%20Corintios%2013%3A13&amp;version=RVR1960">1 Corintios 13:13</a></div>
<div class="bible-item-text col-sm-9">
Y ahora permanecen la <b>fe</b>, la <b>esperanza</b> y el <b>amor</b>, estos tres; pero el mayor de ellos es el <b>amor</b>.<div class="bible-item-extras"><a href="/passage/?search=1%20Corintios%2013%3A12%2D13&amp;version=RVR1960">In Context</a>
 | <a href="/passage/?search=1%20Corintios%2013&amp;version=RVR1960">Full Chapter</a>
 | <a href="/verse/es/1%20Corintios%2013%3A13">Other Translations</a>
</div><!-- .bible-item-extras -->
</div><!-- bible-item-text -->
</li>
<li class="row bible-item" data-osis="1Thess.1.3"><div class="bible-item-title-wrap col-sm-3"><a class="bible-item-title" href="/passage/?search=1%20Tesalonicenses%201%3A3&amp;version=RVR1960">1 Tesalonicenses 1:3</a></div>
<div class="bible-item-text col-sm-9">
acordándonos sin cesar delante del Dios y Padre nuestro de la obra de vuestra <b>fe</b>, del trabajo de vuestro <b>amor</b> y de vuestra constancia en la <b>esperanza</b> en nuestro Señor Jesucristo.<div class="bible-item-extras"><a href="/passage/?search=1%20Tesalonicenses%201%3A2%2D4&amp;version=RVR1960">In Context</a>
 | <a href="/passage/?search=1%20Tesalonicenses%201&amp;version=RVR1960">Full Chapter</a>
 | <a href="/verse/es/1%20Tesalonicenses%201%3A3">Other Translations</a>
</div><!-- .bible-item-extras -->
</div><!-- bible-item-text -->
</li>
<li class="row bible-item" data-osis="1Thess.5.8"><div class="bible-item-title-wrap col-sm-3"><a class="bible-item-title" href="/passage/?search=1%20Tesalonicenses%205%3A8&amp;version=RVR1960">1 Tesalonicenses 5:8</a></div>
<div class="bible-item-text col-sm-9">
Pero nosotros, que somos del día, seamos sobrios, habiéndonos vestido con la coraza de <b>fe</b> y de <b>amor</b>, y con la <b>esperanza</b> de salvación como yelmo.<div class="bible-item-extras"><a href="/passage/?search=1%20Tesalonicenses%205%3A7%2D9&amp;version=RVR1960">In Context</a>
 | <a href="/passage/?search=1%20Tesalonicenses%205&amp;version=RVR1960">Full Chapter</a>
 | <a href="/verse/es/1%20Tesalonicenses%205%3A8">Other Translations</a>
</div><!-- .bible-item-extras -->
</div><!-- bible-item-text -->
</li>
</ol>
</div></div>
        '
      )
    } else {
      NULL
    }
  }
  httr2::with_mocked_responses(mock_response_success_multiple, {
    result <- find_bible_verse("fe esperanza amor")
    expect_type(result, "character")
    expect_length(result, 3)
    expect_match(result[1], "> *__1 Corintios 13:13__: Y ahora permanecen la fe, la esperanza y el amor, estos tres; pero el mayor de ellos es el amor.*", fixed = TRUE)
    expect_match(result[2], "> *__1 Tesalonicenses 1:3__: acordándonos sin cesar delante del Dios y Padre nuestro de la obra de vuestra fe, del trabajo de vuestro amor y de vuestra constancia en la esperanza en nuestro Señor Jesucristo.*", fixed = TRUE)
    expect_match(result[3], "> *__1 Tesalonicenses 5:8__: Pero nosotros, que somos del día, seamos sobrios, habiéndonos vestido con la coraza de fe y de amor, y con la esperanza de salvación como yelmo.*", fixed = TRUE)
  })

  # Test case 3: Mock a response with no verses found
  mock_response_no_verses <- function(req) {
    if (grepl("quicksearch=this_is_a_non_sense_query", req$url)) {
      httr2::response(
        status_code = 200,
        headers = "Content-Type: text/html",
        body = '
<div class="content-section">
                        <div class="search-tools">
                            <input type="hidden" name="quicksearch" value="this_is_a_non_sense_query"><input class="dropdowns" type="submit" value="Change">                                                                                    <div class="mobile-rpp">
                                <div class="js-dropdowns">
                                    <span class="mobile-rpp-display"></span>
                                    <span class="dropdown-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 11.5 6.5" width="11.5" height="6.5"><title>dropdown</title><use xlink:href="#icon-dropdown"></use></svg>
</span>
                                </div>
                                <span> results per page</span>
                            </div>
                        </div>
                                            <p>Sorry, we didn’t find any results for your search. Please try the following:</p><ul><li>Double-check spelling, especially people and place names.</li><li>Make sure there are spaces between words. Bible Gateway treats “nameoftheFather” and “name of the Father” differently.</li><li>Use fewer words in your search, especially if you’re unsure of the exact phrase. For example, “baptizing name Father” and “baptizing them in the name of the Father” will both return Matthew 28:19; however, the latter leaves a greater chance for spelling and syntax errors.</li><li>Retry your search in another translation.</li></ul><br>                      <div class="info-viewer-footer d-flex">
                          <div class="iv-prev-page">
                                                      </div>
                          <div class="iv-next-page">
                                                      </div>
                        </div>
                      </div>
      '
      )
    }else {
      NULL
    }
  }

  httr2::with_mocked_responses(mock_response_no_verses, {
    result <- find_bible_verse("this_is_a_non_sense_query")
    expect_null(result)
  })

  # Test case 4: Mock a response with error
  mock_response_error <- function(req) {
    if (grepl("quicksearch=error", req$url)) {
      httr2::response(status_code = 500)
    } else {
      NULL
    }
  }

  httr2::with_mocked_responses(mock_response_error, {
    expect_warning(result <- find_bible_verse("error"), "Error fetching data from Bible Gateway")
    expect_null(result)
  })

})
