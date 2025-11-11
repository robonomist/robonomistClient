# robonomist_id class

robonomist_id objects are character vectors composed dataset and table
names which are separated by "/".

## Usage

``` r
robonomist_id(x = character(), table = NULL)

new_robonomist_id(x = character())

robonomist_dataset(x)

robonomist_table(x)
```

## Arguments

- x:

  character vector, Dataset name, or complete id string if `table` is
  NULL.

- table:

  character, Table name.

## Functions

- `new_robonomist_id()`: Constructor for robonomist_id class

- `robonomist_dataset()`: Extract dataset component from robonomist_id

- `robonomist_table()`: Extract table component from robonomist_id
