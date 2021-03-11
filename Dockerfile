FROM rocker/r-base:4.0.3

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
  r-cran-devtools \
  r-cran-httr \
  r-cran-tibble \
  r-cran-crayon \
  r-cran-cli \
  r-cran-pillar \
  && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

COPY . /robonomistClient
RUN r -e 'devtools::install("robonomistClient")'
RUN rm -r robonomistClient

CMD ["R"]

