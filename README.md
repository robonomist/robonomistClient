
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

Client R package for Robonomist Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources through Robonomist Data Servers, which integrate various
datasources with up-to-date data. The client provides access to over 34
000 data tables in 14 datasources.

Currently integrated datasources:

-   Statistics Finland (StatFin & StatFin archive databases)
-   Statistics Finland municipal data (Key figures & Financial data)
-   Finnish Tax Administration
-   Customs Finland
-   Finnish Treasury
-   Eurostat
-   European Commission Business and consumer surveys
-   World Bank
-   OECD
-   THL Sotkanet
-   THL Epirapo COVID-19 data
-   ECB Statistical data warehouse
-   COVID-19 data (ECDC & covid19datahub.io)
-   Robonomist’s processed tidy data

To setup a Robonomist Data Server for your organization, please contact
<a href="mailto:team@robonomist.com" class="email">team@robonomist.com</a>.

## Installation

Install the development version from github:

    ## install.packages("devtools")
    devtools::install_github("robonomist/robonomistClient")

## Getting started

Once installed, set your Robonomist Data Server’s address option
`robonomist.server`. Now can start exploring the database.

    library(robonomistClient)
    set_robonomist_server("hostname.com")

List all available datasources:

    datasources()

    ## ℹ Processing request...                       
    ## ── Robonomist Server Datasources

    ##    dataset          title                                                       
    ##  1 tidy             Robonomist's processed tidy data                            
    ##  2 StatFin          Statistics Finland, StatFin database                        
    ##  3 StatFin_Passiivi Statistics Finland, StatFin archive database                
    ##  4 Eurostat         Statistic Finland, Eurostat main tables database            
    ##  5 Vero             Verohallinnon tilastotietokanta                             
    ##  6 kunnat           Tilastokeskus, Kuntien avainluvut                           
    ##  7 kunnat           Tilastokeskus, Kuntien ja kuntayhtymien raportoimat taloust…
    ##  8 tulli            Finnish Customs, Uljas Statistical Database                 
    ##  9 covid            European Centre for Disease Prevention and Control COVID-19…
    ## 10 covid            COVID-19 Data Hub dataset                                   
    ## 11 ec               European Commission's Business and consumer surveys         
    ## 12 eurostat         Eurostat database                                           
    ## 13 ecb              ECB Statistical Data Warehouse                              
    ## 14 oecd             OECD database                                               
    ## 15 valtiokonttori   Valtiokonttori, Valtiontalouden kuukausitiedote             
    ## 16 epirapo          THL Epirapo COVID-19 database                               
    ## 17 sotkanet         THL Sotkanet                                                
    ## 18 wb               World Bank Open Data

The `data` function is convenient way to search and get data tables.
Print all available data tables:

    data()

    ## ℹ Processing request...                       
    ## ── Robonomist Database search results

    ##    id                title                                                      
    ##  1 tidy/ashi         Osakeasuntojen hinnat                                      
    ##  2 tidy/ati          Ansiotasoindeksi ja säännöllisen ansion indeksi työnantaja…
    ##  3 tidy/jali         Julkisyhteisöjen alijäämä ja velka                         
    ##  4 tidy/jtume        Julkisyhteisöjen tulot ja menot neljännesvuosittain        
    ##  5 tidy/kbar         Kuluttajabarometri                                         
    ##  6 tidy/kbar_alue    Kuluttajabarometri alueittain                              
    ##  7 tidy/khi_hist     Kuluttajahintaindeksi, kuukausitiedot, 1972M01 alkaen      
    ##  8 tidy/khi2015      Kuluttajahintaindeksi (2015=100)                           
    ##  9 tidy/kk_ajoik     Ajoneuvokannan keski-ikä maakunnittain                     
    ## 10 tidy/kk_alope_pää Aloittaneet ja lopettaneet yritykset kunnittain ja päätoim…
    ## # … with 34,703 more rows

To get a specific data table, use the tables id.

    data("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")

    ## ℹ Processing request...

    ## # Robonomist id: StatFin/vrm/synt/statfin_synt_pxt_12dx.px
    ## # A tibble:      2,981 x 3
    ## # Title:         Väestönmuutokset muuttujina Vuosi ja Tiedot
    ## # Last updated:  2020-05-14 08:00:00
    ## # Next update:   2021-05-14 08:00:00
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
    ## # … with 2,971 more rows

## Features

You can easily explore all available data tables in the Data Viewer.

    View(data())

To explore available data tables in the `Vero` dataset, for example, use
the dataset name with a forward slash as the first argument in `data`,
i.e. `View(data("Vero/"))`. Or print all the data table listing:

    data("Vero/")

    ## ℹ Processing request...                       
    ## ── Robonomist Database search results

    ##    id                                       title                               
    ##  1 Vero/Kiinteistoverot/kive_101.px         1.1 Maksuunpantu kiinteistövero: as…
    ##  2 Vero/Kiinteistoverot/kive_102.px         1.2 Maksuunpantu kiinteistövero: as…
    ##  3 Vero/Kiinteistoverot/kive_201.px         2.1 Käyttötarkoituksen mukaiset kii…
    ##  4 Vero/Kiinteistoverot/kive_202.px         2.2 Kiinteistöveroprosentin mukaise…
    ##  5 Vero/Kiinteistoverot/kive_301.px         3. Rakennusten kiinteistöverot, jäl…
    ##  6 Vero/Kiinteistoverot/kive_400.px         4. Maankäyttölajitilasto muuttujina…
    ##  7 Vero/Valmistevero/valmistevero_010.px    Valmistevero muuttujina Valmistever…
    ##  8 Vero/Verotulojen_kehitys/010_alvkavamp_… 3.2. Oma-aloitteisten verojen ilmoi…
    ##  9 Vero/Verotulojen_kehitys/010_alvkavatol… 3.3. Oma-aloitteisten verojen ilmoi…
    ## 10 Vero/Verotulojen_kehitys/010_alvkava_ta… 3.1. Oma-aloitteisten verojen ilmoi…
    ## # … with 311 more rows

To search all data tables related to “väestö”, use:

    data_search("väestö")

    ## ℹ Processing request...                       
    ## ── Robonomist Database search results

    ##    id                          title                                            
    ##  1 tidy/kk_kourak              15 vuotta täyttänyt väestö koulutusasteen, maaku…
    ##  2 tidy/kk_pieku               Asuntoväestön pienituloisuus ja pitkittynyt pien…
    ##  3 tidy/kk_piemk               Asuntoväestön pienituloisuus ja pitkittynyt pien…
    ##  4 tidy/kk_tuloek              Tuloerot ja tulonsiirtojen tuloeroja tasaava vai…
    ##  5 tidy/kk_tuloemk             Tuloerot ja tulonsiirtojen tuloeroja tasaava vai…
    ##  6 tidy/kk_vaennuste           Väestöennuste 2019-2040                          
    ##  7 tidy/kk_vamuu_alue_arkisto  Väestömuutosten ennakkotiedot alueittain, arkisto
    ##  8 tidy/kk_vamuu_alue_tot      Väestönmuutokset ja väkiluku alueittain          
    ##  9 tidy/kk_varake_alue         Väestörakenteen ennakkotiedot alueittain         
    ## 10 tidy/kk_varake_alue_arkisto Väestörakenteen ennakkotiedot alueittain, arkisto
    ## # … with 814 more rows

Also the `data("väestö")` function will search data for data tables when
the argument does not match an exact table id or an unique data table.
E.g. in this case it will return the same search results as
`data_search("väestö")`.

To prevent searching and guarantee that a data table or an error will be
returned, use `data_get("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")`.

The `data()` function will return a data table, when exactly one match
is found. Use `data_get()` to return a data table for a given table id.
The function `data()` is meant for exploration, and in production
settings it is better to use `data_get()`. The function `data_search()`
allows to search and return matching table ids, without downloading
actual data.

## Examples

    data("StatFin/vrm/synt/statfin_synt_pxt_12dx.px") %>%
      robonomist::tidy_auto() %>%
      filter(Tiedot %in% c("Elävänä syntyneet", "Kuolleet")) %>%
      ggplot(aes(time, value/1000, color = Tiedot)) +
      geom_line() +
      labs(title = "Elävänä syntyneet ja kuolleet Suomessa",
           subtitle = "Tuhatta henkeä",
           caption = "Lähde: Tilastokeskus.", x=NULL, y=NULL)

![](README_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

    data("ec/esi_nace2§(Fin|Swe|Ger)§sentiment§2015-01-01") %>%
      ggplot(aes(time, value, color = Country)) +
      geom_line() +
      labs(title = "Economic Sentiment Indicator",
           subtitle = "Composite index (average = 100)",
           caption = "Source: European Commission.", x=NULL,y=NULL)

![](README_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

You can also export the data, for example to an [Excel
file](../../raw/main/README_files/export.xlsx):

    data("ec/esi_nace2§(Fin|Swe|Ger)§§2015-01-01") %>%
      pivot_wider(names_from = Country) %>%
      split(.$Indicator) %>%
      writexl::write_xlsx("README_files/export.xlsx")
