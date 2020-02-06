# Import prostate data
prosPath <- system.file("extdata", "prostate.csv", package="h2o")
prostate.hex <- h2o.importFile(path = prosPath)

# Finding factors
h2o.anyFactor(prostate.hex)

# Converting to factors
# Converts column 4 (RACE) to an enum
as.factor(prostate.hex[,4])
prostate.hex[,4] <- as.factor(prostate.hex[,4])

# Summary will return a count of the factors
summary(prostate.hex[,4])

# Converts current data frame (prostate data set) to an R data frame
prostate.R <- as.data.frame(prostate.hex)

# Displays a summary of data frame where the summary was executed in R
summary(prostate.R) 


# Converts R object "iris" into H2O object "iris.hex"
iris.hex = as.h2o(iris, destination_frame= "iris.hex")
head(iris.hex)


## Assign a new name to prostate dataset in the KV store
h2o.ls()

prostate.hex <- h2o.assign(data = prostate.hex, key = "myNewName")
h2o.ls()

##Displays the titles of the columns
colnames(iris.hex)
names(iris.hex)


## Get minimum and maximum values
min(prostate.hex$AGE)

max(prostate.hex$AGE)


# Getting qunatiles
prostate.qs <- quantile(prostate.hex$PSA, probs = (1:10)/10)
prostate.qs

# Take the outliers or the bottom and top 10% of data
PSA.outliers <- prostate.hex[prostate.hex$PSA <= prostate.qs["10%"] | prostate.hex$PSA >= prostate.qs["90%"],]

# Check that the number of rows return is about 20% of the original data
nrow(prostate.hex)
nrow(PSA.outliers)

nrow(PSA.outliers)/nrow(prostate.hex)


## Summarizing data
summary(prostate.hex)


## summarizing data in a table

# Counts of the ages of all patients
head(as.data.frame(h2o.table(prostate.hex[,"AGE"])))

# Two-way table of ages (rows) and race (cols) of all patients
table <- h2o.table(prostate.hex[,c("AGE","RACE")])
as.data.frame(table)



# Creates object for uniform distribution on prostate data set
s <- h2o.runif(prostate.hex)
summary(s)


## Create training set with threshold of 0.8
prostate.train <- prostate.hex[s <= 0.8,]

##Assign name to training set
prostate.train <- h2o.assign(prostate.train, "prostate.train")

## Create test set with threshold to filter values greater than 0.8
prostate.test <- prostate.hex[s > 0.8,]

## Assign name to test set
prostate.test <- h2o.assign(prostate.test, "prostate.test")

## Combine results of test & training sets, then display result
nrow(prostate.hex) 
nrow(prostate.train) + nrow(prostate.test) # Matches the full set


## Splitting frames (for train_test split)

# Splits data in prostate data frame with a ratio of
prostate.split <- h2o.splitFrame(data = prostate.hex, ratios = 0.75)

# Creates training set from 1st data set in split
prostate.train <- prostate.split[[1]]

# Creates testing set from 2st data set in split
prostate.test <- prostate.split[[2]]


## Getting Frames
# To create a reference object to the data frame in H2O, use h2o.getFrame().
# This is helpful for switching between the web UI and the R API or for multiple users accessing the same H2O instance. The following
# example assumes prostate.hex is in the key-value (KV) store.

prostate.hex <- h2o.getFrame(id = "prostate.hex")


## Listing H2O Objects
h2o.ls()

## Removing H2O Objects
h2o.rm(c("prostate.train","prostate.test"))


# Getting Models
# To create a reference object for the model in H2O, use h2o.getModel().
# This is helpful for users that alternate between the web UI and the R API or
# multiple users accessing the same H2O instance.
gbm.model <- h2o.getModel(model_id = "GBM_8e4591a9b413407b983d73fbd9eb44cf")



# Adding Functions

# Create an R functional expression
simpleFun <- function(x) { 2*x + 5 }

# Evaluate the expression across prostate’s AGE column
calculated <- simpleFun(prostate.hex[,"AGE"])
h2o.cbind(prostate.hex[,"AGE"], calculated)

