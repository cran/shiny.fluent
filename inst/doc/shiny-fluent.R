## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
library(shiny.fluent)
library(tidyverse)

## ---- include=FALSE, cache=FALSE----------------------------------------------
# HACK: running via do.call because otherwise read_chunk breaks pkgdown::build_site (see https://github.com/r-lib/pkgdown/issues/1159)
do.call(knitr::read_chunk, list(path = "../inst/examples/tutorial/01_hello_world.R"))
do.call(knitr::read_chunk, list(path = "../inst/examples/tutorial/02_basic_app.R"))
do.call(knitr::read_chunk, list(path = "../inst/examples/tutorial/03_adding_filtering.R"))
do.call(knitr::read_chunk, list(path = "../inst/examples/tutorial/04_more_filters.R"))
do.call(knitr::read_chunk, list(path = "../inst/examples/tutorial/05_more_outputs.R"))

## ----helloworld-dependencies, eval=FALSE--------------------------------------
#  library(shiny)
#  library(shiny.fluent)

## ----helloworld, eval=FALSE---------------------------------------------------
#  ui <- fluentPage(
#    Text(variant = "xxLarge", "Hello world!")
#  )
#  
#  server <- function(input, output, session) {}
#  
#  shinyApp(ui, server)

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part1-step1.png")

## -----------------------------------------------------------------------------
fluentPeople %>% glimpse()

## -----------------------------------------------------------------------------
fluentSalesDeals %>% glimpse()

## ----details_list_columns, eval=FALSE-----------------------------------------
#  details_list_columns <- tibble(
#    fieldName = c("rep_name", "date", "deal_amount", "client_name", "city", "is_closed"),
#    name = c("Sales rep", "Close date", "Amount", "Client", "City", "Is closed?"),
#    key = fieldName)

## ----deals_table, eval=FALSE--------------------------------------------------
#  ui <- fluentPage(
#    uiOutput("analysis")
#  )
#  
#  server <- function(input, output, session) {
#    filtered_deals <- reactive({
#      filtered_deals <- fluentSalesDeals %>% filter(is_closed > 0)
#    })
#  
#    output$analysis <- renderUI({
#      items_list <- if(nrow(filtered_deals()) > 0){
#        DetailsList(items = filtered_deals(), columns = details_list_columns)
#      } else {
#        p("No matching transactions.")
#      }
#  
#      Stack(
#        tokens = list(childrenGap = 5),
#        Text(variant = "large", "Sales deals details", block = TRUE),
#        div(style="max-height: 500px; overflow: auto", items_list)
#      )
#    })
#  }
#  
#  shinyApp(ui, server)

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part1-step2.png")

## ----03_filters_ui, eval=FALSE------------------------------------------------
#  filters <- tagList(
#    DatePicker.shinyInput("fromDate", value = as.Date('2020/01/01'), label = "From date"),
#    DatePicker.shinyInput("toDate", value = as.Date('2020/12/31'), label = "To date")
#  )

## ----03_ui, eval=FALSE--------------------------------------------------------
#  ui <- fluentPage(
#    filters,
#    uiOutput("analysis")
#  )

## ----03_filters_server, eval=FALSE--------------------------------------------
#  server <- function(input, output, session) {
#    filtered_deals <- reactive({
#      req(input$fromDate)
#      filtered_deals <- fluentSalesDeals %>% filter(
#        date >= input$fromDate,
#        date <= input$toDate,
#        is_closed > 0
#      )
#    })

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part1-step3.png")

## ----04_filters_ui, eval=FALSE------------------------------------------------
#  filters <- Stack(
#    tokens = list(childrenGap = 10),
#    Stack(
#      horizontal = TRUE,
#      tokens = list(childrenGap = 10),
#      DatePicker.shinyInput("fromDate", value = as.Date('2020/01/01'), label = "From date"),
#      DatePicker.shinyInput("toDate", value = as.Date('2020/12/31'), label = "To date")
#    ),
#    Label("Filter by sales reps", className = "my_class"),
#    NormalPeoplePicker.shinyInput(
#      "selectedPeople",
#      class = "my_class",
#      options = fluentPeople,
#      pickerSuggestionsProps = list(
#        suggestionsHeaderText = 'Matching people',
#        mostRecentlyUsedHeaderText = 'Sales reps',
#        noResultsFoundText = 'No results found',
#        showRemoveButtons = TRUE
#      )
#    ),
#    Slider.shinyInput("slider",
#      value = 0, min = 0, max = 1000000, step = 100000,
#      label = "Minimum amount",
#      valueFormat = JS("function(x) { return '$' + x}"),
#      snapToStep = TRUE
#    ),
#    Toggle.shinyInput("closedOnly", value = TRUE, label = "Include closed deals only?")
#  )

## ----04_helpers, eval=FALSE---------------------------------------------------
#  makeCard <- function(title, content, size = 12, style = "") {
#    div(
#      class = glue("card ms-depth-8 ms-sm{size} ms-xl{size}"),
#      style = style,
#      Stack(
#        tokens = list(childrenGap = 5),
#        Text(variant = "large", title, block = TRUE),
#        content
#      )
#    )
#  }

## ----04_ui, eval=FALSE--------------------------------------------------------
#  ui <- fluentPage(
#    tags$style(".card { padding: 28px; margin-bottom: 28px; }"),
#    makeCard("Filters", filters, size = 4, style = "max-height: 320px;"),
#    uiOutput("analysis")
#  )

## ----04_filters_server, eval=FALSE--------------------------------------------
#  server <- function(input, output, session) {
#    filtered_deals <- reactive({
#      req(input$fromDate)
#      selectedPeople <- (
#        if (length(input$selectedPeople) > 0) input$selectedPeople
#        else fluentPeople$key
#      )
#      minClosedVal <- if (isTRUE(input$closedOnly)) 1 else 0
#  
#      filtered_deals <- fluentSalesDeals %>%
#        filter(
#          rep_id %in% selectedPeople,
#          date >= input$fromDate,
#          date <= input$toDate,
#          deal_amount >= input$slider,
#          is_closed >= minClosedVal
#        ) %>%
#        mutate(is_closed = ifelse(is_closed == 1, "Yes", "No"))
#    })

## ----04_table, eval=FALSE-----------------------------------------------------
#      makeCard("Top results", div(style="max-height: 500px; overflow: auto", items_list))

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part1-step4.png")

## ----05_ui, eval=FALSE--------------------------------------------------------
#  ui <- fluentPage(
#    tags$style(".card { padding: 28px; margin-bottom: 28px; }"),
#    Stack(
#      tokens = list(childrenGap = 10), horizontal = TRUE,
#      makeCard("Filters", filters, size = 4, style = "max-height: 320px"),
#      makeCard("Deals count", plotlyOutput("plot"), size = 8, style = "max-height: 320px")
#    ),
#    uiOutput("analysis")
#  )

## ----05_outputs, eval=FALSE---------------------------------------------------
#      Stack(
#        tokens = list(childrenGap = 10), horizontal = TRUE,
#        makeCard("Top results", div(style="max-height: 500px; overflow: auto", items_list)),
#        makeCard("Map", leafletOutput("map"))
#      )

## ----05_render, eval=FALSE----------------------------------------------------
#    output$map <- renderLeaflet({
#      points <- cbind(filtered_deals()$LONGITUDE, filtered_deals()$LATITUDE)
#      leaflet() %>%
#        addProviderTiles(providers$Stamen.TonerLite, options = providerTileOptions(noWrap = TRUE)) %>%
#        addMarkers(data = points)
#    })
#  
#    output$plot <- renderPlotly({
#      p <- ggplot(filtered_deals(), aes(x = rep_name)) +
#        geom_bar(fill = unique(filtered_deals()$color)) +
#        ylab("Number of deals") +
#        xlab("Sales rep") +
#        theme_light()
#      ggplotly(p, height = 300)
#    })

## ---- echo=FALSE--------------------------------------------------------------
knitr::include_graphics("images/tutorial-part1-step5.png")

