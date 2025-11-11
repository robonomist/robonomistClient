# Set the hostname of Robonomist Data Server

Set the hostname of Robonomist Data Server

## Usage

``` r
set_robonomist_server(
  hostname = getOption("robonomist.server"),
  access_token = getOption("robonomist.access.token")
)
```

## Arguments

- hostname:

  character, Set the hostname in format "data.example.com". To use
  secure websocket, also set the protocol, e.g.
  "wss://data.example.com".

- access_token, :

  character, Bearer token
