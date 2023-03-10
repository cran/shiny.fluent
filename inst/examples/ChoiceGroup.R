library(shiny.fluent)

if (interactive()) {
  options <- list(
    list(key = "A", text = "Option A"),
    list(key = "B", text = "Option B"),
    list(key = "C", text = "Option C")
  )

  shinyApp(
    ui = div(
      ChoiceGroup.shinyInput("choice", value = "B", options = options),
      textOutput("groupValue")
    ),
    server = function(input, output) {
      output$groupValue <- renderText({
        sprintf("Value: %s", input$choice)
      })
    }
  )
}
