
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 96 420 up-to-date data tables from 58
different datasources with 13 different languages.

Some of the integrated datasources:

- Statistics Finland (StatFin & StatFin archive databases)
- Statistics Finland municipal data (Key figures & Financial data)
- Paavo postal code area statistics by Statistics Finland
- Experimental statistics by Statistics Finland
- Immigrants and integration database by Statistics Finland
- Finnish Tax Administration
- Finnish Centre for Pensions
- Natural Resources Institute Finland (Luonnonvarakeskus LUKE)
- Traficom database (The Finnish Transport and Communications Agency)
- Customs Finland
- THL Sotkanet
- Vipunen, Education Statistics Finland
- Helsingin seudun aluesarjat -tilastotietokanta
- Helsingin ympäristötilasto
- Fingrid
- TutkiHallintoa.fi (Valtiokonttori)
- Eurostat
- European Commission Business and consumer surveys
- World Bank
- OECD
- European Central Bank (ECB) Statistical data warehouse
- Deutsche Bundesbank time series database
- COVID-19 data (THL Epirapo, ECDC, and covid19datahub.io)
- Statistics Sweden
- The Swedish National Institute of Economic Research
- Swedish Agricultural Agency
- Statistics Norway
- Statistics Denmark
- Statistics Iceland
- Statistics Estonia
- Bank for International Settlements (BIS)
- International Monetary Fund (IMF)
- United Nations Economic Commission for Europe Statistical Database
- United Nations Conference on Trade and Development
- FAO, Food and Agriculture Organization of the United Nations
- Nordic Statistics Database
- U.S. Energy Information Administration database
- FRED, Federal Reserve Economic Data, St. Louis Fed
- Entso-E Transperancy Platform
- Robonomist’s curated tidy data tables

To setup a Robonomist Data Server for your organization, please contact
<team@robonomist.com>.

## Installation

Install the development version from github:

``` r
## install.packages("devtools")
devtools::install_github("robonomist/robonomistClient")
```

## Getting started

Once installed, set the hostname of your Robonomist Data Server and
connnect with `set_robonomist_server` function. Then you can start
exploring the database.

``` r
library(robonomistClient)
set_robonomist_server(hostname = "hostname.com", access_token = "xyz")
```

List all available datasources:

``` r
datasources()
```

    ## # Robonomist Server Datasources
    ##    dataset                  title                                                    languages          
    ##  1 StatFin                  Statistics Finland, StatFin database                     c("fi", "sv", "en")
    ##  2 StatFin_Passiivi         Statistics Finland, StatFin archive database             c("fi", "sv", "en")
    ##  3 Vero                     Finnish Tax Administration statistical database          c("fi", "sv", "en")
    ##  4 ec                       European Commission's Business and Consumer Surveys      en                 
    ##  5 kunnat                   Key statistics of municipalities, Statistics Finland     c("fi", "sv", "en")
    ##  6 kunnat                   Financial data reported by municipalities and joint mun… c("fi", "sv", "en")
    ##  7 paavo                    Statistics Finland's Paavo database                      c("fi", "sv", "en")
    ##  8 tulli                    Finnish Customs, Uljas Statistical Database              c("fi", "sv", "en")
    ##  9 luke                     Statistics database of Natural Resources Institute Finl… c("fi", "sv", "en")
    ## 10 etk                      Finnish Centre for Pensions' statistical database        c("fi", "sv", "en")
    ## 11 eurostat                 Eurostat database                                        c("en", "de", "fr")
    ## 12 ecb                      ECB Statistical Data Warehouse                           en                 
    ## 13 bundesbank               Deutsche Bundesbank time series database                 c("en", "de")      
    ## 14 oecd                     OECD database                                            en                 
    ## 15 wb                       World Bank Open Data                                     en                 
    ## 16 hsa                      Greater Helsinki Open Statistical Databases, Aluesarjat  c("fi", "sv", "en")
    ## 17 helymp                   Helsinki environmental statistics                        c("fi", "en", "sv")
    ## 18 helhyv                   Helsinki wellbeing statistics                            fi                 
    ## 19 nordstat                 Nordstat                                                 c("fi", "en", "sv")
    ## 20 covid                    European Centre for Disease Prevention and Control COVI… en                 
    ## 21 vipunen                  Vipunen, Education Statistics Finland                    fi                 
    ## 22 epirapo                  THL Epirapo COVID-19 database                            fi                 
    ## 23 sotkanet                 Sotkanet indicator bank of the Finnish Institute for He… c("fi", "en", "sv")
    ## 24 maakoto                  Immigrants and integration statistics, Statistics Finla… c("fi", "sv", "en")
    ## 25 koto                     Integration database, Finnish Ministry of Economic Affa… c("fi", "sv", "en")
    ## 26 toimipaikkalaskuri       Toimipaikkalaskuri database, Statitstics Finland         fi                 
    ## 27 kokeelliset              Statistics Finland's experimental statistics             c("fi", "sv", "en")
    ## 28 traficom                 Traficom statistics database                             c("fi", "sv", "en")
    ## 29 tieliikenneonnettomuudet Road traffic accidents statistical database, Statistics… c("fi", "sv", "en")
    ## 30 rudolf                   Rudolf statistical database, Business Finland            c("fi", "en")      
    ## # ℹ 28 more rows
    ## # ℹ 2 more variables: datasource <chr>, available <lgl>

The `data` function is convenient way to search and get data tables.
Print all available data tables:

``` r
data()
```

    ## # Robonomist Database search results
    ##    id                                      title                                                              lang 
    ##    <r_id>                                  <chr>                                                              <chr>
    ##  1 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptiot muuttujina Vuosi, Syntymävaltio, Adoptiotyyppi, Ikä, Suk… fi   
    ##  2 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptioner efter År, Födelseland, Typ av adoption, Ålder, Kön och… sv   
    ##  3 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptions by Year, Country of birth, Adoption type, Age, Sex and … en   
    ##  4 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptiot muuttujina Vuosi, Adoptoitavan vanhemmat ja Tiedot        fi   
    ##  5 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptioner efter År, Föräldrarna till den som adopteras och Uppgi… sv   
    ##  6 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptions by Year, Parents of the adopted person and Information   en   
    ##  7 StatFin/aku/statfin_aku_pxt_12dz.px     Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattiin liitt… fi   
    ##  8 StatFin/aku/statfin_aku_pxt_12dz.px     Deltagande i vuxenutbildning (inkl. arbets- eller yrkesinriktad, … sv   
    ##  9 StatFin/aku/statfin_aku_pxt_12dz.px     Participation in adult education (incl. adult education and train… en   
    ## 10 StatFin/aku/statfin_aku_pxt_12ea.px     Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattiin liitt… fi   
    ## 11 StatFin/aku/statfin_aku_pxt_12ea.px     Deltagande i vuxenutbildning (inkl. arbets- eller yrkesinriktad, … sv   
    ## 12 StatFin/aku/statfin_aku_pxt_12ea.px     Participation in adult education (incl. adult education and train… en   
    ## 13 StatFin/aku/statfin_aku_pxt_14bu.px     Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattiin liitt… fi   
    ## 14 StatFin/aku/statfin_aku_pxt_14bu.px     Deltagande i vuxenutbildning (inkl. arbets- eller yrkesinriktad, … sv   
    ## 15 StatFin/aku/statfin_aku_pxt_14bu.px     Participation in adult education and training (incl. adult educat… en   
    ## 16 StatFin/aku/statfin_aku_pxt_14bv.px     Aikuiskoulutukseen osallistuminen (ml. työhön tai ammattiin liitt… fi   
    ## 17 StatFin/aku/statfin_aku_pxt_14bv.px     Deltagande i vuxenutbildning (inkl. arbets- eller yrkesinriktad, … sv   
    ## 18 StatFin/aku/statfin_aku_pxt_14bv.px     Participation in adult education and training (incl. adult educat… en   
    ## 19 StatFin/altp/statfin_altp_pxt_12bc.px   Bruttokansantuote henkeä kohden kohden alueittain, vuosittain muu… fi   
    ## 20 StatFin/altp/statfin_altp_pxt_12bc.px   Bruttonationalprodukt per person och region, årsvis efter Region,… sv   
    ## 21 StatFin/altp/statfin_altp_pxt_12bc.px   Gross domestic product per capita by area, annually by Area, Year… en   
    ## 22 StatFin/altp/statfin_altp_pxt_12bd.px   Tulot ja tuotanto alueittain, vuosittain muuttujina Alue, Taloust… fi   
    ## 23 StatFin/altp/statfin_altp_pxt_12bd.px   Inkomster och produktion per region, årsvis efter Region, Transak… sv   
    ## 24 StatFin/altp/statfin_altp_pxt_12bd.px   Income and production by area, annually by Area, Transaction, Ind… en   
    ## 25 StatFin/altp/statfin_altp_pxt_12be.px   Investoinnit ja kiinteä pääoma alueittain, vuosittain muuttujina … fi   
    ## 26 StatFin/altp/statfin_altp_pxt_12be.px   Investeringar och fast kapital per region, årsvis efter Region, T… sv   
    ## 27 StatFin/altp/statfin_altp_pxt_12be.px   Investments and fixed capital by area, annually by Area, Transact… en   
    ## 28 StatFin/altp/statfin_altp_pxt_12bf.px   Kotitalouksien tulot ja menot alueittain, vuosittain muuttujina S… fi   
    ## 29 StatFin/altp/statfin_altp_pxt_12bf.px   Hushållens inkomster och utgifter per region, årsvis efter Sektor… sv   
    ## 30 StatFin/altp/statfin_altp_pxt_12bf.px   Household income and expenditure by area, annually by Sector, Are… en   
    ## # ℹ 171,700 more rows

To get a specific data table, use the tables id.

``` r
data("StatFin/synt/statfin_synt_pxt_12dx.px")
```

    ## # Robonomist id: StatFin/synt/statfin_synt_pxt_12dx.px
    ## # Title:         Väestönmuutokset muuttujina Vuosi ja Tiedot
    ## # Last updated:  2024-05-28 08:00:00
    ## # Next update:   2025-05-20 08:00:00
    ## # A tibble:      3,025 × 3
    ##    Vuosi Tiedot                     value
    ##  * <chr> <chr>                      <dbl>
    ##  1 1749  Elävänä syntyneet          16700
    ##  2 1749  Kuolleet                   11600
    ##  3 1749  Luonnollinen väestönlisäys  5100
    ##  4 1749  Kuntien välinen muutto        NA
    ##  5 1749  Maahanmuutto Suomeen          NA
    ##  6 1749  Maastamuutto Suomesta         NA
    ##  7 1749  Nettomaahanmuutto             NA
    ##  8 1749  Solmitut avioliitot         3900
    ##  9 1749  Avioerot                      NA
    ## 10 1749  Kokonaismuutos                NA
    ## # ℹ 3,015 more rows

Get data using a link from the datasources website:

``` r
fetch_data_from_url("https://data-explorer.oecd.org/vis?tm=sna&pg=0&fs[0]=Measure%2C0%7CAquaculture%20production%23AQUA_PD%23&fc=Measure&snb=1&vw=tb&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_FISH_PROD%40DF_FISH_AQUA&df[ag]=OECD.TAD.ARP&df[vs]=1.0&pd=2010%2C&dq=.A.._T.T&ly[rw]=REF_AREA&ly[cl]=TIME_PERIOD&to[TIME_PERIOD]=false")
```

    ## data_get("oecd/DSD_FISH_PROD@DF_FISH_AQUA", dl_filter = ".A.._T.T")

    ## # Robonomist id: oecd/DSD_FISH_PROD@DF_FISH_AQUA
    ## # Title:         Aquaculture production
    ## # Vintage:       2024-07-25 09:39:34
    ## # A tibble:      1,431 × 10
    ##    REF_AREA  FREQ   MEASURE                SPECIES UNIT_MEASURE time       value UNIT_MULT DECIMALS CONVENTION
    ##  * <chr>     <chr>  <chr>                  <chr>   <chr>        <date>     <dbl> <chr>     <chr>    <chr>     
    ##  1 Argentina Annual Aquaculture production Total   Tonnes       1995-01-01  1474 0         0        LW        
    ##  2 Argentina Annual Aquaculture production Total   Tonnes       1996-01-01  1322 0         0        LW        
    ##  3 Argentina Annual Aquaculture production Total   Tonnes       1997-01-01  1314 0         0        LW        
    ##  4 Argentina Annual Aquaculture production Total   Tonnes       1998-01-01  1040 0         0        LW        
    ##  5 Argentina Annual Aquaculture production Total   Tonnes       1999-01-01  1218 0         0        LW        
    ##  6 Argentina Annual Aquaculture production Total   Tonnes       2000-01-01  1784 0         0        LW        
    ##  7 Argentina Annual Aquaculture production Total   Tonnes       2001-01-01  1340 0         0        LW        
    ##  8 Argentina Annual Aquaculture production Total   Tonnes       2002-01-01  1457 0         0        LW        
    ##  9 Argentina Annual Aquaculture production Total   Tonnes       2003-01-01  1647 0         0        LW        
    ## 10 Argentina Annual Aquaculture production Total   Tonnes       2004-01-01  1848 0         0        LW        
    ## # ℹ 1,421 more rows

## More information

You can find detailed information on how to use `robonomistClient` in
the [documentation](https://robonomist.github.io/robonomistClient).

- [Basic
  features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
- [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
- [Filtering large data
  tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
