##########################
#                        #
#     Predictions        #
#                        #
##########################

# The following section describes some of the prediction methods available in H2O.

# 1. Predict: Generate outcomes of a dataset with any model. Predict with GLM, GBM, Decision Trees or Deep Learning models.
# 2. Confusion Matrix: Visualize the performance of an algorithm in a table to understand how a model performs.
# 3. Area Under Curve (AUC): A graphical plot to visualize the performance of a model by its sensitivity,
#    true positives and false positives to select the best model.
# 4. Hit Ratio: A classiﬁcation matrix to visualize the ratio of the number of correctly classiﬁed and incorrectly classiﬁed cases.
# 5. PCA Score: Determine how well your feature selection ﬁts a particular model.
# 6. Multi-Model Scoring: Compare and contrast multiple models on a dataset to ﬁnd the best performer to deploy into production.


# Models have been trained on script 03_trainind_models.R

## Predict 
?h2o.predict

prostate.fit = h2o.predict(object = prostate.glm, newdata = prostate.hex)
prostate.fit





