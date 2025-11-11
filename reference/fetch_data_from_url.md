# Parse and Retrieve Data from URL

**\[deprecated\]**

This function was deprecated because
[`data()`](https://robonomist.github.io/robonomistClient/reference/data.md)
function now supports direct data fetching from various datasources.

The `fetch_data_from_url()` function is designed to facilitate easy
access to data by parsing a copied URL from websites of various
datasources. It forms a query to the database and retrieves the data in
R using the `robonomistclient` package.

Currently supported sites:

- [OECD Data Explorer](https://data-explorer.oecd.org/)

- [Eurostat Data
  Explorer](https://ec.europa.eu/eurostat/databrowser/explore/all/all_themes)

- [ECB Data Portal](https://data.ecb.europa.eu/)

- [World Bank](https://data.worldbank.org/)

- [Fred Economic Data](https://fred.stlouisfed.org/)

- [Bank of International Settlements, BIS](https://data.bis.org/)

- [Databases of Statistics
  Finland](https://stat.fi/tup/tilastotietokannat/index.html)

- [Database of Finnish Centre for
  Pensions](https://tilastot.etk.fi/pxweb/en/ETK)

- [Statistics
  Sweden](https://www.statistikdatabasen.scb.se/pxweb/sv/ssd/)

## Usage

``` r
fetch_data_from_url(url, get = TRUE)
```

## Arguments

- url:

  A character string representing the URL copied from the datasource's
  website when a particular dataset is selected.

- get:

  A logical value indicating whether to execute the query and return the
  data (`TRUE`, default) or just return the query string (`FALSE`).

## Value

If `get` is `TRUE`, the function returns the queried data. If `get` is
`FALSE`, it returns the query string.

## Examples

``` r
# Example usage:
url <- "https://data-explorer.oecd.org/vis?tm=sna&pg=0&fs[0]=Measure%2C0%7CAquaculture%20production%23AQUA_PD%23&fc=Measure&snb=1&vw=tb&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_FISH_PROD%40DF_FISH_AQUA&df[ag]=OECD.TAD.ARP&df[vs]=1.0&pd=2010%2C&dq=.A.._T.T&ly[rw]=REF_AREA&ly[cl]=TIME_PERIOD&to[TIME_PERIOD]=false"
fetch_data_from_url(url)
#> Warning: `fetch_data_from_url()` was deprecated in robonomistClient 2.2.22.
#> ℹ Please use `data()` instead.
#> data_get("oecd/DSD_FISH_PROD@DF_FISH_AQUA", dl_filter = ".A.._T.T") 
#> ⠙ Requesting get
#> ✔ Requesting get [220ms]
#> 
#> # Robonomist id: oecd/DSD_FISH_PROD@DF_FISH_AQUA
#> # Title:         Aquaculture production
#> # Vintage:       2025-03-10 14:23:35
#> # A tibble:      1,456 × 10
#>    REF_AREA  FREQ   MEASURE      SPECIES UNIT_MEASURE time       value UNIT_MULT
#>  * <chr>     <chr>  <chr>        <chr>   <chr>        <date>     <dbl> <chr>    
#>  1 Argentina Annual Aquaculture… Total   Tonnes       1995-01-01  1474 0        
#>  2 Argentina Annual Aquaculture… Total   Tonnes       1996-01-01  1322 0        
#>  3 Argentina Annual Aquaculture… Total   Tonnes       1997-01-01  1314 0        
#>  4 Argentina Annual Aquaculture… Total   Tonnes       1998-01-01  1040 0        
#>  5 Argentina Annual Aquaculture… Total   Tonnes       1999-01-01  1218 0        
#>  6 Argentina Annual Aquaculture… Total   Tonnes       2000-01-01  1784 0        
#>  7 Argentina Annual Aquaculture… Total   Tonnes       2001-01-01  1340 0        
#>  8 Argentina Annual Aquaculture… Total   Tonnes       2002-01-01  1457 0        
#>  9 Argentina Annual Aquaculture… Total   Tonnes       2003-01-01  1647 0        
#> 10 Argentina Annual Aquaculture… Total   Tonnes       2004-01-01  1848 0        
#> # ℹ 1,446 more rows
#> # ℹ 2 more variables: DECIMALS <chr>, CONVENTION <chr>
fetch_data_from_url(url, get = FALSE)
#> data_get("oecd/DSD_FISH_PROD@DF_FISH_AQUA", dl_filter = ".A.._T.T")
# StatFin
fetch_data_from_url("https://statfin.stat.fi/PxWeb/pxweb/fi/StatFin/StatFin__aku/statfin_aku_pxt_12ea.px/")
#> data_get("StatFin/aku/statfin_aku_pxt_12ea.px") 
#> ⠙ Requesting get
#> ✔ Requesting get [232ms]
#> 
#> # Robonomist id: StatFin/aku/statfin_aku_pxt_12ea.px
#> # Title:         12ea -- Aikuiskoulutukseen osallistuminen (ml. työhön tai
#> #   ammattiin liittyvä, henkilöstökoulutus sekä muu kuin työhön liittyvä
#> #   aikuiskoulutus) sukupuolittain, 1990-2022
#> # Last updated:  2023-10-06 08:00:00
#> # A tibble:      168 × 4
#>    Vuosi Sukupuoli Tiedot                                                  value
#>  * <chr> <chr>     <chr>                                                   <dbl>
#>  1 1990  Yhteensä  Aikuiskoulutukseen osallistuneet, lkm                  1.53e6
#>  2 1990  Yhteensä  Aikuiskoulutukseen osallistuneet, %                    4.7 e1
#>  3 1990  Yhteensä  Työhön tai ammattiin liittyvään aikuiskoulutukseen os… 1.09e6
#>  4 1990  Yhteensä  Työhön tai ammattiin liittyvään aikuiskoulutukseen os… 4.4 e1
#>  5 1990  Yhteensä  Työnantajan tukemaan koulutukseen (henkilöstökoulutuk… 9.69e5
#>  6 1990  Yhteensä  Työnantajan tukemaan koulutukseen (henkilöstökoulutuk… 4.7 e1
#>  7 1990  Yhteensä  Muuhun kuin työhön tai ammattiin liittyvään aikuiskou… 5.45e5
#>  8 1990  Yhteensä  Muuhun kuin työhön tai ammattiin liittyvään aikuiskou… 1.8 e1
#>  9 1990  Miehet    Aikuiskoulutukseen osallistuneet, lkm                  6.98e5
#> 10 1990  Miehet    Aikuiskoulutukseen osallistuneet, %                    4.3 e1
#> # ℹ 158 more rows

# Eurostat fetch_data_from_url("https://ec.europa.eu/eurostat/databrowser/view/cens_hnmga/default/table?lang=en&category=cens.cens_hn.cens_hnstr")

# ECB
fetch_data_from_url("https://data.ecb.europa.eu/data/datasets/ICP/ICP.M.U2.N.000000.4.ANR")
#> data_get("ecb/ICP", dl_filter = "M.U2.N.000000.4.ANR") 
#> ⠙ Requesting get
#> ✔ Requesting get [174ms]
#> 
#> # Robonomist id: ecb/ICP
#> # Title:         Indices of Consumer prices
#> # Vintage:       2025-11-11 08:00:00
#> # A tibble:      346 × 8
#>    Frequency `Reference area`      `Adjustment indicator` Classification - ICP…¹
#>  * <chr>     <chr>                 <chr>                  <chr>                 
#>  1 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  2 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  3 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  4 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  5 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  6 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  7 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  8 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#>  9 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#> 10 Monthly   Euro area (changing … Neither seasonally no… HICP - Overall index  
#> # ℹ 336 more rows
#> # ℹ abbreviated name: ¹​`Classification - ICP context`
#> # ℹ 4 more variables: `Institution originating the data flow` <chr>,
#> #   `Series variation - ICP context` <chr>, time <date>, value <dbl>

# World bank
fetch_data_from_url("https://data.worldbank.org/indicator/SH.DYN.MORT?locations=1W&start=1990&view=chart")
#> data_get("wb/SH.DYN.MORT") 
#> ⠙ Requesting get
#> ✔ Requesting get [189ms]
#> 
#> # Robonomist id: wb/SH.DYN.MORT
#> # Title:         Mortality rate, under-5 (per 1,000 live births)
#> # Vintage:       2025-11-11 06:19:53.842075
#> # A tibble:      18,590 × 6
#>    indicator                                iso2c iso3c country time       value
#>  * <chr>                                    <chr> <chr> <chr>   <date>     <dbl>
#>  1 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1960-01-01    NA
#>  2 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1961-01-01    NA
#>  3 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1962-01-01    NA
#>  4 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1963-01-01    NA
#>  5 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1964-01-01    NA
#>  6 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1965-01-01    NA
#>  7 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1966-01-01    NA
#>  8 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1967-01-01    NA
#>  9 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1968-01-01    NA
#> 10 Mortality rate, under-5 (per 1,000 live… ZH    AFE   Africa… 1969-01-01    NA
#> # ℹ 18,580 more rows

# Fred
fetch_data_from_url("https://fred.stlouisfed.org/series/FPCPITOTLZGUSA")
#> data_get("fred/FPCPITOTLZGUSA") 
#> ⠙ Requesting get
#> ✔ Requesting get [537ms]
#> 
#> # Robonomist id: fred/FPCPITOTLZGUSA
#> # Title:         Inflation, consumer prices for the United States
#> # Vintage:       2025-04-16 18:53:02
#> # A tibble:      65 × 7
#>    series_id      Title   Frequency Units `Seasonal adjustment` time       value
#>  * <chr>          <chr>   <chr>     <chr> <chr>                 <date>     <dbl>
#>  1 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1960-01-01  1.46
#>  2 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1961-01-01  1.07
#>  3 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1962-01-01  1.20
#>  4 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1963-01-01  1.24
#>  5 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1964-01-01  1.28
#>  6 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1965-01-01  1.59
#>  7 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1966-01-01  3.02
#>  8 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1967-01-01  2.77
#>  9 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1968-01-01  4.27
#> 10 FPCPITOTLZGUSA Inflat… Annual    Perc… Not Seasonally Adjus… 1969-01-01  5.46
#> # ℹ 55 more rows

# BIS
fetch_data_from_url("https://data.bis.org/topics/RPP/BIS,WS_SPP,1.0/Q.5R.N.628")
#> data_get("bis/WS_SPP", dl_filter = "Q.5R.N.628") 
#> ⠙ Requesting get
#> ✔ Requesting get [212ms]
#> 
#> # Robonomist id: bis/WS_SPP
#> # Title:         Selected residential property prices
#> # Vintage:       2025-11-12 08:00:00
#> # A tibble:      34,876 × 6
#>    Frequency `Reference area` Value `Unit of measure`          time        value
#>  * <chr>     <chr>            <chr> <chr>                      <date>      <dbl>
#>  1 Quarterly Czechia          Real  Year-on-year changes, in … 2009-01-01  0.654
#>  2 Quarterly Czechia          Real  Year-on-year changes, in … 2009-04-01 -5.76 
#>  3 Quarterly Czechia          Real  Year-on-year changes, in … 2009-07-01 -6.72 
#>  4 Quarterly Czechia          Real  Year-on-year changes, in … 2009-10-01 -7.20 
#>  5 Quarterly Czechia          Real  Year-on-year changes, in … 2010-01-01 -5.32 
#>  6 Quarterly Czechia          Real  Year-on-year changes, in … 2010-04-01 -2.58 
#>  7 Quarterly Czechia          Real  Year-on-year changes, in … 2010-07-01 -2.71 
#>  8 Quarterly Czechia          Real  Year-on-year changes, in … 2010-10-01 -2.00 
#>  9 Quarterly Czechia          Real  Year-on-year changes, in … 2011-01-01 -1.53 
#> 10 Quarterly Czechia          Real  Year-on-year changes, in … 2011-04-01 -1.21 
#> # ℹ 34,866 more rows

# SCB
fetch_data_from_url("https://www.statistikdatabasen.scb.se/pxweb/sv/ssd/START__EN__EN0302/SSDArGasavtal/")
#> data_get("se/EN/EN0302/SSDArGasavtal") 
#> ⠙ Requesting get
#> ✔ Requesting get [537ms]
#> 
#> # Robonomist id: se/EN/EN0302/SSDArGasavtal
#> # Title:         Change of natural gas supplier. Year 2008 - 2024
#> # Last updated:  2025-03-28 14:37:00
#> # A tibble:      68 × 5
#>    `consumer category` `customers or installations` observations     year  value
#>  * <chr>               <chr>                        <chr>            <chr> <dbl>
#>  1 households          number of customers          Change of natur… 2008     NA
#>  2 households          number of customers          Change of natur… 2009    285
#>  3 households          number of customers          Change of natur… 2010    266
#>  4 households          number of customers          Change of natur… 2011    281
#>  5 households          number of customers          Change of natur… 2012    157
#>  6 households          number of customers          Change of natur… 2013    238
#>  7 households          number of customers          Change of natur… 2014    452
#>  8 households          number of customers          Change of natur… 2015    170
#>  9 households          number of customers          Change of natur… 2016    226
#> 10 households          number of customers          Change of natur… 2017    354
#> # ℹ 58 more rows
```
