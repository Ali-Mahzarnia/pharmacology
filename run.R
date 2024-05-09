data = readxl::read_xlsx("Test.xlsx")

df = data[4:12,1:10]
df2= df[2:dim(df)[1], -c(4,7,10)]
#df2 = lapply(df2, function(x) as.numeric(as.character(x)))
df3 = matrix(NA, dim(df2)[1] * (dim(df2)[2]-1) )

df3 = matrix(NA,1,2) 
colnames(df3) = c("dose", "response")
for (j in 2:dim(df2)[2]) {
  temp = cbind( df2[,1], df2[,j])
  colnames(temp) = c("dose", "response")
  df3 = rbind(df3,temp )
}

df3 = df3[2:dim(df3)[1],]
df3[,2]  = as.numeric(df3[,2] )
response_norm = 100 * ( df3[,2]  - min(df3[,2]) ) / (max(df3[,2])  - min(df3[,2]) )

x= log10(as.numeric(df3[,1]))
y=response_norm
b = fit_3pl_curve_hill(x, y)

bb = summary(b)
bb$coefficients
####

# Plot the data and fitted curve
plot(x, y, pch = 16, col = "blue", xlab = "x", ylab = "y", main = "3PL Curve Fitting")
curve(predict(b, newdata = as.data.frame(x)), add = TRUE, col = "red", lwd = 2)



# example of prediction

ki_new = log10(10^(-7.12)  / (1+ L / kd))
x=as.numeric(ki_new)
predict(b, as.data.frame(x))

