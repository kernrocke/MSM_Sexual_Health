
*NOTE: This do file should only be run after running SHS8.do

clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_analysis_001.do
**  Project:      	MSM Sexual Health 
**  Analyst:		Kern Rocke
**	Date Created:	28/07/2019
**	Date Modified: 	22/10/2019
**  Algorithm Task: Data Analysis for EQUALS  & S-Files Presentation


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200



*recategorization was done to age due to the fact of low numbers past age 35
gen age_cat = Howoldareyou
recode age_cat (4=3) (5/max=4)
label var age_cat "Age categories (new)"
label define age_cat 1"18-24" 2"25-29" 3"30-34" 4">35", modify
label value age_cat age_cat
tab age_cat

////////////////////////////////////////////////////////////////////////////////


/*
Objective #2

To determine the prevalence of the use of PrEP among 
gbMSM in Barbados

This would be a simple tabulation. It would be he;lpful to look at this also
using chi square analysis for key variables such as sociodemographics etc. 

*/

//Sociodemographcis
tab age_cat Haveyoueverus~P , col chi2
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
