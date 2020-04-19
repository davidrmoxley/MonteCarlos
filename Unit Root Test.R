
#Demonstrate Unit Root test through Monte Carlo Simulation
#Theoretical Prediction: H0: ????0 = 0, a1 = 1 & series has unit root;
#if the t statistic is less than -2.89, 
#you will correctly reject the NULL Hypothesis of unit root, 
#95% of the time (incorrectly 5% of the time).

c <- 0 #results counter of t-statistics greater than -2.89

simulations <- 10000
while(simulations > 0){
  # Generate a vector of 100 error terms, et ~ N(0,1)
  e <- rnorm(101,0,1)
  df <- as.data.frame(e)
  df$T <- c(0:100)

  # Generate yt = a1yt-1 + et, a1 = 1
  df$yt <- 0
  for(i in 2:nrow(df)){df$yt[i] = df$yt[i-1] + df$e[i]}

  # Estimate AR model, ??y = a0 + ????0yt-1 + et
  df$ytm1[2:101] <- df$yt[1:100]
  df$y_delta <- df$yt - df$ytm1
  model_est <- lm(df$y_delta ~ df$ytm1, data=df[2:101,])

  # Calculate t-statistic, t = ????/se(????),If < -2.89, increment counter, c
  if(summary(model_est)[["coefficients"]][2,1] / summary(model_est)[["coefficients"]][2,2] < -2.89){c <- c + 1}

  simulations <- simulations -1 #increment to next simulation
}

#Compare c/10,000 to theoretical prediction of 5%
c/10000



