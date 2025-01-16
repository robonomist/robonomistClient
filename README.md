
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

The `robonomistClient` package is a powerful R client designed to
simplify access to diverse datasets hosted on the Robonomist Data
Server. With seamless integration, the package enables analysts,
researchers, and developers to retrieve and analyze up-to-date,
multilingual data from numerous national and international sources, all
in a tidy format ready for analysis.

## Key Features

The robonomistClient package is designed to deliver:

**Comprehensive Data Coverage**

Access data from national statistical agencies, international
organizations, and regional sources — all in one place. This means less
time spent searching for data and more time for analysis.

- Statistics Finland, OECD, World Bank, European Central Bank, and more.

**High Data Fidelity and Trust**

Our data is reliable and accurately reflects the information from
official statistical agencies. Complete metadata is provided for every
dataset to ensure that your analysis is based on credible information.

- Full transparency on data sources.
- Detailed metadata included.

**Flexibility in Data Retrieval**

Customize the way data is retrieved to fit your specific needs:

- Multilingual support
- Choose between variable labels or codes.
- Interpret time variables as dates or raw values.

**Seamless Integration for Dynamic Workflows**

Designed to work smoothly with R, robonomistClient makes building
dynamic documents and automatically updating apps easier by providing a
stable API:

- Reduce disruptions caused by changing official statistics APIs.
- Focus on insights rather than wrangling with data inconsistencies.

## Datasources

The `robonomistClient` package provides seamless and efficient access to
a wide range of datasources via the Robonomist Data Server. With support
for **95 197 up-to-date data tables** across **57 distinct datasources**
and **13 languages**, the package is designed to streamline your data
analysis workflow.

**International Datasources**

- **Global Institutions**: OECD, International Monetary Fund (IMF),
  World Bank, United Nations Economic Commission for Europe Statistical
  Database (UNECE), United Nations Conference on Trade and Development
  (UNCTAD), FAO (Food and Agriculture Organization), Bank for
  International Settlements (BIS).
- **European Union**: Eurostat, European Commission, European Central
  Bank (ECB).
- **Nordic Countries**: Statistics Sweden, Swedish National Institute of
  Economic Research, Swedish Agricultural Agency, Statistics Norway,
  Statistics Denmark, Statistics Iceland, Statistics Estonia, Nordic
  Statistics Database.

**Finnish Datasources**

- **Statistics Finland**: StatFin, StatFin archive databases, Municipal
  figures & financial data, Paavo postal code area statistics,
  experimental statistics, immigrants and integration database.
- **Regional Data**: Helsingin seudun aluesarjat -tilastotietokanta,
  Helsingin ympäristötilasto.
- **National Agencies**: Finnish Tax Administration, Finnish Centre for
  Pensions, Natural Resources Institute Finland (LUKE), Traficom
  (Finnish Transport and Communications Agency), Customs Finland, THL
  Sotkanet, Vipunen (Education Statistics Finland), Fingrid,
  TutkiHallintoa.fi (Valtiokonttori).

**Thematic & Specialized Datasources**

- **Energy & Environment**: Entso-E Transparency Platform, U.S. Energy
  Information Administration database, Fingrid.
- **Financial**: Deutsche Bundesbank time series database, FRED (Federal
  Reserve Economic Data\*\*.
- **Health & Pandemic Data**: THL Epirapo, ECDC.

This list highlights just some of the many datasources available through
the `robonomistClient package`. The package also includes **Robonomist’s
curated tidy data tables**, providing ready-to-use datasets tailored for
streamlined analysis and insight generation.

## Getting started

To setup a Robonomist Data Server for your organization, please contact
<team@robonomist.com>.

### 1. Install the Package

First, install the package from GitHub (if you haven’t already):

``` r
# Install devtools if necessary
# install.packages("devtools")

# Install the latest version of robonomistClient from GitHub
devtools::install_github("robonomist/robonomistClient")
```

### 2. Set Up Your Connection

To start using the package, you need to set the hostname of your
Robonomist Data Server and provide an access token. Use the set
`robonomist_server()` function to establish the connection.

``` r
library(robonomistClient)

# Set up the connection
set_robonomist_server(hostname = "hostname.com", access_token = "abc")
```

### 3. Explore Available Datasources

To see which datasources are available, use the `datasources()`
function. This will give you an overview of all the datasources you can
access.

``` r
datasources()
```

    #> # Robonomist Server Datasources
    #>    dataset          title                                          languages
    #>    <r_dataset>      <chr>                                          <iso2>   
    #>  1 StatFin          Statistics Finland, StatFin database           fi,sv,en 
    #>  2 StatFin_Passiivi Statistics Finland, StatFin archive database   fi,sv,en 
    #>  3 Vero             Finnish Tax Administration statistical databa… fi,sv,en 
    #>  4 ec               European Commission's Business and Consumer S… en       
    #>  5 kunnat           Key statistics of municipalities, Statistics … fi,sv,en 
    #>  6 kunnat           Financial data reported by municipalities and… fi,sv,en 
    #>  7 paavo            Statistics Finland's Paavo database            fi,sv,en 
    #>  8 tulli            Finnish Customs, Uljas Statistical Database    fi,sv,en 
    #>  9 luke             Statistics database of Natural Resources Inst… fi,sv,en 
    #> 10 etk              Finnish Centre for Pensions' statistical data… fi,sv,en 
    #> # ℹ 47 more rows
    #> # ℹ 2 more variables: datasource <chr>, available <lgl>

### 4. Search and Retrieve Data Tables

The `data()` function allows you to search and retrieve data tables from
the datasources. Here’s how to list all available data tables:

``` r
data()
```

    #> # Robonomist Database search results
    #>    id                                      title                       lang 
    #>    <r_id>                                  <chr>                       <chr>
    #>  1 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptiot muuttujina Vuosi,… fi   
    #>  2 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptioner efter År, Födel… sv   
    #>  3 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptions by Year, Country… en   
    #>  4 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptiot muuttujina Vuosi,… fi   
    #>  5 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptioner efter År, Föräl… sv   
    #>  6 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptions by Year, Parents… en   
    #>  7 StatFin/aku/statfin_aku_pxt_12dz.px     Aikuiskoulutukseen osallis… fi   
    #>  8 StatFin/aku/statfin_aku_pxt_12dz.px     Deltagande i vuxenutbildni… sv   
    #>  9 StatFin/aku/statfin_aku_pxt_12dz.px     Participation in adult edu… en   
    #> 10 StatFin/aku/statfin_aku_pxt_12ea.px     Aikuiskoulutukseen osallis… fi   
    #> # ℹ 170,260 more rows

- Search for tables related to employment:

  ``` r
  data("Employment")
  ```

      #> # Robonomist Database search results
      #>    id                                        title                     lang 
      #>    <r_id>                                    <chr>                     <chr>
      #>  1 StatFin/altp/statfin_altp_pxt_12bg.px     Employment and hours wor… en   
      #>  2 StatFin/klt/statfin_klt_pxt_13jb.px       Employment of students s… en   
      #>  3 StatFin/ntp/statfin_ntp_pxt_11tj.px       Employment and hours wor… en   
      #>  4 StatFin/tyokay/statfin_tyokay_pxt_115b.px Population by Area, Main… en   
      #>  5 StatFin/tyokay/statfin_tyokay_pxt_115c.px Population by Main type … en   
      #>  6 StatFin/tyokay/statfin_tyokay_pxt_115d.px Population by Area, Main… en   
      #>  7 StatFin/tyokay/statfin_tyokay_pxt_115e.px Population by Main type … en   
      #>  8 StatFin/tyokay/statfin_tyokay_pxt_115f.px Population by Area, Main… en   
      #>  9 StatFin/tyokay/statfin_tyokay_pxt_115g.px Population by Main type … en   
      #> 10 StatFin/tyokay/statfin_tyokay_pxt_115h.px Employed labour force in… en   
      #> # ℹ 3,656 more rows

- Search for a specific dataset with language options:

  ``` r
  data("StatFin/ntp", lang = "en")
  ```

      #> # Robonomist Database search results
      #>   id                                  title                            lang 
      #>   <r_id>                              <chr>                            <chr>
      #> 1 StatFin/ntp/statfin_ntp_pxt_11tj.px Employment and hours worked qua… en   
      #> 2 StatFin/ntp/statfin_ntp_pxt_132g.px Income and production by indust… en   
      #> 3 StatFin/ntp/statfin_ntp_pxt_132h.px Gross domestic product and nati… en

These search capabilities help you quickly locate the data you need
without needing to know exact IDs.

### 5. Retrieve a Specific Data Table

If you know the ID of a specific data table you want, you can retrieve
it by passing the ID to the `data()` function. For example:

``` r
data("StatFin/synt/statfin_synt_pxt_12dx.px")
```

    #> # Robonomist id: StatFin/synt/statfin_synt_pxt_12dx.px
    #> # Title:         Väestönmuutokset muuttujina Vuosi ja Tiedot
    #> # Last updated:  2024-05-28 08:00:00
    #> # Next update:   2025-05-20 08:00:00
    #> # A tibble:      3,025 × 3
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
    #> # ℹ 3,015 more rows

#### Retrieve Data for Production Use

The `data_get()` function is designed for production use cases where
robustness is crucial. It allows you to fetch a specific dataset by its
ID directly, without any searching. This ensures consistency, especially
in automated scripts or applications where you need to reliably retrieve
the same dataset over time.

``` r
# Fetch a specific dataset using its ID for production use
production_data <- data_get("StatFin/synt/statfin_synt_pxt_12dx.px")
```

#### Fetch Data Directly Using a URL

You can also fetch data directly using a link from the datasource’s
website using `fetch_data_from_url()`. This is useful when you have a
specific URL from a datasource explorer, such as the OECD’s data
explorer:

``` r
fetch_data_from_url("https://data-explorer.oecd.org/vis?tm=sna&pg=0&fs[0]=Measure%2C0%7CAquaculture%20production%23AQUA_PD%23&fc=Measure&snb=1&vw=tb&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_FISH_PROD%40DF_FISH_AQUA&df[ag]=OECD.TAD.ARP&df[vs]=1.0&pd=2010%2C&dq=.A.._T.T&ly[rw]=REF_AREA&ly[cl]=TIME_PERIOD&to[TIME_PERIOD]=false")
```

    #> data_get("oecd/DSD_FISH_PROD@DF_FISH_AQUA", dl_filter = ".A.._T.T")

    #> # Robonomist id: oecd/DSD_FISH_PROD@DF_FISH_AQUA
    #> # Title:         Aquaculture production
    #> # Vintage:       2024-07-25 09:39:34
    #> # A tibble:      1,431 × 10
    #>    REF_AREA  FREQ   MEASURE  SPECIES UNIT_MEASURE time       value UNIT_MULT
    #>  * <chr>     <chr>  <chr>    <chr>   <chr>        <date>     <dbl> <chr>    
    #>  1 Argentina Annual Aquacul… Total   Tonnes       1995-01-01  1474 0        
    #>  2 Argentina Annual Aquacul… Total   Tonnes       1996-01-01  1322 0        
    #>  3 Argentina Annual Aquacul… Total   Tonnes       1997-01-01  1314 0        
    #>  4 Argentina Annual Aquacul… Total   Tonnes       1998-01-01  1040 0        
    #>  5 Argentina Annual Aquacul… Total   Tonnes       1999-01-01  1218 0        
    #>  6 Argentina Annual Aquacul… Total   Tonnes       2000-01-01  1784 0        
    #>  7 Argentina Annual Aquacul… Total   Tonnes       2001-01-01  1340 0        
    #>  8 Argentina Annual Aquacul… Total   Tonnes       2002-01-01  1457 0        
    #>  9 Argentina Annual Aquacul… Total   Tonnes       2003-01-01  1647 0        
    #> 10 Argentina Annual Aquacul… Total   Tonnes       2004-01-01  1848 0        
    #> # ℹ 1,421 more rows
    #> # ℹ 2 more variables: DECIMALS <chr>, CONVENTION <chr>

## More information

For more detailed information and examples, check the package
documentation:

- [Basic
  features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
- [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
- [Filtering large data
  tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
