clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_PrEP_PEP_004.do
**  Project:      	Sexual Health Survey
**	Sub-Project:	Sexual Well-being and PrEP
**  Analyst:		Kern Rocke
**	Date Created:	19/02/2020
**	Date Modified: 	19/02/2020
**  Algorithm Task: APHA Research Conference Analysis


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
local logpath "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies"
cd "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies/Manuscripts/MSM Sexual Health/Results"

*Open log file
log using "`logpath'/Manuscripts/MSM Sexual Health/APHA Conference/MSM_PrEP_PEP_004.log", replace

*-----------------------------BEGIN---------------------------------------------

*Load encrypted data for analysis
use "`datapath'/Manuscripts/MSM Sexual Health/Data/MSM_PrEP_PEP_002.dta", clear

/*
ANALYSIS NOTE from Eden Augustus

To cross tab question 58 - 64 (STI/HIV testing) with 14 and 15 (current use and history of use)

*/

*Create variable for STI test type
gen test_sti_type = .
replace test_sti_type = 1 if test_syphillis==1
replace test_sti_type = 2 if test_gonorrhoea==1
replace test_sti_type = 3 if test_chlamydia==1
replace test_sti_type = 4 if test_lymphog==1
replace test_sti_type = 5 if test_htlv1==1
replace test_sti_type = 6 if test_htlv2==1
replace test_sti_type = 7 if test_hepB==1
replace test_sti_type = 8 if test_hepC==1

label var test_sti_type "STI Test Type"
label define test_sti_type 1"Syphillis" 2"Gonorrhoea" 3"Chlamydia" 4"Lymphod" ///
							5"Htlv1" 6"Htlv2" 7"Hep B" 8"Hep C"
label value test_sti_type test_sti_type

tab test_sti_type





*Tabulation loop for STI and HIV testing by PrEP Characteristics
foreach x in Inthelast12monthshaveyou Wasthetest test_syphillis test_gonorrhoea ///
			test_chlamydia test_lymphog test_htlv1 test_htlv2 test_hepB ///
			test_hepC HaveyoueverhadaHumanImmuno Howoftendoyougettestedfor ///
			DoyouknowyourHIVstatus sti_prep test_sti_type{

tab `x' prep_use, col chi2
tab `x' prep_current, col chi2 
tab `x' prep_time , col chi2


	}

	
	
*Selecting those who are currently on the PrEP program

preserve
keep if prep_location_current==3

foreach x in Inthelast12monthshaveyou Wasthetest test_syphillis test_gonorrhoea ///
			test_chlamydia test_lymphog test_htlv1 test_htlv2 test_hepB ///
			test_hepC HaveyoueverhadaHumanImmuno Howoftendoyougettestedfor ///
			DoyouknowyourHIVstatus sti_prep test_sti_type{
			
tab `x'

}

restore

/*
Note: There are no observations for those on the PrEP programme who confirmed 
		for any sti test (syphillis gonorrhoea chlamydia lymphog htlv1 htlv2 
		Hep B Hep C

	
*Close log file
log close
*-----------------------------END-----------------------------------------------


