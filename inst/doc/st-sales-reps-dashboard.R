## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(shiny.fluent)

## ---- include=FALSE, cache=FALSE----------------------------------------------
do.call(knitr::read_chunk, list(path = "../inst/examples/tutorial/dashboard_layout.R"))

## ----libraries, eval=FALSE----------------------------------------------------
#  library(dplyr)
#  library(ggplot2)
#  library(glue)
#  library(leaflet)
#  library(plotly)
#  library(sass)
#  library(shiny)
#  library(shiny.fluent)
#  library(shiny.router)

## ----make-page, eval=FALSE----------------------------------------------------
#  makePage <- function (title, subtitle, contents) {
#    tagList(div(
#      class = "page-title",
#      span(title, class = "ms-fontSize-32 ms-fontWeight-semibold", style =
#             "color: #323130"),
#      span(subtitle, class = "ms-fontSize-14 ms-fontWeight-regular", style =
#             "color: #605E5C; margin: 14px;")
#    ),
#    contents)
#  }

## ----analysis-page, eval=FALSE------------------------------------------------
#  analysis_page <- makePage(
#    "Sales representatives",
#    "Best performing reps",
#    div(
#      Stack(
#        horizontal = TRUE,
#        tokens = list(childrenGap = 10),
#        makeCard("Filters", filters, size = 4, style = "max-height: 320px"),
#        makeCard("Deals count", plotlyOutput("plot"), size = 8, style = "max-height: 320px")
#      ),
#      uiOutput("analysis")
#    )
#  )
#  
#  ui <- fluentPage(
#    tags$style(".card { padding: 28px; margin-bottom: 28px; }"),
#    analysis_page
#  )

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part2-step1.png")

## ----layout, eval=FALSE-------------------------------------------------------
#  header <- "header"
#  navigation <- "navigation"
#  footer <- "footer"
#  
#  layout <- function(mainUI){
#    div(class = "grid-container",
#        div(class = "header", header),
#        div(class = "sidenav", navigation),
#        div(class = "main", mainUI),
#        div(class = "footer", footer)
#    )
#  }

## ----basic-layout-ui, eval=FALSE----------------------------------------------
#  ui <- fluentPage(
#    layout(analysis_page),
#    tags$head(
#      tags$link(href = "style.css", rel = "stylesheet", type = "text/css")
#    ))

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part2-step2.png")

## ----header, eval=FALSE-------------------------------------------------------
#  header <- tagList(
#    img(src = "appsilon-logo.png", class = "logo"),
#    div(Text(variant = "xLarge", "Sales Reps Analysis"), class = "title"),
#    CommandBar(
#      items = list(
#        CommandBarItem("New", "Add", subitems = list(
#          CommandBarItem("Email message", "Mail", key = "emailMessage", href = "mailto:me@example.com"),
#          CommandBarItem("Calendar event", "Calendar", key = "calendarEvent")
#        )),
#        CommandBarItem("Upload sales plan", "Upload"),
#        CommandBarItem("Share analysis", "Share"),
#        CommandBarItem("Download report", "Download")
#      ),
#      farItems = list(
#        CommandBarItem("Grid view", "Tiles", iconOnly = TRUE),
#        CommandBarItem("Info", "Info", iconOnly = TRUE)
#      ),
#      style = list(width = "100%")))

## ----navigation, eval=FALSE---------------------------------------------------
#  navigation <- Nav(
#    groups = list(
#      list(links = list(
#        list(name = 'Home', url = '#!/', key = 'home', icon = 'Home'),
#        list(name = 'Analysis', url = '#!/other', key = 'analysis', icon = 'AnalyticsReport'),
#        list(name = 'shiny.fluent', url = 'http://github.com/Appsilon/shiny.fluent', key = 'repo', icon = 'GitGraph'),
#        list(name = 'shiny.react', url = 'http://github.com/Appsilon/shiny.react', key = 'shinyreact', icon = 'GitGraph'),
#        list(name = 'Appsilon', url = 'http://appsilon.com', key = 'appsilon', icon = 'WebAppBuilderFragment')
#      ))
#    ),
#    initialSelectedKey = 'home',
#    styles = list(
#      root = list(
#        height = '100%',
#        boxSizing = 'border-box',
#        overflowY = 'auto'
#      )
#    )
#  )

## ----footer, eval=FALSE-------------------------------------------------------
#  footer <- Stack(
#    horizontal = TRUE,
#    horizontalAlign = 'space-between',
#    tokens = list(childrenGap = 20),
#    Text(variant = "medium", "Built with ❤ by Appsilon", block=TRUE),
#    Text(variant = "medium", nowrap = FALSE, "If you'd like to learn more, reach out to us at hello@appsilon.com"),
#    Text(variant = "medium", nowrap = FALSE, "All rights reserved.")
#  )
#  
#  
#  layout <- function(mainUI){
#    div(class = "grid-container",
#        div(class = "header", header),
#        div(class = "sidenav", navigation),
#        div(class = "main", mainUI),
#        div(class = "footer", footer)
#    )
#  }
#  
#  # ---
#  ui <- fluentPage(
#    layout(analysis_page),
#    tags$head(
#      tags$link(href = "style.css", rel = "stylesheet", type = "text/css")
#    ))

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part2-step3.png")

## ----home-page, eval=FALSE----------------------------------------------------
#  card1 <- makeCard(
#    "Welcome to shiny.fluent demo!",
#    div(
#      Text("shiny.fluent is a package that allows you to build Shiny apps using Microsoft's Fluent UI."),
#      Text("Use the menu on the left to explore live demos of all available components.")
#    ))
#  
#  card2 <- makeCard(
#    "shiny.react makes it easy to use React libraries in Shiny apps.",
#    div(
#      Text("To make a React library convenient to use from Shiny, we need to write an R package that wraps it - for example, a shiny.fluent package for Microsoft's Fluent UI, or shiny.blueprint for Palantir's Blueprint.js."),
#      Text("Communication and other issues in integrating Shiny and React are solved and standardized in shiny.react package."),
#      Text("shiny.react strives to do as much as possible automatically, but there's no free lunch here, so in all cases except trivial ones you'll need to do some amount of manual work. The more work you put into a wrapper package, the less work your users will have to do while using it.")
#    ))
#  
#  home_page <- makePage(
#    "This is a Fluent UI app built in Shiny",
#    "shiny.react + Fluent UI = shiny.fluent",
#    div(card1, card2)
#  )

## ----router, eval=FALSE-------------------------------------------------------
#  router <- make_router(
#    route("/", home_page),
#    route("other", analysis_page))

## ----router-ui, eval=FALSE----------------------------------------------------
#  # Add shiny.router dependencies manually: they are not picked up because they're added in a non-standard way.
#  shiny::addResourcePath("shiny.router", system.file("www", package = "shiny.router"))
#  shiny_router_js_src <- file.path("shiny.router", "shiny.router.js")
#  shiny_router_script_tag <- shiny::tags$script(type = "text/javascript", src = shiny_router_js_src)
#  
#  
#  ui <- fluentPage(
#    layout(router$ui),
#    tags$head(
#      tags$link(href = "style.css", rel = "stylesheet", type = "text/css"),
#      shiny_router_script_tag
#    ))

## ----router-server, eval=FALSE------------------------------------------------
#    router$server(input, output, session)

