

<!-- README.md is generated from README.Rmd. Please edit that file -->

# biblegatewayr

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/biblegatewayr.png)](https://cran.r-project.org/package=biblegatewayr)
<!-- badges: end -->

The `biblegatewayr` package provides functions to interact with the
BibleGateway web page. It includes `get_bible_verse` to retrieve
specific verses by canonical reference (e.g., “John 3:16”) and
`find_bible_verse` to search for verses containing specific text. Both
functions support multiple Bible versions and return formatted output,
making it easy to incorporate Bible verses into markdown documents.

## Installation

You can install the development version of `biblegatewayr` from
[GitHub](https://github.com/angelfelizr/biblegatewayr) with:

``` r
# install.packages("devtools")
devtools::install_github("angelfelizr/biblegatewayr")
```

Or install the latest version from CRAN:

``` r
install.packages("biblegatewayr")
```

## Examples

### Get a Specific Verse

This example demonstrates how to get a specific verse using
`get_bible_verse`.

``` r
library(biblegatewayr)

# Get the verse John 3:16
get_bible_verse("Juan 3:16") |> cat()
```

> ***Juan 3:16**: Porque de tal manera amó Dios al mundo, que ha dado a
> su Hijo unigénito, para que todo aquel que en él cree, no se pierda,
> mas tenga vida eterna.*

``` r

# Get the verse Psalm 23
get_bible_verse("Salmos 23")
```

\[1\] “\> ***Salmos 23**: <sup>**1**</sup> Jehová es mi pastor; nada me
faltará. <sup>**2**</sup> En lugares de delicados pastos me hará
descansar; Junto a aguas de reposo me pastoreará. <sup>**3**</sup>
Confortará mi alma; Me guiará por sendas de justicia por amor de su
nombre. <sup>**4**</sup> Aunque ande en valle de sombra de muerte, No
temeré mal alguno, porque tú estarás conmigo; Tu vara y tu cayado me
infundirán aliento. <sup>**5**</sup> Aderezas mesa delante de mí en
presencia de mis angustiadores; Unges mi cabeza con aceite; mi copa está
rebosando. <sup>**6**</sup> Ciertamente el bien y la misericordia me
seguirán todos los días de mi vida, Y en la casa de Jehová moraré por
largos días.*”

### Search for Verses

This example demonstrates how to search for verses containing specific
text using `find_bible_verse`.

``` r
# Search for verses containing "el amor es paciente"
find_bible_verse("el amor es paciente", version = "NTV") |> cat(sep = "\n\n")
```

> ***1 Corintios 13:4**: El amor es paciente y bondadoso. El amor no es
> celoso ni fanfarrón ni orgulloso*

> ***Nehemías 9:30**: En tu amor fuiste paciente con ellos durante
> muchos años. Enviaste tu Espíritu, quien les advertía por medio de los
> profetas. ¡Pero aun así no quisieron escuchar! Entonces nuevamente
> permitiste que los pueblos de la tierra los conquistaran;*

> ***1 Corintios 13:4**: El amor es paciente y bondadoso. El amor no es
> celoso ni fanfarrón ni orgulloso*

> ***2 Pedro 3:9**: En realidad, no es que el Señor sea lento para
> cumplir su promesa, como algunos piensan. Al contrario, es paciente
> por amor a ustedes. No quiere que nadie sea destruido; quiere que
> todos se arrepientan.*

``` r

# Search for verses containing "fe esperanza amor" in the NTV version
find_bible_verse("fe esperanza amor", version = "NTV")
```

\[1\] “\> ***1 Corintios 13:7**: El amor nunca se da por vencido, jamás
pierde la fe, siempre tiene esperanzas y se mantiene firme en toda
circunstancia.*” \[2\] “\> ***1 Corintios 13:13**: Tres cosas durarán
para siempre: la fe, la esperanza y el amor; y la mayor de las tres es
el amor.*”

## Main components

This package contains two main functions:

- `get_bible_verse()`: Retrieves a specific Bible verse by its reference
  (e.g., “John 3:16”).
- `find_bible_verse()`: Searches for Bible verses based on a text query.

Both functions allow you to specify the Bible version. For more details
please refer to the function documentation with `?get_bible_verse` or
`?find_bible_verse`.
