
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_analysis_006.do
**  Project:      	MSM Sexual Health
**	Sub-Project:	Prevalence, Barriers and Facilitators to PrEP and PEP 
**  Analyst:		Kern Rocke
**	Date Created:	02/08/2020
**	Date Modified: 	02/08/2020
**  Algorithm Task: Calculation of the HIRI MSM Index


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 150

*Setting working directory
** Dataset to encrypted location

*WINDOWS OS
*local datapath "X:/OneDrive - The University of the West Indies"
*local logpath "X:/OneDrive - The University of the West Indies"
*cd "X:/OneDrive - The University of the West Indies"

*MAC OS
local datapath "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies"
cd "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies"

*Load encrypted data for analysis
use "`datapath'/Manuscripts/MSM Sexual Health/Data/MSM_PrEP_PEP_001.dta", clear


*-------------------------------------------------------------------------------

*Age
gen hiri_age = .
replace hiri_age = 8 if age == 1 | age == 2
replace hiri_age = 5 if age == 3 | age == 4
replace hiri_age = 2 if age == 5
replace hiri_age = 0 if age >= 6

*How many men have you had sex with in the last 6 months
gen hiri_sex6 = .
replace hiri_sex6 = 7 if msm_sex_amt >10
replace hiri_sex6 = 4 if msm_sex_amt >=6 & msm_sex_amt <=10
replace hiri_sex6 = 0 if msm_sex_amt <=5

*In the last 6 months how many time did you have receptive anal sex with a man?
gen hiri_anal = . 
replace hiri_anal = 10 if anal_sex_receptive >1
replace hiri_anal = 0 if anal_sex_receptive == 1

*How many of your male sex partners were HIV positive?
gen hiri_hiv_positive = . 
replace hiri_hiv_positive = 8 if Howmanyofyourmalesexpartne >= 3
replace hiri_hiv_positive = 4 if Howmanyofyourmalesexpartne == 2
replace hiri_hiv_positive = 0 if Howmanyofyourmalesexpartne == 1

*In the last 6 months how mnay times did you have insertive anal sex with a man who was HIV positive?
gen hiri_insertive = .
replace hiri_insertive = 6 if anal_sex_insertive >= 2
replace hiri_insertive = 0 if anal_sex_insertive == 1

*In the last 6 months, have you used methamphetamines such as crystal or speed?
gen hiri_crystal = . 
replace hiri_crystal = 5 if Inthelastsixmonthshaveyou == 2
replace hiri_crystal = 0 if Inthelastsixmonthshaveyou == 1

*In the last 6 months, have you used poppers (amyl nitrate)?
gen hiri_poppers = .
replace hiri_poppers = 3 if drug_popper == 2
replace hiri_poppers = 0 if drug_popper == 1

** HIRI MSM Index
egen hiri_msm = rowtotal(hiri_age hiri_sex6 hiri_anal hiri_hiv_positive hiri_insertive hiri_crystal hiri_poppers)
label var hiri_msm "HIRI MSM Index"

*HIRI MSM Index categories
gen hiri_cat = . 
replace hiri_cat = 0 if hiri_msm <10
replace hiri_cat = 1 if hiri_msm >=10
label var hiri_cat "HIRI MSM Index Categories"
label define hiri_cat 0"Standard HIV preventation services" ///
					  1"Evaluate for PrEP or other intensive HIV prevention services"
label value hiri_cat hiri_cat

*-------------------------------------------------------------------------------
cls
*Descriptives
tabstat hiri_msm, stat(mean sd median min max)
tab hiri_cat
proportion hiri_cat


*-------------------------------------------------------------------------------











