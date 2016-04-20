library(shiny)
library(ggplot2)

# Simulation of "n" data points, "nsim" times
# lam is the parameter in the exponential distribution
sim.results <- function(n,nsim,lam){
  set.seed(1)
  means <- NULL
  vars <- NULL
  for (i in 1:nsim){
    rand <- rexp(n,lam)
    means <- c(means,mean(rand))
    vars <- c(vars,var(rand))
  }
  df <- data.frame(mu=means,vr=vars, y=1:n); df
}

shinyServer(
  function(input, output) {
    output$oid1 = renderPrint({input$nsim})
    output$oid2 = renderPrint({input$lambda})
    output$plt1 = renderPlot({
      df <- sim.results(50, input$nsim, input$lambda)
      lam <- input$lambda
      n <- 50
      #
      g <- ggplot(df,aes(mu)) + geom_histogram(aes(y=..density..),
                                               color="black",fill="white",
                                               binwidth = 0.4)
      g <- g + geom_vline(aes(xintercept=1/lam),color="red",linetype="dashed")
      g <- g + ggtitle("Sample (bars) & Theoretical mean (1/lambda) (red line)")
      print(g)
    })
    output$plt2 = renderPlot({
      df <- sim.results(50, input$nsim, input$lambda)
      lam <- input$lambda
      n <- 50
      means <- df$mu
      z <- (means-1/lam) / (1/lam/sqrt(n))
      df2 <- data.frame(mu=z,y=1:n)
      g2 <- ggplot(df2,aes(z)) + geom_histogram(aes(y=..density..),
                                                color="black",fill="white",binwidth=0.5)
      g2 <- g2 + stat_function(fun=dnorm,color="red")
      g2 <- g2 + ggtitle("Distribution of n means & Normal Distribution(red)")
      print(g2)
    })
  }
)