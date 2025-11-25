
CREATE DATABASE PatientInfo;

USE PatientInfo;

DELETE FROM patientsrecords;
CREATE TABLE patientsrecords (
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Blood_Type VARCHAR(5),
    Medical_Condition VARCHAR(100),
    Doctor VARCHAR(100),
    Hospital VARCHAR(100),
    Insurance_Provider VARCHAR(100),
    Billing_Amount DECIMAL(15,2),
    Room_Number INT,
    Admission_Type VARCHAR(50),
    Medication VARCHAR(100),
    Test_Results VARCHAR(100)
);
#1.Write the query to reterive the first 100 patients-------
SELECT * FROM patientsrecords
LIMIT 100;

#2. Write a query to filter the patients who have 'Cancer' as their condition ----
select * from patientsrecords where medical_condition ='Cancer';

#3. Write the query for the filtering of the patients with gender-------
select  gender, count(*)as pateint_count
from patientsrecords 
group by gender;

#4. Query for the number of patients in each condition ----
select medical_condition, count(*) as name_count
FROM patientsrecords
GROUP BY medical_condition;

 #5. Average billing per admission type--------
SELECT admission_type, AVG(billing_amount) as average_bill
FROM patientsrecords
GROUP BY admission_type;

#6.Write the query for maximum, mininum, and average billing for all patients------
 SELECT 
    MAX(billing_amount) as max_bill,
    MIN(billing_amount) as min_bill,
    AVG(billing_amount) as avg_bill
FROM patientsrecords;

 #7.Group by Age Groups and find Average Billing---------
SELECT 
    CASE 
        WHEN age < 18 THEN '0-18'
        WHEN age BETWEEN 18 AND 65 THEN '18-65'
        ELSE '65+' 
    END AS age_group,
    AVG(billing_amount) as avg_billing
FROM patientsrecords
GROUP BY 
    CASE 
        WHEN age < 18 THEN '0-18'
        WHEN age BETWEEN 18 AND 65 THEN '18-65'
        ELSE '65+' 
    END;
    
    
#8.Join “patients” and “admissions” tables
SELECT 
    p.patient_id,
    p.name,
    p.age,
    a.admission_date,
    a.billing_amount
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id;

#9.Top 5 most common admission types------
SELECT admission_type, COUNT(*) as frequency
FROM patientsrecords
GROUP BY admission_type
ORDER BY frequency DESC
LIMIT 5;

#10. Find patients with more than one admission-----
SELECT name, COUNT(*) as admission_count
FROM patientsrecords
GROUP BY name
HAVING COUNT(*) > 1
order by admission_count Desc;

#11.Remove duplicate patient records in SQL based on the patient identifier --------
SELECT name, COUNT(*)
FROM patientsrecords
GROUP BY name
HAVING COUNT(*) > 1;

DELETE FROM patientsrecords
WHERE rowid NOT IN (
  SELECT MIN(rowid)
  FROM patientsrecords
  GROUP BY name
);

#12.Update billing value for a specific patient(say patient_id=12345) in SQL?------
UPDATE name
SET billing_amount = 5000.00
WHERE room_number = 458;

#13.Delete records where billing is NULL or ≤ 0-------
DELETE FROM patientsrecords
WHERE billing_amount IS NULL OR billing_amount <= 0;

#14.Subquery for patients above average billing---
SELECT *
FROM patientsrecords
WHERE billing_amount > (SELECT AVG(billing_amount) FROM patientsrecords);

#15.Rank patients by billing amount(highest billing is rank 1)----
SELECT 
    name, 
    billing_amount,
    RANK() OVER (ORDER BY billing_amount DESC) as billing_rank
FROM patientsrecords;

#16.Cumulative billing per patient over their admissions-----
SELECT 
    name,
    billing_amount,
    SUM(billing_amount) OVER (PARTITION BY name ORDER BY billing_amount) as cumulative_bill
FROM admission_type;

#17.Partition by age group and find average stay within the each parition ------
SELECT 
    name,
    age,
    (discharge_date - admission_date) as length_of_stay,
    AVG(discharge_date - admission_date) OVER (
        PARTITION BY 
            CASE 
                WHEN age < 18 THEN '0-18'
                WHEN age BETWEEN 18 AND 65 THEN '18-65'
                ELSE '65+' 
            END
    ) as avg_stay_for_age_group
FROM patientsrecords;

#18.Create a "Patient Summary" View----
CREATE VIEW patient_summary AS
SELECT 
    patient_id,
    age,
    admission_type,
    (discharge_date - admission_date) as length_of_stay,
    billing_amount
FROM patientsrecords;

#19. How you would grant permission to another user on your healthcare database table in SQL?
#---In healthcare, data privacy (HIPAA/GDPR) is critical. 
You grant permissions to ensure the Principle of Least Privilege—users should only have access to the data they specifically need to do their job, 
and nothing more.
To grant read-only access:
GRANT SELECT ON patients TO analyst_user;












