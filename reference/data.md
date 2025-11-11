# Search and get data from Robonomist Data Server

`data()` is a convenience function that searches the database and
returns

1.  search results if multiple matching tables are found, and

2.  data if only one match is found.

`data_get()` returns data for a given table id without performing
searching, url parsing or pattern filters, and is prefered in
programmatic use-cases where robustness and speed are important.
`data_get()` will result in error, if no match exists.

`data_search()` performs a search and returns a list of matching data
tables without downloading any data.

## Usage

``` r
dаta(
  pattern = "",
  dl_filter = NULL,
  labels = getOption("robonomistClient.labels"),
  lang = NULL,
  na.rm = FALSE,
  tidy_time = getOption("robonomistClient.tidy_time"),
  ...
 )

data_get(
  id,
  dl_filter = NULL,
  labels = getOption("robonomistClient.labels"),
  lang = NULL,
  na.rm = FALSE,
  tidy_time = getOption("robonomistClient.tidy_time"),
  ...
)

data_search(pattern = "")
```

## Arguments

- pattern:

  Character. Search query or table id, possibly followed by a
  `§`-filter.

- dl_filter:

  List or named vector. The download filter is passed to datasource
  download functions to filter data before download. See Details.

- labels:

  Logical. If FALSE, then variable values are returned as codes instead
  of labels.

- lang:

  Two-letter language code, e.g. "en" or "sv".

- na.rm:

  Logical. If TRUE, and supported by the datasource, missing values are
  removed from the returned data frame upon retrieval.

- tidy_time:

  Logical. If TRUE, the time dimension is parsed into Date class and
  renamed `time`. If NULL, the datasource specific default will be used.

- ...:

  Other arguments passed to datasource download functions.

- id, :

  Character. Exact table id. If multiple ids are provided as a character
  vector, they are bound row-wise into a single data frame.

## `§`-filter

The `data()` function allows for a special `§`-filter. When the pattern
matches a single table and the function returns a data frame, the
`§`-filter can be used to subset rows of data frame. The tibble is
filterd by sequence of regular expressions separated by section sign
`§`. The regular expression are applied to data frame's variables
sequentially.

If the last variable is a date, it is used as a start date filter.

## Download filter

Some datasources (e.g. datasets "ecb" & "tulli") do not allow
downloading full data tables, nor is it always preferred due to the
large large size of table. For these datasources the user must provide a
download filter via the `dl_filter` argument. When the argument is left
as `NULL`, the `data` function will return a list of variables and
potential values. This list can be used to construct a suitable download
filter.

Generally, `dl_filter` should be named list where names are variable
names and values character vectors of selected values (see Examples).
Alternatively, some datasources allow for a dot-separated string to
define a download filter.

## Examples

``` r
# Search for datasets matching pattern:
data("consumer indicator")
#> ℹ Connecting to robonomistServer at wss://data.robonomist.app
#> ✔ Connecting to robonomistServer at wss://data.robonomist.app [1.2s]
#> 
#> ℹ Connected successfully to robonomistServer 2.10.2
#> ✔ Connected successfully to robonomistServer 2.10.2 [24ms]
#> 
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ⠸ Requesting data
#> ⠼ Requesting data
#> ✔ Requesting data [7.3s]
#> 
#> # Robonomist Database search results
#>    id                                                          title       lang 
#>    <r_id>                                                      <chr>       <chr>
#>  1 ec/consumer                                                 Consumer S… en   
#>  2 ec/consumer_nsa                                             Consumer S… en   
#>  3 ec/consumer_q                                               Consumer S… en   
#>  4 ec/consumer_q_nsa                                           Consumer S… en   
#>  5 eurostat/ei_bsco_m                                          Consumers … en   
#>  6 ecb/JDF_EXR_HCI_CPI                                         Harmonised… en   
#>  7 wb/EP.CPI.1996                                              Consumer P… en   
#>  8 wb/EP.CPI.2002                                              Consumer P… en   
#>  9 wb/EP.CPI.2007                                              Consumer P… en   
#> 10 wb/FP.CPI.TOTL.ZG                                           Inflation,… en   
#> 11 wb/MO.INDEX.ECON.XQ                                         Sustainabl… en   
#> 12 wb/PX.REC.REER                                              Real effec… en   
#> 13 wb/SPI.D5.2.4.CPIBY                                         CPI base y… en   
#> 14 se/PR/PR0101/PR0101S/SnabbStatPR0101                        Consumer P… en   
#> 15 konj/hushall/indikatorhus.px                                Household … en   
#> 16 konj/hushall/zhushallhist/hushallpremm/Indikatorhus.px      Household … en   
#> 17 dk/FORV1                                                    Consumer c… en   
#> 18 md/40_Statistica_economica/15_ENE/serii_lunare/ENE010200.px Stocks, in… en   
#> 19 si/0811601S.px                                              Consumer s… en   
#> 20 si/0811602S.px                                              Consumer s… en   

## Limit your search to a specific dataset by providing
## the dataset name and a slash as prefix:
data("ec/ consumer indicator")
#> ⠙ Requesting data
#> ✔ Requesting data [239ms]
#> 
#> # Robonomist Database search results
#>   id                title                                                  lang 
#>   <r_id>            <chr>                                                  <chr>
#> 1 ec/consumer       Consumer Sentiment Indicator                           en   
#> 2 ec/consumer_nsa   Consumer Sentiment Indicator, non-seasonally adjusted  en   
#> 3 ec/consumer_q     Consumer Sentiment Indicator, quarterly questions      en   
#> 4 ec/consumer_q_nsa Consumer Sentiment Indicator, non-seasonally adjusted… en   

## Download data by providing exact table id:
data("ec/consumer")
#> ⠙ Requesting data
#> ✔ Requesting data [1.1s]
#> 
#> # Robonomist id: ec/consumer
#> # Title:         Consumer Sentiment Indicator
#> # Vintage:       2025-10-27 16:40:55
#> # A tibble:      205,800 × 4
#>    Country                              Indicator               time       value
#>  * <chr>                                <chr>                   <date>     <dbl>
#>  1 European Union (current composition) Confidence Indicator (… 1985-01-01 -10.2
#>  2 European Union (current composition) Confidence Indicator (… 1985-02-01 -10.6
#>  3 European Union (current composition) Confidence Indicator (… 1985-03-01 -11.5
#>  4 European Union (current composition) Confidence Indicator (… 1985-04-01 -10.8
#>  5 European Union (current composition) Confidence Indicator (… 1985-05-01 -11.2
#>  6 European Union (current composition) Confidence Indicator (… 1985-06-01 -11.6
#>  7 European Union (current composition) Confidence Indicator (… 1985-07-01 -11.2
#>  8 European Union (current composition) Confidence Indicator (… 1985-08-01 -10.9
#>  9 European Union (current composition) Confidence Indicator (… 1985-09-01 -10.7
#> 10 European Union (current composition) Confidence Indicator (… 1985-10-01  -8  
#> # ℹ 205,790 more rows

## With time series based datasets you can retrieve the time series
## using the source's id:
data("ecb/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#> ⠙ Requesting data
#> ✔ Requesting data [225ms]
#> 
#> # Robonomist id: ecb/FM
#> # Title:         Financial market data
#> # Vintage:       2025-11-11 08:00:00
#> # A tibble:      382 × 9
#>    Frequency `Reference area`                 Currency Financial market provid…¹
#>  * <chr>     <chr>                            <chr>    <chr>                    
#>  1 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  2 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  3 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  4 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  5 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  6 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  7 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  8 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  9 Monthly   Euro area (changing composition) Euro     Refinitiv                
#> 10 Monthly   Euro area (changing composition) Euro     Refinitiv                
#> # ℹ 372 more rows
#> # ℹ abbreviated name: ¹​`Financial market provider`
#> # ℹ 5 more variables: `Financial market instrument` <chr>,
#> #   `Financial market provider identifier` <chr>,
#> #   `Financial market data type` <chr>, time <date>, value <dbl>

## Alternatively, you can copy the full URL from the source's website:
data("https://data.ecb.europa.eu/data/datasets/FM/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#> ⠙ Requesting data
#> ℹ The URL points to a data table in dataset "ecb".
#> ⠙ Requesting data
#> ℹ For direct data retrieval, use:
#> >  data_get("ecb/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA", raw = TRUE)
#> ⠙ Requesting data
#> ✔ Requesting data [252ms]
#> 
#> # Robonomist id: ecb/FM
#> # Title:         Financial market data
#> # Vintage:       2025-11-11 08:00:00
#> # A tibble:      382 × 9
#>    Frequency `Reference area`                 Currency Financial market provid…¹
#>  * <chr>     <chr>                            <chr>    <chr>                    
#>  1 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  2 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  3 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  4 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  5 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  6 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  7 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  8 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  9 Monthly   Euro area (changing composition) Euro     Refinitiv                
#> 10 Monthly   Euro area (changing composition) Euro     Refinitiv                
#> # ℹ 372 more rows
#> # ℹ abbreviated name: ¹​`Financial market provider`
#> # ℹ 5 more variables: `Financial market instrument` <chr>,
#> #   `Financial market provider identifier` <chr>,
#> #   `Financial market data type` <chr>, time <date>, value <dbl>

## Most time series datasets also support wildcards. For example,
## in case of ECB, you can leave a part of the series id unspecified:
data("ecb/FM.M.U2.EUR.RT.MM..HSTA")
#> ⠙ Requesting data
#> ✔ Requesting data [230ms]
#> 
#> # Robonomist id: ecb/FM
#> # Title:         Financial market data
#> # Vintage:       2025-11-11 08:00:00
#> # A tibble:      1,528 × 9
#>    Frequency `Reference area`                 Currency Financial market provid…¹
#>  * <chr>     <chr>                            <chr>    <chr>                    
#>  1 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  2 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  3 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  4 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  5 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  6 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  7 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  8 Monthly   Euro area (changing composition) Euro     Refinitiv                
#>  9 Monthly   Euro area (changing composition) Euro     Refinitiv                
#> 10 Monthly   Euro area (changing composition) Euro     Refinitiv                
#> # ℹ 1,518 more rows
#> # ℹ abbreviated name: ¹​`Financial market provider`
#> # ℹ 5 more variables: `Financial market instrument` <chr>,
#> #   `Financial market provider identifier` <chr>,
#> #   `Financial market data type` <chr>, time <date>, value <dbl>

## If the data table too large to download in full, you may need to
## provide a download filter. First get the available variables and values:
data("ecb/AME") |> str()
#> ⠙ Requesting data
#> ✔ Requesting data [222ms]
#> 
#> List of 7
#>  $ FREQ              : tibble [10 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:10] "A" "B" "D" "E" ...
#>   ..$ label: chr [1:10] "Annual" "Daily - business week" "Daily" "Event (not supported)" ...
#>  $ AME_REF_AREA      : tibble [109 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:109] "A10" "A13" "ALB" "AUS" ...
#>   ..$ label: chr [1:109] "10 accession countries" "13 candidate countries" "Albania" "Australia" ...
#>  $ AME_TRANSFORMATION: tibble [3 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:3] "1" "3" "9"
#>   ..$ label: chr [1:3] "Original data and moving arithmetic mean" "Index numbers and moving arithmetic mean" "Annual changes (and moving arithmetic mean for time periods)"
#>  $ AME_AGG_METHOD    : tibble [5 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:5] "0" "1" "2" "3" ...
#>   ..$ label: chr [1:5] "Standard aggregation" "Weighted mean by GDP, weights in current euro" "Weighted mean by GDP, weights in current PPS" "Weighted mean by private consumption in euro" ...
#>  $ AME_UNIT          : tibble [11 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:11] "0" "212" "30" "310" ...
#>   ..$ label: chr [1:11] "National currency" "PPS [1960-1993 GDP EU-12, 1994- GDP EU-15]" "US Dollar" "Percentage of GDP at market prices" ...
#>  $ AME_REFERENCE     : tibble [28 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:28] "0" "215" "30" "315" ...
#>   ..$ label: chr [1:28] "No reference" "EU-15 = 100 including former West Germany" "US = 100" "EU-15 = 100 including unified Germany" ...
#>  $ AME_ITEM          : tibble [910 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:910] "AAGE" "AAGT" "ADGGFI" "ADGGFU" ...
#>   ..$ label: chr [1:910] "Average share of imports and exports of goods in world trade excluding intra EU trade - Foreign trade statistic"| __truncated__ "Average share of imports and exports of goods in world trade including intra EU trade - Foreign trade statistics" "Snow ball effect on general government consolidated gross debt Maastricht and former definition (linked series)" "Impact of the nominal increase of GDP on general government consolidated gross debt, Maastricht and former defi"| __truncated__ ...
#>  - attr(*, "robonomist_id")= r_id [1:1] ecb/AME
#>  - attr(*, "robonomist_vintage")= POSIXct[1:1], format: "2025-11-11 08:00:00"
#>  - attr(*, "robonomist_title")= chr "AMECO"
#>  - attr(*, "robonomist_language")= chr "en"
#>  - attr(*, "robonomist_source")= chr NA
#>  - attr(*, "robonomist_frequency")= chr NA
#>  - attr(*, "class")= chr [1:2] "robonomist_data" "list"

## Then provide a suitable filter to download data:
data("ecb/AME", dl_filter = list(ame_ref_area = "FIN"))
#> ⠙ Requesting data
#> ✔ Requesting data [251ms]
#> 
#> # Robonomist id: ecb/AME
#> # Title:         AMECO
#> # Vintage:       2025-11-11 08:00:00
#> # A tibble:      243 × 9
#>    Frequency `Ameco reference area` `Ameco transformation`                  
#>  * <chr>     <chr>                  <chr>                                   
#>  1 Annual    Finland                Original data and moving arithmetic mean
#>  2 Annual    Finland                Original data and moving arithmetic mean
#>  3 Annual    Finland                Original data and moving arithmetic mean
#>  4 Annual    Finland                Original data and moving arithmetic mean
#>  5 Annual    Finland                Original data and moving arithmetic mean
#>  6 Annual    Finland                Original data and moving arithmetic mean
#>  7 Annual    Finland                Original data and moving arithmetic mean
#>  8 Annual    Finland                Original data and moving arithmetic mean
#>  9 Annual    Finland                Original data and moving arithmetic mean
#> 10 Annual    Finland                Original data and moving arithmetic mean
#> # ℹ 233 more rows
#> # ℹ 6 more variables: `Ameco aggregation method` <chr>, `Ameco unit` <chr>,
#> #   `Ameco reference` <chr>, `Ameco item` <chr>, time <date>, value <dbl>

## Another example with Finish Customs dataset:
data("tulli/uljas_cpa2008",
  dl_filter = list(
    "Tavaraluokitus CPA2008_2" = "*A-X",
    "Aika" = c("201505", "201506"),
    "Maa" = "=ALL",
    "Suunta" = "=FIRST 1",
    "Indikaattorit" = "=FIRST 1"
  )
)
#> ⠙ Requesting data
#> ✔ Requesting data [243ms]
#> 
#> # Robonomist id: tulli/uljas_cpa2008
#> # Title:         CPA2008, CC BY 4.0
#> # Vintage:       2023-12-20 16:36:42
#> # A tibble:      508 × 6
#>    `Tavaraluokitus CPA2008_2`   Maa      Suunta Indikaattorit time         value
#>  * <chr>                        <chr>    <chr>  <chr>         <date>       <dbl>
#>  1 *A-X (2008--.) KAIKKI RYHMÄT AA (200… Tuont… Tilastoarvo … 2015-05-01  4.23e9
#>  2 *A-X (2008--.) KAIKKI RYHMÄT AD (200… Tuont… Tilastoarvo … 2015-05-01  2.18e5
#>  3 *A-X (2008--.) KAIKKI RYHMÄT AE (200… Tuont… Tilastoarvo … 2015-05-01  7.22e5
#>  4 *A-X (2008--.) KAIKKI RYHMÄT AF (200… Tuont… Tilastoarvo … 2015-05-01  7.99e4
#>  5 *A-X (2008--.) KAIKKI RYHMÄT AG (200… Tuont… Tilastoarvo … 2015-05-01 NA     
#>  6 *A-X (2008--.) KAIKKI RYHMÄT AI (200… Tuont… Tilastoarvo … 2015-05-01 NA     
#>  7 *A-X (2008--.) KAIKKI RYHMÄT AL (200… Tuont… Tilastoarvo … 2015-05-01  2.25e4
#>  8 *A-X (2008--.) KAIKKI RYHMÄT AM (200… Tuont… Tilastoarvo … 2015-05-01  2.52e2
#>  9 *A-X (2008--.) KAIKKI RYHMÄT AN (200… Tuont… Tilastoarvo … 2015-05-01 NA     
#> 10 *A-X (2008--.) KAIKKI RYHMÄT AO (200… Tuont… Tilastoarvo … 2015-05-01 NA     
#> # ℹ 498 more rows

## Using §-filter to filter data after download:
data("ec/consumer§Fin§Confidence")
#> ⠙ Requesting data
#> ✔ Requesting data [340ms]
#> 
#> # Robonomist id: ec/consumer
#> # Title:         Consumer Sentiment Indicator
#> # Vintage:       2025-10-27 16:40:55
#> # A tibble:      490 × 4
#>    Country Indicator                                    time       value
#>    <chr>   <chr>                                        <date>     <dbl>
#>  1 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-01-01    NA
#>  2 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-02-01    NA
#>  3 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-03-01    NA
#>  4 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-04-01    NA
#>  5 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-05-01    NA
#>  6 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-06-01    NA
#>  7 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-07-01    NA
#>  8 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-08-01    NA
#>  9 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-09-01    NA
#> 10 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 1985-10-01    NA
#> # ℹ 480 more rows

## Using §-filter with start date:
data("ec/consumer§Fin§Confidence§2020-01-01")
#> ⠙ Requesting data
#> ✔ Requesting data [291ms]
#> 
#> # Robonomist id: ec/consumer
#> # Title:         Consumer Sentiment Indicator
#> # Vintage:       2025-10-27 16:40:55
#> # A tibble:      70 × 4
#>    Country Indicator                                    time       value
#>    <chr>   <chr>                                        <date>     <dbl>
#>  1 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-01-01  -4.4
#>  2 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-02-01  -4.9
#>  3 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-03-01  -7  
#>  4 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-04-01 -13.9
#>  5 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-05-01  -8.8
#>  6 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-06-01  -3.8
#>  7 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-07-01  -1.9
#>  8 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-08-01  -5.1
#>  9 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-09-01  -6  
#> 10 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-10-01  -6.8
#> # ℹ 60 more rows
```
