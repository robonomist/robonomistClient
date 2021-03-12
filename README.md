# Robonomist Client <a href='https://robonomist.com'><img src='man/figures/logo.png' align="right" height="138.5" /></a>

Client R package for Robonomist Server

## Datasources

The `robonomistClient` package allows easy and fast access to various datasources via Robonomist Server instances, which integrate various datasources with up-to-date data.

Currently integrated datasources:

* Statistics Finland (StatFin & StatFin archive databases)
* Statistics Finland municipal data (Key figures & Financial data)
* Finnish Tax Administration
* Customs Finland
* Finnish Treasury
* Eurostat
* European Commission Business and consumer surveys
* World Bank
* OECD
* THL Sotkanet
* THL Epirapo COVID-19 data
* ECB
* COVID-19 data (ECDC & covid19datahub.io)
* Robonomist's processed tidy data

## Installation

Install the development version from github:

``` r
## install.packages("devtools")
devtools::install_github("robonomist/robonomistClient")
```

## Getting started

Once installed, set the `robonomist.server` option to your Robonomist Server's address. Now can start exploring the database. The `data` function is convenient way to search and get data tables.

``` r
library(robonomistClient)
options(robonomist.server = "hostname.com")

## List all available data tables
data()

## List all data tables related to "inflation"
data("inflation")
data_search("inflation")

## Get specific data table
data("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")
data_get("StatFin/vrm/synt/statfin_synt_pxt_12dx.px")

```

The `data()` function will return a data table, when exactly one match is found. Use `data_get()` to return a data table for a given table id. The function `data()` is meant for exploration, and in production settings it is better to use `data_get()`. The function `data_search()` allows to search and return matching table ids.
