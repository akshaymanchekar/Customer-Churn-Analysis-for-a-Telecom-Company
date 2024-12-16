# 📞 Customer Churn Analysis for a Telecom Company  

![Dashboard Banner](images/customer_churn_banner.png)  

## 📊 Overview  
The **Customer Churn Analysis Dashboard** leverages advanced analytical techniques to understand the reasons behind customer attrition and predict churn within a telecom company. This project employs **R** for data processing, modeling, and visualization, enabling actionable insights that help reduce churn rates and improve customer retention strategies.  

---

## 🚀 Project Objectives  
1. **Predict Customer Churn**: Identify customers likely to leave the service.  
2. **Analyze Key Factors**: Determine what drives churn, such as overage fees, service interactions, and usage patterns.  
3. **Enhance Retention Strategies**: Develop targeted interventions to improve customer satisfaction and loyalty.  

---

## 📂 Data Overview  
- **Dataset**: Telecom Customer Churn Dataset (sourced from [Kaggle](https://www.kaggle.com/datasets/barun2104/telecom-churn?resource=download)).  
- **Rows**: 3,334 entries.  
- **Columns**: 11 key variables describing customer behavior, service usage, and charges.  

### **Key Variables**  
- `Churn`: Indicates whether the customer churned (1) or stayed (0).  
- `AccountWeeks`: Number of weeks the customer has been with the service.  
- `ContractRenewal`: Whether the customer renewed their contract.  
- `DataPlan`: Whether the customer has a data plan.  
- `DataUsage`: Amount of data used.  
- `CustServCalls`: Number of customer service calls made.  
- `MonthlyCharge`: Monthly charge for the customer’s service.  
- `OverageFee`: Fee charged for exceeding allocated usage.  
- `RoamMins`: Minutes spent on roaming.  

---

## 🔍 Analysis Steps  
1. **Data Preprocessing**:  
   - Handle missing values and normalize variables.  
   - Convert data types as needed.  

2. **Exploratory Data Analysis (EDA)**:  
   - Visualize churn rates and identify key trends.  
   - Analyze customer usage patterns, service interactions, and churn correlations.  

3. **Modeling**:  
   - Built predictive models using:  
     - Logistic Regression  
     - Decision Trees  
     - Neural Networks  

4. **Feature Importance**:  
   - Identify the most significant predictors of churn, such as:  
     - High **Overage Fees**  
     - Frequent **Customer Service Calls**  
     - Long **Roaming Minutes**  

---

## 📈 Key Insights  
- **Churn Rate**:  
  - Overall churn rate is **14.19%**.  
  - 483 out of 3,334 customers discontinued the service.  

- **Service Interactions**:  
  - Customers making **4+ service calls** were significantly more likely to churn.  
  - **100% churn** for customers with 9+ service calls.  

- **Billing Factors**:  
  - High churn rates for customers with monthly charges **$75+** or high **overage fees**.  

- **Usage Patterns**:  
  - Churned customers had:  
    - **Higher roaming minutes**.  
    - Longer call durations.  
    - Distinct bimodal distribution of day minutes.  

- **Revenue Impact**:  
  - High churn among long-term customers (90–130 weeks) highlights missed revenue opportunities.  

---

## 🛠️ Tools and Technologies  
- **Language**: R  
- **Environment**: RStudio  

---

## 🌟 Recommendations  
1. **Enhance Customer Service**:  
   - Address issues for customers with frequent service calls (4+).  
   - Improve service training to handle root causes effectively.  

2. **Billing and Plan Optimization**:  
   - Minimize overage fees with clear, transparent billing policies.  
   - Offer affordable plans tailored to high-usage customers.  

3. **Proactive Retention Strategies**:  
   - Use predictive models to identify at-risk customers.  
   - Provide loyalty incentives like discounts or value-added benefits for long-term customers.  

4. **Personalized Communication**:  
   - Focus on high-usage customers to recommend suitable plans and prevent churn.  

5. **Feedback Mechanisms**:  
   - Collect real-time feedback to address dissatisfaction promptly.  

---

## 📸 Dashboard Snapshots  

### **📍 Logistic Regression Insights**  
![Logistic Regression](images/logistic_regression_insights.png)  
*Logistic Regression identified overage fees and service calls as key churn predictors.*  

### **📍 Decision Tree Visualization**  
![Decision Tree](images/decision_tree_visualization.png)  
*Decision Trees highlighted key splits based on monthly charges and customer service calls.*  

### **📍 Neural Network Analysis**  
![Neural Network](images/neural_network_analysis.png)  
*Neural Networks uncovered complex relationships in customer behavior.*  

---

## 🌐 Connect With Me  
📧 Email: [akshay.manchekar2002@gmail.com](mailto:akshay.manchekar2002@gmail.com)  
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Akshay_Manchekar-blue?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/akshaymanchekar)  

---

🌟 **Thank You for Exploring This Project!** Feel free to share your feedback or suggestions. 🚀  
