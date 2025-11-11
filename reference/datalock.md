# Lock and Save Data Locally

Saves an R object `x` to a file with a `.rdlock` extension, effectively
"locking" its value for reproducible use. If the file already exists and
`overwrite` is `FALSE`, the function reads and returns the existing
value instead of overwriting it.

## Usage

``` r
datalock(
  x,
  name = NULL,
  path = getOption("robonomistClient.datalock.path"),
  overwrite = getOption("robonomistClient.datalock.overwrite", FALSE)
)
```

## Arguments

- x:

  The R object to save and lock.

- name:

  Optional. The file name to use. If `NULL`, a name is generated from a
  hash of the expression for `x`. Must be a single, non-empty character
  string if provided.

- path:

  Optional. Directory path to save the file. Defaults to the value of
  the 'robonomistClient.datalock.path' option. If `NULL`, saves to the
  current working directory.

- overwrite:

  Logical. If `TRUE`, overwrites any existing file. If `FALSE`
  (default), reads and returns the existing file if present.

## Value

The value of `x` after saving, or the value read from file if it already
exists and `overwrite` is `FALSE`.

## Note

If no name is provided, a hash of the expression for `x` is used as the
file name.

## Examples

``` r
library(tibble)

# Lock and save a data frame
locked_df1 <-
  tibble(x = runif(3), y = c("a", "b", "c")) |>
  datalock()

# Now re-running the same code retrieves the locked data instead of generating new random values
locked_df2 <-
  tibble(x = runif(3), y = c("a", "b", "c")) |>
  datalock()

# Check that the locked data is identical
identical(locked_df1, locked_df2)  # TRUE
#> [1] TRUE
```
