# Print filter criteria for categorical variables in a tibble

Generates and prints a filter expression for the categorical variables
in a tibble. If run interactively and the `clipr` package is available,
the filter expression is also copied to the clipboard for easy use in
scripts or reports. This helps quickly create filter conditions for
further data analysis.

## Usage

``` r
print_filter(.data, ...)
```

## Arguments

- .data:

  A tibble containing the data.

- ...:

  \<'data-masking'\> Optional. Variables to include in the filter
  expression. If omitted, all categorical variables are used.

## Value

Invisibly returns the original tibble. The filter expression is printed
to the console and, if possible, copied to the clipboard.

## Examples

``` r
if (FALSE) { # \dontrun{
data("sotkanet/4") %>% print_filter(region_category, gender)
} # }
```
