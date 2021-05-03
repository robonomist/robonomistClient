FROM rocker/r-ubuntu:20.04

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libssl-dev \
  liblz4-dev \
  r-cran-devtools \
  r-cran-httr \
  r-cran-tibble \
  r-cran-crayon \
  r-cran-cli \
  r-cran-pillar \
  r-cran-dplyr \
  r-cran-vctrs \
  r-cran-rlang \
  r-cran-purrr \
  r-cran-tidyr \
  && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

COPY . /robonomistClient
RUN r -e 'devtools::install("robonomistClient")'
RUN rm -r robonomistClient

CMD ["R"]

