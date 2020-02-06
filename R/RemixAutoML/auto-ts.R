################################################
#                                              #
#  AutoTS - Automated time-series forecasting  #
#                                              #
################################################

# Link: https://www.r-bloggers.com/automate-your-kpi-forecasts-with-only-1-line-of-r-code-using-autots/



# Load packages ----
#   devtools::install_github('AdrianAntico/RemixAutoML', dependencies = T)
library(RemixAutoML)
library(data.table)
library(dplyr)
library(magrittr)
library(ggplot2)
library(scales)
library(magick)
library(grid)


# IMPORT DATA FROM REMIX INSTITUTE BOX ACCOUNT ----------

# link to manually download file: https://remixinstitute.app.box.com/v/walmart-store-sales-data/
# walmart_store_sales_data = data.table::fread("https://remixinstitute.box.com/shared/static/9kzyttje3kd7l41y1e14to0akwl9vuje.csv", header = T, stringsAsFactors = FALSE)

walmart_store_sales_data <- data.table::fread("walmart_train.csv")
head(walmart_store_sales_data)


# FIND TOP GROSSING STORE (USING dplyr) ---------------------

# group by Store, sum Weekly Sales
top_grossing_store = walmart_store_sales_data %>% dplyr::group_by(., Store) %>%
  dplyr::summarize(., Weekly_Sales = sum(Weekly_Sales, na.rm = TRUE))

top_grossing_store

# max Sales of 45 stores
max_sales = max(top_grossing_store$Weekly_Sales)

# find top grossing store
top_grossing_store = top_grossing_store %>% dplyr::filter(., Weekly_Sales == max_sales)
top_grossing_store = top_grossing_store$Store %>% as.numeric(.)

# what is the top grossing store?
print(paste("Store Number: ", top_grossing_store, sep = ""))


# FIND WEEKLY SALES DATA FOR TOP GROSSING STORE (USING data.table) ----------
top_store_weekly_sales <- walmart_store_sales_data[Store == eval(top_grossing_store), 
                                                   .(Weekly_Sales = sum(Weekly_Sales, na.rm = TRUE)), 
                                                   by = "Date"]


top_store_weekly_sales


# FORECAST WEEKLY SALES FOR WALMART STORE USING AutoTS ------

# forecast for the next 16 weeks - technically 1 line of code, but
# each argument was dedicated its own line for presentation purposes
weekly_forecast = RemixAutoML::AutoTS(
  data = top_store_weekly_sales,
  TargetName = "Weekly_Sales",
  DateName = "Date",
  FCPeriods = 16,
  HoldOutPeriods = 12,
  TimeUnit = "week"
)


head(weekly_forecast)


# VISUALIZE AutoTS FORECASTS ----------------

# view 16 week forecast
View(weekly_forecast$Forecast)

# View model evaluation metrics
View(weekly_forecast$EvaluationMetrics)

# which model won?
print(weekly_forecast$ChampionModel)

# see ggplot of forecasts
plot = weekly_forecast$TimeSeriesPlot

#change y-axis to currency
plot = plot + ggplot2::scale_y_continuous(labels = scales::dollar)

# RemixAutoML branding.
# Inspiration here: https://michaeltoth.me/you-need-to-start-branding-your-graphs-heres-how-with-ggplot.html
logo = magick::image_read("https://www.remixinstitute.com/wp-content/uploads/7b-Cheetah_Charcoal_Inline_No_Sub_No_BG.png")
plot
grid::grid.raster(logo, x = .73, y = 0.01, just = c('left', 'bottom'), width = 0.25)
