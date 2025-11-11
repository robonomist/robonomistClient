# Quickly explore categorical and summary variables in a tibble

Provides a concise overview of a tibble by listing unique values for
categorical variables and summary statistics for numeric or date/time
variables. Useful for initial data exploration before filtering or
analysis.

## Usage

``` r
ogle(.data, ...)
```

## Arguments

- .data:

  A tibble to explore.

- ...:

  \<'data-masking'\> Optional. Variables to include in the exploration.
  If omitted, all variables are explored.

## Value

A list: for character and factor variables, their unique values; for
numeric and date/time variables, a summary.

## Examples

``` r
if (FALSE) { # \dontrun{
data("sotkanet/4") %>% ogle()
data("sotkanet/4") %>% ogle(region)
} # }
```
