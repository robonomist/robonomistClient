
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 73 612 up-to-date data tables from 45
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
  - Eurostat
  - European Commission Business and consumer surveys
  - World Bank
  - OECD
  - ECB Statistical data warehouse
  - COVID-19 data (THL Epirapo, ECDC, and covid19datahub.io)
  - Statistics Sweden
  - The Swedish National Institute of Economic Research
  - Swedish Agricultural Agency
  - Statistics Norway
  - Statistics Denmark
  - Statistics Iceland
  - Statistics Estonia
  - United Nations Economic Commission for Europe Statistical Database
  - United Nations Conference on Trade and Development
  - FAO, Food and Agriculture Organization of the United Nations
  - Nordic Statistics Database
  - U.S. Energy Information Administration database
  - FRED, Federal Reserve Economic Data, St. Louis Fed
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

    ## ⠙ Requesting datasources                        ℹ Object retrieved from client cache (valid until 2022-05-13 18:07:07).
    ## ⠙ Requesting datasources✔ Requesting datasources [14ms]
    ## 
    ## ── Robonomist Server Datasources

    ##    dataset            title                                                     
    ##  1 StatFin            Statistics Finland, StatFin database                      
    ##  2 StatFin_Passiivi   Statistics Finland, StatFin archive database              
    ##  3 Vero               Verohallinnon tilastotietokanta                           
    ##  4 ec                 European Commission's Business and Consumer Surveys       
    ##  5 kunnat             Kuntien avainluvut (Tilastokeskus)                        
    ##  6 kunnat             Kuntien ja kuntayhtymien raportoimat taloustiedot (Tilast…
    ##  7 paavo              Postinumeroalueittainen avoin tieto -tietokanta Paavo (Ti…
    ##  8 tulli              Finnish Customs, Uljas Statistical Database               
    ##  9 luke               Luonnonvarakeskus LUKE:n tilastotietokanta)               
    ## 10 etk                Eläketurvakeskuksen tietokanta                            
    ## 11 eurostat           Eurostat database                                         
    ## 12 ecb                ECB Statistical Data Warehouse                            
    ## 13 bundesbank         Deutche Bundesbank time series database                   
    ## 14 oecd               OECD database                                             
    ## 15 oecd3              OECD database                                             
    ## 16 wb                 World Bank Open Data                                      
    ## 17 hsa                Helsingin seudun aluesarjat -tilastotietokanta            
    ## 18 helymp             Helsingin ympäristötilasto                                
    ## 19 helhyv             Helsingin hyvinvointitilastot                             
    ## 20 nordstat           Nordstat                                                  
    ## 21 covid              European Centre for Disease Prevention and Control COVID-…
    ## 22 vipunen            Vipunen, Education Statistics Finland                     
    ## 23 epirapo            THL Epirapo COVID-19 database                             
    ## 24 sotkanet           THL Sotkanet                                              
    ## 25 maakoto            Maahanmuuttajat ja kotoutuminen -tietokanta (Tilastokesku…
    ## 26 koto               Kototietokanta (Tilastokeskus)                            
    ## 27 toimipaikkalaskuri Toimipaikkalaskuri-tietokanta (Tilastokeskus)             
    ## 28 kokeelliset        Tilastokeskuksen kokeelliset tilastot                     
    ## 29 traficom           Traficomin tilastotietokanta (Tilastokeskus)              
    ## 30 tk_eurostat        Eurostatin avaintaulukot -tietokanta (Tilastokeskus)      
    ## 31 se                 Statistics Sweden                                         
    ## 32 konj               The Swedish National Institute of Economic Research       
    ## 33 sjv                The Swedish Agricultural Agency                           
    ## 34 no                 Statistics Norway                                         
    ## 35 dk                 Statistics Denmark                                        
    ## 36 is                 Statistics Iceland                                        
    ## 37 ee                 Statistics Estonia                                        
    ## 38 unece              United Nations Economic Commission for Europe Statistical…
    ## 39 nordic             Nordic Statistics                                         
    ## 40 unctad             United Nations Conference on Trade and Development        
    ## 41 eia                U.S. Energy Information Administration database           
    ## 42 fred               FRED, Federal Reserve Economic Data, St. Louis Fed        
    ## 43 fao                Food and Agriculture Organization of the United Nations   
    ## 44 fingrid            Fingrid avoin data                                        
    ## 45 tidy               Robonomistin jalostetut tietokannat                       
    ## # … with 1 more variable: languages <list>

The `data` function is convenient way to search and get data tables.
Print all available data tables:

``` r
data()
```

    ## ⠙ Requesting data⠹ Requesting data✔ Requesting data [1.8s]
    ## 
    ## ── Robonomist Database search results

    ##    id                                      title                           lang 
    ##    <r_id>                                  <chr>                           <chr>
    ##  1 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptiot muuttujina Vuosi, Syn… fi   
    ##  2 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptioner efter År, Födelsela… sv   
    ##  3 StatFin/adopt/statfin_adopt_pxt_11lv.px Adoptions by Year, Country of … en   
    ##  4 StatFin/akay/statfin_akay_pxt_001.px    001 -- Ajankäyttö (26 lk) syks… fi   
    ##  5 StatFin/akay/statfin_akay_pxt_001.px    001 -- Time Use (26 categories… en   
    ##  6 StatFin/akay/statfin_akay_pxt_002.px    Ajankäyttö (26 lk) muuttujina … fi   
    ##  7 StatFin/akay/statfin_akay_pxt_002.px    Time Use (26 categories) by Ac… en   
    ##  8 StatFin/akay/statfin_akay_pxt_003.px    003 -- Työllisten miesten ja n… fi   
    ##  9 StatFin/akay/statfin_akay_pxt_003.px    003 -- Time use (26 categories… en   
    ## 10 StatFin/akay/statfin_akay_pxt_004.px    Ajankäyttö (26 lk) muuttujina … fi   
    ## 11 StatFin/akay/statfin_akay_pxt_004.px    Time Use (26 categories) by Ac… en   
    ## 12 StatFin/akay/statfin_akay_pxt_005.px    005 -- Ajankäyttö (82 lk) suku… fi   
    ## 13 StatFin/akay/statfin_akay_pxt_005.px    005 -- Time Use (82 categories… en   
    ## 14 StatFin/akay/statfin_akay_pxt_006.px    006 -- Ajankäyttö (82 lk) iän … fi   
    ## 15 StatFin/akay/statfin_akay_pxt_006.px    006 -- Time Use (82 categories… en   
    ## 16 StatFin/akay/statfin_akay_pxt_007.px    007 -- Yli 10-vuotiaiden ajank… fi   
    ## 17 StatFin/akay/statfin_akay_pxt_007.px    007 -- Time Use (132 categorie… en   
    ## 18 StatFin/akay/statfin_akay_pxt_008.px    008 -- Kirjastossa käyminen 12… fi   
    ## 19 StatFin/akay/statfin_akay_pxt_008.px    008 -- Biblioteksbesök under d… sv   
    ## 20 StatFin/akay/statfin_akay_pxt_008.px    008 -- Visiting the library du… en   
    ## 21 StatFin/akay/statfin_akay_pxt_009.px    009 -- Kirjastossa käyminen 12… fi   
    ## 22 StatFin/akay/statfin_akay_pxt_009.px    009 -- Biblioteksbesök under d… sv   
    ## 23 StatFin/akay/statfin_akay_pxt_009.px    009 -- Visiting the library du… en   
    ## 24 StatFin/akay/statfin_akay_pxt_010.px    010 -- Kirjastossa käyminen 12… fi   
    ## 25 StatFin/akay/statfin_akay_pxt_010.px    010 -- Biblioteksbesök under d… sv   
    ## 26 StatFin/akay/statfin_akay_pxt_010.px    010 -- Visiting the library du… en   
    ## 27 StatFin/akay/statfin_akay_pxt_011.px    011 -- Lukemiseen käytetty aik… fi   
    ## 28 StatFin/akay/statfin_akay_pxt_011.px    011 -- Tid som använts till at… sv   
    ## 29 StatFin/akay/statfin_akay_pxt_011.px    011 -- Time used for reading b… en   
    ## 30 StatFin/akay/statfin_akay_pxt_012.px    012 -- Kulttuuritilaisuuksissa… fi   
    ## # … with 132,637 more rows

To get a specific data table, use the tables id.

``` r
data("StatFin/synt/statfin_synt_pxt_12dx.px")
```

    ## ⠙ Requesting data✔ Requesting data [136ms]

    ## # Robonomist id: StatFin/synt/statfin_synt_pxt_12dx.px
    ## # A tibble:      2,992 × 3
    ## # Title:         12dx -- Väestönmuutokset ja väkiluku, 1749-2020
    ## # Last updated:  2021-06-18 08:00:00
    ## # Next update:   2022-06-17 08:00:00
    ##    Vuosi Tiedot                     value
    ##    <chr> <chr>                      <dbl>
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
    ## # … with 2,982 more rows

## More information

You can find detailed information on how to use `robonomistClient` in
the [documentation](https://robonomist.github.io/robonomistClient).

  - [Basic
    features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
  - [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
  - [Filtering large data
    tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
