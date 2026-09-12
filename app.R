library(shiny)

ui <- fluidPage(
  titlePanel("Calculadora"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("num1", "Digite o primeiro número:", value = 0),
      numericInput("num2", "Digite o segundo número:", value = 0),
      
      selectInput("operador", "Escolha a operação:",
                  choices = c("Adição (+)" = "+",
                              "Subtração (-)" = "-",
                              "Multiplicação (*)" = "*",
                              "Divisão (/)" = "/")),
      
      actionButton("calcular", "Calcular", class = "btn-primary")
    ),
    
    mainPanel(
      h3("Resultado:"),
      verbatimTextOutput("resultado")
    )
  )
)

server <- function(input, output, session) {
  
  resultadoCalculo <- eventReactive(input$calcular, {
    n1 <- input$num1
    n2 <- input$num2
    op <- input$operador
    
    res <- switch(op,
                  "+" = n1 + n2,
                  "-" = n1 - n2,
                  "*" = n1 * n2,
                  "/" = {
                    if (n2 == 0) {
                      "Erro: Divisão por zero não permitida!"
                    } else {
                      n1 / n2
                    }
                  }
    )
    return(res)
  })
  
  output$resultado <- renderText({
    resultadoCalculo()
  })
}

shinyApp(ui = ui, server = server)