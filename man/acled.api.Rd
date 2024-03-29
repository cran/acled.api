% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/acled.api.R
\name{acled.api}
\alias{acled.api}
\title{Automated Retrieval of ACLED Conflict Event Data}
\usage{
acled.api(
  email.address = Sys.getenv("ACLED_EMAIL_ADDRESS"),
  access.key = Sys.getenv("ACLED_ACCESS_KEY"),
  country = NULL,
  region = NULL,
  start.date = NULL,
  end.date = NULL,
  add.variables = NULL,
  all.variables = FALSE,
  dyadic = FALSE,
  interaction = NULL,
  other.query = NULL
)
}
\arguments{
\item{email.address}{character string. Supply the email address that you registered with \href{https://developer.acleddata.com/}{ACLED access}.
The email address can also be set as an environment variable using \emph{\code{Sys.setenv(ACLED_EMAIL_ADDRESS="your.email.address")}}, in
which case this argument can be skipped. Usage examples below illustrate these two approaches.}

\item{access.key}{character string. Supply your ACLED access key. The  access key can also be set as an environment variable
using \emph{\code{Sys.setenv(ACLED_ACCESS_KEY="your.access.key")}}, in which case this argument can be skipped. Usage examples below illustrate these two approaches.}

\item{country}{character vector. Supply one or more country names to narrow down which events should be retrieved. See the details
below for information on how the arguments "country" and "region" interact.}

\item{region}{numeric or character vector. Supply one or more region codes (numeric) or region names (character)
to narrow down which events should be retrieved (see \href{https://acleddata.com/resources/general-guides/}{ACLED's API user guide}
for details on region codes and names). See the details below for information on how the arguments "country" and "region" interact.}

\item{start.date}{character string. Supply the earliest date to be retrieved. Format: "yyyy-mm-dd".}

\item{end.date}{character string. Supply the last date to be retrieved. Format: "yyyy-mm-dd".}

\item{add.variables}{character vector. Supply the names of ACLED variables you wish to add to the
default output (see \href{https://acleddata.com/resources/general-guides/}{ACLED's codebook} for details). The default
output includes: region, country, year, event_date, source, admin1, admin2, admin3, location, event_type, sub_event_type,
interaction, fatalities.}

\item{all.variables}{logical. When set to FALSE (default), a narrow default selection of variables is returned (which
can be refined using the argument add.variables). If set to TRUE, all variables are included in the output (overrides
argument add.variables).}

\item{dyadic}{logical. When set to FALSE (default), monadic data is returned (one
observation per event). If set to TRUE, dyadic data is returned.}

\item{interaction}{numeric vector. Supply one or more interaction codes to narrow down which events should be
retrieved (see \href{https://acleddata.com/resources/general-guides/}{ACLED's codebook} for details.}

\item{other.query}{character vector. Allows users to add their own ACLED API queries to the
GET call. Vector elements are assumed to be individual queries, and are automatically separated by an & sign.}
}
\value{
A data frame containing ACLED events.
}
\description{
Access and manage the application programming interface (API)
of the \href{https://acleddata.com/}{Armed Conflict Location & Event Data Project (ACLED)}.
The function \emph{\code{acled.api()}} makes it easy to retrieve a user-defined sample (or all of the
available data) of ACLED, enabling a seamless integration of regular data updates into
the research work flow. If the data are intended for replicable use (e.g., later publication of analysis results), the
downloaded data should be stored locally after retrieval. See the package's README file for a
note on replicability when using ACLED data. \cr \cr
When using this package, you acknowledge that you have read ACLED's terms and
conditions of use, and that you agree with their attribution requirements.
}
\details{
The function \emph{\code{acled.api()}} is an R wrapper for
the \href{https://acleddata.com/}{Armed Conflict Location & Event Data Project} API.
Internally it uses \emph{\code{httr}} to access the API, and \emph{\code{jsonlite}} to manage the JSON content that the call returns. The JSON data
are converted into the base class \emph{\code{data.frame}}. Variables are of class \emph{\code{character}} by default.
Variables which only contain numbers as recognized by the regular
expression \verb{^[0-9]+$} are coerced into \emph{\code{numeric}} before the \emph{\code{data.frame}} object is returned. \cr \cr
The user's registered email address and ACLED access key can be supplied as strings directly to their respective arguments,
or set in advance as environment variables
using \cr \cr \emph{\code{Sys.setenv(ACLED_EMAIL_ADDRESS="your.email.address")}} and \cr \cr \emph{\code{Sys.setenv(ACLED_ACCESS_KEY="your.access.key")}}. \cr \cr
If both the country argument and the region argument are NULL (default), all available countries are retrieved. The same applies to
the time frame when both the start date and the end date are NULL (default). Note that the API cannot handle requests with only one
of the dates specified (either none of them or both of them need to be supplied). \cr \cr
The ACLED API combines the country argument and the region argument with a logical AND operator. Therefore, specifying e.g. the
country "Togo" and the region "Southern Africa" leads the API to query for a country named "Togo" in the region "Southern Africa".
In this case, no data will be returned as no events match this query.
}
\examples{
\dontrun{
# Email and access key provided as strings:
my.data.frame1 <- acled.api(
  email.address = "your.email.address",
  access.key = "your.access.key",
  region = c(1,7),
  start.date = "2018-11-01",
  end.date = "2018-11-31")
head(my.data.frame1)

# Email and access key provided as environment variables:
my.data.frame2 <- acled.api(
  email.address = Sys.getenv("ACLED_EMAIL_ADDRESS"),
  access.key = Sys.getenv("ACLED_ACCESS_KEY"),
  region = c(1,7),
  start.date = "2020-01-01",
  end.date = "2020-11-31",
  interaction = c(10:18, 22:28),
  add.variables = c("geo_precision", "time_precision"))
sd(my.data.frame2$geo_precision)
}
}
\references{
Armed Conflict Location & Event Data Project (ACLED); \url{https://acleddata.com/} \cr
Clionadh Raleigh, Andrew Linke, Havard Hegre and Joakim Karlsen. 2010.
"Introducing ACLED-Armed Conflict Location and Event Data." \emph{Journal of Peace Research} 47 (5): 651-660.
}
\author{
Christoph Dworschak \cr Website: \url{https://www.chrisdworschak.com/}
}
