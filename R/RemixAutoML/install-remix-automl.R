##############################
#                            #
#  Install Remyx package     #
#                            #
##############################



## LINUX ##
library(devtools)

# 1. First install catboost
devtools::install_url('https://github.com/catboost/catboost/releases/download/v0.20.2/catboost-R-Linux-0.20.2.tgz',
                      INSTALL_opts = c("--no-multiarch"))

# 2. Install dependencies
to_install <- c("arules", 
                "catboost",
                "caTools",
                "data.table",
                "doParallel", 
                "foreach", 
                "forecast", 
                "ggplot2", 
                "h2o", 
                "itertools", 
                "lubridate", 
                "monreg", 
                "pROC", 
                "RColorBrewer", 
                "recommenderlab", 
                "ROCR", 
                "scatterplot3d", 
                "stringr", 
                "tm", 
                "tsoutliers", 
                "wordcloud", 
                "xgboost",
                "zoo",
                "ML_metrics",
                "nortest")


for (i in to_install) {
  message(paste("looking for ", i))
  if(i == "catboost" & !requireNamespace(i)) {
    devtools::install_github('catboost/catboost', subdir = 'catboost/R-package')
  } else if(i == "h2o" & !requireNamespace(i)) {
    if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
    if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }
    pkgs <- c("RCurl","jsonlite")
    for (pkg in pkgs) {
      if (! (pkg %in% rownames(installed.packages()))) { install.packages(pkg) }
    }
    install.packages("h2o", type="source", 
                     repos="https://h2o-release.s3.amazonaws.com/h2o/rel-yates/3/R")
  } else if (!requireNamespace(i)) {
    message(paste("     installing", i))
    install.packages(i)
  }
}

# 3.  Run to install RemixAutoML
devtools::install_github('AdrianAntico/RemixAutoML', 
                         upgrade = F, 
                         dependencies = F, 
                         force = TRUE)  

library(RemixAutoML)  

?`RemixAutoML-package`
