% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/robonomist_id.R
\name{robonomist_id}
\alias{robonomist_id}
\alias{new_robonomist_id}
\alias{robonomist_dataset}
\alias{robonomist_table}
\title{robonomist_id class}
\usage{
robonomist_id(x = character(), table = NULL)

new_robonomist_id(x = character())

robonomist_dataset(x)

robonomist_table(x)
}
\arguments{
\item{x}{character vector, Dataset name, or complete id string if \code{table} is NULL.}

\item{table}{character, Table name.}
}
\description{
robonomist_id objects are character vectors composed dataset and table names which are separated by "/".
}
\section{Functions}{
\itemize{
\item \code{new_robonomist_id()}: Constructor for robonomist_id class

\item \code{robonomist_dataset()}: Extract dataset component from robonomist_id

\item \code{robonomist_table()}: Extract table component from robonomist_id

}}
