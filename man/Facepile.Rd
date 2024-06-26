% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/components.R, R/documentation.R, R/examples.R
\name{Facepile}
\alias{Facepile}
\title{Facepile}
\usage{
Facepile(...)
}
\arguments{
\item{...}{Props to pass to the component.
The allowed props are listed below in the \bold{Details} section.}
}
\value{
Object with \code{shiny.tag} class suitable for use in the UI of a Shiny app.
}
\description{
A face pile (\code{Facepile}) displays a list of personas. Each circle represents a person and contains their image or initials. Often this control is used when sharing who has access to a specific view or file, or when assigning someone a task within a workflow.

For more details and examples visit the \href{https://developer.microsoft.com/en-us/fluentui#/controls/web/Facepile}{official docs}.
The R package cannot handle each and every case, so for advanced use cases
you need to work using the original docs to achieve the desired result.
}
\details{
\itemize{
\item \bold{ addButtonProps } \code{IButtonProps} \cr Button properties for the add face button
\item \bold{ ariaDescription } \code{string} \cr ARIA label for persona list
\item \bold{ ariaLabel } \code{string} \cr Defines the aria label that the screen readers use when focus goes on a list of personas.
\item \bold{ chevronButtonProps } \code{IButtonProps} \cr Deprecated at v0.70, use \code{overflowButtonProps} instead.
\item \bold{ className } \code{string} \cr Additional css class to apply to the Facepile
\item \bold{ componentRef } \verb{IRefObject<IFacepile>} \cr Optional callback to access the IFacepile interface. Use this instead of ref for accessing the public methods and properties of the component.
\item \bold{ getPersonaProps } \verb{(persona: IFacepilePersona) => IPersonaSharedProps} \cr Method to access properties on the underlying Persona control
\item \bold{ maxDisplayablePersonas } \code{number} \cr Maximum number of personas to show
\item \bold{ onRenderPersona } \verb{IRenderFunction<IFacepilePersona>} \cr Optional custom renderer for the persona, gets called when there is one persona in personas array
\item \bold{ onRenderPersonaCoin } \verb{IRenderFunction<IFacepilePersona>} \cr Optional custom renderer for the persona coins, gets called when there are multiple persona in personas array
\item \bold{ overflowButtonProps } \code{IButtonProps} \cr Properties for the overflow icon
\item \bold{ overflowButtonType } \code{OverflowButtonType} \cr Type of overflow icon to use
\item \bold{ overflowPersonas } \code{IFacepilePersona[]} \cr Personas to place in the overflow
\item \bold{ personas } \code{IFacepilePersona[]} \cr Array of IPersonaProps that define each Persona.
\item \bold{ personaSize } \code{PersonaSize} \cr Size to display the personas
\item \bold{ showAddButton } \code{boolean} \cr Show add person button
\item \bold{ styles } \verb{IStyleFunctionOrObject<IFacepileStyleProps, IFacepileStyles>} \cr Call to provide customized styling that will layer on top of the variant rules.
\item \bold{ theme } \code{ITheme} \cr Theme provided by High-Order Component.
}
}
\section{Best practices}{
\subsection{Layout}{
\itemize{
\item The face pile empty state should only include an "Add" button. Another variant is to use an input field with placeholder text instructing people to add a person. See the people picker component for the menu used to add people to the face pile list.
\item When there is only one person in the face pile, consider using their name next to the face or initials.
\item When there is a need to show the face pile expanded into a vertical list, include a downward chevron button. Selecting the chevron opens a standard list view of people.
\item When the face pile exceeds a max number of 5 people, show a button at the end of the list indicating how many are not being shown. Clicking or tapping on the overflow would open a standard list view of people.
\item The component can include an "Add" button which can be used for quickly adding a person to the list.
\item When hovering over a person in the face pile, include a tooltip or people card that offers more information about that person.
}
}
}

\examples{
library(shiny)
library(shiny.fluent)

personas <- list(
  list(personaName = "Adams Baker"),
  list(personaName = "Clark Davis"),
  list(personaName = "Evans Frank")
)

ui <- function(id) {
  ns <- NS(id)
  Facepile(personas = personas)
}

server <- function(id) {
  moduleServer(id, function(input, output, session) {})
}

if (interactive()) {
  shinyApp(ui("app"), function(input, output) server("app"))
}
}
