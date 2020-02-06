##############################
#                            #
#     Appendix: Commands     #
#                            #
##############################

# The following section lists some common R commands by function and a brief description of each command.

## Dataset Operations

# Data Import/Export

# Download a H2O dataset to a CSV ﬁle on local disk.
h2o.downloadCSV

# Export H2O Data Frame to a ﬁle.
h2o.exportFile

# Import a ﬁle from the local path and parse it.
h2o.importFile

#  Parse a raw data ﬁle.
h2o.parseRaw

# Upload a ﬁle from the local drive and parse it.
h2o.uploadFile

## Native R to H2O Coercion

# Convert an R object to an H2O object.
as.h2o

## H2O to Native R Coercion

# Check if an object is a data frame, or coerce it if possible.
as.data.frame


## Data Generation

# Create an H2O data frame, with optional randomization.
h2o.createFrame

# Produce a vector of random uniform numbers.
h2o.runif

# Create interaction terms between categorical features of an H2O Frame.
h2o.interaction


## Data Sampling/Splitting

#  Split an existing H2O dataset according to user-speciﬁed ratios.
h2o.splitFrame

## Missing Data Handling

#  Impute a column of data using the mean, median, or mode.
h2o.impute
h2o.insertMissingValues: Replaces a user-speciﬁed fraction of entries
in a H2O dataset with missing values.