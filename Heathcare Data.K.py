import pandas as pd;
import numpy as mp;
import matplotlib.pyplot as plt;
import seaborn as sns;

#1. How do you read the healthcare dataset CSV into a Pandas DataFrame?
df = pd.read_csv("C:/Users/priya/Downloads/healthcare_dataset.csv")

#2. How would you inspect the first few rows, data types, and summary statistics of the dataset?
df.head()
df.tail(10)
df.info()
df.describe()
df.shape



#3.Suppose some columns have missing values. What strategies would you use in Pandas to handle them in this healthcare dataset?
df.dropna(inplace=True)
df.isnull().sum()



#4.How do you drop duplicate rows in the DataFrame?
df.drop.duplicates(inplace=True)


#5.If the admission and discharge dates are strings, how would you convert them to datetime type in Pandas?
df['Date of Admission'] = pd.to_datetime(df['date of admission'])


#6. How can you create a new column for the length of hospital stay (in days) using admission and discharge dates?

df['Length of the stay'] = (df['discharge date'] - ['Admission Date']).dt.days

#7.How would you categorize age into groups (for example: 18–30, 31–50, 51–70, 71+)?
bins = [17, 30, 50, 70, 150]
labels = ['18-30', '31-50', '51-70', '71+']
df['Age Group'] = pd.cut (df['Age'], bins=bins, labels=labels , right = True)
print('Age Group')

#8.How would you filter the DataFrame to include only patients with a particular medical condition (e.g., “Diabetes”)?
diabetics_df = df[df['Medical Condition'] == 'Diabetes']
print(diabetics_df)

#9.How do you compute the average billing amount per medical condition?
avg_billing = df.groupby('Medical Condition')['Billing Amount'].mean()
print(avg_billing)

#11.How would you find the top 5 most common medical conditions in the dataset?
top_conditions = df['Medical Condition'].value_counts().head(5)
print(top_conditions)

#12.How can you calculate the total billing amount per patient?
total_bill_per_patient = df.groupby('Patient Name')['Billing Amount'].sum()

#13.How do you handle outliers in the billing amount column (very high or low amounts)?
Q1 = df['Billing Amount'].quantile(0.25)
Q3 = df['Billing Amount'].quantile(0.75)
IQR = Q3 - Q1

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

# Filter DataFrame to keep only rows within bounds
df_no_outliers = df[(df['Billing Amount'] >= lower_bound) & (df['Billing Amount'] <= upper_bound)]

#14.How would you merge (or “join”) the main DataFrame with another DataFrame that contains, say, patient demographic details?
# Assuming both dataframes share a common column like 'Patient ID'
merged_df = pd.merge(df, demographics_df, on='Patient ID', how='left')

#15.How can you group data by admission type (Emergency, Urgent, Elective) and compute summary statistics (count, mean billing, etc.)?

summary = df.groupby('Admission Type').agg({
    'Billing Amount': ['mean', 'sum'],
    'Patient Name': 'count'  
})
print(summary)

#16.How do you pivot the DataFrame to show average billing per admission type across different age groups?
pivot = pd.pivot_table(
    df, 
    values='Billing Amount', 
    index='Age Group', 
    columns='Admission Type', 
    aggfunc='mean'
)
print(pivot)

#17.How would you use the apply function to create a binary column like “is_senior” (True if age >= 65)?
df['is_senior'] = df['Age'].apply(lambda x: True if x >= 65 else False)

#18.How do you sort the DataFrame by billing amount, descending, and then pick the top 10 rows?
top_10_expensive = df.sort_values(by='Billing Amount', ascending=False).head(10)
print(top_10_expensive)

#19.How can you perform a rolling or cumulative calculation (for example, cumulative sum of billing over patient admissions sorted by date)?
# 1a. Sort by Patient and Date
df.sort_values(by=['Patient ID', 'Date of Admission'], inplace=True)

# 2b. Group by Patient and calculate cumulative sum
df['Cumulative Billing'] = df.groupby('Patient ID')['Billing Amount'].cumsum()

#20.How would you visualize the distribution of patient ages using Pandas and Matplotlib or Seaborn?
sns.histplot(df['Age'], kde=True, bins=20)
plt.title('Distribution of Patient Ages')
plt.xlabel('Age')
plt.show()

#21. How can you export your cleaned and transformed DataFrame back to a CSV file?
# index=False prevents pandas from writing the row numbers as a column
df.to_csv('cleaned_healthcare_data.csv', index=False)

#22.Change the date of admission to format?
df['date'] = pd.to_datetime(df['date'])
df['new_date'] = df['date'].dt.strftime('%m-%d-%Y')

