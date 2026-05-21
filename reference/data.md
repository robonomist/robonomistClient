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
#> Error in websocket callback: qs-legacy format detected, use qs::qread
#> Error in self$send(fun = "server_version", args = list(), message = FALSE): Connection was lost!
#> ✖ Connecting to robonomistServer at wss://data.robonomist.app [1h 1s]
#> 

## Limit your search to a specific dataset by providing
## the dataset name and a slash as prefix:
data("ec/ consumer indicator")
#> ℹ Connecting to robonomistServer at wss://data.robonomist.app
#> Error in websocket callback: qs-legacy format detected, use qs::qread
#> Error in self$send(fun = "server_version", args = list(), message = FALSE): Connection was lost!
#> ✖ Connecting to robonomistServer at wss://data.robonomist.app [8m 53.6s]
#> 

## Download data by providing exact table id:
data("ec/consumer")
#> ℹ Connecting to robonomistServer at wss://data.robonomist.app
#> ✔ Connecting to robonomistServer at wss://data.robonomist.app [845ms]
#> 
#> ℹ Connected successfully to robonomistServer 2.11.0
#> ✔ Connected successfully to robonomistServer 2.11.0 [18ms]
#> 
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ⠸ Requesting data
#> ⠼ Requesting data
#> ✔ Requesting data [7.1s]
#> 
#> # Robonomist id: ec/consumer
#> # Title:         Consumer Sentiment Indicator
#> # Vintage:       2026-04-27 10:30:14
#> # A tibble:      208,320 × 4
#>    Country                              Indicator               time       value
#>  * <chr>                                <chr>                   <date>     <dbl>
#>  1 European Union (current composition) Confidence Indicator (… 1985-01-01 -10.2
#>  2 European Union (current composition) Confidence Indicator (… 1985-02-01 -10.7
#>  3 European Union (current composition) Confidence Indicator (… 1985-03-01 -11.5
#>  4 European Union (current composition) Confidence Indicator (… 1985-04-01 -10.7
#>  5 European Union (current composition) Confidence Indicator (… 1985-05-01 -11.1
#>  6 European Union (current composition) Confidence Indicator (… 1985-06-01 -11.6
#>  7 European Union (current composition) Confidence Indicator (… 1985-07-01 -11.2
#>  8 European Union (current composition) Confidence Indicator (… 1985-08-01 -10.9
#>  9 European Union (current composition) Confidence Indicator (… 1985-09-01 -10.7
#> 10 European Union (current composition) Confidence Indicator (… 1985-10-01  -8  
#> # ℹ 208,310 more rows

## With time series based datasets you can retrieve the time series
## using the source's id:
data("ecb/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ⠸ Requesting data
#> → Request failed in server error:
#>  ! in callr subprocess.
#> Caused by error in `(function (id, lang = NULL, ..., raw = FALSE) …`:
#> ! Failed to compute and could not find a cache backup.
#> At key:
#> List of 8
#> $ : chr "data"
#> $ : Named chr [1:2] "v1.0.2" "v1"
#> ..- attr(*, "names")= chr [1:2] "ECB" "Datasource"
#> $ : chr "ecb"
#> $ : chr "ECB"
#> $ : r_id [1:1] ecb/FM
#> $ : NULL
#> $ dl_filter: chr "M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA"
#> $ na.rm : logi FALSE
#> Caused by error in `httr_retry()` at robonomistServer/R/DatasourceECB.R:95:7:
#> ! Service Unavailable (HTTP 503).
#> ⠸ Requesting data
#> Error: Request failed
#> ✖ Requesting data [8.1s]
#> 

## Alternatively, you can copy the full URL from the source's website:
data("https://data.ecb.europa.eu/data/datasets/FM/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA")
#> ⠙ Requesting data
#> ℹ The URL points to a data table in dataset "ecb".
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ℹ For direct data retrieval, use:
#> >  data_get("ecb/FM.M.U2.EUR.RT.MM.EURIBOR1YD_.HSTA", raw = TRUE)
#> ⠹ Requesting data
#> ⠸ Requesting data
#> ! Failed to handle url in datasource ECB
#> ⠸ Requesting data
#> ⠼ Requesting data
#> → Request failed in server error:
#>  ! in callr subprocess.
#> Caused by error in `staging$handle_url(query$url, lang, ...)` at Data.R:59:9:
#> ! No datasource could handle the url.
#> ⠼ Requesting data
#> Error: Request failed
#> ✖ Requesting data [8.6s]
#> 

## Most time series datasets also support wildcards. For example,
## in case of ECB, you can leave a part of the series id unspecified:
data("ecb/FM.M.U2.EUR.RT.MM..HSTA")
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ⠸ Requesting data
#> ⠼ Requesting data
#> → Request failed in server error:
#>  ! in callr subprocess.
#> Caused by error in `(function (id, lang = NULL, ..., raw = FALSE) …`:
#> ! Failed to compute and could not find a cache backup.
#> At key:
#> List of 8
#> $ : chr "data"
#> $ : Named chr [1:2] "v1.0.2" "v1"
#> ..- attr(*, "names")= chr [1:2] "ECB" "Datasource"
#> $ : chr "ecb"
#> $ : chr "ECB"
#> $ : r_id [1:1] ecb/FM
#> $ : NULL
#> $ dl_filter: chr "M.U2.EUR.RT.MM..HSTA"
#> $ na.rm : logi FALSE
#> Caused by error in `httr_retry()` at robonomistServer/R/DatasourceECB.R:95:7:
#> ! Service Unavailable (HTTP 503).
#> ⠼ Requesting data
#> Error: Request failed
#> ✖ Requesting data [9.9s]
#> 

## If the data table too large to download in full, you may need to
## provide a download filter. First get the available variables and values:
data("ecb/AME") |> str()
#> ⠙ Requesting data
#> ✔ Requesting data [2.2s]
#> 
#> List of 7
#>  $ FREQ              : tibble [10 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:10] "A" "B" "D" "E" ...
#>   ..$ label: chr [1:10] "Annual" "Daily - businessweek" "Daily" "Event (not supported)" ...
#>  $ AME_REF_AREA      : tibble [122 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:122] "A10" "A13" "ALB" "AMT" ...
#>   ..$ label: chr [1:122] "10 accession countries" "13 candidate countries" "Albania" "AMECO Total (51 countries)" ...
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
#>  $ AME_ITEM          : tibble [925 × 2] (S3: tbl_df/tbl/data.frame)
#>   ..$ id   : chr [1:925] "AAGE" "AAGT" "ADGGFI" "ADGGFU" ...
#>   ..$ label: chr [1:925] "Average share of imports and exports of goods in world trade excluding intra EU trade - Foreign trade statistic"| __truncated__ "Average share of imports and exports of goods in world trade including intra EU trade - Foreign trade statistics" "Snow ball effect on general government consolidated gross debt Maastricht and former definition (linked series)" "Impact of the nominal increase of GDP on general government consolidated gross debt, Maastricht and former defi"| __truncated__ ...
#>  - attr(*, "robonomist_id")= r_id [1:1] ecb/AME
#>  - attr(*, "robonomist_vintage")= POSIXct[1:1], format: "2026-05-21 08:00:00"
#>  - attr(*, "robonomist_title")= chr "AMECO"
#>  - attr(*, "robonomist_language")= chr "en"
#>  - attr(*, "robonomist_source")= chr NA
#>  - attr(*, "robonomist_frequency")= chr NA
#>  - attr(*, "class")= chr [1:2] "robonomist_data" "list"

## Then provide a suitable filter to download data:
data("ecb/AME", dl_filter = list(ame_ref_area = "FIN"))
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ⠸ Requesting data
#> ⠼ Requesting data
#> → Request failed in server error:
#>  ! in callr subprocess.
#> Caused by error in `(function (id, lang = NULL, ..., raw = FALSE) …`:
#> ! Failed to compute and could not find a cache backup.
#> At key:
#> List of 8
#> $ : chr "data"
#> $ : Named chr [1:2] "v1.0.2" "v1"
#> ..- attr(*, "names")= chr [1:2] "ECB" "Datasource"
#> $ : chr "ecb"
#> $ : chr "ECB"
#> $ : r_id [1:1] ecb/AME
#> $ : NULL
#> $ dl_filter:List of 1
#> $ na.rm : logi FALSE
#> Caused by error in `httr_retry()` at robonomistServer/R/DatasourceECB.R:95:7:
#> ! Service Unavailable (HTTP 503).
#> ⠼ Requesting data
#> Error: Request failed
#> ✖ Requesting data [9s]
#> 

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
#> ⠹ Requesting data
#> ✔ Requesting data [2.2s]
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
#> ✔ Requesting data [488ms]
#> 
#> # Robonomist id: ec/consumer
#> # Title:         Consumer Sentiment Indicator
#> # Vintage:       2026-04-27 10:30:14
#> # A tibble:      496 × 4
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
#> # ℹ 486 more rows

## Using §-filter with start date:
data("ec/consumer§Fin§Confidence§2020-01-01")
#> ⠙ Requesting data
#> ✔ Requesting data [356ms]
#> 
#> # Robonomist id: ec/consumer
#> # Title:         Consumer Sentiment Indicator
#> # Vintage:       2026-04-27 10:30:14
#> # A tibble:      76 × 4
#>    Country Indicator                                    time       value
#>    <chr>   <chr>                                        <date>     <dbl>
#>  1 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-01-01  -4.3
#>  2 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-02-01  -4.5
#>  3 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-03-01  -7  
#>  4 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-04-01 -14  
#>  5 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-05-01  -9.1
#>  6 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-06-01  -3.9
#>  7 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-07-01  -2  
#>  8 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-08-01  -5.4
#>  9 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-09-01  -6.1
#> 10 Finland Confidence Indicator (Q1 + Q2 + Q4 + Q9) / 4 2020-10-01  -6.8
#> # ℹ 66 more rows
```
