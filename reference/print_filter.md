# Print all filtering criteria for categorical variables of a tibble

This function generates and prints a filtering criteria string for
categorical variables in a tibble. If running in an interactive session
and the `clipr` package is installed, the generated filter string will
also be copied to the clipboard for easy pasting into scripts or
reports. This is particularly useful for quickly generating filter
conditions for subsequent data manipulation tasks.

## Usage

``` r
print_filter(.data, ...)
```

## Arguments

- .data:

  A tibble containing the data.

- ...:

  \<'data-masking'\> Optional variables to specify which categorical
  variables to include in the filter printout. If omitted, filter
  criteria for all categorical variables will be generated and printed.

## Value

The function prints the filtering criteria to the console and, if
applicable, copies it to the clipboard. It returns the original tibble
invisibly for further chaining of functions.

## Examples

``` r
if (FALSE) { # \dontrun{
data("sotkanet/4") %>% print_filter(region_category, gender)
} # }
```
