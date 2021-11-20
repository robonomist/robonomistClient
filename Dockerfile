FROM rocker/tidyverse:4.1.2

COPY . /robonomistClient
RUN r -e 'devtools::install("robonomistClient")'
RUN rm -r robonomistClient

CMD ["R"]

