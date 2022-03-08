Setup
-----

    library(robonomistClient)
    library(tidyverse)

FRED
----

The St. Louis Fed Database FRED contain about +800k time series. To
avoid filling up the Robonomist Server table of content, individual time
series from FRED are not directly visible in the search function.
Instead, you can list all “sources” and “releases” with:

    data("fred/")
    #>    id             title                           lang
    #>  1 fred/source=1  Board of Governors of the Fede… en  
    #>  2 fred/source=3  Federal Reserve Bank of Philad… en  
    #>  3 fred/source=4  Federal Reserve Bank of St. Lo… en  
    #>  4 fred/source=6  Federal Financial Institutions… en  
    #>  5 fred/source=11 Dow Jones & Company             en  
    #>  6 fred/source=14 University of Michigan          en  
    #>  7 fred/source=15 Council of Economic Advisers (… en  
    #>  8 fred/source=16 U.S. Office of Management and … en  
    #>  9 fred/source=17 U.S. Congressional Budget Offi… en  
    #> 10 fred/source=18 U.S. Bureau of Economic Analys… en  
    #> 11 fred/source=19 U.S. Census Bureau              en  
    #> 12 fred/source=21 U.S. Department of Housing and… en  
    #> 13 fred/source=22 U.S. Bureau of Labor Statistics en  
    #> 14 fred/source=23 U.S. Department of the Treasur… en  
    #> 15 fred/source=26 Haver Analytics                 en  
    #> 16 fred/source=31 Reserve Bank of Australia       en  
    #> 17 fred/source=32 Deutsche Bundesbank             en  
    #> 18 fred/source=33 Bank of Italy                   en  
    #> 19 fred/source=34 Swiss National Bank             en  
    #> 20 fred/source=35 Central Bank of the Republic o… en  
    #> 21 fred/source=36 U.S. Federal Housing Finance A… en  
    #> 22 fred/source=37 Bank of Japan                   en  
    #> 23 fred/source=38 Bank of Mexico                  en  
    #> 24 fred/source=41 Freddie Mac                     en  
    #> 25 fred/source=42 Automatic Data Processing, Inc. en  
    #> 26 fred/source=44 Wilshire Associates             en  
    #> 27 fred/source=46 Federal Reserve Bank of Kansas… en  
    #> 28 fred/source=47 Chicago Board Options Exchange  en  
    #> 29 fred/source=48 Organization for Economic Co-o… en  
    #> 30 fred/source=50 U.S. Employment and Training A… en  
    #> # … with 383 more rows

The database hierarchy is very simple: Sources contain releases, and
releases contain time series.

To list all releases, for example, in source 1 (Board of Governors of
the Federal Reserve System), call:

    data("fred/source=1")
    #> # A tibble: 34 × 5
    #>    release_id name                                     press_release link  notes
    #>         <int> <chr>                                    <lgl>         <chr> <chr>
    #>  1         13 G.17 Industrial Production and Capacity… TRUE          http…  <NA>
    #>  2         14 G.19 Consumer Credit                     TRUE          http…  <NA>
    #>  3         15 G.5 Foreign Exchange Rates               TRUE          http…  <NA>
    #>  4         17 H.10 Foreign Exchange Rates              TRUE          http…  <NA>
    #>  5         18 H.15 Selected Interest Rates             TRUE          http…  <NA>
    #>  6         19 H.3 Aggregate Reserves of Depository In… TRUE          http… "The…
    #>  7         20 H.4.1 Factors Affecting Reserve Balances TRUE          http…  <NA>
    #>  8         21 H.6 Money Stock Measures                 TRUE          http…  <NA>
    #>  9         22 H.8 Assets and Liabilities of Commercia… TRUE          http…  <NA>
    #> 10         52 Z.1 Financial Accounts of the United St… TRUE          http… "The…
    #> # … with 24 more rows

To list all time series in the first release on the list (Industrial
Production and Capacity Utilization), call:

    data("fred/release=13")
    #> # A tibble: 1,884 × 14
    #>    series_id    title observation_sta… observation_end frequency frequency_short
    #>    <chr>        <chr> <chr>            <chr>           <chr>     <chr>          
    #>  1 CAPB00004S   Indu… 1948-01-01       2021-12-01      Monthly   M              
    #>  2 CAPB00004SQ  Indu… 1948-01-01       2021-10-01      Quarterly Q              
    #>  3 CAPB50001S   Indu… 1967-01-01       2021-12-01      Monthly   M              
    #>  4 CAPB50001SQ  Indu… 1967-01-01       2021-10-01      Quarterly Q              
    #>  5 CAPB5610CS   Indu… 1967-01-01       2021-12-01      Monthly   M              
    #>  6 CAPB5610CSQ  Indu… 1967-01-01       2021-10-01      Quarterly Q              
    #>  7 CAPB562A3CS  Indu… 1948-01-01       2021-12-01      Monthly   M              
    #>  8 CAPB562A3CSQ Indu… 1948-01-01       2021-10-01      Quarterly Q              
    #>  9 CAPB5640CS   Indu… 1948-01-01       2021-12-01      Monthly   M              
    #> 10 CAPB5640CSQ  Indu… 1948-01-01       2021-10-01      Quarterly Q              
    #> # … with 1,874 more rows, and 8 more variables: units <chr>, units_short <chr>,
    #> #   seasonal_adjustment <chr>, seasonal_adjustment_short <chr>,
    #> #   last_updated <chr>, popularity <int>, group_popularity <int>, notes <chr>

To download a time series, use the `get_data` function:

    data_get("fred/CAPB00004S")
    #> # A tibble: 888 × 7
    #>    series_id  Title            Frequency Units `Seasonal adju…` time       value
    #>    <chr>      <chr>            <chr>     <chr> <chr>            <date>     <dbl>
    #>  1 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-01-01  16.3
    #>  2 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-02-01  16.4
    #>  3 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-03-01  16.5
    #>  4 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-04-01  16.6
    #>  5 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-05-01  16.6
    #>  6 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-06-01  16.7
    #>  7 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-07-01  16.8
    #>  8 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-08-01  16.9
    #>  9 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-09-01  17.0
    #> 10 CAPB00004S Industrial Capa… Monthly   Inde… Seasonally Adju… 1948-10-01  17.1
    #> # … with 878 more rows

You can also retrieve multiple time series by providing a vector of ids:

    d <- data_get(c("fred/CAPB5610CS", "fred/CAPB5640CS"))
    d
    #> # A tibble: 1,548 × 7
    #>    series_id  Title            Frequency Units `Seasonal adju…` time       value
    #>    <chr>      <chr>            <chr>     <chr> <chr>            <date>     <dbl>
    #>  1 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-01-01  72.2
    #>  2 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-02-01  72.5
    #>  3 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-03-01  72.9
    #>  4 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-04-01  73.2
    #>  5 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-05-01  73.5
    #>  6 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-06-01  73.9
    #>  7 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-07-01  74.2
    #>  8 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-08-01  74.5
    #>  9 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-09-01  74.9
    #> 10 CAPB5610CS Industrial Capa… Monthly   Inde… Seasonally Adju… 1967-10-01  75.2
    #> # … with 1,538 more rows
    ggplot(d, aes(time, value, color = Title)) +
      geom_line()

![](/home/juha/workspace/robonomistClient/vignettes/special-exported_files/figure-markdown_strict/unnamed-chunk-6-1.png)

The FRED api also allows some basic time series transformations with the
`units` parameter:

    data_get(c("fred/CAPB5610CS", "fred/CAPB5640CS"), units = "pc1") |>
      ggplot(aes(time, value, color = Title)) +
      geom_line()

![](/home/juha/workspace/robonomistClient/vignettes/special-exported_files/figure-markdown_strict/unnamed-chunk-7-1.png)

Allowed values for `units`: \* lin = Levels (No transformation) \* chg =
Change \* ch1 = Change from Year Ago \* pch = Percent Change \* pc1 =
Percent Change from Year Ago \* pca = Compounded Annual Rate of Change
\* cch = Continuously Compounded Rate of Change \* cca = Continuously
Compounded Annual Rate of Change \* log = Natural Log

Similarly time series can be temporally aggregated with the `frequency`
and `aggregation_method` parameters:

    data_get(c("fred/CAPB5610CS", "fred/CAPB5640CS"), units = "pc1", frequency = "a", aggregation_method = "sum") |>
      ggplot(aes(time, value, color = Title)) +
      geom_line()
    #> Warning: Removed 2 row(s) containing missing values (geom_path).

![](/home/juha/workspace/robonomistClient/vignettes/special-exported_files/figure-markdown_strict/unnamed-chunk-8-1.png)

Allowed values for `frequency`: \* d = Daily \* w = Weekly \* bw =
Biweekly \* m = Monthly \* q = Quarterly \* sa = Semiannual \* a =
Annual

Allowed values for `aggregation_method`: \* avg = Average \* sum = Sum
\* eop = End of Period
