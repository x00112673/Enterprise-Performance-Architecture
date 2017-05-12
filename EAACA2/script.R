#EAA CA2
#James O'Reilly
#X00112673

# reads results.dat file into results variable including the header provided
results = read.table("results.dat", header = TRUE)

# creates N variable and populates it with
# data from the column N in results.dat file
N = results$N

# creates T variable to 10 seconds
# the amount of time each loadtest was active
T = 10 

# creates Co variable and populates it with
# data from the column CN in results.dat file
# the number of completed transactions CN 
Co = results$CN

# creates Xo variable and initializes it to equal
# completed transactions divided by time in seconds
Xo = Co / T

# this is a function to calculate Ui
# to calculate this 
# I subtracted 100 from every idle value to retrieve Bi
# I then divided the busy time (Bi) by T to calculate Ui
Ui <- function(){
  busy = 100 - results$IDLE
  ui = busy / T
}

# To plot this graph I used the plot function in R
# using main to name the graph and xlab/ylab to name
# the axis accordingly, choosing N for the x-axis 
# because this is the independent variable
plot(N, Ui(), main="Ui VS N",
     xlab="Number of Users (N)", ylab="Utilization (Ui)")

# I used the abline & lines functions to calculate the following lines
# with lm calling the regression line
# and lowess calling the lowess line
abline(lm(Ui()~N), col="red") # regression line (y~x) 
lines(lowess(N, Ui()), col="blue") # lowess line (x,y) 


# using the summary function I was able to print out
# stats for Ui() such as min, max, median, mean, 1st 
# and 3rd quartiles 
print("Summary statistics for Utilization (Ui):")
print(summary(Ui()))

Di = Ui() / Xo

# To plot this graph I used the plot function in R
# using main to name the graph and xlab/ylab to name
# the axis accordingly, choosing N for the x-axis 
# because this is the independent variable
plot(N, Di, main="Di VS N",
     xlab="Number of Users (N)", ylab="Service Demand (Di)")
abline(lm(Di~N), col="red") # regression line (y~x) 
lines(lowess(N, Di), col="blue") # lowess line (x,y) 


# using the summary function I was able to print out
# stats for Ui() such as min, max, median, mean, 1st 
# and 3rd quartiles 
print("Summary statistics for Service Demand (Di):")
print(summary(Di))


# To plot this graph I used the plot function in R
# using main to name the graph and xlab/ylab to name
# the axis accordingly, choosing N for the x-axis 
# because this is the independent variable
plot(N, Xo, main="Xo VS N",
     xlab="Number of Users (N)", ylab="Throughput (Xo)(tps)")

abline(lm(Xo~N), col="red") # regression line (y~x) 
lines(lowess(N, Xo), col="blue") # lowess line (x,y) 


# using the summary function I was able to print out
# stats for Ui() such as min, max, median, mean, 1st 
# and 3rd quartiles 
print("Summary statistics for Throughtput (Xo):")
print(summary(Xo))

R = N / Xo

# To plot this graph I used the plot function in R
# using main to name the graph and xlab/ylab to name
# the axis accordingly, choosing N for the x-axis 
# because this is the independent variable
RvsN <- plot(N, R, main="R VS N",
     xlab="Number of Users (N)", ylab="Interactive Response Time (R)(sec)", stat="summary")


abline(lm(R~N), col="red") # regression line (y~x) 
lines(lowess(N, R), col="blue") # lowess line (x,y) 


# using the summary function I was able to print out
# stats for Ui() such as min, max, median, mean, 1st 
# and 3rd quartiles 
print("Summary statistics for Interactive Response Time (R):")
print(summary(R))