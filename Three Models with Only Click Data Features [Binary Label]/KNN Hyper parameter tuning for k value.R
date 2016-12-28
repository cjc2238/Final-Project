library(ElemStatLearn)
require(class)
library(ggplot2)
library(kernlab)
library(rpart)
library(ROCR)
library(caret)
library(pROC)
setwd("~/GitHub/Final-Project/Three Models with Only Click Data Features [Binary Label]")

df1 <- read.csv("AAA_Data_Binary_Label.csv")
df1$binary_label <- as.character(df1$binary_label)
df1$binary_label[df1$binary_label == " Monitor"] <- "monitor"
df1$binary_label[df1$binary_label == "Don't Monitor"] <- "ignore"
df1$binary_label <- as.factor(df1$binary_label)

df1 <- df1[,-c(1,2,3,13)]
gp <- runif(nrow(df1))
df1 <- df1[order(gp),]

trainIndex <- createDataPartition(df1$binary_label,p=.75,list=FALSE)
trainData <- df1[trainIndex,]
testData  <- df1[-trainIndex,]
trainX <-trainData[,-10]        # Pull out the variables for training
sapply(trainX,summary)           # Look at a summary of the training data

ctrl <- trainControl(method="repeatedcv",repeats = 3)

knnFit <- train(x=trainX,
      y= trainData$binary_label,
      method = "knn",   
      tuneLength = 20,					
      preProc = c("center","scale"),
      trControl=ctrl)

#Output of kNN fit
knnFit

plot(knnFit)
