##########################
#                        #
#     Running models     #
#                        #
##########################

# 1. Gradient Boosting Machine (GBM)
# 2. Generalized Linear Models (GLM)
# 3. K-means
# 4. Principal Components Analysis (PCA)

library(h2o)
h2o.init(nthreads = -1)
data(iris)
iris.hex <- as.h2o(iris,destination_frame = "iris.hex")


## 1. Gradient Boosting Machine (GBM)
help(h2o.gbm)

iris.gbm <- h2o.gbm(y = 1, x = 2:5, training_frame = iris.hex, ntrees = 10,
                    max_depth = 3, min_rows = 2, learn_rate = 0.2,
                    distribution= "gaussian")


# To obtain the Mean-squared Error by tree from the model object:
iris.gbm@model$scoring_history

# To generate a classiﬁcation model that uses labels, use distribution="multinomial":
iris.gbm2 <- h2o.gbm(y = 5, x = 1:4, training_frame
                       = iris.hex, ntrees = 15, max_depth = 5, min_rows =
                         2, learn_rate = 0.01, distribution= "multinomial")

iris.gbm2@model$training_metrics


## 2. Generalized Linear Models (GLM)
help(h2o.glm)

prostate.hex <- h2o.importFile(path = "https://raw.github.com/h2oai/h2o/master/smalldata/logreg/prostate.csv" , destination_frame = "prostate.hex")

prostate.glm <- h2o.glm(y = "CAPSULE", x = c("AGE","RACE","PSA","DCAPS"), training_frame = prostate.hex,
                      family = "binomial", nfolds = 10, alpha =0.5)

prostate.glm@model$cross_validation_metrics


## 3. K-means
help(h2o.kmeans)

iris.kmeans <- h2o.kmeans(training_frame = iris.hex, k = 3, x =1:4)

iris.kmeans@model$model_summary


## 4. Principal Components Analysis (PCA)
help(h2o.prcomp)

ausPath = system.file("extdata", "australia.csv", package="h2o")
australia.hex = h2o.importFile(path = ausPath)

australia.pca <- h2o.prcomp(training_frame = australia.hex, transform = "STANDARDIZE",k = 3)
australia.pca



