# Manual
# 3PL Curve Fitting Function (R) 

## Overview:
The 3PL Curve Fitting function in R (3par_log_fitting.R) provides a tool for estimating parameters for the three-parameter logistic (3PL) curve model in R. The package utilizes Nonlinear Least Squares (nls()) function to fit the curve to data, enabling users to analyze dose-response relationships commonly encountered in scientific research.

## Installation:
To install the package, you can simply clone the repository or download and run the source file . Ensure that R is installed on your system.

## Usage:
The main function fit_3pl_curve_hill() fits a 3PL curve to given data using Nonlinear Least Squares regression. Below is a guide on how to use this function:
```R
fit_3pl_curve_hill(x, y)
```
where 
* x: A vector containing the logarithm (base 10) of doses.
* y: A vector containing the response values corresponding to each dose.

## Output:
The function returns an object of class "nls" representing the fitted model that can be used for prediction or visualziation. In addition in R console it will be printed if hill slope is take 1 or -1 while running the function.

# Example:
Here's an example demonstrating how to use the package with sample data:
```R
# Generate example data
set.seed(123)
x <- seq(0, 10, by = 0.5)
y <- 10 + (90 - 10) / (1 + 10^((5 - x) * (-1))) + rnorm(length(x), 0, 5) # here in population we considered hill =-1

# Fit 3PL curve to the data
fit <- fit_3pl_curve_hill(x, y)

# Print the summary of the fit
summary(fit)

# Plot the data and fitted curve
plot(x, y, pch = 16, col = "blue", xlab = "x", ylab = "y", main = "3PL Curve Fitting")
curve(predict(fit, newdata = data.frame(x)), add = TRUE, col = "red", lwd = 2)

```

![Fitted curve hill =-1](https://github.com/Ali-Mahzarnia/pharmacology/blob/main/Rplot01.png)

The follwoning example has hill slope =1 instead of -1.
```



set.seed(123)
y <- 10 + (90 - 10) / (1 + 10^((5 - x) * (1))) + rnorm(length(x), 0, 5) # here in population we considered hill =1

# Fit 3PL curve to the data
fit <- fit_3pl_curve_hill(x, y)

# Print the summary of the fit
summary(fit)

# Plot the data and fitted curve
plot(x, y, pch = 16, col = "blue", xlab = "x", ylab = "y", main = "3PL Curve Fitting")
curve(predict(fit, newdata = data.frame(x)), add = TRUE, col = "red", lwd = 2)


```
![Fitted curve hill =1](https://github.com/Ali-Mahzarnia/pharmacology/blob/main/Rplot02.png)

## Prediction
To predict response values for new doses, use the predict() function:

```R
x=as.numeric(5.044)
predict(fit, newdata = as.data.frame(x))
```
