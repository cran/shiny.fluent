library(shiny.fluent)

if (interactive()) {
  shinyApp(
    ui = reactOutput("focusTrapZone"),
    server = function(input, output) {
      output$focusTrapZone <- renderReact({
        useTrapZone <- isTRUE(input$useTrapZone)
        stackStyles <- list(root = list(
          border = if (useTrapZone) '2px solid #ababab' else 'transparent',
          padding = 10
        ))
        textFieldStyles <- list(root = list(width = 300));
        stackTokens = list(childrenGap = 8);

        div(
          FocusTrapZone(
            disabled = !useTrapZone,
            Stack(
              horizontalAlign = "start",
              tokens = stackTokens,
              styles = stackStyles,
              Toggle.shinyInput("useTrapZone",
                value = FALSE,
                label = "Use trap zone",
                onText = "On (toggle to exit)",
                offText = "Off (toggle to trap focus)"
              ),
              TextField.shinyInput(
                "textInput",
                label = "Input inside trap zone",
                styles = textFieldStyles
              ),
              Link(
                href = "https://bing.com",
                target = "_blank",
                "Hyperlink inside trap zone"
              )
            )
          ),
          Link(
            href = "https://bing.com",
            target = "_blank",
            "Hyperlink outside trap zone"
          )
        )
      })
    }
  )
}
