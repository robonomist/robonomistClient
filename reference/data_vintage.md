# Vintage of a data table

`data_vintage()` returns the latest update time of the specified data
tables for the purpose of monitoring data freshness.

The vintage indicates the time when the table of was last updated at the
source, if such information is provided by the datasource. If the source
does not provide vintage information, the vintage will be the time new
data was last queried from the source.

## Usage

``` r
data_vintage(id)
```

## Arguments

- id:

  Character vector, Exact table ids

## Value

Named vector of POSIXct-class datetimes indicating the vintage of each
table.
