###############################################################################
# 1. Data Preparation and Cleaning
  
  # Loading the dataset
  telecom_data <- read.csv("telecom_churn.csv")
  
  # View the first few rows of the dataset to verify the data is loaded correctly
  head(telecom_data)
  
  # Check the structure of the dataset
  str(telecom_data)
  
  # Check the summary of the data
  summary(telecom_data)
  
  # Check for missing values
  sum(is.na(telecom_data))
  
  # Convert necessary columns to factors
  telecom_data$Churn <- as.factor(telecom_data$Churn)
  telecom_data$ContractRenewal <- as.factor(telecom_data$ContractRenewal)
  telecom_data$DataPlan <- factor(telecom_data$DataPlan, levels = c(0, 1), labels = c("Basic Plan", "High End Plan"))
  telecom_data$DataPlan <- factor(telecom_data$DataPlan, 
                                  levels = c(0, 1), 
                                  labels = c("Basic Plan", "High End Plan"))
  
  # Check the distribution of values
  table(telecom_data$DataPlan)  
  
  # Mean, median, standard deviation, and variance for numeric columns
  mean(telecom_data$MonthlyCharge)      # Mean of MonthlyCharge
  median(telecom_data$MonthlyCharge)    # Median of MonthlyCharge
  sd(telecom_data$MonthlyCharge)        # Standard deviation of MonthlyCharge
  var(telecom_data$MonthlyCharge)       # Variance of MonthlyCharge
  
  
  #Removing Outliers using Z-score Method:
  # Calculate the Z-scores for MonthlyCharge
  z_scores <- scale(telecom_data$MonthlyCharge)
  
  # Define outliers (values with Z-score > 3 or < -3)
  outliers_z <- abs(z_scores) > 3
  
  # Remove outliers
  telecom_data_no_outliers_z <- telecom_data[!outliers_z, ]
  
  # Check the new dataset
  summary(telecom_data_no_outliers_z)


###############################################################################
# 2. EDA
# Visualization 1: Churn Rate by Contract Renewal Status

# Load required libraries
library(ggplot2)

# Bar plot to show churn rate by contract renewal status
ggplot(telecom_data, aes(x = factor(ContractRenewal), fill = factor(Churn))) + 
  geom_bar(position = "fill", width = 0.5) +  # Adjust width to make bars thinner
  labs(
    x = "Contract Not Renewed = 0     Contract Renewed = 1", 
    y = "Percentage of Customer Base", 
    fill = "Churn Status", 
    title = "Churn Rate by Contract Renewal Status"
  ) +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("#FDA172", "#FC6A03")) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 15, 
      face = "bold", 
      color = "#333333", 
      hjust = 0.5,     # Center-align the title
      margin = margin(t = 15, b = 15)  # Add space above and below
    ),
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 9),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  )




###############################################################################
# Visualization 2: Relationship between Data Usage and Monthly Charges

library(ggplot2)
library(dplyr)

# Filter out data usage between 0 and 1 GB
filtered_data <- telecom_data %>%
  filter(DataUsage < 0 | DataUsage > 1)

# Enhanced scatter plot to visualize the relationship between Data Usage and Monthly Charges
ggplot(filtered_data, aes(x = DataUsage, y = MonthlyCharge, color = factor(Churn))) + 
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "#DD571C") +
  labs(
    x = "Data Usage (GB)", 
    y = "Monthly Charge ($)", 
    color = "Churn Status",
    title = "Relationship between Data Usage and Monthly Charges"
  ) +
  scale_color_manual(values = c("#FDA172", "Black")) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 15, 
      face = "bold", 
      color = "#333333", 
      hjust = 0.5,  # Center-align the title
      margin = margin(t = 10, b = 10)
    ),
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 9),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  )




###############################################################################
# Visualization 3: Customer Service Calls Impact on Churn

library(ggplot2)

# Bar plot to show the number of customer service calls by churn status
ggplot(telecom_data, aes(x = factor(CustServCalls), fill = factor(Churn))) + 
  geom_bar(position = "fill") +
  labs(
    x = "Number of Customer Service Calls (Count)", 
    y = "Percentage of Customer Base", 
    fill = "Churn Status", 
    title = "Impact of Customer Service Calls on Churn"
  ) +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = c("#FDA172", "#DD571C")) +
  theme_minimal() +
  theme(
    plot.title = element_text(
      size = 15, 
      face = "bold", 
      color = "#333333", 
      hjust = 0.5,  # Center-align the title
      margin = margin(t = 10, b = 10)
    ),
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 9),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  )





##########################################################################
# Visualization 4: Average monthly charges by churn status

library(dplyr)
library(ggplot2)

# Summarize average monthly charges by churn status in telecom_data
library(dplyr)
library(ggplot2)


# Summarize average monthly charges by churn status in telecom_data
telecom_data %>%
  group_by(Churn) %>%
  summarize(avg_charge = mean(MonthlyCharge, na.rm = TRUE)) %>%
  ggplot(aes(x = avg_charge, y = factor(Churn), fill = factor(Churn))) +  # Convert Churn to a factor
  geom_bar(stat = "identity", width = 0.5) +  # Make the bars thinner by adjusting width
  scale_fill_manual(values = c("#FDA172", "#DD571C")) +  # Use specified color shades
  labs(title = "Average Monthly Charges by Churn Status", 
       x = "Average Monthly Charge ($)", 
       y = "Churn Status") +
  coord_flip() +
  scale_y_discrete(labels = c("0" = "No", "1" = "Yes")) +  # Rename y-axis labels for clarity
  theme_minimal() +  # Use minimal theme to remove grey background
  theme(
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 9),
    legend.position = "none",  # Remove the legend
    plot.title = element_text(size = 15, face = "bold", hjust = 0.5),  # Bold, centered title
    plot.margin = margin(t = 20, r = 20, b = 20, l = 20)  # Increase margins: top, right, bottom, left
  )




#########################################################
# Visualization 5:Bar chart showing the number of customers who churned (Churn = 1) and those who did not (Churn = 0)


# Load necessary libraries
library(ggplot2)

# Create a bar chart for Churn status with specific y-axis labels and no background color
ggplot(telecom_data, aes(x = Churn, fill = Churn)) +
  geom_bar(width = 0.5) +  # Adjust width to make bars thinner
  scale_fill_manual(values = c("#FDA172", "#DD571C")) +  # Color scheme
  labs(title = "Churn Distribution", 
       x = "Churn Status", 
       y = "Count of Customers") +
  scale_y_continuous(
    breaks = seq(0, 3000, by = 500),  # Set y-axis labels from 0 to 2500 in increments of 500
    limits = c(0, 3000)               # Ensure the y-axis starts at 0 and goes up to 2500
  ) +
  theme(
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 9),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8),
    plot.title = element_text(size = 15, face = "bold", color = "#333333", hjust = 0.5),
    panel.background = element_blank(),  # Remove background color
    plot.background = element_blank(),   # Remove plot background color
    panel.grid = element_blank()         # Remove grid lines
  )




#######################################################################################
# Viz 6 Histogram for Account Weeks by Churn

# Load necessary library
library(ggplot2)

# Create histogram to show the distribution of AccountWeeks by Churn status
ggplot(telecom_data, aes(x = AccountWeeks, fill = Churn)) +
  geom_histogram(position = "dodge", bins = 30, alpha = 0.7) +  # Histogram with dodged bars
  scale_fill_manual(values = c("#FDA172", "#DD571C")) +  # Custom color scheme for churn (0 = No, 1 = Yes)
  labs(title = "Distribution of Account Weeks by Churn", 
       x = "Account Weeks (Number of Weeks using the service)", 
       y = "Count of Customers") +
  theme(
    axis.title = element_text(size = 10),
    axis.text = element_text(size = 9),
    plot.title = element_text(size = 15, face = "bold", color = "#333333", hjust = 0.5),
    panel.background = element_blank(),  # Remove background color
    plot.background = element_blank(),   # Remove plot background color
    panel.grid = element_blank()         # Remove grid lines
  )





#######################################################################################
# Viz 7 relationship between OverageFee and MonthlyCharge

ggplot(telecom_data, aes(x = OverageFee, y = MonthlyCharge, color = Churn)) +
  geom_point(alpha = 0.6) +  # Add transparency to avoid overlapping points
  scale_color_manual(values = c("0" = "#FDA172", "1" = "Black")) +  # Use your color scheme for churn vs non-churn
  labs(title = "Overage Fee vs Monthly Charges",
       x = "Overage Fee (Additional Charges)",
       y = "Monthly Charges (Regular Charges)",
       color = "Churn Status") +
  theme_minimal() +  # Minimal theme to remove background gridlines
  theme(
    plot.title = element_text(size = 15, face = "bold", color = "#333333", hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )




#######################################################################################
# Viz 8 Roaming Minutes by Churn

ggplot(telecom_data, aes(x = RoamMins, fill = Churn)) +
  geom_density(alpha = 0.6) +  # Use transparency for overlapping areas
  scale_fill_manual(values = c("0" = "#FDA172", "1" = "#DD571C")) +  # Apply your custom color scheme for churn and non-churn
  labs(title = "Roaming Minutes by Churn Status",
       x = "Roaming Minutes",
       y = "Density",
       fill = "Churn Status") +
  theme_minimal() +  # Minimal theme to remove gridlines
  theme(
    plot.title = element_text(size = 15, face = "bold", color = "#333333", hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )





#######################################################################################
# Viz 9 Distribution of DayMins by Churn

ggplot(telecom_data, aes(x = DayMins, fill = Churn)) +
  geom_density(alpha = 0.6) +  # Transparency to help with overlapping areas
  scale_fill_manual(values = c("0" = "#FDA172", "1" = "#DD571C")) +  # Use the custom color scheme
  labs(title = "Density Plot of Day Minutes by Churn Status",
       x = "Day Minutes",
       y = "Density",
       fill = "Churn Status") +
  theme_minimal() +  # Minimal theme for cleaner plot
  theme(
    plot.title = element_text(size = 15, face = "bold", color = "#333333", hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )




#######################################################################################
# Viz 10: Day Calls vs Monthly Charges (Scatter Plot)


ggplot(telecom_data, aes(x = DayCalls, y = MonthlyCharge, color = Churn)) +
  geom_point(alpha = 0.6) +
  scale_color_manual(values = c("0" = "#FDA172", "1" = "Black")) +  # Custom colors for churn
  labs(title = "Day Calls vs Monthly Charges by Churn Status",
       x = "Day Calls",
       y = "Monthly Charges",
       color = "Churn Status") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 15, face = "bold", color = "#333333", hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )




################################################################################
# Calculate Churn Rate
# Load necessary library
library(dplyr)

# Calculate churn rate
churn_rate <- telecom_data %>%
  summarize(
    total_customers = n(),                  # Total number of customers
    churned_customers = sum(Churn == 1),   # Number of churned customers
    churn_rate_percentage = (churned_customers / total_customers) * 100  # Churn rate as a percentage
  )

# Display the churn rate
print(churn_rate)




################################################################################
# 3. DATA MINING
# 3.1 Association Rules: Apriori Algorithm

# Load necessary package
library(arules)

# Convert relevant columns to factors (for apriori algorithm)
telecom_data$CustServCalls <- as.factor(telecom_data$CustServCalls)

# Select relevant columns for association rules
transaction_data <- telecom_data[, c("ContractRenewal", "DataPlan", "CustServCalls", "Churn")]

# Apply apriori algorithm
rules <- apriori(transaction_data, parameter = list(support = 0.40, confidence = 0.8))

# View the rules
inspect(rules)

# Visualize the rules (if you want, you can install arulesViz for better visualization)
library(arulesViz)

plot(rules, 
     method = "scatter", 
     control = list(main = "Scatter Plot of Association Rules",  # Title
                    cex.main = 1.5,  # Title size
                    col = c("#FDA172", "#DD571C"), # Use your color scheme for the points
                    pch = 19,        # Point type (filled circles)
                    cex = 1.2        # Size of the points
     )
)




#######################################################################################
# 3. DATA MINING
# 3.2 Logistic Regression

# A. Load necessary libraries
library(caTools)   # For splitting data
library(pROC)      # For ROC curve
library(ggplot2)   # For visualization


# B. Inspect & Prepare Data

  # Check structure
  str(telecom_data)
  
  # Convert Churn, DataPlan, and ContractRenewal to factors if they aren't already
  telecom_data$Churn <- as.factor(telecom_data$Churn)
  telecom_data$DataPlan <- as.factor(telecom_data$DataPlan)
  telecom_data$ContractRenewal <- as.factor(telecom_data$ContractRenewal)


# C. Split the Dataset into Training and Test Sets
  
  set.seed(123)  # Set seed for reproducibility
  split <- sample.split(telecom_data$Churn, SplitRatio = 0.7)
  
  train_data <- subset(telecom_data, split == TRUE)
  test_data <- subset(telecom_data, split == FALSE)
  
  # Check the number of rows in each set
  cat("Training Set Rows:", nrow(train_data), "\n")
  cat("Test Set Rows:", nrow(test_data), "\n")
  

# D. Fit the Logistic Regression Model
  
  # Build logistic regression model
  logistic_model <- glm(Churn ~ MonthlyCharge + DayMins + CustServCalls + OverageFee,
                        data = train_data,
                        family = "binomial")
  
  # View model summary
  summary(logistic_model)
  

# E. Predict on the Test Set
  
  # Predict probabilities on test data
  test_data$predicted_prob <- predict(logistic_model, test_data, type = "response")
  
  # Convert probabilities to binary predictions (threshold = 0.5)
  test_data$predicted_class <- ifelse(test_data$predicted_prob > 0.5, 1, 0)
  
  
# F. Evaluate the Model
  
  # F.1 Confusion Matrix
  
    # Confusion matrix
    confusion_matrix <- table(Predicted = test_data$predicted_class, Actual = test_data$Churn)
    print(confusion_matrix)
    
    # Calculate accuracy
    accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
    cat("Accuracy:", round(accuracy, 4), "\n")
  
  # F.2 ROC Curve
    
    # Plot ROC curve
    roc_curve <- roc(test_data$Churn, test_data$predicted_prob)
    plot(roc_curve, col = "#DD571C", lwd = 2, main = "ROC Curve for Logistic Regression")
    auc(roc_curve)  # Display AUC value
    
  
# G. Interpreting Results
    
    # Exponentiate coefficients to interpret as odds ratios
    exp(coef(logistic_model))
    

# H. Visualizing key results
    
    # H.1 Compare predicted vs actual churn
    ggplot(test_data, aes(x = as.factor(predicted_class), fill = as.factor(Churn))) +
      geom_bar(position = "dodge") +
      labs(title = "Predicted vs Actual Churn", x = "Predicted Churn", y = "Count") +
      scale_fill_manual(values = c("#FDA172", "#DD571C"), name = "Actual Churn") +
      theme_minimal()
    
    # H.2 Visualize the coefficients to understand the impact of predictors
    # Coefficients plot
    coef_df <- as.data.frame(summary(logistic_model)$coefficients)
    coef_df <- coef_df[order(coef_df$Estimate, decreasing = TRUE), ]
    coef_df$Predictor <- rownames(coef_df)
    
    ggplot(coef_df, aes(x = reorder(Predictor, Estimate), y = Estimate)) +
      geom_col(fill = "#DD571C") +
      coord_flip() +
      labs(title = "Logistic Regression Coefficients", x = "Predictor", y = "Estimate") +
      theme_minimal()
    
    
    
    
#######################################################################################
# 3. DATA MINING
# 3.3 Decision Trees
    
  # A. Load Required Libraries
    # Install packages if not already installed
    if (!require("rpart")) install.packages("rpart")
    if (!require("rpart.plot")) install.packages("rpart.plot")
    
    # Load libraries
    library(rpart)
    library(rpart.plot)
    
  # B. Split the Data
    # Set seed for reproducibility
    set.seed(123)
    
    # Create a 70-30 train-test split
    sample_index <- sample(1:nrow(telecom_data), 0.7 * nrow(telecom_data))
    train_data <- telecom_data[sample_index, ]
    test_data <- telecom_data[-sample_index, ]
    
  # C. Build the Decision Tree
    # Build a simplified decision tree
    decision_tree <- rpart(Churn ~ MonthlyCharge + DataPlan + CustServCalls + OverageFee + DayMins + AccountWeeks, 
                           data = train_data, 
                           method = "class", 
                           control = rpart.control(minsplit = 50, cp = 0.02))  # Higher minsplit and cp for a smaller tree
    
    
  # D. Visualize the Decision Tree
    # Visualize the tree
    rpart.plot(decision_tree, 
               type = 4, 
               extra = 106,  # Adds percentages and counts
               under = TRUE, # Place class labels under the splits
               faclen = 0,   # Display full factor names
               main = "Simplified Decision Tree for Churn Prediction")
    
    
  # E. Evaluate the Model on the Test Data
    # Make predictions on test data
    predictions <- predict(decision_tree, newdata = test_data, type = "class")
    
    # Confusion Matrix
    confusion_matrix <- table(Predicted = predictions, Actual = test_data$Churn)
    print(confusion_matrix)
    
    # Calculate Accuracy
    accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
    cat("Accuracy:", accuracy)
    
    # Calculating Precision, Sensitivity, Specificity
    
      # Step 1: Load required library
      library(caret)
      
      # Step 2: Confusion Matrix (assuming `predicted_labels` and `test_data$Churn` are defined)
      conf_matrix <- confusionMatrix(as.factor(predictions), as.factor(test_data$Churn), positive = "1")
      
      # Step 3: Extract Metrics
      precision <- conf_matrix$byClass["Precision"]
      sensitivity <- conf_matrix$byClass["Sensitivity"]
      specificity <- conf_matrix$byClass["Specificity"]
      
      # Step 4: Print the Results
      cat("Precision: ", round(precision, 3), "\n")
      cat("Sensitivity (Recall): ", round(sensitivity, 3), "\n")
      cat("Specificity: ", round(specificity, 3), "\n")
    
  
      
      
#######################################################################################
# 3. DATA MINING
# 3.4 Neural Network
    
    # A. Install and Load Necessary Packages
      # Install necessary packages if not already installed
      install.packages("nnet")    # For neural network model
      install.packages("caret")   # For model evaluation
      
      # Load the libraries
      library(nnet)
      library(caret)
      
    
    # B. Data Preparation
      
      # Split the data into training and testing sets (80% training, 20% testing)
      set.seed(123)  # Set seed for reproducibility
      trainIndex <- createDataPartition(telecom_data$Churn, p = 0.8, list = FALSE)
      train_data <- telecom_data[trainIndex, ]
      test_data <- telecom_data[-trainIndex, ]
      
    
    # C. Fit the Neural Network Model
      # Fit the Feedforward Neural Network model
      nn_model <- nnet(Churn ~ MonthlyCharge + DayMins + CustServCalls + OverageFee, 
                       data = train_data, 
                       size = 3,   # Number of neurons in the hidden layer (try different values)
                       linout = FALSE,  # For classification (not regression)
                       decay = 0.01,  # Regularization parameter to avoid overfitting
                       maxit = 100)   # Number of iterations (epochs)
      
    
    # D. Make Predictions
      # Make predictions on the test data
      predicted_nn <- predict(nn_model, test_data, type = "class")
      
      # View the first few predictions
      head(predicted_nn)
      
    
    # E. Evaluate Model Performance
      # Create confusion matrix for evaluation
      conf_matrix <- confusionMatrix(as.factor(predicted_nn), as.factor(test_data$Churn))
      
      # Print the confusion matrix
      print(conf_matrix)
      
      # Extract and print precision, sensitivity, and specificity
      precision <- conf_matrix$byClass["Precision"]
      sensitivity <- conf_matrix$byClass["Sensitivity"]
      specificity <- conf_matrix$byClass["Specificity"]
      
      cat("Precision: ", round(precision, 3), "\n")
      cat("Sensitivity (Recall): ", round(sensitivity, 3), "\n")
      cat("Specificity: ", round(specificity, 3), "\n")
      
    # F. Plot the NN
      # Plot the neural network
      plot(nn_model)
      
    
      # Install NeuralNetTools if not installed already
      install.packages("NeuralNetTools")
      library(NeuralNetTools)
      
      # Plot the neural network using plotnet
      plotnet(nn_model)
      

#######################################################################################

