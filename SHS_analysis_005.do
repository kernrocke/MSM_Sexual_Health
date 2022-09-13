clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_analysis_005.do
**  Project:      	MSM Sexual Health
**	Sub-Project:	Prevalence, Barriers and Facilitators to PrEP and PEP 
**  Analyst:		Kern Rocke
**	Date Created:	15/06/2020
**	Date Modified: 	04/01/2021
**  Algorithm Task: Table 5 for Manuscript Submissin


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

cls
preserve
*People currently on prep and people who never used prep

gen prep_useage = .
replace prep_useage = 1 if  prep_heard == 1 & prep_use == 1 & prep_current == 1  // Currently on prep
replace prep_useage = 0 if prep_heard == 1 & prep_use == 0 // Aware of prep but never used

label var prep_useage "PrEP Usage"
label define prep_useage 1"Currently on prep" 0 "Aware of prep but never used"
label value prep_useage prep_useage


* Run sociodemographics
foreach x in gender_identity sex_identity age_cat_new education income_source  ///
			relationship_status income_source relationship_status income ///
			live_person relationship_type {
			
tab `x' prep_useage, row nofreq chi2
*-------------------------------------------------------------------------------
}
restore

*-------------------------------------------------------------------------------

*Save dataset
save "`datapath'/Manuscripts/MSM Sexual Health/Data/MSM_PrEP_PEP_003.dta", replace

*-------------------------------------------------------------------------------
