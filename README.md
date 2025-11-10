
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
[a wide range of
datasources](https://robonomist.github.io/robonomistClient/articles/datasources.html)
via the Robonomist Data Server. With support for **101 569 up-to-date
data tables** across **60 distinct datasources** and **13 languages**,
the package is designed to streamline your data analysis workflow.

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
    #>    dataset          title                                                             languages datasource available
    #>    <r_dataset>      <chr>                                                             <iso2>    <chr>      <lgl>    
    #>  1 StatFin          Statistics Finland, StatFin database                              fi,sv,en  StatFin    TRUE     
    #>  2 StatFin_Passiivi Statistics Finland, StatFin archive database                      fi,sv,en  StatFin_P… TRUE     
    #>  3 Vero             Finnish Tax Administration statistical database                   fi,sv,en  Vero       TRUE     
    #>  4 ec               European Commission's Business and Consumer Surveys               en        EC         TRUE     
    #>  5 kunnat           Key statistics of municipalities, Statistics Finland              fi,sv,en  KuntienAv… TRUE     
    #>  6 kunnat           Financial data reported by municipalities and joint municipal au… fi,sv,en  KuntienTa… TRUE     
    #>  7 paavo            Statistics Finland's Paavo database                               fi,sv,en  Paavo      TRUE     
    #>  8 tulli            Finnish Customs, Uljas Statistical Database                       fi,sv,en  Tulli      TRUE     
    #>  9 luke             Statistics database of Natural Resources Institute Finland (Luke) fi,sv,en  Luke       TRUE     
    #> 10 etk              Finnish Centre for Pensions' statistical database                 fi,sv,en  ETK        TRUE     
    #> # ℹ 50 more rows

### 4. Search and Retrieve Data Tables

The `data()` function allows you to search and retrieve data tables from
the datasources. Here’s how to list all available data tables:

``` r
data()
```

    #> # Robonomist Database search results
    #>    id                                      title                                                               lang 
    #>    <r_id>                                  <chr>                                                               <chr>
    #>  1 StatFin/adopt/statfin_adopt_pxt_11lv.px 11lv -- Adoptiot lapsen syntymämaan, ikäryhmän ja sukupuolen sekä … fi   
    #>  2 StatFin/adopt/statfin_adopt_pxt_13qh.px 13qh -- Adoptiot adoptoitavan vanhempien mukaan, 1999-2024          fi   
    #>  3 StatFin/aku/statfin_aku_pxt_12dz.px     12dz -- Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattii… fi   
    #>  4 StatFin/aku/statfin_aku_pxt_12ea.px     12ea -- Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattii… fi   
    #>  5 StatFin/aku/statfin_aku_pxt_14bu.px     14bu -- Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattii… fi   
    #>  6 StatFin/aku/statfin_aku_pxt_14bv.px     14bv -- Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattii… fi   
    #>  7 StatFin/ava/statfin_ava_pxt_12a9.px     12a9 -- Perusopetuksen vuosiluokkien 1-9 ja lisäopetuksen suoritta… fi   
    #>  8 StatFin/ava/statfin_ava_pxt_12aa.px     12aa -- Aikuisten perusopetuksen oppimäärän suorittaneiden kieliva… fi   
    #>  9 StatFin/ava/statfin_ava_pxt_12ad.px     12ad -- Toisen asteen opiskelijoiden valitsemat vieraat kielet, 20… fi   
    #> 10 StatFin/ava/statfin_ava_pxt_139d.px     139d -- Toisen asteen opiskelijoiden valitsemien vieraiden kielen … fi   
    #> # ℹ 179,165 more rows

Search for tables related to employment:

``` r
data("employment eurostat")
```

    #> # Robonomist Database search results
    #>    id                           title                                                                          lang 
    #>    <r_id>                       <chr>                                                                          <chr>
    #>  1 eurostat/bd_9pm_r2           High growth enterprises (growth by 10% or more) and related employment by NAC… en   
    #>  2 eurostat/bd_9pm_r2$dv_2421   High growth enterprises (growth by 10% or more) and related employment by NAC… en   
    #>  3 eurostat/bd_hg               High growth enterprises and related employment by NACE Rev. 2 activity         en   
    #>  4 eurostat/bd_hg$dv_2307       High growth enterprises and related employment by NACE Rev. 2 activity         en   
    #>  5 eurostat/bd_hg_micro         High growth micro enterprises and related employment by NACE Rev. 2 activity   en   
    #>  6 eurostat/bd_hg_micro$dv_2422 High growth micro enterprises and related employment by NACE Rev. 2 activity   en   
    #>  7 eurostat/bs_bs10_00          Turnover by client specialisation and employment size class (2000)             en   
    #>  8 eurostat/bs_bs1_01           SBS variables by product specialisation and by employment size class for div … en   
    #>  9 eurostat/bs_bs1_03           SBS variables by employment size class for div 72 and 74 (2003)                en   
    #> 10 eurostat/bs_bs1_04           Main economic variables by employment size class (2004)                        en   
    #> # ℹ 511 more rows

Search for a specific dataset with language options:

``` r
data("eurostat/ lfs", lang = "de")
```

These search capabilities help you quickly locate the data you need
without needing to know exact IDs.

### 5. Retrieve a Specific Data Table

If you know the ID of a specific data table you want, you can retrieve
it by passing the ID to the `data()` function. For example:

``` r
data("eurostat/bd_hg") |> tail()
```

    #> # Robonomist id: eurostat/bd_hg
    #> # Title:         High growth enterprises and related employment by NACE Rev. 2 activity
    #> # Vintage:       2025-10-24 23:00:00
    #> # A tibble:      6 × 6
    #>   freq   indic_sbs                                                                  nace_r2   geo   time       value
    #>   <chr>  <chr>                                                                      <chr>     <chr> <date>     <dbl>
    #> 1 Annual Employees in young high-growth enterprises measured in employment - number Other pe… Port… 2023-01-01    NA
    #> 2 Annual Employees in young high-growth enterprises measured in employment - number Other pe… Roma… 2023-01-01   112
    #> 3 Annual Employees in young high-growth enterprises measured in employment - number Other pe… Swed… 2023-01-01    36
    #> 4 Annual Employees in young high-growth enterprises measured in employment - number Other pe… Slov… 2023-01-01     0
    #> 5 Annual Employees in young high-growth enterprises measured in employment - number Other pe… Slov… 2023-01-01     0
    #> 6 Annual Employees in young high-growth enterprises measured in employment - number Other pe… Türk… 2023-01-01    NA

### 6. Fetch Data Using Web Links

TODO: Make this more easier to understand

Happend to find a useful data table on a datasource’s website? For most
datasources, you can easily fetch the data using the `data()` function.
Just copy the link from your browser and pass it to the `data()`
function. For example, if you find a dataset on the OECD website, you
can retrieve it like this:

``` r
data("https://data-explorer.oecd.org/vis?tm=sna&pg=0&fs[0]=Measure%2C0%7CAquaculture%20production%23AQUA_PD%23&fc=Measure&snb=1&vw=tb&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_FISH_PROD%40DF_FISH_AQUA&df[ag]=OECD.TAD.ARP&df[vs]=1.0&pd=2010%2C&dq=.A.._T.T&ly[rw]=REF_AREA&ly[cl]=TIME_PERIOD&to[TIME_PERIOD]=false")
```

    #> ℹ The URL points to a data table in dataset "oecd".

    #> ℹ For direct data retrieval, use:
    #> >  data_get("oecd/DSD_FISH_PROD@DF_FISH_AQUA", dl_filter = ".A.._T.T")

    #> # Robonomist id: oecd/DSD_FISH_PROD@DF_FISH_AQUA
    #> # Title:         Aquaculture production
    #> # Vintage:       2025-03-10 14:23:35
    #> # A tibble:      1,456 × 10
    #>    REF_AREA  FREQ   MEASURE                SPECIES UNIT_MEASURE time       value UNIT_MULT DECIMALS CONVENTION
    #>  * <chr>     <chr>  <chr>                  <chr>   <chr>        <date>     <dbl> <chr>     <chr>    <chr>     
    #>  1 Argentina Annual Aquaculture production Total   Tonnes       1995-01-01  1474 0         0        LW        
    #>  2 Argentina Annual Aquaculture production Total   Tonnes       1996-01-01  1322 0         0        LW        
    #>  3 Argentina Annual Aquaculture production Total   Tonnes       1997-01-01  1314 0         0        LW        
    #>  4 Argentina Annual Aquaculture production Total   Tonnes       1998-01-01  1040 0         0        LW        
    #>  5 Argentina Annual Aquaculture production Total   Tonnes       1999-01-01  1218 0         0        LW        
    #>  6 Argentina Annual Aquaculture production Total   Tonnes       2000-01-01  1784 0         0        LW        
    #>  7 Argentina Annual Aquaculture production Total   Tonnes       2001-01-01  1340 0         0        LW        
    #>  8 Argentina Annual Aquaculture production Total   Tonnes       2002-01-01  1457 0         0        LW        
    #>  9 Argentina Annual Aquaculture production Total   Tonnes       2003-01-01  1647 0         0        LW        
    #> 10 Argentina Annual Aquaculture production Total   Tonnes       2004-01-01  1848 0         0        LW        
    #> # ℹ 1,446 more rows

### 7. Retrieve Data for Production Use

RobonomistClient is designed to work as stable platform for building
dynamic documents and automatically updating data applications. To
ensure robustness in production use cases, the package provides the
`data_get()` function. It uses data table IDs directly, avoiding the
need for searching and ensuring consistent data retrieval.

``` r
# Fetch a specific dataset using its ID for production use
production_data <- data_get("StatFin/synt/statfin_synt_pxt_12dx.px")
```

## More information

For more detailed information and examples, check the package
documentation:

- [Basic
  features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
- [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
- [Filtering large data
  tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
