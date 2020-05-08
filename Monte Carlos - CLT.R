# Central Limit Theorem: 
#the frequency distribution of sample means from any population 
# will be normally distributed around u, the population mean
population <- rt(1:100, df = 4)
h_tdist <- hist(population, main="T-Distribution compared to Normal Distribution")
xfit<-seq(min(population),max(population),length=40)
yfit<-dnorm(xfit,mean=mean(population),sd=sd(population))
yfit <- yfit*diff(h_tdist$mids[1:2])*length(population)
lines(xfit, yfit, col="blue", lwd=2)
# essentially, CLT says a histogram of averages from the population represented by bars will follow the shape
# of the blue line asymptotically

set.seed(12345)
#Theoretical Prediction: 
# frequency distribution of x_bar_i from a 
# t distribution of 4 degrees of freedom with n = 100
# will follow normal distribution around mean of 0 (for t distribution with df > 1)

#Monte Carlo
# create population distribution
population <- rt(1:100, df = 4)
hist(population)

x_bar_i <- c()
# Sample and compute x_bar_i; store; repeat 100 times and check
x_bar_i <- replicate(100, append(x_bar_i,mean(as.matrix(sample(population,10)))))
  
# Compare frequency dist of x_bar_i to normal curve after 100 samples
h_partialmc <-hist(x_bar_i, breaks=20
        , col="red", xlab="sample mean"
        , main="100 MCs Sample Means compared to Normal Curve")
xfit<-seq(min(x_bar_i),max(x_bar_i),length=40)
yfit<-dnorm(xfit,mean=mean(x_bar_i),sd=sd(x_bar_i))
yfit <- yfit*diff(h_partialmc$mids[1:2])*length(x_bar_i)
lines(xfit, yfit, col="blue", lwd=2)
#getting warmer

#Run an additional 9900 simulations
x_bar_i <- replicate(9900, append(x_bar_i,mean(as.matrix(sample(population,10)))))
# Compare frequency dist of x_bar_i to normal curve after 10,000 Monte Carlos
h_fullmc <- hist(x_bar_i, breaks=20
                 , col="red", xlab="sample mean"
                 , main="10,000 MCs Sample Means compared to Normal Curve")
xfit<-seq(min(x_bar_i),max(x_bar_i),length=40)
yfit<-dnorm(xfit,mean=mean(x_bar_i),sd=sd(x_bar_i))
yfit <- yfit*diff(h_fullmc$mids[1:2])*length(x_bar_i)
lines(xfit, yfit, col="blue", lwd=2)


