# CMS-diabetes-readmission-analysis

## 📌 Project Overview

This project analyzes hospital encounters involving diabetic patients to identify factors associated with **30-day hospital readmission**.

The goal is to help healthcare leadership understand readmission patterns and better target care management resources.

## 🎯 Business Problem

The health system is facing financial penalties under the **CMS Hospital Readmissions Reduction Program (HRRP)** due to elevated readmission rates.

### Business Question
Which **patient, treatment, and encounter characteristics** are most associated with 30-day readmission?

## 🔍 Analysis

The project investigates factors such as:

- Patient age
- Admission type
- Hospital stay
- Number of medications
- Insulin usage
- Medication changes
- Previous inpatient visits
- Previous emergency visits

## 📊 Key Findings

- Previous inpatient visits show a strong association with 30-day readmission.
- Patients with previous emergency visits are more likely to be readmitted.
- 30-day readmitted patients have a slightly longer average hospital stay.
- Medication count, insulin usage, and medication changes show smaller differences between groups.
- Age alone shows a relatively weak association with readmission.

## 🛠️ Tools Used

**Python | Pandas | MySQL | SQL | Power BI | GitHub**

## 📈 Dashboard

The Power BI dashboard provides an interactive view of 30-day readmission patterns.

![CMS Diabetes Readmission Dashboard](visualization/dashboard.png)

## 📁 Project Structure

```text
CMS-diabetes-readmission-analysis/
├── panda/          # Data cleaning
├── sql/            # SQL analysis
├── visualization/  # Power BI dashboard
└── README.md
