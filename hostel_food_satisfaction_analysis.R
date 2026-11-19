# ==============================================================================
# PROJECT: Hostel Food Satisfaction Analysis using Data Mining
# INSTITUTION: Dr. B. R. Ambedkar National Institute of Technology, Jalandhar
# DEPARTMENT: Department of Computer Science & Engineering
# COURSE: Data Mining & Analytics Laboratory (CSPC-323 / Section: 5A - G3)
# AUTHORS: Jaydev Kurmi (Roll No: 24103067) & Jeetu Yadav (Roll No: 24103068)
# SUPERVISOR: Dr. Jagdeep Kaur, Associate Professor, Department of CSE, NITJ
# DATASET: hostel_food_satisfaction.csv (N = 85 Survey Responses)
# ==============================================================================

# ------------------------------------------------------------------------------
# STEP 1: VERIFY ENVIRONMENT & CREATE OUTPUT DIRECTORIES
# ------------------------------------------------------------------------------
if (!dir.exists("plots")) {
  dir.create("plots", recursive = TRUE)
  cat("[INIT] Created directory: plots/\n")
}

# ------------------------------------------------------------------------------
# STEP 2: LOAD & PREPROCESS THE DATASET
# ------------------------------------------------------------------------------
# Try loading from standard local filename or full survey responses name
data_path <- "hostel_food_satisfaction.csv"
if (!file.exists(data_path)) {
  alt_path <- "Hostel Food Satisfaction Survey (Responses).csv"
  if (file.exists(alt_path)) {
    data_path <- alt_path
  } else {
    stop("ERROR: Dataset file not found! Please place 'hostel_food_satisfaction.csv' in the working directory.")
  }
}

raw_df <- read.csv(data_path, check.names = FALSE, stringsAsFactors = FALSE)
cat(sprintf("\n[DATA LOAD] Successfully loaded '%s' with %d rows and %d columns.\n", data_path, nrow(raw_df), ncol(raw_df)))

# Standardize and clean column names for analytical computing
colnames(raw_df) <- c(
  "Timestamp", "Year_of_Study", "Mess_Frequency", "Taste",
  "Quality_Freshness", "Variety", "Hygiene", "Portion_Availability",
  "Staff_Service", "Outside_Food_Freq", "Overall_Satisfaction"
)

# Convert categorical variables into ordered factors
raw_df$Outside_Food_Freq <- factor(
  raw_df$Outside_Food_Freq,
  levels = c("Never", "Rarely", "Sometimes", "Often", "Very Often")
)
raw_df$Year_of_Study <- factor(
  raw_df$Year_of_Study,
  levels = c("1st Year", "2nd Year", "3rd Year", "4th Year")
)

rating_cols <- c("Taste", "Quality_Freshness", "Variety", "Hygiene", "Portion_Availability", "Staff_Service")
num_df <- raw_df[, c(rating_cols, "Overall_Satisfaction")]

cat("\n--- DATASET SUMMARY ---\n")
summary(raw_df)

# ------------------------------------------------------------------------------
# STEP 3: VISUALIZATIONS (DISPLAYS IN RSTUDIO PLOTS PANE & SAVES TO PNG)
# ------------------------------------------------------------------------------

# --- PLOT 1: Overall Satisfaction Distribution ---
cat("\n[1/5] Generating Plot 1: Overall Satisfaction Distribution...\n")
# 1A. Display directly in interactive R Plots pane
counts <- table(raw_df$Overall_Satisfaction)
cols1 <- c("#e53e3e", "#dd6b20", "#d69e2e", "#3182ce", "#38a169")
bp1 <- barplot(counts, col = cols1, border = NA, ylim = c(0, max(counts) * 1.25),
               main = "Distribution of Overall Hostel Mess Food Satisfaction",
               sub = "Scale: 1 (Very Low) to 5 (Very High) | N = 85",
               xlab = "Satisfaction Rating", ylab = "Number of Students",
               cex.lab = 1.05, cex.main = 1.15, font.main = 2)
text(bp1, counts + 0.8, labels = counts, font = 2, col = "#1a202c", cex = 1.05)
grid(nx = NA, ny = NULL, col = "#e2e8f0", lty = 1)

# 1B. Save high-resolution PNG for Presentation & Report
png("plots/1_satisfaction_dist.png", width = 2100, height = 1350, res = 300)
par(mar = c(4.5, 4.5, 3, 1), bg = "white")
bp1_png <- barplot(counts, col = cols1, border = NA, ylim = c(0, max(counts) * 1.25),
                   main = "Overall Mess Food Satisfaction Distribution (Scale 1-5)",
                   xlab = "Satisfaction Score (1 = Very Low, 5 = Very High)",
                   ylab = "Number of Students", cex.lab = 1.05, cex.main = 1.15, font.main = 2)
text(bp1_png, counts + 0.8, labels = counts, font = 2, col = "#1a202c", cex = 1.05)
grid(nx = NA, ny = NULL, col = "#e2e8f0", lty = 1)
dev.off()
cat("      -> Saved: plots/1_satisfaction_dist.png\n")


# --- PLOT 2: Average Rating by Mess Quality Attribute ---
cat("\n[2/5] Generating Plot 2: Average Score across Quality Attributes...\n")
means <- colMeans(raw_df[, rating_cols])
sorted_means <- sort(means, decreasing = FALSE)
pal2 <- colorRampPalette(c("#e53e3e", "#dd6b20", "#319795", "#38a169"))(length(sorted_means))

# 2A. Display directly in interactive R Plots pane
bp2 <- barplot(sorted_means, horiz = TRUE, col = pal2, border = NA, xlim = c(0, 5),
               main = "Average Rating by Mess Quality Attribute",
               xlab = "Mean Rating (out of 5.0)", las = 1, cex.names = 0.85,
               cex.lab = 1.05, cex.main = 1.15, font.main = 2)
text(sorted_means + 0.22, bp2, labels = sprintf("%.2f", sorted_means), font = 2, col = "#1a202c", cex = 0.95)

# 2B. Save high-resolution PNG
png("plots/3_attribute_means.png", width = 2400, height = 1350, res = 300)
par(mar = c(4.5, 9.5, 3, 1.5), bg = "white")
bp2_png <- barplot(sorted_means, horiz = TRUE, col = pal2, border = NA, xlim = c(0, 5),
                   main = "Average Rating by Mess Quality Attribute",
                   xlab = "Mean Rating (out of 5)", las = 1, cex.names = 0.9,
                   cex.lab = 1.05, cex.main = 1.15, font.main = 2)
text(sorted_means + 0.22, bp2_png, labels = sprintf("%.2f", sorted_means), font = 2, col = "#1a202c", cex = 0.95)
dev.off()
cat("      -> Saved: plots/3_attribute_means.png\n")


# --- PLOT 3: Pearson Correlation Heatmap ---
cat("\n[3/5] Generating Plot 3: Pearson Correlation Matrix...\n")
cmat <- cor(num_df)
n <- ncol(cmat)

# 3A. Display directly in interactive R Plots pane
image(1:n, 1:n, cmat[, n:1], col = colorRampPalette(c("#3182ce", "#edf2f7", "#e53e3e"))(100),
      axes = FALSE, xlab = "", ylab = "", main = "Correlation Matrix: Factors vs Overall Satisfaction")
axis(1, at = 1:n, labels = colnames(cmat), las = 2, cex.axis = 0.8)
axis(2, at = 1:n, labels = rev(colnames(cmat)), las = 2, cex.axis = 0.8)
for (i in 1:n) {
  for (j in 1:n) {
    val <- cmat[i, n - j + 1]
    text(i, j, labels = sprintf("%.2f", val), cex = 0.85, font = 2,
         col = ifelse(abs(val) > 0.45, "white", "black"))
  }
}

# 3B. Save high-resolution PNG
png("plots/2_correlation_heatmap.png", width = 2400, height = 2000, res = 300)
par(mar = c(7, 7, 3, 2), bg = "white")
image(1:n, 1:n, cmat[, n:1], col = colorRampPalette(c("#3182ce", "#edf2f7", "#e53e3e"))(100),
      axes = FALSE, xlab = "", ylab = "", main = "Correlation Matrix: Food & Service Factors vs Satisfaction")
axis(1, at = 1:n, labels = colnames(cmat), las = 2, cex.axis = 0.85)
axis(2, at = 1:n, labels = rev(colnames(cmat)), las = 2, cex.axis = 0.85)
for (i in 1:n) {
  for (j in 1:n) {
    val <- cmat[i, n - j + 1]
    text(i, j, labels = sprintf("%.2f", val), cex = 0.9, font = 2,
         col = ifelse(abs(val) > 0.45, "white", "black"))
  }
}
dev.off()
cat("      -> Saved: plots/2_correlation_heatmap.png\n")


# --- PLOT 4: Outside Food Ordering Frequency vs Mess Satisfaction ---
cat("\n[4/5] Generating Plot 4: Outside Food Tendencies vs Satisfaction...\n")
box_cols <- c("#2b6cb0", "#4299e1", "#63b3ed", "#ed8936", "#e53e3e")

# 4A. Display directly in interactive R Plots pane
boxplot(Overall_Satisfaction ~ Outside_Food_Freq, data = raw_df, col = box_cols, border = "#2d3748",
        main = "Overall Mess Satisfaction vs Outside Food Frequency",
        xlab = "Frequency of Ordering Outside Food", ylab = "Overall Mess Satisfaction (1-5)",
        cex.lab = 1.05, cex.main = 1.15, font.main = 2)

# 4B. Save high-resolution PNG
png("plots/4_outside_food_vs_satisfaction.png", width = 2400, height = 1350, res = 300)
par(mar = c(5, 4.5, 3, 1), bg = "white")
boxplot(Overall_Satisfaction ~ Outside_Food_Freq, data = raw_df, col = box_cols, border = "#2d3748",
        main = "Overall Mess Satisfaction vs Outside Food Frequency",
        xlab = "Frequency of Ordering Outside Food", ylab = "Overall Mess Satisfaction (1-5)",
        cex.lab = 1.05, cex.main = 1.15, font.main = 2)
dev.off()
cat("      -> Saved: plots/4_outside_food_vs_satisfaction.png\n")


# --- PLOT 5: Academic Year of Study vs Mean Satisfaction ---
cat("\n[5/5] Generating Plot 5: Satisfaction Across Study Years...\n")
yr_means <- tapply(raw_df$Overall_Satisfaction, raw_df$Year_of_Study, mean)
yr_cols <- c("#4299e1", "#3182ce", "#2b6cb0", "#2c5282")

# 5A. Display directly in interactive R Plots pane
bp5 <- barplot(yr_means, col = yr_cols, border = NA, ylim = c(0, 5),
               main = "Mean Overall Satisfaction by Year of Study",
               xlab = "Year of Study", ylab = "Mean Satisfaction Score",
               cex.lab = 1.05, cex.main = 1.15, font.main = 2)
text(bp5, yr_means / 2, labels = sprintf("%.2f", yr_means), font = 2, col = "white", cex = 1.1)

# 5B. Save high-resolution PNG
png("plots/5_year_satisfaction.png", width = 2100, height = 1350, res = 300)
par(mar = c(4.5, 4.5, 3, 1), bg = "white")
bp5_png <- barplot(yr_means, col = yr_cols, border = NA, ylim = c(0, 5),
                   main = "Mean Overall Satisfaction by Year of Study",
                   xlab = "Year of Study", ylab = "Mean Satisfaction Score",
                   cex.lab = 1.05, cex.main = 1.15, font.main = 2)
text(bp5_png, yr_means / 2, labels = sprintf("%.2f", yr_means), font = 2, col = "white", cex = 1.1)
dev.off()
cat("      -> Saved: plots/5_year_satisfaction.png\n")


# ------------------------------------------------------------------------------
# STEP 4: DATA MINING & PREDICTIVE MODELING
# ------------------------------------------------------------------------------

# --- 4.1 Multiple Linear Regression ---
cat("\n=======================================================\n")
cat("      STATISTICAL MODEL 1: MULTIPLE LINEAR REGRESSION\n")
cat("=======================================================\n")
reg_model <- lm(Overall_Satisfaction ~ Taste + Quality_Freshness + Variety + Hygiene + Portion_Availability + Staff_Service, data = raw_df)
print(summary(reg_model))

# --- 4.2 Unsupervised K-Means Clustering (Student Personas) ---
cat("\n=======================================================\n")
cat("      DATA MINING MODEL 2: K-MEANS CLUSTERING (k = 3)\n")
cat("=======================================================\n")
set.seed(42)
scaled_features <- scale(num_df)
k_res <- kmeans(scaled_features, centers = 3, nstart = 25)
raw_df$Cluster <- as.factor(k_res$cluster)

cat("\nCluster Membership Sizes:\n")
print(table(raw_df$Cluster))

cluster_profiles <- aggregate(num_df, by = list(Cluster = raw_df$Cluster), FUN = mean)
cluster_profiles[,-1] <- round(cluster_profiles[,-1], 2)
cat("\nCluster Centroid Profiles (Mean Scores):\n")
print(cluster_profiles)

cat("\n=======================================================\n")
cat(" SUCCESS: All 5 plots displayed in RStudio Plots panel!\n")
cat(" All charts exported to 'plots/' folder for PPT & Report.\n")
cat("=======================================================\n")
