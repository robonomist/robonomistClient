# Examples

## Setup

``` r
library(robonomistClient)
library(tidyverse)
library(roboplotr)
```

## Electricity prices in Finland

``` r
data("entsoe/dap_FI")
#> # Robonomist id: entsoe/dap_FI
#> # Title:         Day ahead price for bidding zone, Finland
#> # Vintage:       2025-11-13 16:00:00
#> # A tibble:      653 × 6
#>    Area  Currency `Measure unit` resolution time                value
#>  * <chr> <chr>    <chr>          <chr>      <dttm>              <dbl>
#>  1 FI    EURO     megawatt hours PT15M      2025-11-07 23:00:00  30.1
#>  2 FI    EURO     megawatt hours PT15M      2025-11-07 23:15:00  27.5
#>  3 FI    EURO     megawatt hours PT15M      2025-11-07 23:30:00  25.9
#>  4 FI    EURO     megawatt hours PT15M      2025-11-07 23:45:00  25.5
#>  5 FI    EURO     megawatt hours PT15M      2025-11-08 00:00:00  29.5
#>  6 FI    EURO     megawatt hours PT15M      2025-11-08 00:15:00  27.8
#>  7 FI    EURO     megawatt hours PT15M      2025-11-08 00:30:00  26.3
#>  8 FI    EURO     megawatt hours PT15M      2025-11-08 00:45:00  26.2
#>  9 FI    EURO     megawatt hours PT15M      2025-11-08 01:00:00  30  
#> 10 FI    EURO     megawatt hours PT15M      2025-11-08 01:15:00  29.3
#> # ℹ 643 more rows

data("entsoe/dap_FI") |>
  ggplot(aes(time, value)) +
  geom_line() +
  labs(
    title = "Electricity prices in Finland",
    subtitle = "Day-ahead market price, €/MWh",
    caption = "Source: ENTSO-E Transparency Platform.",
    x = NULL, y = NULL
  )
```

![](examples_files/figure-html/electricity-1.png)

## FAO food price index

``` r
data("tidy/fao_food_price_index§§Food")  |>
  roboplot(Type)
```

## Economic sentiment indicator

``` r
data("ec/esi_nace§(Fin|Euro area)§sentiment§2000-01-01")  |>
  roboplot(Country, caption = "European Commission")
```

``` r
data("ec/esi_nace2§(Fin|Swe|Ger)§sentiment§2015-01-01") |>
  ggplot(aes(time, value, color = Country)) +
  geom_line() +
  labs(
    title = "Economic Sentiment Indicator",
    subtitle = "Composite index (average = 100)",
    caption = "Source: European Commission.",
    x = NULL, y = NULL
  )
```

![](examples_files/figure-html/sentiment-indicator2-1.png)

## Inflation

``` r
data("eurostat/prc_hicp_manr") |>
  filter(
    coicop %in% c("All-items HICP"),
    geo %in% c("Germany", "Finland", "Sweden"),
    time >= "2015-01-01"
  ) |>
  roboplot(geo, title = "Consumer price inflation", subtitle = "Annual change, %")
#> ⠙ Requesting data
#> ⠹ Requesting data
#> ✔ Requesting data [6s]
#> 
#> Using the attribute "source" for plot caption.
#> roboplotr arranged data 'd' column `geo` using mean of 'value'. Relevel `geo`
#> as factor with levels of your liking to control trace order.
```

## The history of births and deaths in Finland

``` r
data("StatFin/synt/statfin_synt_pxt_12dx.px", tidy_time = TRUE) |>
  filter(Tiedot %in% c("Elävänä syntyneet", "Kuolleet")) |>
  ggplot(aes(time, value/1000, color = Tiedot)) +
  geom_line() +
  labs(
    title = "Elävänä syntyneet ja kuolleet Suomessa",
    subtitle = "Tuhatta henkeä",
    caption = "Lähde: Tilastokeskus.",
    x=NULL, y=NULL
  )
```

![](examples_files/figure-html/vaestonmuutokset-1.png)

## Exporting data to Excel

You can also export the data, for example to an [Excel
file](https://robonomist.github.io/raw/main/man/figures/export.xlsx):

``` r
tbl <-
  data("ec/esi_nace2§(Fin|Swe|Ger)§§2020-01-01") |>
  pivot_wider(names_from = Country)
tbl
#> # A tibble: 490 × 5
#>    Indicator                                   time       Germany Finland Sweden
#>    <chr>                                       <date>       <dbl>   <dbl>  <dbl>
#>  1 Industrial confidence indicator (40%)       2020-01-01   -10.5    -9.7   -1.3
#>  2 Services confidence indicator (30 %)        2020-01-01    19.9    10.1   12.4
#>  3 Consumer confidence indicator (20%)         2020-01-01    -2.9    -4.4   -3.5
#>  4 Retail trade confidence indicator (5%)      2020-01-01    -7.8    -6     21.3
#>  5 Construction confidence indicator (5%)      2020-01-01    14.1    -0.4   10.6
#>  6 The Economic sentiment indicator is a comp… 2020-01-01   104.     96.5   98.6
#>  7 The Employment expectations indicator is a… 2020-01-01   105.    105    102. 
#>  8 Industrial confidence indicator (40%)       2020-02-01   -10.4    -4.9    0.9
#>  9 Services confidence indicator (30 %)        2020-02-01    20.3     7      9.6
#> 10 Consumer confidence indicator (20%)         2020-02-01    -2.3    -4.9   -2.3
#> # ℹ 480 more rows

writexl::write_xlsx(tbl, "export.xlsx")
```
