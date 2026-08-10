create database demo;

use demo;

describe cleaned_diabetic_data;

-- creating and loading data from csv file through import wizard
SELECT 
	COUNT(encounter_id) as Count
FROM diabetic;

ALTER TABLE cleaned_diabetic_data RENAME TO diabetic;

SELECT count(*) 
FROM diabetic;

-- BUSINESS PROBLEM : which patient, treatment, and encounter characteristics are most associated with readmission risk?
-- 1. Do patient with older age get readmitted more often?
SELECT 
	readmitted,
    ROUND(AVG(new_age), 2) as AverageAge 
FROM diabetic
GROUP BY readmitted
ORDER BY AverageAge DESC;

/* ---RESULTS---------------------------------------------------
<30	66.76
>30	66.41
NO	65.52
-------OBSERVATION----------------------------------------------
Older patients show a slightly higher average age among those who were readmitted. 
However, the difference is minimal, suggesting that age alone is not a strong indicator of 30-day readmission risk. 
------------------------------------------------------------------------------------------------------------------- */

--  2. Do patient with longer hospital stay get readmitted more often?
SELECT
	readmitted,
    ROUND(AVG(time_in_hospital), 2) AS AverageHospitalStay
FROM diabetic
GROUP BY readmitted
ORDER BY AverageHospitalStay DESC;

/* ---RESULTS---------------------------------------------------
<30	4.77
>30	4.50
NO	4.25
-------OBSERVATION----------------------------------------------
Patients readmitted within 30 days had the highest average hospital stay (4.77 days), 
compared with 4.50 days for patients readmitted after 30 days and 4.25 days for patients not readmitted. 
This suggests that longer hospital stays are associated with a slightly higher likelihood of 30-day readmission, although the difference is relatively small.
------------------------------------------------------------------------------------------------------------------------------------------------------------*/

--  3. which admission type has the highest readmission ?
SELECT
    admission_type_id,
    (CASE admission_type_id
		WHEN 1 THEN 'Emergency'
        WHEN 2 THEN 'Urgent'
        WHEN 3 THEN 'Elective'
        WHEN 4 THEN 'Newborn'
        WHEN 7 THEN 'Trauma Center'
        ELSE 'others'
        END
	) AS descriptions,
    COUNT(*) AS TotalReadmission,
     ROUND(AVG(
			CASE when readmitted = '<30' then 1 else 0 end
		) * 100, 2) as AvgReadmissionRate
FROM diabetic
GROUP BY admission_type_id, descriptions
ORDER BY AvgReadmissionRate DESC;

/* RESULT --------------------------------------------------------
1	Emergency	53990	11.52
2	Urgent	18480	11.18
6	others	5291	11.08
3	Elective	18869	10.39
5	others	4785	10.34
4	Newborn	10	10.00
8	others	320	8.44
7	Trauma Center	21	0.00

------Observation---------------------------------------------------------------------------------------------------------------------
Emergency admissions have the highest 30-day readmission rate at 11.52%, followed by urgent admissions at 11.18%. 
Elective admissions have a lower readmission rate of 10.39%. This suggests that patients admitted through emergency or urgent care may have a slightly higher risk of being readmitted within 30 days, 
although the differences between the major admission types are relatively small.
----------------------------------------------------------------------------------------------------------------*/

-- 4. Do patient with more medication is likely to return with in 30 day ? 
SELECT
	readmitted,
    ROUND(AVG(num_medications), 2) AS AvgNumMedication
FROM diabetic
GROUP BY readmitted
ORDER BY AvgNumMedication DESC;

/*----------RESULT----------------------------------------------------------------------------------------------
<30	16.90
>30	16.28
NO	15.67

--Observation --------------------------------------------------------------------------------------------------
Patients readmitted within 30 days had the highest average number of medications (16.90), compared with 16.28 for 
patients readmitted after 30 days and 15.67 for patients who were not readmitted. This suggests that patients taking 
more medications may have a slightly higher likelihood of 30-day readmission, although the difference is relatively small.
--------------------------------------------------------------------------------------------------------------------------*/

-- 5. Do patient taking insulin increases the chance of readmission ?
SELECT
	readmitted,
    ROUND(
		AVG( CASE WHEN insulin = 'Up' OR insulin = 'Steady' THEN 1 ELSE 0 END ) * 100,
        2) AS AvgInsulinTakenRate
FROM diabetic
GROUP BY readmitted
ORDER BY AvgInsulinTakenRate DESC;

/* RESULT ----------------------------------------------------------------------------------
<30	43.17
>30	41.76
NO	40.86

---------Observation -----------------------------------------------------------------------
Patients readmitted within 30 days had the highest insulin usage rate (43.17%), 
compared with 41.76% for patients readmitted after 30 days and 40.86% for patients who were not readmitted. 
This suggests that insulin use is associated with a slightly higher likelihood of 30-day readmission. 
However, the difference is relatively small, so insulin use alone may not be a strong indicator of readmission risk.
-------------------------------------------------------------------------------------------------------------------*/

-- 6. Does change in medication also leads to readmission ?
SELECT 
	readmitted,
    ROUND(
		AVG(CASE WHEN `change` = 'Ch' THEN 1 ELSE 0 END) * 100, 
		2) AS AvgChangeRate
FROM diabetic
GROUP BY readmitted
ORDER BY AvgChangeRate DESC;

/* RESULT -------------------------------------------------------------------------------------
<30	48.94
>30	48.59
NO	44.07

-----OBSERVATION-------------------------------------------------------------------------------
Patients readmitted within 30 days had the highest medication change rate (48.94%), followed closely by patients 
readmitted after 30 days (48.59%), while patients who were not readmitted had a lower rate (44.07%). This suggests that 
medication changes may be associated with a slightly higher likelihood of 30-day readmission. However, the difference between 
the two readmitted groups is minimal, so medication change alone may not be a strong predictor of readmission risk.
-----------------------------------------------------------------------------------------------------------------------------*/

-- 7. Do patient with A1Cresult test get readmitted more often?
SELECT 
	readmitted,
    ROUND(
		AVG( CASE WHEN A1Cresult != 'Not Tested' THEN 1 ELSE 0 END ) * 100,
        2) AS A1CresultRate
FROM diabetic
GROUP BY readmitted
ORDER BY A1CresultRate DESC;

/* RESULT ------------------------------------------------------------------------------------
NO	17.39
>30	16.32
<30	14.76

-- Observation -----------------------------------------------------------------------------------
The Avg A1Cresult rate is less than other readmitted group.
--------------------------------------------------------------------------------------------------*/

-- 8. Do patient with more previous inpatient get readmitted more often?
SELECT
	readmitted,
    ROUND(
		
        AVG(number_inpatient), 
        2) AS AvgPreviousInpatient 
FROM diabetic
GROUP BY readmitted
ORDER BY AvgPreviousInpatient DESC;

/* RESULT -----------------------------------------------------------------------------------------
<30	1.22
>30	0.84
NO	0.38

---OBSERVATION-------------------------------------------------------------------------------------
Patients readmitted within 30 days had the highest average number of previous inpatient visits (1.22), 
compared with 0.84 for patients readmitted after 30 days and 0.38 for patients who were not readmitted. 
This indicates a clear association between previous inpatient admissions and 30-day readmission risk, suggesting that 
patients with a history of frequent hospitalizations may require greater care-management attention before discharge.
----------------------------------------------------------------------------------------------------------------------*/

-- 9. Do patient with past emergency history get readmitted more often?
SELECT 
	readmitted,
    ROUND(
		AVG(number_emergency), 2) AS AvgNumEmergency
FROM diabetic
GROUP BY readmitted
ORDER BY AvgNumEmergency DESC;

/* RESULT ---------------------------------------------------------------------------------------
<30	0.36
>30	0.28
NO	0.11

Observation-------------------------------------------------------------------------------------------
Patients readmitted within 30 days had the highest average number of previous emergency visits (0.36), 
compared with 0.28 for patients readmitted after 30 days and 0.11 for patients who were not readmitted. 
This suggests that a history of emergency department visits is associated with a higher likelihood of 30-day readmission, 
indicating that patients with frequent emergency visits may benefit from closer follow-up and care management.
------------------------------------------------------------------------------------------------------------------------*/

-- 10. Which discharge disposition has the highest readmission ? 
SELECT 
	discharge_disposition_id,
    (CASE discharge_disposition_id
			WHEN 1 THEN 'Discharged to home'
            WHEN 2 THEN 'Discharged/transferred to another short term hospital'
            WHEN 3 THEN 'Discharged/transferred to SNF'
            WHEN 4 THEN 'Discharged/transferred to ICF'
            WHEN 12 THEN 'Still patient or expected to return for outpatient services'
            WHEN  15 THEN 'Discharged/transferred within this institution to Medicare approved swing bed'
            WHEN 28 THEN 'Discharged/transferred/referred to a psychiatric hospital of psychiatric distinct part unit of a hospital'
            WHEN 22 THEN 'Discharged/transferred to another rehab fac including rehab units of a hospital .'
            WHEN 5 THEN 'Discharged/transferred to another type of inpatient care institution'
            ELSE 'Others'
            END
	) as Descriptions,
    COUNT(*) AS TotalReadmission,
	ROUND(AVG( CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) * 100, 2) AS AVGReadmissionRate
FROM diabetic 
GROUP BY discharge_disposition_id, Descriptions
ORDER BY AVGReadmissionRate DESC;

/* RESULT ---------------------------------------------------------------------------
12	 Still patient or expected to return for outpatient services	3	66.67
15	Discharged/transferred within this institution to Medicare approved swing bed	63	44.44
9	Others	21	42.86
28	Discharged/transferred/referred to a psychiatric hospital of psychiatric distinct part unit of a hospital	139	36.69
22	Discharged/transferred to another rehab fac including rehab units of a hospital .	1993	27.70
5	Discharged/transferred to another type of inpatient care institution	1184	20.86
2	Discharged/transferred to another short term hospital	2128	16.07
3	Discharged/transferred to SNF	13954	14.66
24	Others	48	14.58
7	Others	623	14.45
8	Others	108	13.89
4	Discharged/transferred to ICF	815	12.76
6	Others	12902	12.70
18	Others	3691	12.44
25	Others	989	9.30
1	Discharged to home	60234	9.30
23	Others	412	7.28
14	Others	372	6.45
13	Others	399	4.76
11	Others	1642	0.00
10	Others	6	0.00
16	Others	11	0.00
17	Others	14	0.00
20	Others	2	0.00
19	Others	8	0.00
27	Others	5	0.00

Observation -----------------------------------------------------------------------------------------
Although Discharge 12 has the highest observed rate, it includes only 3 patients. More meaningful 
patterns are seen in discharge groups with larger patient populations, such as rehabilitation facilities
and psychiatric hospitals.
------------------------------------------------------------------------------------------------*/

/* 

---OVERALL FINDING-----------------------------------------------------------------------------------
The analysis suggests that previous healthcare utilization is the strongest and most consistent factor associated with 30-day 
readmission. Patients readmitted within 30 days had higher average numbers of previous inpatient admissions (1.22 vs. 0.38 for 
non-readmitted patients) and emergency visits (0.36 vs. 0.11), indicating that patients with a history of frequent hospital or 
emergency care may be at greater risk.

Other factors—including longer hospital stays, higher medication counts, insulin use, medication changes, and emergency or urgent 
admission types—also showed slightly higher rates among patients readmitted within 30 days. However, the differences were generally 
modest, suggesting that these factors alone are not strong predictors.

Age showed only a minimal difference between readmission groups, suggesting that age alone is not a strong indicator of 30-day 
readmission risk.

Key Business Insight

Patients with a history of frequent hospital and emergency visits should be prioritized for additional care-management support, 
follow-up, and discharge planning, as prior healthcare utilization shows the clearest association with 30-day readmission risk.

One important caution: these findings show associations, not causation. Your next step should be to combine these factors and 
determine whether they jointly identify high-risk encounters rather than treating any single factor as a definitive predictor.
*/
