
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_PrEP_PEP_001.do
**  Project:      	Sexual Health Survey
**	Sub-Project:	PrEP and PEP Facilitators and Barriers
**  Analyst:		Kern Rocke
**	Date Created:	16/11/2019
**	Date Modified: 	16/11/2019
**  Algorithm Task: Data Cleaning


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 150


*Setting working directory
** Dataset to encrypted location
/*
WINDOWS OS
local datapath "X:/OneDrive - The University of the West Indies"
*/
*MAC OS
local datapath "/Users/kernrocke/OneDrive - The University of the West Indies"
*local datapath "X:/The University of the West Indies/DataGroup - repo_data/data_p145"
cd "/Users/kernrocke/OneDrive - The University of the West Indies"



//Note: This algorithm is meant to clean raw data exported from Survey Monkey

*Load in SHS Survey Data
import excel "`datapath'/MSM Sexual Health/Data/Copy of Sexual Health Survey SHS 2019-CDR-4TWZB62.xlsx", sheet("Sheet") firstrow allstring clear


destring RespondentID, replace

drop CollectorID-CustomData1
encode Whatgenderwereyouassignedat, gen(Whatgenderwereyouassignedat1)
order Whatgenderwereyouassignedat1, after(RespondentID)
drop Whatgenderwereyouassignedat
rename Whatgenderwereyouassignedat1 Whatgenderwereyouassignedat
replace Whatgenderwereyouassignedat = 2 if J == "Male"
label define Whatgenderwereyouassignedat 1"Female" 2"Male", modify
label value Whatgenderwereyouassignedat Whatgenderwereyouassignedat
drop J

encode Whatgenderdoyouidentifyas, gen(Whatgenderdoyouidentifyas1)
order Whatgenderdoyouidentifyas1, after(Whatgenderwereyouassignedat)
drop Whatgenderdoyouidentifyas
rename Whatgenderdoyouidentifyas1 Whatgenderdoyouidentifyas
replace Whatgenderdoyouidentifyas = 2 if L == "Male"
replace Whatgenderdoyouidentifyas = 3 if M == "Transfemale"
replace Whatgenderdoyouidentifyas = 4 if N == "Transman"
label define Whatgenderdoyouidentifyas 1"Female" 2"Male" 3"Trans-Female" ///
										4"Trans-Male", modify
label value Whatgenderdoyouidentifyas Whatgenderdoyouidentifyas
drop L M N

encode HowdoyoudefineyourselfIn, gen(HowdoyoudefineyourselfIn1)
order HowdoyoudefineyourselfIn1, after(Whatgenderdoyouidentifyas)
drop HowdoyoudefineyourselfIn
rename HowdoyoudefineyourselfIn1 HowdoyoudefineyourselfIn
replace HowdoyoudefineyourselfIn = 2 if P != ""
replace HowdoyoudefineyourselfIn = 3 if Q != ""
replace HowdoyoudefineyourselfIn = 4 if R != ""
label define HowdoyoudefineyourselfIn 1"Straight or heterosexual" ///
										2"Gay or homosexual" 3"Bisexual" ///
										4"Other", modify
label value HowdoyoudefineyourselfIn HowdoyoudefineyourselfIn
drop P Q R

encode Whatisthehighestlevelofedu , gen(Whatisthehighestlevelofedu1)
order Whatisthehighestlevelofedu1, after(HowdoyoudefineyourselfIn)
drop Whatisthehighestlevelofedu
rename Whatisthehighestlevelofedu1 Whatisthehighestlevelofedu
replace Whatisthehighestlevelofedu = 2 if T != ""
replace Whatisthehighestlevelofedu = 3 if U != ""
replace Whatisthehighestlevelofedu = 4 if V != ""
replace Whatisthehighestlevelofedu = 4 if W != ""
replace Whatisthehighestlevelofedu = 4 if X != ""
label define Whatisthehighestlevelofedu 1"Primary" 2"Secondary School" ///
										3"Diploma/Associate Degree" 3"Undergraduate" ///
										4"Postgraduate", modify
label value Whatisthehighestlevelofedu Whatisthehighestlevelofedu
drop T U V W X

encode Howdoyousupportyourself , gen(Howdoyousupportyourself1)
order Howdoyousupportyourself1, after(Whatisthehighestlevelofedu)
drop Howdoyousupportyourself
rename Howdoyousupportyourself1 Howdoyousupportyourself
replace Howdoyousupportyourself = 2 if Z != ""
replace Howdoyousupportyourself = 3 if AA != ""
replace Howdoyousupportyourself = 4 if AB != ""
replace Howdoyousupportyourself = 5 if AC != ""
label define Howdoyousupportyourself 1"I am employed full time" ///
										2"I am employed part time" ///
										3"My parents support me" ///
										4"My partner supports me" ///
										5"Other", modify
label value Howdoyousupportyourself Howdoyousupportyourself
drop Z AA AB AC

encode Areyou , gen(Areyou1)
order Areyou1, after(Howdoyousupportyourself)
drop Areyou
rename Areyou1 Areyou
replace Areyou = 2 if AE != ""
replace Areyou = 3 if AF != ""
replace Areyou = 4 if AG != ""
replace Areyou = 5 if AH != ""
replace Areyou = 6 if AI != ""
replace Areyou = 7 if AJ != ""
label define Areyou 1"Single" 2"Married" 3"Divorced" 4"Widowed" ///
					5"In a common-law union" 6"In partnership" 7"Other", modify
label value Areyou Areyou
drop AE AF AG AH AI AJ





browse







