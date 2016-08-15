library(shiny)
library(shinydashboard)

dados = read.csv(file = "dados.csv", header = FALSE, sep = ";" , dec = ".")

dashboardPage(
  
  dashboardHeader(title = "PRO-SPB"),
  dashboardSidebar(
    
  
    radioButtons("qtd", "Quantidade de Variaveis", c(1,2), 1),
    
    conditionalPanel("input.qtd == 1",
                         selectInput("var1", "Variavel x:", colnames(dados)),
                         selectInput("tgrafc", "Tipo de Grafico", c("Histograma", "Barras"), selected = "Histograma"
                                                 )
        ),
    
    conditionalPanel("input.qtd == 2",
                         selectInput("varx", "Variavel x:", colnames(dados)),
                         selectInput("vary", "Variavel y:", colnames(dados)),
                         selectInput("tgrafc1", "Tipo de Grafico", c("Histograma", "Barras"), selected = "Barras"
                                                 
                                     ))
                
     
    
    
  ),
  
  dashboardBody(
    navbarPage("Visualizacao dos Dados",
               tabPanel("Grafico", icon = icon("bar-chart-o"), plotOutput("plots")),
               tabPanel("Sumario",icon = icon("list-alt"), verbatimTextOutput("sumario") ),
               tabPanel("Tabela", icon = icon("table"),dataTableOutput("tabela"))
    
    
)))
  

