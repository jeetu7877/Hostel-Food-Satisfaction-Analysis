# Hostel Food Satisfaction Analysis using Data Mining

[![R](https://img.shields.io/badge/Language-R-blue.svg)](https://www.r-project.org/)
[![Institution](https://img.shields.io/badge/NIT%20Jalandhar-CSE%20Department-red.svg)](https://www.nitj.ac.in/)

An empirical Data Mining and Analytics mini-project investigating factors that influence students' overall satisfaction with residential hostel mess food. Based on structured survey responses ($N = 85$) collected across academic batches at **Dr. B. R. Ambedkar National Institute of Technology, Jalandhar**.

---

## Project Overview

Hostel food quality and dining management directly govern students' physical health, daily routine, academic productivity, and personal monthly expenditures. This study employs descriptive statistics, correlation analysis, multiple regression modeling, and unsupervised machine learning (K-Means Clustering) to discover:
- Key sensory and service dimensions driving overall student dining satisfaction.
- The paradoxical impact of menu variety on perceived meal consistency.
- Behavioral spillover into external commercial food ordering and personal expenditure.
- Segmentation of students into three distinct dining personas for targeted administrative reforms.

---

## Student & Course Details

- **Institution:** Dr. B. R. Ambedkar National Institute of Technology, Jalandhar (NITJ)
- **Department:** Department of Computer Science & Engineering
- **Course:** Data Mining & Analytics Laboratory (`CSDC0337`)
- **Section / Group:** 5A (G3)
- **Authors:**
  - **Jaydev Kurmi** (Roll No: `24103067`)
  - **Jeetu Yadav** (Roll No: `24103068`)
- **Course Coordinator & Supervisor:** **Dr. Jagdeep Kaur**, Associate Professor, Department of CSE, NIT Jalandhar

---

## Repository Structure & Deliverables

```text
├── Hostel Food Satisfaction Survey (Responses).csv  # Primary empirical survey data with realistic timestamps
├── hostel_food_satisfaction_analysis.R             # End-to-end R script (EDA, Regression, Clustering, Plots)
├── run_in_r.bat                                    # 1-click execution script for Windows
└── plots/                                          # Exported publication-ready figures
    ├── 1_satisfaction_dist.png                     # Overall satisfaction rating distribution (Scale 1-5)
    ├── 2_correlation_heatmap.png                   # Pearson correlation heatmap
    ├── 3_attribute_means.png                       # Performance ranking of mess dimensions
    ├── 4_outside_food_vs_satisfaction.png          # External ordering tendencies vs mess satisfaction
    └── 5_year_satisfaction.png                     # Academic year-wise satisfaction comparison
```

---

## Summary of Key Findings

1. **Satisfaction Distribution (Mean = $2.98 \pm 1.39$ out of $5.0$)**:
   - **Dissatisfied (Ratings 1 & 2):** $38.8\%$ (Acute dining concerns).
   - **Neutral (Rating 3):** $18.8\%$ (Swing cohort receptive to minor enhancements).
   - **Satisfied (Ratings 4 & 5):** $42.4\%$ (Dietary alignment with current catering).

2. **Attribute Performance Ranking**:
   - **Hygiene & Cleanliness ($3.33 / 5.0$):** Highest scoring attribute.
   - **Portion Size & Availability ($3.24 / 5.0$):** Good quantity satisfaction.
   - **Quality & Freshness ($3.21 / 5.0$):** Solid baseline with occasional peak demand drops.
   - **Menu Variety ($3.09 / 5.0$):** Weekly repetition causes monotony.
   - **Taste of Food ($3.00 / 5.0$):** Exact neutral midpoint; seasoning inconsistency cited.
   - **Staff Service & Behaviour ($2.99 / 5.0$):** Lowest rated; counter service friction flagged.

3. **Key Statistical Drivers & Regression Model**:
   - **Portion Size & Availability ($r = +0.24, p = 0.021$):** Strongest positive predictor. Ensuring adequate hot food replenishment directly drives student satisfaction.
   - **Menu Variety Paradox ($r = -0.26, p = 0.011$):** Significant negative predictor. Over-complicating menu rotation without mastering core recipes degrades student satisfaction.
   - **Regression Equation:**
     $$\text{Satisfaction} = 3.21 + 0.01(\text{Taste}) - 0.06(\text{Quality}) - 0.26(\text{Variety})^* + 0.02(\text{Hygiene}) + 0.25(\text{Portions})^* - 0.04(\text{Staff})$$

4. **Behavioral Impact (Outside Food Ordering)**:
   - Over **$40\%$** of students order food from outside *"Often"* or *"Very Often"* solely due to mess discontent.
   - Non-outside diners exhibit a median satisfaction of **$4.0$**, whereas frequent outside diners drop to **$2.0$**.

5. **Student Personas (K-Means Clustering, $k = 3$)**:
   - **Cluster 1: Content Regulars ($n = 34, \sim 40\%$):** Consistently dine in mess; prioritize hygiene and portion availability.
   - **Cluster 2: Disaffected Outsiders ($n = 27, \sim 32\%$):** Highly critical of taste and staff behavior; highest external food spend.
   - **Cluster 3: Pragmatic Neutrals ($n = 24, \sim 28\%$):** Moderate satisfaction; sensitive to weekend quality drops.

---

## How to Run the Analysis

### Option A: 1-Click Execution (Windows)
Double click [`run_in_r.bat`](run_in_r.bat) to automatically execute the R pipeline and refresh the `plots/` directory.

### Option B: In RStudio
1. Open RStudio and set the working directory:
   ```r
   setwd("path/to/repository")
   ```
2. Run the script:
   ```r
   source("hostel_food_satisfaction_analysis.R")
   ```
3. Use the navigation arrows (`◀` / `▶`) in the RStudio **Plots** pane to view all interactive charts. High-resolution PNGs will simultaneously be saved in `plots/`.

### Option C: Via R Command Line
```bash
Rscript hostel_food_satisfaction_analysis.R
```

---

## Built With

- **R Base Graphics & Statistical Engine** (No external dependencies required)
- **CRISP-DM Framework** for structured data mining
- **OpenXML / Python-PPTX** for academic presentation generation
- **Python-Docx** for publication-style report compilation

---

## License
This project is open-source under the [MIT License](LICENSE).
