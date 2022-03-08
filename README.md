
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

<!-- badges: start -->
[![R-CMD-check](https://github.com/robonomist/robonomistClient/workflows/R-CMD-check/badge.svg)](https://github.com/robonomist/robonomistClient/actions)
<!-- badges: end -->

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 71 648 up-to-date data tables from 42
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

    ## 

    ## ── Robonomist Server Datasources

    ##    dataset            title                                                     
    ##  1 StatFin            Statistics Finland, StatFin database                      
    ##  2 StatFin_Passiivi   Statistics Finland, StatFin archive database              
    ##  3 kunnat             Kuntien avainluvut (Tilastokeskus)                        
    ##  4 kunnat             Kuntien ja kuntayhtymien raportoimat taloustiedot (Tilast…
    ##  5 paavo              Postinumeroalueittainen avoin tieto -tietokanta Paavo (Ti…
    ##  6 Vero               Verohallinnon tilastotietokanta                           
    ##  7 ec                 European Commission's Business and Consumer Surveys       
    ##  8 tulli              Finnish Customs, Uljas Statistical Database               
    ##  9 luke               Luonnonvarakeskus LUKE:n tilastotietokanta)               
    ## 10 etk                Eläketurvakeskuksen tietokanta                            
    ## 11 eurostat           Eurostat database                                         
    ## 12 ecb                ECB Statistical Data Warehouse                            
    ## 13 oecd               OECD database                                             
    ## 14 wb                 World Bank Open Data                                      
    ## 15 hsa                Helsingin seudun aluesarjat -tilastotietokanta            
    ## 16 helymp             Helsingin ympäristötilasto                                
    ## 17 helhyv             Helsingin hyvinvointitilastot                             
    ## 18 helhyv             Nordstat                                                  
    ## 19 covid              European Centre for Disease Prevention and Control COVID-…
    ## 20 vipunen            Vipunen, Education Statistics Finland                     
    ## 21 epirapo            THL Epirapo COVID-19 database                             
    ## 22 sotkanet           THL Sotkanet                                              
    ## 23 maakoto            Maahanmuuttajat ja kotoutuminen -tietokanta (Tilastokesku…
    ## 24 koto               Kototietokanta (Tilastokeskus)                            
    ## 25 toimipaikkalaskuri Toimipaikkalaskuri-tietokanta (Tilastokeskus)             
    ## 26 kokeelliset        Tilastokeskuksen kokeelliset tilastot                     
    ## 27 traficom           Traficomin tilastotietokanta (Tilastokeskus)              
    ## 28 tk_eurostat        Eurostatin avaintaulukot -tietokanta (Tilastokeskus)      
    ## 29 se                 Statistics Sweden                                         
    ## 30 konj               The Swedish National Institute of Economic Research       
    ## 31 sjv                The Swedish Agricultural Agency                           
    ## 32 no                 Statistics Norway                                         
    ## 33 dk                 Statistics Denmark                                        
    ## 34 is                 Statistics Iceland                                        
    ## 35 ee                 Statistics Estonia                                        
    ## 36 unece              United Nations Economic Commission for Europe Statistical…
    ## 37 nordic             Nordic Statistics                                         
    ## 38 unctad             United Nations Conference on Trade and Development        
    ## 39 eia                U.S. Energy Information Administration database           
    ## 40 fred               FRED, Federal Reserve Economic Data, St. Louis Fed        
    ## 41 fao                Food and Agriculture Organization of the United Nations   
    ## 42 tidy               Robonomistin jalostetut tietokannat                       
    ## # … with 1 more variable: languages <list>

The `data` function is convenient way to search and get data tables.
Print all available data tables:

``` r
data()
```

    ## 

    ## ── Robonomist Database search results

    ##    id                                        title                         lang 
    ##    <r_id>                                    <chr>                         <chr>
    ##  1 StatFin/asu/asas/statfin_asas_pxt_115a.px Asuntokunnat ja asuntoväestö… fi   
    ##  2 StatFin/asu/asas/statfin_asas_pxt_115a.px Bostadshushåll och boendebef… sv   
    ##  3 StatFin/asu/asas/statfin_asas_pxt_115a.px Household-dwelling units and… en   
    ##  4 StatFin/asu/asas/statfin_asas_pxt_115y.px Asuntokunnat ja asuntoväestö… fi   
    ##  5 StatFin/asu/asas/statfin_asas_pxt_115y.px Antal bostadshushåll och ant… sv   
    ##  6 StatFin/asu/asas/statfin_asas_pxt_115y.px Number of household-dwelling… en   
    ##  7 StatFin/asu/asas/statfin_asas_pxt_116a.px Asuntokunnat muuttujina Vuos… fi   
    ##  8 StatFin/asu/asas/statfin_asas_pxt_116a.px Bostadshushåll efter År, Hus… sv   
    ##  9 StatFin/asu/asas/statfin_asas_pxt_116a.px Household-dwelling units by … en   
    ## 10 StatFin/asu/asas/statfin_asas_pxt_116b.px Asuntokunnat ja asuntoväestö… fi   
    ## 11 StatFin/asu/asas/statfin_asas_pxt_116b.px Bostadshushåll och bostadsbe… sv   
    ## 12 StatFin/asu/asas/statfin_asas_pxt_116b.px Household-dwelling units and… en   
    ## 13 StatFin/asu/asas/statfin_asas_pxt_116d.px Asuntokunnat muuttujina Alue… fi   
    ## 14 StatFin/asu/asas/statfin_asas_pxt_116d.px Bostadshushåll efter Område,… sv   
    ## 15 StatFin/asu/asas/statfin_asas_pxt_116d.px Household-dwelling units by … en   
    ## 16 StatFin/asu/asas/statfin_asas_pxt_116e.px Asuntokunnat ja asuntoväestö… fi   
    ## 17 StatFin/asu/asas/statfin_asas_pxt_116e.px Antal bostadshushåll och ant… sv   
    ## 18 StatFin/asu/asas/statfin_asas_pxt_116e.px Number of household-dwelling… en   
    ## 19 StatFin/asu/asas/statfin_asas_pxt_116f.px Asunnot muuttujina Alue, Tal… fi   
    ## 20 StatFin/asu/asas/statfin_asas_pxt_116f.px Bostäder efter Område, Husty… sv   
    ## 21 StatFin/asu/asas/statfin_asas_pxt_116f.px Dwellings by Area, Type of b… en   
    ## 22 StatFin/asu/asvu/statfin_asvu_pxt_11x4.px Vuokraindeksi (2015=100) ja … fi   
    ## 23 StatFin/asu/asvu/statfin_asvu_pxt_11x4.px Hyresindex (2015=100) och ge… sv   
    ## 24 StatFin/asu/asvu/statfin_asvu_pxt_11x4.px Rent index (2015=100) and av… en   
    ## 25 StatFin/asu/asvu/statfin_asvu_pxt_11x5.px Vuokraindeksi (2015=100) ja … fi   
    ## 26 StatFin/asu/asvu/statfin_asvu_pxt_11x5.px Hyresindex (2015=100) och ge… sv   
    ## 27 StatFin/asu/asvu/statfin_asvu_pxt_11x5.px Rent index (2015=100) and av… en   
    ## 28 StatFin/asu/asvu/statfin_asvu_pxt_12d4.px Vapaarahoitteisten vuokra-as… fi   
    ## 29 StatFin/asu/asvu/statfin_asvu_pxt_12d4.px Fördelning av totalhyror för… sv   
    ## 30 StatFin/asu/asvu/statfin_asvu_pxt_12d4.px Distributions of total rents… en   
    ## # … with 130,182 more rows

To get a specific data table, use the tables id.

``` r
data("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")
```

    ## # Robonomist id: StatFin/vrm/synt/statfin_synt_pxt_12dx.px
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
