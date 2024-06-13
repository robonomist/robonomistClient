
# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

A client package for R to access Robonomist Data Server

## Datasources

The `robonomistClient` package allows easy and fast access to various
datasources connecting to a Robonomist Data Server. Currently the client
package provides access to 98 253 up-to-date data tables from 60
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
    ##    dataset            title                           languages           datasource                 
    ##  1 StatFin            Statistics Finland, StatFin da… c("fi", "sv", "en") StatFin                    
    ##  2 StatFin_Passiivi   Statistics Finland, StatFin ar… c("fi", "sv", "en") StatFin_Passiivi           
    ##  3 Vero               Finnish Tax Administration sta… c("fi", "sv", "en") Vero                       
    ##  4 ec                 European Commission's Business… en                  EC                         
    ##  5 kunnat             Key statistics of municipaliti… c("fi", "sv", "en") KuntienAvainluvut          
    ##  6 kunnat             Financial data reported by mun… c("fi", "sv", "en") KuntienTalous              
    ##  7 paavo              Statistics Finland's Paavo dat… c("fi", "sv", "en") Paavo                      
    ##  8 tulli              Finnish Customs, Uljas Statist… c("fi", "sv", "en") Tulli                      
    ##  9 luke               Statistics database of Natural… c("fi", "sv", "en") Luke                       
    ## 10 etk                Finnish Centre for Pensions' s… c("fi", "sv", "en") ETK                        
    ## 11 eurostat           Eurostat database               c("en", "de", "fr") eurostat                   
    ## 12 ecb                ECB Statistical Data Warehouse  en                  ECB                        
    ## 13 bundesbank         Deutsche Bundesbank time serie… c("en", "de")       Bundesbank                 
    ## 14 oecd               OECD database                   en                  OECD                       
    ## 15 oecd3              OECD database (SDMX-JSON API)   en                  OECD3                      
    ## 16 oecd               OECD database                   en                  OECD4                      
    ## 17 wb                 World Bank Open Data            en                  WB                         
    ## 18 hsa                Greater Helsinki Open Statisti… c("fi", "sv", "en") HSA                        
    ## 19 helymp             Helsinki environmental statist… c("fi", "en", "sv") HelsinginYmpäristötilasto  
    ## 20 helhyv             Helsinki wellbeing statistics   fi                  HelsinginHyvinvointitilasto
    ## 21 nordstat           Nordstat                        c("fi", "en", "sv") Nordstat                   
    ## 22 covid              European Centre for Disease Pr… en                  ECDC                       
    ## 23 vipunen            Vipunen, Education Statistics … fi                  Vipunen                    
    ## 24 epirapo            THL Epirapo COVID-19 database   fi                  Epirapo                    
    ## 25 sotkanet           Sotkanet indicator bank of the… c("fi", "en", "sv") Sotkanet                   
    ## 26 maakoto            Immigrants and integration sta… c("fi", "sv", "en") Maakoto                    
    ## 27 koto               Integration database, Finnish … c("fi", "sv", "en") Koto                       
    ## 28 toimipaikkalaskuri Toimipaikkalaskuri database, S… fi                  Toimipaikkalaskuri         
    ## 29 kokeelliset        Statistics Finland's experimen… c("fi", "sv", "en") KokeellisetTilastot        
    ## 30 traficom           Traficom statistics database    c("fi", "sv", "en") Traficom                   
    ## # ℹ 30 more rows
    ## # ℹ 1 more variable: available <lgl>

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
    ## # ℹ 172,382 more rows

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
    ## # Vintage:       2024-03-08 18:57:12
    ## # A tibble:      1,431 × 10
    ##    REF_AREA FREQ   MEASURE                SPECIES UNIT_MEASURE time         value UNIT_MULT DECIMALS CONVENTION
    ##  * <chr>    <chr>  <chr>                  <chr>   <chr>        <date>       <dbl> <chr>     <chr>    <chr>     
    ##  1 Israel   Annual Aquaculture production Total   Tonnes       2021-01-01  14875  0         0        LW        
    ##  2 Sweden   Annual Aquaculture production Total   Tonnes       1995-01-01   7554  0         0        LW        
    ##  3 France   Annual Aquaculture production Total   Tonnes       1995-01-01 280786  0         0        LW        
    ##  4 Denmark  Annual Aquaculture production Total   Tonnes       2003-01-01  37772  0         0        LW        
    ##  5 Denmark  Annual Aquaculture production Total   Tonnes       2002-01-01  32026  0         0        LW        
    ##  6 Denmark  Annual Aquaculture production Total   Tonnes       2001-01-01  41573  0         0        LW        
    ##  7 Sweden   Annual Aquaculture production Total   Tonnes       2005-01-01   5880  0         0        LW        
    ##  8 Sweden   Annual Aquaculture production Total   Tonnes       2004-01-01   5989  0         0        LW        
    ##  9 Sweden   Annual Aquaculture production Total   Tonnes       2003-01-01   6334  0         0        LW        
    ## 10 Denmark  Annual Aquaculture production Total   Tonnes       2019-01-01  40221. 0         0        LW        
    ## # ℹ 1,421 more rows

## More information

You can find detailed information on how to use `robonomistClient` in
the [documentation](https://robonomist.github.io/robonomistClient).

  - [Basic
    features](https://robonomist.github.io/robonomistClient/articles/basic_features.html)
  - [Examples](https://robonomist.github.io/robonomistClient/articles/examples.html)
  - [Filtering large data
    tables](https://robonomist.github.io/robonomistClient/articles/filtering.html)
