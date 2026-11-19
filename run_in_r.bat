@echo off
echo ========================================================
echo Running Hostel Food Satisfaction R Script...
echo ========================================================

cd /d "%~dp0"

if exist "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" (
    "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" hostel_food_satisfaction_analysis.R
    goto done
)

where Rscript >nul 2>nul
if %errorlevel% equ 0 (
    Rscript hostel_food_satisfaction_analysis.R
    goto done
)

echo ERROR: Rscript.exe not found on your system!
echo Please make sure R is installed.
pause
exit /b 1

:done
echo.
echo ========================================================
echo SUCCESS! Plots are generated in the "plots" folder:
echo - plots\1_satisfaction_dist.png
echo - plots\2_correlation_heatmap.png
echo - plots\3_attribute_means.png
echo - plots\4_outside_food_vs_satisfaction.png
echo - plots\5_year_satisfaction.png
echo ========================================================
pause
