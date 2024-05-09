

######## hil =-1

# Define a function to fit a 3PL curve to data with specified parameters
fit_3pl_curve_hill <- function(x, y) {
  # Define the 3PL model equation with specified parameters
  model <- function(x, top, bot, logEC50) {
    bot + (top - bot) / (1 + 10^((logEC50 - x)*(-1) ))
  }
  
  # Fit the model to the data using nls() function
  fit <- nls(y ~ model(x, top, bot, logEC50), start = list(top = max(y), bot = min(y), logEC50 = median(x)))
  
  return(fit)
}

# Example usage:
# Generate example data
set.seed(123)
x <- seq(0, 10, by = 0.5)
y <- 10 + (90 - 10) / (1 + 10^((5 - x) *(-1))) + rnorm(length(x), 0, 5)

# Fit 3PL curve to the data
fit <- fit_3pl_curve_hill(x, y)

# Print the summary of the fit
summary(fit)

# Plot the data and fitted curve
plot(x, y, pch = 16, col = "blue", xlab = "x", ylab = "y", main = "3PL Curve Fitting")
curve(predict(fit, newdata = data.frame(x)), add = TRUE, col = "red", lwd = 2)
# legend("topleft", legend = "Fitted Curve", col = "red", lty = 1, lwd = 2)

x=as.numeric(5.044)
predict(fit, newdata = as.data.frame(x))
