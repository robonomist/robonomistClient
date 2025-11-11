# Explore data by listing distinct categorical values and summarizing other variables

The `ogle` function provides a quick overview of the contents within a
tibble, specifically targeting the exploration of categorical variables
by listing their distinct values and summarizing other variable types.
This function is useful for preliminary data exploration before
proceeding with more specific data filtering or analysis.

## Usage

``` r
ogle(.data, ...)
```

## Arguments

- .data:

  A tibble to explore.

- ...:

  \<'data-masking'\> Additional arguments, specifying the variables to
  be included in the exploration. When no variables are specified, all
  variables in the tibble are explored.

## Value

A list where each element corresponds to a variable in the tibble. For
character and factor variables, it returns their distinct values. For
variables that meet a summary condition (as defined by
`robonomistClient:::is_summary`), a statistical summary is returned.

## Examples

``` r
if (FALSE) { # \dontrun{
data("sotkanet/4") %>% ogle()
data("sotkanet/4") %>% ogle(region)
} # }
```
