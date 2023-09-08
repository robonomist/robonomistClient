
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 80 244 up-to-date data tables from 50
different datasources with 9 different languages.

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
    ##    dataset                  title                                       languages          
    ##  1 StatFin                  Statistics Finland, StatFin database        c("fi", "sv", "en")
    ##  2 StatFin_Passiivi         Statistics Finland, StatFin archive databa… c("fi", "sv", "en")
    ##  3 Vero                     Verohallinnon tilastotietokanta             c("fi", "sv", "en")
    ##  4 ec                       European Commission's Business and Consume… en                 
    ##  5 kunnat                   Kuntien avainluvut (Tilastokeskus)          c("fi", "sv", "en")
    ##  6 kunnat                   Kuntien ja kuntayhtymien raportoimat talou… c("fi", "sv", "en")
    ##  7 paavo                    Postinumeroalueittainen avoin tieto -tieto… c("fi", "sv", "en")
    ##  8 tulli                    Finnish Customs, Uljas Statistical Database c("fi", "sv", "en")
    ##  9 luke                     Luonnonvarakeskus LUKE:n tilastotietokanta  c("fi", "sv", "en")
    ## 10 etk                      Eläketurvakeskuksen tietokanta              c("fi", "sv", "en")
    ## 11 eurostat                 Eurostat database                           c("en", "de", "fr")
    ## 12 ecb                      ECB Statistical Data Warehouse              en                 
    ## 13 bundesbank               Deutche Bundesbank time series database     c("en", "de")      
    ## 14 oecd                     OECD database                               en                 
    ## 15 oecd3                    OECD database (SDMX-JSON API)               en                 
    ## 16 wb                       World Bank Open Data                        en                 
    ## 17 hsa                      Helsingin seudun aluesarjat -tilastotietok… fi                 
    ## 18 helymp                   Helsingin ympäristötilasto                  c("fi", "en", "sv")
    ## 19 helhyv                   Helsingin hyvinvointitilastot               fi                 
    ## 20 nordstat                 Nordstat                                    c("fi", "en", "sv")
    ## 21 covid                    European Centre for Disease Prevention and… en                 
    ## 22 vipunen                  Vipunen, Education Statistics Finland       fi                 
    ## 23 epirapo                  THL Epirapo COVID-19 database               fi                 
    ## 24 sotkanet                 THL Sotkanet                                c("fi", "en", "sv")
    ## 25 maakoto                  Maahanmuuttajat ja kotoutuminen -tietokant… c("fi", "sv", "en")
    ## 26 koto                     Kototietokanta (Tilastokeskus)              c("fi", "sv", "en")
    ## 27 toimipaikkalaskuri       Toimipaikkalaskuri-tietokanta (Tilastokesk… fi                 
    ## 28 kokeelliset              Tilastokeskuksen kokeelliset tilastot       c("fi", "sv", "en")
    ## 29 traficom                 Traficomin tilastotietokanta (Tilastokesku… c("fi", "sv", "en")
    ## 30 tieliikenneonnettomuudet Tieliikenneonnettomuudet-tietokanta (Tilas… c("fi", "sv", "en")
    ## 31 rudolf                   Tilastopalvelu Rudolf (Business Finland)    c("fi", "en")      
    ## 32 se                       Statistics Sweden                           c("en", "sv")      
    ## 33 konj                     The Swedish National Institute of Economic… c("en", "sv")      
    ## 34 sjv                      The Swedish Agricultural Agency             sv                 
    ## 35 no                       Statistics Norway                           c("en", "no")      
    ## 36 dk                       Statistics Denmark                          c("en", "da")      
    ## 37 is                       Statistics Iceland                          c("en", "is")      
    ## 38 ee                       Statistics Estonia                          c("en", "et")      
    ## 39 unece                    United Nations Economic Commission for Eur… en                 
    ## 40 nordic                   Nordic Statistics                           en                 
    ## 41 unctad                   United Nations Conference on Trade and Dev… en                 
    ## 42 eia                      U.S. Energy Information Administration dat… en                 
    ## 43 fred                     FRED, Federal Reserve Economic Data, St. L… en                 
    ## 44 fao                      Food and Agriculture Organization of the U… en                 
    ## 45 fingrid                  Fingrid avoin data                          c("fi", "en")      
    ## 46 tutkihallintoa           Tutkihallintoa.fi, Valtiokonttori           fi                 
    ## 47 tidy                     Robonomistin jalostetut tietokannat         c("fi", "en")      
    ## 48 entsoe                   ENTSO-E Transperancy Platform               en                 
    ## 49 imf                      IMF                                         en                 
    ## 50 bis                      Bank for International Settlements (BIS) D… en                 
    ## # ℹ 2 more variables: datasource <chr>, available <lgl>

The `data` function is convenient way to search and get data tables.
Print all available data tables:

``` r
data()
```

    ## # Robonomist Database search results
    ##    id                                      title                                                 lang 
    ##    <r_id>                                  <chr>                                                 <chr>
    ##  1 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptiot muuttujina Vuosi, Syntymävaltio, Adoptiotyy… fi   
    ##  2 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptioner efter År, Födelseland, Typ av adoption, Å… sv   
    ##  3 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptions by Year, Country of birth, Adoption type, … en   
    ##  4 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptiot muuttujina Vuosi, Adoptoitavan vanhemmat ja… fi   
    ##  5 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptioner efter År, Föräldrarna till den som adopte… sv   
    ##  6 StatFin/adopt/statfin_adopt_pxt_13qh.px Adoptions by Year, Parents of the adopted person and… en   
    ##  7 StatFin/akay/statfin_akay_pxt_001.px    001 -- Ajankäyttö (26 lk) syksyllä                    fi   
    ##  8 StatFin/akay/statfin_akay_pxt_001.px    001 -- Time Use (26 categories) in autumn 1979, 1987… en   
    ##  9 StatFin/akay/statfin_akay_pxt_002.px    Ajankäyttö (26 lk) muuttujina Toiminto, Pääasialline… fi   
    ## 10 StatFin/akay/statfin_akay_pxt_002.px    Time Use (26 categories) by Activity, Labour market … en   
    ## 11 StatFin/akay/statfin_akay_pxt_003.px    003 -- Työllisten miesten ja naisten ajankäyttö sosi… fi   
    ## 12 StatFin/akay/statfin_akay_pxt_003.px    003 -- Time use (26 categories) of employed men by s… en   
    ## 13 StatFin/akay/statfin_akay_pxt_004.px    Ajankäyttö (26 lk) muuttujina Toiminto, Elinvaihe, S… fi   
    ## 14 StatFin/akay/statfin_akay_pxt_004.px    Time Use (26 categories) by Activity, Stage in famil… en   
    ## 15 StatFin/akay/statfin_akay_pxt_005.px    005 -- Ajankäyttö (82 lk) sukupuolen mukaan           fi   
    ## 16 StatFin/akay/statfin_akay_pxt_005.px    005 -- Time Use (82 categories) by sex in 1987-1988,… en   
    ## 17 StatFin/akay/statfin_akay_pxt_006.px    006 -- Ajankäyttö (82 lk) iän mukaan                  fi   
    ## 18 StatFin/akay/statfin_akay_pxt_006.px    006 -- Time Use (82 categories) by age in 1987-1988,… en   
    ## 19 StatFin/akay/statfin_akay_pxt_007.px    007 -- Yli 10-vuotiaiden ajankäyttö (132 lk) sukupuo… fi   
    ## 20 StatFin/akay/statfin_akay_pxt_007.px    007 -- Time Use (132 categories) by sex in 1999-2000… en   
    ## 21 StatFin/akay/statfin_akay_pxt_008.px    008 -- Kirjastossa käyminen 12 kuukauden aikana suku… fi   
    ## 22 StatFin/akay/statfin_akay_pxt_008.px    008 -- Biblioteksbesök under de senaste 12 månaderna… sv   
    ## 23 StatFin/akay/statfin_akay_pxt_008.px    008 -- Visiting the library during the past 12 month… en   
    ## 24 StatFin/akay/statfin_akay_pxt_009.px    009 -- Kirjastossa käyminen 12 kuukauden aikana suku… fi   
    ## 25 StatFin/akay/statfin_akay_pxt_009.px    009 -- Biblioteksbesök under de senaste 12 månaderna… sv   
    ## 26 StatFin/akay/statfin_akay_pxt_009.px    009 -- Visiting the library during the past 12 month… en   
    ## 27 StatFin/akay/statfin_akay_pxt_010.px    010 -- Kirjastossa käyminen 12 kuukauden aikana suku… fi   
    ## 28 StatFin/akay/statfin_akay_pxt_010.px    010 -- Biblioteksbesök under de senaste 12 månaderna… sv   
    ## 29 StatFin/akay/statfin_akay_pxt_010.px    010 -- Visiting the library during the past 12 month… en   
    ## 30 StatFin/akay/statfin_akay_pxt_011.px    011 -- Lukemiseen käytetty aika sukupuolen ja iän mu… fi   
    ## # ℹ 141,417 more rows

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
