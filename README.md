# 🏥 Diabetes Hospital Readmission Analysis

## Project Overview

This project analyzes hospital encounters involving diabetic patients to identify factors associated with hospital readmissions, particularly within 30 days of discharge.

Hospital readmissions increase healthcare costs and may indicate gaps in patient care and discharge planning. The goal of this project is to explore patient demographics, hospital stays, medication usage, admission types, and previous healthcare utilization to identify patterns associated with readmission.

The project uses **SQL for data analysis** and **Power BI for interactive dashboard development**, transforming raw healthcare data into meaningful business insights.

## Business Objectives

- Analyze the 30-day hospital readmission rate among diabetic patients.
- Identify patient characteristics associated with readmission.
- Compare hospital stays across readmission groups.
- Examine the relationship between medication usage and readmission.
- Investigate whether previous inpatient and emergency visits are associated with readmission.
- Identify opportunities for improving patient care and reducing avoidable readmissions.

## Dataset
**Dataset:** Diabetes 130-US Hospitals for Years 1999–2008
The dataset contains approximately 101,766 hospital encounters involving diabetic patients across 130 US hospitals.
Key attributes include:

| Category | Variables |
|---|---|
| Patient Information | Age, Race, Gender |
| Hospital Stay | Time in Hospital, Admission Type |
| Medication | Number of Medications, Insulin, Medication Change |
| Previous Healthcare Usage | Number of Inpatient Visits, Emergency Visits, Outpatient Visits |
| Readmission | Readmitted |

## Data Cleaning and Preparation
The dataset was cleaned and prepared before analysis.
Key cleaning steps:
- Removed the `weight` column due to a high percentage of missing values.
- Replaced `?` values in categorical columns with `Unknown`.
- Handled missing laboratory test results appropriately.
- Checked duplicate `encounter_id` records.
- Retained repeated `patient_nbr` values because one patient can have multiple hospital encounters.
- Standardized data for SQL analysis and Power BI visualization.

## Tools and Technologies

- **SQL / MySQL:** Data cleaning, querying, aggregation, and analysis.
- **Power BI:** Interactive dashboard and data visualization.
- **DAX:** Measures and calculations for healthcare KPIs.
- **Excel:** Initial data inspection and preparation.

## Key Performance Indicators (KPIs)

The dashboard focuses on the following metrics:

- Total Hospital Encounters
- Unique Patients
- 30-Day Readmission Rate
- Average Hospital Stay
- Average Number of Medications
- Medication Change Rate
- Average Previous Inpatient Visits
- Average Previous Emergency Visits

## Key Analysis and Findings

### 1. Hospital Stay by Readmission Status
| Readmission Status | Average Hospital Stay |
|---|---:|
| <30 Days | 4.77 days |
| >30 Days | 4.50 days |
| No Readmission | 4.25 days |
Patients readmitted within 30 days had the highest average hospital stay among the three groups.

### 2. Readmission by Admission Type
| Admission Type | Readmission Rate |
|---|---:|
| Emergency | 11.52% |
| Urgent | 11.18% |
| Elective | 10.39% |
Emergency admissions showed the highest readmission rate in this analysis.

### 3. Medication Usage by Readmission Status
| Readmission Status | Average Medications |
|---|---:|
| <30 Days | 16.90 |
| >30 Days | 16.28 |
| No Readmission | 15.67 |
Patients readmitted within 30 days had a slightly higher average medication count.

### 4. Medication Change and Previous Healthcare Utilization
The analysis examines medication changes and previous emergency and inpatient visits across readmission groups.
Patients readmitted within 30 days had higher average previous inpatient and emergency utilization than patients without readmission. This suggests that previous healthcare utilization may be useful when identifying patients who need closer follow-up.

## 📈 Power BI Dashboard
The interactive Power BI dashboard presents healthcare insights through:
- KPI cards for overall hospital performance.
- Readmission analysis by admission type.
- Average hospital stay comparison.
- Medication usage distribution.
- Insulin usage analysis.
- Medication change and previous healthcare utilization.

## Dashboard
The Power BI dashboard provides an interactive view of 30-day readmission patterns.
<img width="1513" height="856" alt="image" src="https://github.com/user-attachments/assets/501d1412-e67a-458a-9c58-88981bd71b2e" />

## Business Recommendations
Based on the analysis:
1. **Prioritize High-Risk Patients:** Consider closer monitoring and follow-up for patients with previous inpatient and emergency visits.
2. **Improve Discharge Planning:** Strengthen discharge planning for patients who may be at higher risk of early readmission.
3. **Review Medication Management:** Evaluate medication changes and treatment plans to support continuity of care.
4. **Monitor Emergency Admissions:** Investigate factors contributing to the higher readmission rate among emergency admissions.
5. **Support Patient Follow-Up:** Consider structured post-discharge follow-up programs for diabetic patients.

## Project Outcome
This project demonstrates how healthcare data can be transformed into actionable insights using SQL and Power BI.
It provides an analytical view of patient demographics, hospital utilization, medication patterns, and readmission behavior. The findings can help healthcare analysts and care-management teams explore potential risk factors and identify areas for further investigation.

## Tools Used
**Python | Pandas | MySQL | SQL | Power BI | GitHub**





