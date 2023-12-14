
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 95 606 up-to-date data tables from 58
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
    ##    dataset                  title                                               
    ##  1 StatFin                  Statistics Finland, StatFin database                
    ##  2 StatFin_Passiivi         Statistics Finland, StatFin archive database        
    ##  3 Vero                     Finnish Tax Administration statistical database     
    ##  4 ec                       European Commission's Business and Consumer Surveys 
    ##  5 kunnat                   Key statistics of municipalities, Statistics Finland
    ##  6 kunnat                   Financial data reported by municipalities and joint…
    ##  7 paavo                    Statistics Finland's Paavo database                 
    ##  8 tulli                    Finnish Customs, Uljas Statistical Database         
    ##  9 luke                     Statistics database of Natural Resources Institute …
    ## 10 etk                      Finnish Centre for Pensions' statistical database   
    ## 11 eurostat                 Eurostat database                                   
    ## 12 ecb                      ECB Statistical Data Warehouse                      
    ## 13 bundesbank               Deutsche Bundesbank time series database            
    ## 14 oecd                     OECD database                                       
    ## 15 oecd3                    OECD database (SDMX-JSON API)                       
    ## 16 wb                       World Bank Open Data                                
    ## 17 hsa                      Greater Helsinki Open Statistical Databases, Aluesa…
    ## 18 helymp                   Helsinki environmental statistics                   
    ## 19 helhyv                   Helsinki wellbeing statistics                       
    ## 20 nordstat                 Nordstat                                            
    ## 21 covid                    European Centre for Disease Prevention and Control …
    ## 22 vipunen                  Vipunen, Education Statistics Finland               
    ## 23 epirapo                  THL Epirapo COVID-19 database                       
    ## 24 sotkanet                 Sotkanet indicator bank of the Finnish Institute fo…
    ## 25 maakoto                  Immigrants and integration statistics, Statistics F…
    ## 26 koto                     Integration database, Finnish Ministry of Economic …
    ## 27 toimipaikkalaskuri       Toimipaikkalaskuri database, Statitstics Finland    
    ## 28 kokeelliset              Statistics Finland's experimental statistics        
    ## 29 traficom                 Traficom statistics database                        
    ## 30 tieliikenneonnettomuudet Road traffic accidents statistical database         
    ## 31 rudolf                   Rudolf statistical database, Business Finland       
    ## 32 se                       Statistics Sweden                                   
    ## 33 konj                     The Swedish National Institute of Economic Research…
    ## 34 konj                     The Swedish National Institute of Economic Research…
    ## 35 sjv                      The Swedish Board of Agriculture                    
    ## 36 fohm                     The Public Health Agency of Sweden                  
    ## 37 no                       Statistics Norway                                   
    ## 38 dk                       Statistics Denmark                                  
    ## 39 is                       Statistics Iceland                                  
    ## 40 ee                       Statistics Estonia                                  
    ## 41 lv                       Statistics Latvia                                   
    ## 42 mk                       State Statistical Office of the Republic of Macedon…
    ## 43 md                       Statistics Moldova                                  
    ## 44 si                       Statistics Slovenia                                 
    ## 45 is                       Statistics Åland                                    
    ## 46 unece                    United Nations Economic Commission for Europe Stati…
    ## 47 nordic                   Nordic Statistics database                          
    ## 48 unctad                   United Nations Conference on Trade and Development  
    ## 49 eia                      U.S. Energy Information Administration database     
    ## 50 fred                     FRED, Federal Reserve Economic Data, St. Louis Fed  
    ## # ℹ 8 more rows
    ## # ℹ 3 more variables: languages <list>, datasource <chr>, available <lgl>

The `data` function is convenient way to search and get data tables.
Print all available data tables:

``` r
data()
```

    ## # Robonomist Database search results
    ##    id                                      title                           lang 
    ##    <r_id>                                  <chr>                           <chr>
    ##  1 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptiot muuttujina Vuosi, Syn… fi   
    ##  2 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptioner efter År, Födelsela… sv   
    ##  3 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptions by Year, Country of … en   
    ##  4 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptiot muuttujina Vuosi, Ado… fi   
    ##  5 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptioner efter År, Föräldrar… sv   
    ##  6 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptions by Year, Parents of … en   
    ##  7 StatFin/akay/statfin_akay_pxt_001.px    001 -- Ajankäyttö (26 lk) syks… fi   
    ##  8 StatFin/akay/statfin_akay_pxt_001.px    001 -- Time Use (26 categories… en   
    ##  9 StatFin/akay/statfin_akay_pxt_002.px    Ajankäyttö (26 lk) muuttujina … fi   
    ## 10 StatFin/akay/statfin_akay_pxt_002.px    Time Use (26 categories) by Ac… en   
    ## 11 StatFin/akay/statfin_akay_pxt_003.px    003 -- Työllisten miesten ja n… fi   
    ## 12 StatFin/akay/statfin_akay_pxt_003.px    003 -- Time use (26 categories… en   
    ## 13 StatFin/akay/statfin_akay_pxt_004.px    Ajankäyttö (26 lk) muuttujina … fi   
    ## 14 StatFin/akay/statfin_akay_pxt_004.px    Time Use (26 categories) by Ac… en   
    ## 15 StatFin/akay/statfin_akay_pxt_005.px    005 -- Ajankäyttö (82 lk) suku… fi   
    ## 16 StatFin/akay/statfin_akay_pxt_005.px    005 -- Time Use (82 categories… en   
    ## 17 StatFin/akay/statfin_akay_pxt_006.px    006 -- Ajankäyttö (82 lk) iän … fi   
    ## 18 StatFin/akay/statfin_akay_pxt_006.px    006 -- Time Use (82 categories… en   
    ## 19 StatFin/akay/statfin_akay_pxt_007.px    007 -- Yli 10-vuotiaiden ajank… fi   
    ## 20 StatFin/akay/statfin_akay_pxt_007.px    007 -- Time Use (132 categorie… en   
    ## 21 StatFin/akay/statfin_akay_pxt_008.px    008 -- Kirjastossa käyminen 12… fi   
    ## 22 StatFin/akay/statfin_akay_pxt_008.px    008 -- Biblioteksbesök under d… sv   
    ## 23 StatFin/akay/statfin_akay_pxt_008.px    008 -- Visiting the library du… en   
    ## 24 StatFin/akay/statfin_akay_pxt_009.px    009 -- Kirjastossa käyminen 12… fi   
    ## 25 StatFin/akay/statfin_akay_pxt_009.px    009 -- Biblioteksbesök under d… sv   
    ## 26 StatFin/akay/statfin_akay_pxt_009.px    009 -- Visiting the library du… en   
    ## 27 StatFin/akay/statfin_akay_pxt_010.px    010 -- Kirjastossa käyminen 12… fi   
    ## 28 StatFin/akay/statfin_akay_pxt_010.px    010 -- Biblioteksbesök under d… sv   
    ## 29 StatFin/akay/statfin_akay_pxt_010.px    010 -- Visiting the library du… en   
    ## 30 StatFin/akay/statfin_akay_pxt_011.px    011 -- Lukemiseen käytetty aik… fi   
    ## # ℹ 168,131 more rows

To get a specific data table, use the tables id.

``` r
data("StatFin/synt/statfin_synt_pxt_12dx.px")
```

    ## # Robonomist id: StatFin/synt/statfin_synt_pxt_12dx.px
    ## # Title:         Väestönmuutokset muuttujina Vuosi ja Tiedot
    ## # Last updated:  2023-05-24 08:00:00
    ## # Next update:   2024-05-17 08:00:00
    ## # A tibble:      3,014 × 3
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
    ## # ℹ 3,004 more rows

## More information

You can find detailed information on how to use `robonomistClient` in
the [documentation](https://robonomist.github.io/robonomistClient).

  - [Basic
    features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
  - [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
  - [Filtering large data
    tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
