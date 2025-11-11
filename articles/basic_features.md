# Basic features

## Tidy Data Principles in `robonomistClient`

The `robonomistClient` package follows **tidy data principles** to
ensure that the returned datasets are easy to work with and ready for
analysis. This approach helps minimize data preparation time, enabling
analysts to focus on insights rather than wrangling data. Below are some
of the key principles used:

- **Long Format**: Data is returned in long format whenever possible.
  This means each row represents a single observation, making it ideal
  for use with popular analysis and visualization tools in R, such as
  `ggplot2` and the rest of the tidyverse.
- **Value Variable**: In the long format, the measured quantity is
  captured in a `value` variable that is always numeric. This ensures
  consistency across datasets and facilitates easy aggregation,
  summarization, and visualization.
- **Time Variable**: The time dimension is represented by a date
  variable of class `Date` or date and time of class `POSIXct`. A date
  variable is positioned consistently in the dataset for ease of use:
  - **First Day of the Period**: For date-based data (e.g., monthly,
    quarterly), the date represents *the first day of the period*. For
    example, “March 2024” is represented as `"2024-03-01"`, making it
    easy to sort and filter chronologically.
- **Variable Arrangement**: Categorical variables, which represent the
  grouping dimensions of the data (such as region, industry, or
  demographic group), are positioned **on the left side** of the
  dataset. Additional attributes related to observations may be
  positioned on the right side of the `value` variable. This arrangement
  ensures that categorical identifiers are easily distinguishable from
  the measurement variables and attributes, improving readability and
  simplifying analysis.
- **Consistency**: This tidy structure allows the data to seamlessly
  integrate with typical R workflows and tools for data science, such as
  `dplyr` and `tidyr`. By using consistent formatting, robonomistClient
  data can easily be reshaped, filtered, and summarized to suit a wide
  range of analytical needs.

## Overview of Datasources

The `robonomistClient` package is designed to simplify working with data
from a wide variety of datasources. It allows you to easily access data
in a standardized format, freeing you from worrying about how to extract
and wrangle data from different providers.

To see all available datasources:

``` r
library(robonomistClient)
#> Loaded robonomistClient 2.2.23
#> ℹ Set to connect wss://data.robonomist.app
#> 
#> ✔ Set to connect wss://data.robonomist.app [17ms]
#> 
#> 
#> 
#> 
#> Attaching package: 'robonomistClient'
#> 
#> 
#> The following object is masked from 'package:utils':
#> 
#>     data
datasources()
#> ℹ Connecting to robonomistServer at wss://data.robonomist.app
#> ✔ Connecting to robonomistServer at wss://data.robonomist.app [641ms]
#> 
#> ℹ Connected successfully to robonomistServer 2.10.2
#> ✔ Connected successfully to robonomistServer 2.10.2 [30ms]
#> 
#> ⠙ Requesting datasources
#> ✔ Requesting datasources [170ms]
#> # Robonomist Server Datasources
#>    dataset         title                                    languages datasource
#>    <r_dataset>     <chr>                                    <iso2>    <chr>     
#>  1 StatFin         Statistics Finland, StatFin database     fi,sv,en  StatFin   
#>  2 StatFin_Passii… Statistics Finland, StatFin archive dat… fi,sv,en  StatFin_P…
#>  3 Vero            Finnish Tax Administration statistical … fi,sv,en  Vero      
#>  4 ec              European Commission's Business and Cons… en        EC        
#>  5 kunnat          Key statistics of municipalities, Stati… fi,sv,en  KuntienAv…
#>  6 kunnat          Financial data reported by municipaliti… fi,sv,en  KuntienTa…
#>  7 paavo           Statistics Finland's Paavo database      fi,sv,en  Paavo     
#>  8 tulli           Finnish Customs, Uljas Statistical Data… fi,sv,en  Tulli     
#>  9 luke            Statistics database of Natural Resource… fi,sv,en  Luke      
#> 10 etk             Finnish Centre for Pensions' statistica… fi,sv,en  ETK       
#> 11 eurostat        Eurostat database                        en,de,fr  eurostat  
#> 12 ecb             ECB Statistical Data Warehouse           en        ECB       
#> 13 bundesbank      Deutsche Bundesbank time series database en,de     Bundesbank
#> 14 oecd            OECD database                            en        OECD4     
#> 15 wb              World Bank Open Data                     en        WB        
#> 16 hsa             Greater Helsinki Open Statistical Datab… fi,sv,en  HSA       
#> 17 helymp          Helsinki environmental statistics        fi        Helsingin…
#> 18 helhyv          Helsinki wellbeing statistics            fi        Helsingin…
#> 19 nordstat        Nordstat                                 fi,en,sv  Nordstat  
#> 20 covid           European Centre for Disease Prevention … en        ECDC      
#> 21 vipunen         Vipunen, Education Statistics Finland    fi        Vipunen   
#> 22 epirapo         THL Epirapo COVID-19 database            fi        Epirapo   
#> 23 sotkanet        Sotkanet indicator bank of the Finnish … fi,en,sv  Sotkanet  
#> 24 maakoto         Immigrants and integration statistics, … fi,sv,en  Maakoto   
#> 25 koto            Integration database, Finnish Ministry … fi,sv,en  Koto      
#> 26 toimipaikkalas… Toimipaikkalaskuri database, Statitstic… fi        Toimipaik…
#> 27 kokeelliset     Statistics Finland's experimental stati… fi,sv,en  Kokeellis…
#> 28 traficom        Traficom statistics database             fi,sv,en  Traficom  
#> 29 tieliikenneonn… Road traffic accidents statistical data… fi,sv,en  Tieliiken…
#> 30 rudolf          Rudolf statistical database, Business F… fi,en     Rudolf    
#> # ℹ 30 more rows
#> # ℹ 1 more variable: available <lgl>
```

The package keeps the listed datasources automatically up-to-date,
ensuring that you always access the most current versions.

## Working with Data Tables

All content within `robonomistClient` is organized as data tables, which
are typically tibble objects. The
[`data()`](https://robonomist.github.io/robonomistClient/reference/data.md)
function is a flexible way to explore and retrieve data tables.

### Listing Data Tables

To list all available data tables:

``` r
data()
#> ⠙ Requesting data
#> ℹ Object retrieved from client cache (valid until 2025-11-11 13:39:49.513383).
#> ⠙ Requesting data✔ Requesting data [11ms]
#> # Robonomist Database search results
#>    id                                      title                           lang 
#>    <r_id>                                  <chr>                           <chr>
#>  1 StatFin/adopt/statfin_adopt_pxt_11lv.px 11lv -- Adoptiot lapsen syntym… fi   
#>  2 StatFin/adopt/statfin_adopt_pxt_13qh.px 13qh -- Adoptiot adoptoitavan … fi   
#>  3 StatFin/aku/statfin_aku_pxt_12dz.px     12dz -- Aikuiskoulutukseen osa… fi   
#>  4 StatFin/aku/statfin_aku_pxt_12ea.px     12ea -- Aikuiskoulutukseen osa… fi   
#>  5 StatFin/aku/statfin_aku_pxt_14bu.px     14bu -- Aikuiskoulutukseen osa… fi   
#>  6 StatFin/aku/statfin_aku_pxt_14bv.px     14bv -- Aikuiskoulutukseen osa… fi   
#>  7 StatFin/ava/statfin_ava_pxt_12a9.px     12a9 -- Perusopetuksen vuosilu… fi   
#>  8 StatFin/ava/statfin_ava_pxt_12aa.px     12aa -- Aikuisten perusopetuks… fi   
#>  9 StatFin/ava/statfin_ava_pxt_12ad.px     12ad -- Toisen asteen opiskeli… fi   
#> 10 StatFin/ava/statfin_ava_pxt_139d.px     139d -- Toisen asteen opiskeli… fi   
#> 11 StatFin/ava/statfin_ava_pxt_139p.px     139p -- Osuudet toisen asteen … fi   
#> 12 StatFin/ava/statfin_ava_pxt_14cd.px     14cd -- Perusopetuksen vuosilu… fi   
#> 13 StatFin/ava/statfin_ava_pxt_159d.px     159d -- Katsomusaineiden opisk… fi   
#> 14 StatFin/ava/statfin_ava_pxt_159n.px     159n -- Katsomusaineiden opisk… fi   
#> 15 StatFin/alyr/statfin_alyr_pxt_11g5.px   11g5 -- Julkisyhteisöjen toimi… fi   
#> 16 StatFin/alyr/statfin_alyr_pxt_11ge.px   11ge -- Julkisyhteisöjen toimi… fi   
#> 17 StatFin/alyr/statfin_alyr_pxt_11gh.px   11gh -- Julkisyhteisöjen toimi… fi   
#> 18 StatFin/alyr/statfin_alyr_pxt_13wv.px   13wv -- Yritysten toimipaikat … fi   
#> 19 StatFin/alyr/statfin_alyr_pxt_13ww.px   13ww -- Yritysten toimipaikat … fi   
#> 20 StatFin/alyr/statfin_alyr_pxt_13wx.px   13wx -- Yritysten toimipaikat … fi   
#> 21 StatFin/alyr/statfin_alyr_pxt_13wy.px   13wy -- Yritysten toimipaikat … fi   
#> 22 StatFin/alyr/statfin_alyr_pxt_13wz.px   13wz -- Yritysten toimipaikat … fi   
#> 23 StatFin/alyr/statfin_alyr_pxt_13x1.px   13x1 -- Vähittäiskaupan toimip… fi   
#> 24 StatFin/alyr/statfin_alyr_pxt_13x2.px   13x2 -- Yritysten toimipaikkoj… fi   
#> 25 StatFin/alyr/statfin_alyr_pxt_13x3.px   13x3 -- Yritysten toimipaikkoj… fi   
#> 26 StatFin/alvaa/statfin_alvaa_pxt_14y1.px 14y1 -- Äänioikeutetut ja ääne… fi   
#> 27 StatFin/alvaa/statfin_alvaa_pxt_14y2.px 14y2 -- Puolueiden kannatus eh… fi   
#> 28 StatFin/alvaa/statfin_alvaa_pxt_14y3.px 14y3 -- Äänestystiedot sukupuo… fi   
#> 29 StatFin/alvaa/statfin_alvaa_pxt_14y4.px 14y4 -- Puolueiden kannatus ja… fi   
#> 30 StatFin/alvaa/statfin_alvaa_pxt_14y5.px 14y5 -- Hylätyt äänestysliput … fi   
#> # ℹ 179,159 more rows
```

To browse the tables interactively, you can also open them in the Data
Viewer:

``` r
View(data())
```

### Retrieving a Specific Data Table

If you know the specific ID of the table, you can easily retrieve it:

``` r
df <- data("StatFin/synt/statfin_synt_pxt_12dx.px")
#> ⠙ Requesting data
#> ✔ Requesting data [181ms]
#> 
```

To check the version information (vintage) of a data table, use:

``` r
data_vintage("StatFin/synt/statfin_synt_pxt_12dx.px")
#> ⠙ Requesting vintage
#> ✔ Requesting vintage [163ms]
#> 
#> StatFin/synt/statfin_synt_pxt_12dx.px 
#>            "2025-09-04 09:22:00 EEST"
```

## Filtering by Dataset

You can also narrow your search to a specific dataset. For instance, to
explore all available tables from the Finnish Tax Administration (Vero):

``` r
View(data("Vero/"))  # Opens Data Viewer with the tables
data("Vero/")        # Lists tables in the consoledata("Vero/")
```

## Searching and Retrieving Data

The data() function is convenient because it combines searching and
retrieving data into a single function:

- **Search Mode**: If the argument matches multiple table IDs or titles,
  data() returns a tibble of matched data tables. For instance:

  ``` r
  data("väestö")  # Returns multiple matches for 'väestö'
  #> ⠙ Requesting data
  #> ✔ Requesting data [1.9s]
  #> 
  #> # Robonomist Database search results
  #>    id                                    title                             lang 
  #>    <r_id>                                <chr>                             <chr>
  #>  1 StatFin/asas/statfin_asas_pxt_115a.px 115a -- Asuntokunnat, asuntoväes… fi   
  #>  2 StatFin/asas/statfin_asas_pxt_115y.px 115y -- Asuntokunnat ja asuntovä… fi   
  #>  3 StatFin/asas/statfin_asas_pxt_115z.px 115z -- Asuntokunnat ja asuntovä… fi   
  #>  4 StatFin/asas/statfin_asas_pxt_116b.px 116b -- Asuntokunnat ja asuntovä… fi   
  #>  5 StatFin/asas/statfin_asas_pxt_116e.px 116e -- Asuntokunnat ja asuntovä… fi   
  #>  6 StatFin/eot/statfin_eot_pxt_11te.px   11te -- Itse koettu terveys 16 v… fi   
  #>  7 StatFin/eot/statfin_eot_pxt_11ty.px   11ty -- Tyytyväisyys elämään 16 … fi   
  #>  8 StatFin/eot/statfin_eot_pxt_11ub.px   11ub -- Tyytyväisyys kotitaloude… fi   
  #>  9 StatFin/eot/statfin_eot_pxt_11v2.px   11v2 -- Tyytyväisyys elämään, ke… fi   
  #> 10 StatFin/eot/statfin_eot_pxt_11wp.px   11wp -- Onnellisuuden tunteet ne… fi   
  #> 11 StatFin/eot/statfin_eot_pxt_11z9.px   11z9 -- Yksinäisyyden tunne nelj… fi   
  #> 12 StatFin/eot/statfin_eot_pxt_11zc.px   11zc -- Yksinäisyyden tunne nelj… fi   
  #> 13 StatFin/eot/statfin_eot_pxt_11ze.px   11ze -- Tyytyväisyys elämään, ke… fi   
  #> 14 StatFin/eot/statfin_eot_pxt_11zy.px   11zy -- Itse koettu terveys 16 v… fi   
  #> 15 StatFin/eot/statfin_eot_pxt_121a.px   121a -- Tyytyväisyys elämään 16 … fi   
  #> 16 StatFin/eot/statfin_eot_pxt_13ju.px   13ju -- Luottamus toisiin ihmisi… fi   
  #> 17 StatFin/eot/statfin_eot_pxt_13jv.px   13jv -- Luottamus toisiin ihmisi… fi   
  #> 18 StatFin/eot/statfin_eot_pxt_13wk.px   13wk -- Kotitalousväestön pienit… fi   
  #> 19 StatFin/eot/statfin_eot_pxt_13wl.px   13wl -- Kotitalousväestön pienit… fi   
  #> 20 StatFin/eot/statfin_eot_pxt_13wm.px   13wm -- Kotitalousväestön pienit… fi   
  #> 21 StatFin/eot/statfin_eot_pxt_13xi.px   13xi -- Toimintarajoitteiset hen… fi   
  #> 22 StatFin/eot/statfin_eot_pxt_13xj.px   13xj -- Perustoiminnoissa koetut… fi   
  #> 23 StatFin/eot/statfin_eot_pxt_13xl.px   13xl -- Kokemus ulkopuolisuuden … fi   
  #> 24 StatFin/eot/statfin_eot_pxt_13xt.px   13xt -- Tyytyväisyys ihmissuhtei… fi   
  #> 25 StatFin/eot/statfin_eot_pxt_13xu.px   13xu -- Toimintarajoitteiset hen… fi   
  #> 26 StatFin/eot/statfin_eot_pxt_13xv.px   13xv -- Itse koettu terveydentil… fi   
  #> 27 StatFin/eot/statfin_eot_pxt_13yc.px   13yc -- Kokemus ulkopuolisuuden … fi   
  #> 28 StatFin/eot/statfin_eot_pxt_14cm.px   14cm -- Luovien harrastusten har… fi   
  #> 29 StatFin/eot/statfin_eot_pxt_14cn.px   14cn -- Luovien harrastusten har… fi   
  #> 30 StatFin/eot/statfin_eot_pxt_14ct.px   14ct -- Elokuvissa, esityksissä,… fi   
  #> # ℹ 863 more rows
  ```

- **Retrieve Mode**: If the argument matches exactly one table ID,
  data() will directly return that data table:

  ``` r
  data("StatFin/synt/statfin_synt_pxt_12dx.px")  # Returns the specific data table
  #> ⠙ Requesting data
  #> ✔ Requesting data [186ms]
  #> 
  #> # Robonomist id: StatFin/synt/statfin_synt_pxt_12dx.px
  #> # Title:         12dx -- Väestönmuutokset ja väkiluku, 1749-2024
  #> # Last updated:  2025-05-28 08:00:00
  #> # Next update:   2026-05-19 08:00:00
  #> # A tibble:      3,036 × 3
  #>    Vuosi Tiedot                     value
  #>  * <chr> <chr>                      <dbl>
  #>  1 1749  Elävänä syntyneet          16700
  #>  2 1749  Kuolleet                   11600
  #>  3 1749  Luonnollinen väestönlisäys  5100
  #>  4 1749  Kuntien välinen muutto        NA
  #>  5 1749  Maahanmuutto Suomeen          NA
  #>  6 1749  Maastamuutto Suomesta         NA
  #>  7 1749  Nettomaahanmuutto             NA
  #>  8 1749  Solmitut avioliitot         3900
  #>  9 1749  Avioerot                      NA
  #> 10 1749  Kokonaismuutos                NA
  #> # ℹ 3,026 more rows
  ```

  For more robust usage in production, where consistency is key, it is
  recommended to use more specific functions:

### `data_search()` and `data_get()`

To clearly separate search and retrieval operations:

- [`data_search()`](https://robonomist.github.io/robonomistClient/reference/data.md):
  Use this function to search for matching table IDs without downloading
  the actual data. This is useful for exploring available datasets:

  ``` r
  data_search("väestö")
  #> ⠙ Requesting search
  #> ⠹ Requesting search
  #> ✔ Requesting search [1.5s]
  #> 
  #> # Robonomist Database search results
  #>    id                                    title                             lang 
  #>    <r_id>                                <chr>                             <chr>
  #>  1 StatFin/asas/statfin_asas_pxt_115a.px 115a -- Asuntokunnat, asuntoväes… fi   
  #>  2 StatFin/asas/statfin_asas_pxt_115y.px 115y -- Asuntokunnat ja asuntovä… fi   
  #>  3 StatFin/asas/statfin_asas_pxt_115z.px 115z -- Asuntokunnat ja asuntovä… fi   
  #>  4 StatFin/asas/statfin_asas_pxt_116b.px 116b -- Asuntokunnat ja asuntovä… fi   
  #>  5 StatFin/asas/statfin_asas_pxt_116e.px 116e -- Asuntokunnat ja asuntovä… fi   
  #>  6 StatFin/eot/statfin_eot_pxt_11te.px   11te -- Itse koettu terveys 16 v… fi   
  #>  7 StatFin/eot/statfin_eot_pxt_11ty.px   11ty -- Tyytyväisyys elämään 16 … fi   
  #>  8 StatFin/eot/statfin_eot_pxt_11ub.px   11ub -- Tyytyväisyys kotitaloude… fi   
  #>  9 StatFin/eot/statfin_eot_pxt_11v2.px   11v2 -- Tyytyväisyys elämään, ke… fi   
  #> 10 StatFin/eot/statfin_eot_pxt_11wp.px   11wp -- Onnellisuuden tunteet ne… fi   
  #> 11 StatFin/eot/statfin_eot_pxt_11z9.px   11z9 -- Yksinäisyyden tunne nelj… fi   
  #> 12 StatFin/eot/statfin_eot_pxt_11zc.px   11zc -- Yksinäisyyden tunne nelj… fi   
  #> 13 StatFin/eot/statfin_eot_pxt_11ze.px   11ze -- Tyytyväisyys elämään, ke… fi   
  #> 14 StatFin/eot/statfin_eot_pxt_11zy.px   11zy -- Itse koettu terveys 16 v… fi   
  #> 15 StatFin/eot/statfin_eot_pxt_121a.px   121a -- Tyytyväisyys elämään 16 … fi   
  #> 16 StatFin/eot/statfin_eot_pxt_13ju.px   13ju -- Luottamus toisiin ihmisi… fi   
  #> 17 StatFin/eot/statfin_eot_pxt_13jv.px   13jv -- Luottamus toisiin ihmisi… fi   
  #> 18 StatFin/eot/statfin_eot_pxt_13wk.px   13wk -- Kotitalousväestön pienit… fi   
  #> 19 StatFin/eot/statfin_eot_pxt_13wl.px   13wl -- Kotitalousväestön pienit… fi   
  #> 20 StatFin/eot/statfin_eot_pxt_13wm.px   13wm -- Kotitalousväestön pienit… fi   
  #> 21 StatFin/eot/statfin_eot_pxt_13xi.px   13xi -- Toimintarajoitteiset hen… fi   
  #> 22 StatFin/eot/statfin_eot_pxt_13xj.px   13xj -- Perustoiminnoissa koetut… fi   
  #> 23 StatFin/eot/statfin_eot_pxt_13xl.px   13xl -- Kokemus ulkopuolisuuden … fi   
  #> 24 StatFin/eot/statfin_eot_pxt_13xt.px   13xt -- Tyytyväisyys ihmissuhtei… fi   
  #> 25 StatFin/eot/statfin_eot_pxt_13xu.px   13xu -- Toimintarajoitteiset hen… fi   
  #> 26 StatFin/eot/statfin_eot_pxt_13xv.px   13xv -- Itse koettu terveydentil… fi   
  #> 27 StatFin/eot/statfin_eot_pxt_13yc.px   13yc -- Kokemus ulkopuolisuuden … fi   
  #> 28 StatFin/eot/statfin_eot_pxt_14cm.px   14cm -- Luovien harrastusten har… fi   
  #> 29 StatFin/eot/statfin_eot_pxt_14cn.px   14cn -- Luovien harrastusten har… fi   
  #> 30 StatFin/eot/statfin_eot_pxt_14ct.px   14ct -- Elokuvissa, esityksissä,… fi   
  #> # ℹ 863 more rows
  ```

- [`data_get()`](https://robonomist.github.io/robonomistClient/reference/data.md):
  Use this function for robust retrieval of a specific data table by its
  ID. This ensures either a data table or an error is returned, making
  it more predictable for production use:

  ``` r
  d <- data_get("StatFin/synt/statfin_synt_pxt_12dx.px")
  #> ⠙ Requesting get
  #> ✔ Requesting get [164ms]
  #> 
  ```

## Handling Time and Labels in Data

### Tidy Time Formatting

For most datasources, `robonomistClient` can automatically format the
time dimension for easier analysis. Setting the `tidy_time` argument to
`TRUE` will:

- Name the time dimension time.
- Convert it to `Date` class.
- Relocate the time variable to be just before the value column, making
  it more convenient to work with.

``` r
# Without tidy time formatting
data_get("StatFin/ntp/statfin_ntp_pxt_132h.px")
#> ⠙ Requesting get
#> ✔ Requesting get [210ms]
#> 
#> # Robonomist id: StatFin/ntp/statfin_ntp_pxt_132h.px
#> # Title:         132h -- Bruttokansantuote ja -tulo sekä tarjonta ja kysyntä
#> #   neljännesvuosittain, 1990Q1-2025Q2
#> # Last updated:  2025-09-18 08:00:00
#> # Next update:   2025-11-28 08:00:00
#> # A tibble:      113,316 × 4
#>    Vuosineljännes Taloustoimi                             Tiedot           value
#>  * <chr>          <chr>                                   <chr>            <dbl>
#>  1 1990Q1         B1GMH Bruttokansantuote markkinahintaan Kausitasoitett… 22885.
#>  2 1990Q1         B1GMH Bruttokansantuote markkinahintaan Alkuperäinen s… 21609 
#>  3 1990Q1         B1GMH Bruttokansantuote markkinahintaan Trendisarja kä… 22902.
#>  4 1990Q1         B1GMH Bruttokansantuote markkinahintaan Työpäiväkorjat… 21459.
#>  5 1990Q1         B1GMH Bruttokansantuote markkinahintaan Kausitasoitett… 35957 
#>  6 1990Q1         B1GMH Bruttokansantuote markkinahintaan Alkuperäinen s… 33888 
#>  7 1990Q1         B1GMH Bruttokansantuote markkinahintaan Trendisarja, v… 36011 
#>  8 1990Q1         B1GMH Bruttokansantuote markkinahintaan Työpäiväkorjat… 33928 
#>  9 1990Q1         B1GMH Bruttokansantuote markkinahintaan Kausitasoitetu…    NA 
#> 10 1990Q1         B1GMH Bruttokansantuote markkinahintaan Trendisarjan v…    NA 
#> # ℹ 113,306 more rows

# With tidy time formatting
data_get("StatFin/ntp/statfin_ntp_pxt_132h.px", tidy_time = TRUE)
#> ⠙ Requesting get
#> ✔ Requesting get [208ms]
#> 
#> # Robonomist id: StatFin/ntp/statfin_ntp_pxt_132h.px
#> # Title:         132h -- Bruttokansantuote ja -tulo sekä tarjonta ja kysyntä
#> #   neljännesvuosittain, 1990Q1-2025Q2
#> # Last updated:  2025-09-18 08:00:00
#> # Next update:   2025-11-28 08:00:00
#> # A tibble:      113,316 × 4
#>    Taloustoimi                             Tiedot              time        value
#>  * <chr>                                   <chr>               <date>      <dbl>
#>  1 B1GMH Bruttokansantuote markkinahintaan Kausitasoitettu ja… 1990-01-01 22885.
#>  2 B1GMH Bruttokansantuote markkinahintaan Alkuperäinen sarja… 1990-01-01 21609 
#>  3 B1GMH Bruttokansantuote markkinahintaan Trendisarja käypii… 1990-01-01 22902.
#>  4 B1GMH Bruttokansantuote markkinahintaan Työpäiväkorjattu s… 1990-01-01 21459.
#>  5 B1GMH Bruttokansantuote markkinahintaan Kausitasoitettu ja… 1990-01-01 35957 
#>  6 B1GMH Bruttokansantuote markkinahintaan Alkuperäinen sarja… 1990-01-01 33888 
#>  7 B1GMH Bruttokansantuote markkinahintaan Trendisarja, viite… 1990-01-01 36011 
#>  8 B1GMH Bruttokansantuote markkinahintaan Työpäiväkorjattu s… 1990-01-01 33928 
#>  9 B1GMH Bruttokansantuote markkinahintaan Kausitasoitetun ja… 1990-01-01    NA 
#> 10 B1GMH Bruttokansantuote markkinahintaan Trendisarjan volyy… 1990-01-01    NA 
#> # ℹ 113,306 more rows
```

The `tidy_time` argument defaults to `TRUE` for all datasources that
provide a consistent schema for time variables.

### Working with Labels and Codes

Some datasources provide both labelled and coded versions of data
tables. By default, labels are included, but you can control this using
the labels argument:

``` r
# Retrieve data without labels (useful when working with coded data)
data_get("StatFin/ntp/statfin_ntp_pxt_132h.px", labels = FALSE)
#> ⠙ Requesting get
#> ✔ Requesting get [193ms]
#> 
#> # Robonomist id: StatFin/ntp/statfin_ntp_pxt_132h.px
#> # Title:         132h -- Bruttokansantuote ja -tulo sekä tarjonta ja kysyntä
#> #   neljännesvuosittain, 1990Q1-2025Q2
#> # Last updated:  2025-09-18 08:00:00
#> # Next update:   2025-11-28 08:00:00
#> # A tibble:      113,316 × 4
#>    Vuosineljännes Taloustoimi Tiedot               value
#>  * <chr>          <chr>       <chr>                <dbl>
#>  1 1990Q1         B1GMH       kausitcp            22885.
#>  2 1990Q1         B1GMH       tasmcp              21609 
#>  3 1990Q1         B1GMH       trendicp            22902.
#>  4 1990Q1         B1GMH       tyopcp              21459.
#>  5 1990Q1         B1GMH       kausitvv2015        35957 
#>  6 1990Q1         B1GMH       tasmvv2015          33888 
#>  7 1990Q1         B1GMH       trendivv2015        36011 
#>  8 1990Q1         B1GMH       tyopvv2015          33928 
#>  9 1990Q1         B1GMH       vol_kk_kausitvv2015    NA 
#> 10 1990Q1         B1GMH       vol_kk_trendivv2015    NA 
#> # ℹ 113,306 more rows
```
