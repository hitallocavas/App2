library(shiny)
library(ggplot2)
library(plyr)
dados = read.csv(file = "dados.csv", header = FALSE, sep = ";" , dec = ".")
dataf = data.frame(dados)
shinyServer(function(input, output){
output$plots <- renderPlot(
  
  if(input$qtd == 1){
    Variavel_1 = rnorm(c(dados[,input$var1]))
    tabla = count(dados[,input$var1])
    valor = tabla$x
    frequencia = tabla$freq
    if(input$tgrafc == "Histograma"){
      ggplot() + aes(Variavel_1) + geom_histogram(binwidth=1, colour="red", fill="black", show.legend = TRUE)
    }
    
    else{
      ggplot() + aes(valor,frequencia) + geom_bar(stat="identity", fill = "blue", na.rm = TRUE, show.legend = TRUE)
    }
  }
  else{
    Valorx = c(dados[,input$varx])
    ValorY = c(dados[, input$vary])
    Distribuicao = c(rnorm(Valorx), rnorm(ValorY))
    if(input$tgrafc1 == "Histograma"){
      ggplot() + aes(Distribuicao) + geom_histogram(binwidth=1 , colour="red", fill="grey")
    }
    
    else{
      ggplot() + aes(Valorx, ValorY) + geom_bar(stat="identity" ,fill = "blue")
    }
  }
  
)

output$tabela = renderDataTable({dataf}, options = list(
  pageLength = 5, autoWidth = FALSE, escape =  TRUE, scrollX = TRUE 
))

output$sumario = renderPrint(
  if(input$qtd == 1){
    summary(object = c(dados[,input$var1]))
  }
  
  else{
    VariavelX = c(dados[,input$varx])
    VariavelY = c(dados[,input$vary])
    
    tabela = data.frame(VariavelX, VariavelY)
    summary(tabela)
  }
  
)
  
})