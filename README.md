# HEALTHCARE-DATASET-ANALYSIS

Project Overview

This project performs Exploratory Data Analysis (EDA) on a healthcare dataset.
The goal is to clean, transform, and analyze hospital data to gain business and operational insights.

Objectives

Load and explore the dataset.
Identify and handle missing, duplicate, and incorrect values.
Convert data types (e.g., dates, numeric values).
Perform basic statistical analysis.
Visualize trends and patterns in the dataset.

Rows: 55,500 before cleaning 
        and 
      50,000 after cleaning
Description: Contains 15 columns including patient details, admission/discharge dates, medical conditions, and billing information.

Steps Covered in This Notebook

Data Loading & Inspection
Data Cleaning & Transformation
Feature Engineering
Exploratory Data Analysis (EDA)
Visualization of Key Insights
Key Insights
Dataset Composition

Total patients after cleaning: 50,000
Age range : 18-85 years, with mean age as 51.58
Gender distribution appears balanced.
Data Quality

No missing values after cleaning.
Uniform date formats for admission and discharge

Medical Conditions
Most common conditions : Cancer, Obesity,Diabetes.
Certain diseases corelate with longer hospital stays.

Costs and Billing
Average Billing: 25,555

Hospital Operations
Admission types include Emergency, Urgent, Elective
Emergency cases tend to have higher billing amounts

Technologies Used
Python for data manipulation & analysis.
Pandas for data handling.
Matplotlib & Seaborn for visualization.
Jupyter Notebook for interactive analysis.
