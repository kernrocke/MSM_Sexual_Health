
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
**	Date Modified: 	27/11/2019
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
*cd "X:/OneDrive - The University of the West Indies"

*MAC OS
local datapath "/Users/kernrocke/OneDrive - The University of the West Indies"
cd "/Users/kernrocke/OneDrive - The University of the West Indies"

*Load encrypted data for analysis
use "`datapath'/MSM Sexual Health/Data/MSM_PrEP_PEP_001.dta", clear

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

////////////////////////////////////////////////////////////////////////////////

*Table 1 - PrEP and PEP Characteristics
tab1 prep_heard - prep_preference


*Table 2 - Sociodemographic Characteristics by PrEP Usage

foreach x in gender_identity sex_identity age_cat_new education income_source  ///
			relationship_status income_source relationship_status income ///
			live_person relationship_type {

tab `x' prep_use, row nofreq chi2
}

*-------------------------------------------------------------------------------

*Bi-variable Logistic regression model loop

foreach x in ib4.sex_identity ib2.gender_identity ib6.education i.income_source ///
				ib6.relationship_status i.age_cat_new i.live_person ///
				ib3.relationship_type{

logistic prep_use `x' , vce(robust)

}


*
/*
Objective #2

To determine the prevalence of the use of PrEP among 
gbMSM in Barbados

This would be a simple tabulation. It would be he;lpful to look at this also
using chi square analysis for key variables such as sociodemographics etc. 

*/

//Sociodemographcis
tab age_cat_new Haveyoueverus~P , col chi2
tab Whatisyourmon~o Haveyoueverus~P , col chi2
tab Whatisthehigh~u Haveyoueverus~P , col chi2
tab Areyou Haveyoueverus~P , col chi2


*Note you can now add which ever variables you would like to add now

////////////////////////////////////////////////////////////////////////////////


/*

Objective 3

To identify if an association exists between these three sociodemographic varibles and PrEP awareness

*/

//PrEP awareness
********************************************************************************

//Bivariable Logistic Regression Models for sociodemographic predictors

*compared to persons over the age of 35
logistic Beforetodayha~f ib4.age_cat, vce(robust)

*Income variable
logistic Beforetodayha~f i.Whatisyourmon~o, vce(robust)

*Education
logistic Beforetodayha~f ib3.Whatisthehigh~u, vce(robust)

*Relationship Status 
logistic Beforetodayha~f ib5.Areyou, vce(robust)

//Multivariable regression model

*All Sociodemographic variables - Relationship Status excluded (you can include if you prefer)
logistic Beforetodayha~f ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u , vce(robust)

********************************************************************************


//PrEP usage
********************************************************************************

//Bivariable Logistic Regression Models for sociodemographic predictors

*compared to persons over the age of 35
logistic Haveyoueverus~P ib4.age_cat, vce(robust)

*Income variable
logistic Haveyoueverus~P i.Whatisyourmon~o, vce(robust)

*Education
logistic Haveyoueverus~P ib3.Whatisthehigh~u, vce(robust)

*Relationship Status
logistic Haveyoueverus~P ib5.Areyou, vce(robust)


//Multivariable regression model

*All Sociodemographic variables - relationship status excluded (you can include if you prefer)
logistic Haveyoueverus~P ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u , vce(robust)

********************************************************************************

////////////////////////////////////////////////////////////////////////////////


/*

Objective 4

 To examine the understanding of overall sexual well-being (sexual behaviour, sexually   transmitted infections (STI) and human immunodeficiency virus (HIV)) in relation to PrEP use among gbMSM in Barbados.

For all independent variables which are used here you need to have in your results a table with the frequency and percentages as you did previously. You can decide which regressions you wish to keep. 
*/

//Bivariable logistic models
logistic Haveyoueverus~P Areyouinarela~h , vce(robust)
logistic Haveyoueverus~P Howmanymenhav~i, vce(robust)
logistic Haveyoueverus~P Inthelastsixm~n, vce(robust)
logistic Haveyoueverus~P Howmanyofyour~e, vce(robust)
logistic Haveyoueverus~P Inthelast6mon~t, vce(robust)
logistic Haveyoueverus~P Inthelastsixm~u, vce(robust)
logistic Haveyoueverus~P DD, vce(robust)
logistic Haveyoueverus~P Inthelast6mon~s, vce(robust)
logistic Haveyoueverus~P Inthelast6mon~a, vce(robust)
logistic Haveyoueverus~P Inthelast12mo~u, vce(robust)
logistic Haveyoueverus~P Haveyoueverha~o, vce(robust)
logistic Haveyoueverus~P Doyouknowyour~s, vce(robust)
logistic Haveyoueverus~P Howfrequently~o, vce(robust)
logistic Haveyoueverus~P Howfrequently~e, vce(robust)
logistic Haveyoueverus~P Inthepastyear~r, vce(robust)


//Multivariable logistic model controlling for age, income and education (Sociodemographics)
logistic Haveyoueverus~P Areyouinarela~h ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Howmanymenhav~i ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthelastsixm~n ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Howmanyofyour~e ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthelast6mon~t ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthelastsixm~u ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P DD ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthelast6mon~s ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthelast6mon~a ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthelast12mo~u ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Haveyoueverha~o ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Doyouknowyour~s ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Howfrequently~o ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Howfrequently~e ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
logistic Haveyoueverus~P Inthepastyear~r ib4.age_cat i.Whatisyourmon~o ib3.Whatisthehigh~u, vce(robust)
