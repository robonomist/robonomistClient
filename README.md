
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 38 481 up-to-date data tables from 27
different datasources.

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
  - Helsingin seudun aluesarjat -tilastotietokanta
  - Helsingin ympäristötilasto
  - Eurostat
  - European Commission Business and consumer surveys
  - World Bank
  - OECD
  - ECB Statistical data warehouse
  - COVID-19 data (THL Epirapo, ECDC, and covid19datahub.io)
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

    ## ℹ Processing request...✔ Processing request... ... done
    ## 
    ## ── Robonomist Server Datasources

    ##    dataset            title                                                     
    ##  1 StatFin            Statistics Finland, StatFin database                      
    ##  2 StatFin_Passiivi   Statistics Finland, StatFin archive database              
    ##  3 Vero               Verohallinnon tilastotietokanta                           
    ##  4 kunnat             Kuntien avainluvut (Tilastokeskus)                        
    ##  5 kunnat             Kuntien ja kuntayhtymien raportoimat taloustiedot (Tilast…
    ##  6 paavo              Postinumeroalueittainen avoin tieto -tietokanta Paavo (Ti…
    ##  7 maakoto            Maahanmuuttajat ja kotoutuminen -tietokanta (Tilastokesku…
    ##  8 koto               Kototietokanta (Tilastokeskus)                            
    ##  9 toimipaikkalaskuri Toimipaikkalaskuri-tietokanta (Tilastokeskus)             
    ## 10 kokeelliset        Tilastokeskuksen kokeelliset tilastot                     
    ## # … with 17 more rows

The `data` function is convenient way to search and get data tables.
Print all available data tables:

``` r
data()
```

    ## ℹ Processing request...✔ Processing request... ... done
    ## 
    ## ── Robonomist Database search results

    ##    id                                       title                               
    ##  1 StatFin/asu/asas/statfin_asas_pxt_115a.… Asuntokunnat ja asuntoväestö muuttu…
    ##  2 StatFin/asu/asas/statfin_asas_pxt_115y.… Asuntokunnat ja asuntoväestö muuttu…
    ##  3 StatFin/asu/asas/statfin_asas_pxt_116a.… Asuntokunnat muuttujina Vuosi, Talo…
    ##  4 StatFin/asu/asas/statfin_asas_pxt_116b.… Asuntokunnat ja asuntoväestö muuttu…
    ##  5 StatFin/asu/asas/statfin_asas_pxt_116d.… Asuntokunnat muuttujina Alue, Talot…
    ##  6 StatFin/asu/asas/statfin_asas_pxt_116e.… Asuntokunnat ja asuntoväestö muuttu…
    ##  7 StatFin/asu/asas/statfin_asas_pxt_116f.… Asunnot muuttujina Alue, Talotyyppi…
    ##  8 StatFin/asu/asvu/statfin_asvu_pxt_11x4.… Vuokraindeksi (2015=100) ja keskine…
    ##  9 StatFin/asu/asvu/statfin_asvu_pxt_11x5.… Vuokraindeksi (2015=100) ja keskine…
    ## 10 StatFin/asu/asvu/statfin_asvu_pxt_12d4.… Vapaarahoitteisten vuokra-asuntojen…
    ## # … with 38,471 more rows

To get a specific data table, use the tables id.

``` r
data("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")
```

    ## ℹ Processing request...✔ Processing request... ... done

    ## # Robonomist id: StatFin/vrm/synt/statfin_synt_pxt_12dx.px
    ## # A tibble:      2,992 × 3
    ## # Title:         Väestönmuutokset
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
the
\!(documentation)\[<https://robonomist.github.io/robonomistClient>\].

  - \!(Basic
    features)\[<https://robonomist.github.io/robonomistClient/articles/basic_features.html>\]
  - \!(Examples)\[<https://robonomist.github.io/robonomistClient/articles/examples.html>\]
  - \!(Filtering large data
    tables)\[<https://robonomist.github.io/robonomistClient/articles/filtering.html>\]
