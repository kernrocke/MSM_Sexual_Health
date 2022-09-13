clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_analysis_007.do
**  Project:      	MSM Sexual Health
**	Sub-Project:	Prevalence, Barriers and Facilitators to PrEP and PEP 
**  Analyst:		Kern Rocke
**	Date Created:	04/01/2021
**	Date Modified: 	04/01/2021
**  Algorithm Task: Manuscript Results


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

*Load encrypted data for analysis
use "`datapath'/Manuscripts/MSM Sexual Health/Data/MSM_PrEP_PEP_003.dta", clear

*-------------------------------------------------------------------------------

*Clean income variable
gen income_new = .
replace income_new = 1 if income == 4
replace income_new = 2 if income == 1
replace income_new = 3 if income == 2 | income == 3
replace income_new = 4 if income == 5
label var income_new "Monthly Income"
label define income_new 1"Less than 1500" 2"1500-2500" 3"2501-4500" 4"More than 4500"
label value income_new income_new

*Table 1- Sociodemographic characteristics of study participants 

foreach x in age_cat gender_identity sex_identity education income_new ///
			 income_source relationship_status {
	
	tab `x'
	}
*-------------------------------------------------------------------------------	

*Figure 1 - PreP awareness and use among pariticpants in the entire sample.

foreach x in prep_current prep_use prep_heard {

	tab `x'
	}
*-------------------------------------------------------------------------------	

*Table 2 - Sexual behaviour and drug use behaviour among used for the HIRI-MSM 

foreach x in hiri_cat msm_sex_amt anal_sex_receptive Howmanyofyourmalesexpartne ///
			 anal_sex_insertive Inthelastsixmonthshaveyou drug_popper{
			 
		tab `x'
		}
*-------------------------------------------------------------------------------	

*Table 3 - PrEP procurement and use among current versus former PrEP users 

gen prep_pro = .
replace prep_pro = 2 if prep_use == 1
replace prep_pro = 1 if prep_current == 1

label var prep_pro "PrEP Procurement"
label define prep_pro 1"Current PrEP user" 2"Former PrEP users"
label value prep_pro prep_pro

gen prep_freq_new = .
replace prep_freq_new = 1 if prep_freq == 1 | prep_freq_current ==1 //1-2 times weekly
replace prep_freq_new = 2 if prep_freq == 2 | prep_freq_current ==2 //3-4 times weekly
replace prep_freq_new = 3 if prep_freq == 3 | prep_freq_current ==3 //Before and after sex
replace prep_freq_new = 4 if prep_freq == 5 | prep_freq_current ==4 //Daily

label var prep_freq_new "PrEP Frequency"
label define prep_freq_new 1"1-2 times weekly" 2"3-4 times weekly" 3"Before and after sex" 4"Daily"
label value prep_freq_new prep_freq_new

gen prep_location_new = .
replace prep_location_new = 1 if prep_location == 1 | prep_location_current == 1 // friend
replace prep_location_new = 2 if prep_location == 4 | prep_location_current == 3 // PrEP program
replace prep_location_new = 3 if prep_location == 2 | prep_location_current == 2 // Other

label var prep_location_new "PrEP Location"
label define prep_location_new 1"Friend" 2"PrEP program" 3"Other"
label value prep_location_new prep_location_new

foreach x in prep_time prep_length prep_freq_new prep_location_new{
			
			proportion `x', over(prep_pro) cformat(%9.3f)
			}
*-------------------------------------------------------------------------------

*Table 4 - Bivariable Logistic Regressions for sociodemographic associations to PrEP use (Current and Former)

foreach x in ib4.education i.income_source ib6.relationship_status i.age_cat ///
			 i.live_person ib4.sex_identity {
			 
			 logistic prep_use `x', vce(robust) cformat(%9.2f)
			 }
*-------------------------------------------------------------------------------		 
			 
gen male_partner =. 
replace male_partner = 2 if Inthelast6monthshowmanys != 1 & Inthelast6monthshowmanys != 5 & Inthelast6monthshowmanys != .
replace male_partner = 0 if Inthelast6monthshowmanys == 5
replace male_partner = 1 if Inthelast6monthshowmanys == 1

*-------------------------------------------------------------------------------

gen prep_cat =.
replace prep_cat = 0 if prep_use == 0
replace prep_cat = 2 if prep_current == 1
replace prep_cat = 1 if prep_use == 1 & prep_current == 0
label define prep_cat 0"None prep user" 1"Former prep user" 2"Current prep user"
label value prep_cat prep_cat

gen live_person_new = live_person
recode live_person_new (3=2)
label define live_person_new 1"Live alone" 2"Live with family/spouse" 4"Live with friend"
label value live_person_new live_person_new
tab live_person_new

*Table 5 - Bivariable Logistic Regressions for sociodemographic associations to PrEP use (Former vs Current)
cls
foreach x in ib4.education i.income_source ib6.relationship_status i.age_cat ///
			 i.live_person_new ib4.sex_identity {
			 
			 mlogit prep_cat `x', vce(robust) cformat(%9.2f) rrr nolog
			 }
