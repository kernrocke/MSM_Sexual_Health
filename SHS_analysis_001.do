
*NOTE: This do file should only be run after running SHS_PrEP_PEP_002

clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_analysis_001.do
**  Project:      	MSM Sexual Health
**	Sub-Project:	Prevalence, Barriers and Facilitators to PrEP and PEP 
**  Analyst:		Kern Rocke
**	Date Created:	28/07/2019
**	Date Modified: 	18/12/2019
**  Algorithm Task: Data Analysis for Manuscript and CARPHA Submission


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

*--------------------------HOUSE KEEPING----------------------------------------
*Recoding variables
recode gender_birth (1=0)
recode sex_identity (3=1)
recode gender_identity (4=3)
label define gender_identity 1"Female" 2"Male" 3"Transgender", modify
label value gender_identity gender_identity

*recategorization was done to age due to the fact of low numbers past age 35
gen age_cat_new = age
recode age_cat_new (4=3) (5/max=4)
label var age_cat_new "Age categories (new)"
label define age_cat_new 1"18-24" 2"25-29" 3"30-34" 4">35", modify
label value age_cat_new age_cat_new
tab age_cat_new
order age_cat_new, after(age_cat)

*recoding PrEP use variable - place missing values as never used
recode prep_use (.=0)

*Recoding income source variable
recode income_source (4/max=3)
label define income_source 1"Employed full-time" 2"Employed part-time" ///
							3"Financial support (family/partner)", modify
label value income_source income_source

*Create living with family variable
gen live_person = .
replace live_person = 1 if live_alone == 1
replace live_person = 2 if live_father == 1
replace live_person = 2 if live_mother == 1
replace live_person = 2 if live_grand == 1
replace live_person = 2 if live_family_other == 1
replace live_person = 3 if live_spouse == 1
replace live_person = 4 if live_friend == 1
label var live_person "Live with family"
label define live_person 	1"Alone" ///
							2"Family (mother/father/grandparent/other family member" ///
							3"Spouse" ///
							4"Friend"
label value live_person live_person
order live_person, after(religion)

recode relationship_status (1=5) (7=5)
recode relationship_type (5=2)

*Loop for recoding barriers and facilitators
foreach x in barrier_cost barrier_side_effect barrier_finding_out ///
				barrier_time_med barrier_stigma barrier_attitude_staff ///
				barrier_risk_STI Whatisimportanttoyouwhenge prep_import_facilate  ///
				{

replace `x' = 0 if prep_use==1 & `x'==.

}

*Recoding pep_use variable
recode pep_use (.=0)
recode pep_use (1=0) (2=1)
label define pep_use 0"No" 1"yes", modify
label value pep_use pep_use

*Setting up export of results to Excel file
putexcel set "`datapath'/MSM Sexual Health/Data/SHS_Results.xlsx", replace

////////////////////////////////////////////////////////////////////////////////

*Open log file for storing of analysis results
*log using "`logpath'/MSM Sexual Health/Results/Table_1.log"

*TABLE 1 PrEP and PEP CHARACTERISTICS PREVALENCE ESTIMATES

*PrEP characteristics
proportion prep_use, percent cformat(%2.1f)
proportion prep_heard, percent cformat(%2.1f)
proportion prep_current, percent cformat(%2.1f)
proportion prep_time, percent cformat(%2.1f)
proportion prep_freq, percent cformat(%2.1f)
proportion prep_length, percent cformat(%2.1f)
proportion prep_condom, percent cformat(%2.1f)
proportion prep_location, percent cformat(%2.1f)
proportion prep_preference, percent cformat(%2.1f)
proportion condom_freq, percent cformat(%2.1f)

*Barriers characteristics
proportion barrier_cost - barrier_risk_STI, percent cformat(%2.1f)

*Facilitators charactertistics
proportion Whatisimportanttoyouwhenge, percent cformat(%2.1f)
proportion prep_import_facilate, percent cformat(%2.1f)

*PEP characteristics
proportion pep_hear, percent cformat(%2.1f)
proportion pep_use, percent cformat(%2.1f)

*Close log file
*log close

////////////////////////////////////////////////////////////////////////////////

*Open log file for storing of analysis results
*log using "`logpath'/MSM Sexual Health/Results/Table_2.log"

*Table 2 - Sociodemographic Characteristics by PrEP Usage

foreach x in gender_identity sex_identity age_cat_new education income_source  ///
			relationship_status income_source relationship_status income ///
			live_person relationship_type {

tab `x' prep_heard, row nofreq chi2
*-------------------------------------------------------------------------------
tab `x' prep_use, row nofreq chi2
*-------------------------------------------------------------------------------
tab `x' pep_hear, row nofreq chi2
*-------------------------------------------------------------------------------
tab `x' pep_use, row nofreq chi2
*-------------------------------------------------------------------------------
}

*-------------------------------------------------------------------------------

*Bi-variable Logistic regression model loop

foreach x in ib4.sex_identity ib2.gender_identity ib6.education i.income_source ///
				ib6.relationship_status i.age_cat_new i.live_person ///
				ib3.relationship_type {

logistic prep_use `x' , vce(robust)
logistic pep_use `x', vce(robust)
}

*Close log file
*log close

////////////////////////////////////////////////////////////////////////////////

*Open log file for storing of analysis results
*log using "`logpath'/MSM Sexual Health/Results/Table_3.log"

*Table 3: MULTIVARIABLE LOGISTIC REGRESSION MODEL (FINAL)
*-------------------------------------------------------------------------------
*PrEP
*Multi-variable binary logistic regression (Socio-demographic Predictors)
logistic prep_use ib4.sex_identity ib2.gender_identity ib6.education i.income_source	///
			ib6.relationship_status i.age_cat_new i.live_person 	///
			, vce(robust) pformat(%4.3f) cformat(%4.2f)
			
putexcel set "`datapath'/MSM Sexual Health/Data/SHS_Results.xlsx", sheet("PrEP Model") modify
matrix a = r(table)
matrix a = a[.,1..21]
putexcel A8= matrix(a, names)

*-------------------------------------------------------------------------------
*PEP
*Multi-variable binary logistic regression (Socio-demographic Predictors)
logistic pep_use prep_use ib4.sex_identity ib2.gender_identity ib6.education i.income_source	///
			ib6.relationship_status i.age_cat_new i.live_person 	///
			, vce(robust) pformat(%4.3f) cformat(%4.2f)

putexcel set "`datapath'/MSM Sexual Health/Data/SHS_Results.xlsx", sheet("PEP Model") modify
matrix a = r(table)
matrix a = a[.,1..21]
putexcel A8= matrix(a, names)

*-------------------------------------------------------------------------------
*Close log file
*log close

*Save data in encrypted location
save "`datapath'/MSM Sexual Health/Data/MSM_PrEP_PEP_002.dta", replace

*------------------------------------END----------------------------------------
