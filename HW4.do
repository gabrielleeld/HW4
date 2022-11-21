** import data 
import excel "/Users/gel2132/Downloads/crime-iv.xlsx", sheet("crime-iv") firstrow clear

**balance table
estpost ttest SeverityOfCrime MonthsInJail Recidivates, by(RepublicanJudge) unequal welch

esttab . using "regressiontabell33.rtf", cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels ("Control" "Treatment" "Difference") noobs

**first stage
reg SeverityOfCrime RepublicanJudge
estimates store m1
reg SeverityOfCrime RepublicanJudge MonthsInJail
estimates store m2

esttab m1 m2 using "regressiontabell35.rtf", se r2 ar2 replace

**reduced form
reg RepublicanJudge Recidivates
estimates store m3
reg RepublicanJudge Recidivates MonthsInJail
estimates store m4
esttab m3 m4 using "regressiontabell36.rtf", se r2 ar2 replace

**install iv package
ssc install ivreg2

**IV (2SLS) estimation
ivreg2 Recidivates (SeverityOfCrime=RepublicanJudge) MonthsInJail
estimates store m5
esttab m5 using "regressiontabell37.rtf", se r2 ar2 replace


