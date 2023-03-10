% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extensions.R
\name{parseTheme}
\alias{parseTheme}
\title{parseTheme}
\usage{
parseTheme(path = NULL, json = NULL)
}
\arguments{
\item{path}{A path to JSON file containing the theme created in Theme Designer}

\item{json}{A JSON string containing the theme created in Theme Designer}
}
\value{
A list with Fluent theme that can be used in \code{\link{ThemeProvider}}
}
\description{
Reads a theme JSON generated by Theme Designer: \url{https://fabricweb.z5.web.core.windows.net/pr-deploy-site/refs/heads/master/theming-designer/}
and parses it to an object digestable by \code{\link{ThemeProvider}}
}
\seealso{
\code{\link[=ThemeProvider]{ThemeProvider()}} for usage of this function
}
