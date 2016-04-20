library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  headerPanel("Central Limit Theorem"),
  sidebarPanel(
    sliderInput('nsim', 'Number of Simulations', 100, min = 100, max = 1000, step = 100),
    sliderInput('lambda', 'Lambda = ', 0.1, min = 0.1, max = 0.5, step = 0.1)
  ),
  mainPanel(
    h2("Illustrating central limit theorem"),
    p("In this app, we use simulate random data samples with the exponential distribution
      and compute the sample means. The sample means are then shown to be normally 
      distribution via central limit theorem."),
    br(),
    p("The probabilty distribution function of the exaponential distribution function
      is given by:"),
    img(src="exp.png", height = 25, width = 125),
    p("The mean and standard deviations are equal:"),
    img(src="musig.png", height = 20, width = 115),
    p("By central limit thorem, the sample means should be normally distributed:"),
    img(src="z.png", height = 60, width = 125),
    p("Below, by changing the number of simulations, and
      the parameter lambda of exponential distribution, you can visualize the 
      central limit theorem. We simulate on 50 data points."),
    br(),
    h4('Number of simulations:'),
    verbatimTextOutput('oid1'),
    h4('Lambda = '),
    verbatimTextOutput('oid2'),
    plotOutput('plt1'),
    plotOutput('plt2')
  )
))