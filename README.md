Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>
======================================================================================================================

A client package for R to access Robonomist Data Server

Datasources
-----------

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 71 356 up-to-date data tables from 37
different datasources with 9 different languages.

Some of the integrated datasources:

-   Statistics Finland (StatFin & StatFin archive databases)
-   Statistics Finland municipal data (Key figures & Financial data)
-   Paavo postal code area statistics by Statistics Finland
-   Experimental statistics by Statistics Finland
-   Immigrants and integration database by Statistics Finland
-   Finnish Tax Administration
-   Finnish Centre for Pensions
-   Natural Resources Institute Finland (Luonnonvarakeskus LUKE)
-   Traficom database (The Finnish Transport and Communications Agency)
-   Customs Finland
-   THL Sotkanet
-   Vipunen, Education Statistics Finland
-   Helsingin seudun aluesarjat -tilastotietokanta
-   Helsingin ympäristötilasto
-   Eurostat
-   European Commission Business and consumer surveys
-   World Bank
-   OECD
-   ECB Statistical data warehouse
-   COVID-19 data (THL Epirapo, ECDC, and covid19datahub.io)
-   Statistics Sweden
-   The Swedish National Institute of Economic Research
-   Swedish Agricultural Agency
-   Statistics Norway
-   Statistics Denmark
-   Statistics Iceland
-   Statistics Estonia
-   United Nations Economic Commission for Europe Statistical Database
-   Nordic Statistics Database
-   Robonomist’s curated tidy data tables

To setup a Robonomist Data Server for your organization, please contact
<a href="mailto:team@robonomist.com" class="email">team@robonomist.com</a>.

Installation
------------

Install the development version from github:

    ## install.packages("devtools")
    devtools::install_github("robonomist/robonomistClient")

Getting started
---------------

Once installed, set the hostname of your Robonomist Data Server and
connnect with `set_robonomist_server` function. Then you can start
exploring the database.

    library(robonomistClient)
    set_robonomist_server(hostname = "hostname.com", access_token = "xyz")

List all available datasources:

    datasources()

    ## ℹ Processing request...✔ Processing request... ... done
    ## 
    ## ── Robonomist Server Datasources

    ##    dataset          title                                                       
    ##  1 StatFin          Statistics Finland, StatFin database                        
    ##  2 StatFin_Passiivi Statistics Finland, StatFin archive database                
    ##  3 kunnat           Kuntien avainluvut (Tilastokeskus)                          
    ##  4 kunnat           Kuntien ja kuntayhtymien raportoimat taloustiedot (Tilastok…
    ##  5 paavo            Postinumeroalueittainen avoin tieto -tietokanta Paavo (Tila…
    ##  6 Vero             Verohallinnon tilastotietokanta                             
    ##  7 ec               European Commission's Business and consumer surveys         
    ##  8 tulli            Finnish Customs, Uljas Statistical Database                 
    ##  9 luke             Luonnonvarakeskus LUKE:n tilastotietokanta)                 
    ## 10 etk              Eläketurvakeskuksen tietokanta                              
    ## # … with 27 more rows, and 1 more variable: languages <list>

The `data` function is convenient way to search and get data tables.
Print all available data tables:

    data()

    ## ℹ Processing request...✔ Processing request... ... done
    ## 
    ## ── Robonomist Database search results

    ##    id                                       title                               
    ##  1 StatFin/asu/asas/statfin_asas_pxt_115a.… Asuntokunnat ja asuntoväestö muuttu…
    ##  2 StatFin/asu/asas/statfin_asas_pxt_115a.… Bostadshushåll och boendebefolkning…
    ##  3 StatFin/asu/asas/statfin_asas_pxt_115a.… Household-dwelling units and housin…
    ##  4 StatFin/asu/asas/statfin_asas_pxt_115y.… Asuntokunnat ja asuntoväestö muuttu…
    ##  5 StatFin/asu/asas/statfin_asas_pxt_115y.… Antal bostadshushåll och antal pers…
    ##  6 StatFin/asu/asas/statfin_asas_pxt_115y.… Number of household-dwelling units …
    ##  7 StatFin/asu/asas/statfin_asas_pxt_116a.… Asuntokunnat muuttujina Vuosi, Talo…
    ##  8 StatFin/asu/asas/statfin_asas_pxt_116a.… Bostadshushåll efter År, Hustyp, Om…
    ##  9 StatFin/asu/asas/statfin_asas_pxt_116a.… Household-dwelling units by Year, T…
    ## 10 StatFin/asu/asas/statfin_asas_pxt_116b.… Asuntokunnat ja asuntoväestö muuttu…
    ## # … with 124,053 more rows, and 1 more variable: lang <chr>

To get a specific data table, use the tables id.

    data("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")

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

More information
----------------

You can find detailed information on how to use `robonomistClient` in
the [documentation](https://robonomist.github.io/robonomistClient).

-   [Basic
    features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
-   [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
-   [Filtering large data
    tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
