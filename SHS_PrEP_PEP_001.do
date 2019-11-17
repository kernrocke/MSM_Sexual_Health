
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_PrEP_PEP_001.do
**  Project:      	Sexual Health Survey
**	Sub-Project:	PrEP and PEP Facilitators and Barriers
**  Analyst:		Kern Rocke
**	Date Created:	16/11/2019
**	Date Modified: 	17/11/2019
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

/// SECTION 1: DEMOGRAPHICS ////
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

encode Whatisyourmonthlyincomeallo , gen(Whatisyourmonthlyincomeallo1)
order Whatisyourmonthlyincomeallo1, after(Areyou)
drop Whatisyourmonthlyincomeallo
rename Whatisyourmonthlyincomeallo1 Whatisyourmonthlyincomeallo
replace Whatisyourmonthlyincomeallo = 2 if AL != ""
replace Whatisyourmonthlyincomeallo = 3 if AM != ""
replace Whatisyourmonthlyincomeallo = 4 if AN != ""
replace Whatisyourmonthlyincomeallo = 5 if AO != ""
label define Whatisyourmonthlyincomeallo 1"Less than 1500" 2"1500-2500" ///
										3"2501-3500" 4"3501-4500" ///
										5"More than 4500", modify
label value Whatisyourmonthlyincomeallo Whatisyourmonthlyincomeallo
drop AL AM AN AO

encode Howoldareyou , gen(Howoldareyou1)
order Howoldareyou1, after(Whatisyourmonthlyincomeallo)
drop Howoldareyou
rename Howoldareyou1 Howoldareyou
replace Howoldareyou = 2 if AQ != ""
replace Howoldareyou = 3 if AR != ""
replace Howoldareyou = 4 if AS != ""
replace Howoldareyou = 5 if AT != ""
replace Howoldareyou = 6 if AU != ""
replace Howoldareyou = 7 if AV != ""
replace Howoldareyou = 8 if AW != ""
replace Howoldareyou = 9 if AX != ""
replace Howoldareyou = 10 if AY != ""
replace Howoldareyou = 11 if AZ != ""
label define Howoldareyou 1"18-24" 2"25-29" 3"30-34" 4"35-39" 5"40-50" ///
							6"51-60" 6"61-64" 7"65-69" 8"70-74" 9"75-79" ///
							10"80-84" 11"85 and older", modify
label value Howoldareyou Howoldareyou
drop AQ AR AS AT AU AV AW AX AY AZ

encode Whatisyourresidencestatusin, gen(Whatisyourresidencestatusin1)
order Whatisyourresidencestatusin1, after(Howoldareyou)
drop Whatisyourresidencestatusin
rename Whatisyourresidencestatusin1 Whatisyourresidencestatusin
replace Whatisyourresidencestatusin = 2 if BB != ""
replace Whatisyourresidencestatusin = 3 if BC != ""
label define Whatisyourresidencestatusin 1"I am a citizen or permanent resident" ///
										2"I am a student here"  ///
										3"I am a visitor", modify
label value Whatisyourresidencestatusin Whatisyourresidencestatusin
drop BB BC

encode HowlonghaveyoubeeninBarbad, gen(HowlonghaveyoubeeninBarbad1)
order HowlonghaveyoubeeninBarbad1, after(Whatisyourresidencestatusin)
drop HowlonghaveyoubeeninBarbad
rename HowlonghaveyoubeeninBarbad1 HowlonghaveyoubeeninBarbad
replace HowlonghaveyoubeeninBarbad = 2 if BE != ""
replace HowlonghaveyoubeeninBarbad = 3 if BF != ""
replace HowlonghaveyoubeeninBarbad = 4 if BG != ""
label define HowlonghaveyoubeeninBarbad 1"Less than 2 weeks" ///
										2"2 weeks to 3 months"  ///
										3"3 months to 1 year" ///
										4"more than 1 year", modify
label value HowlonghaveyoubeeninBarbad HowlonghaveyoubeeninBarbad
drop BE BF BG

encode Howoftendoyouattendreligiou, gen(Howoftendoyouattendreligiou1)
order Howoftendoyouattendreligiou1, after(HowlonghaveyoubeeninBarbad)
drop Howoftendoyouattendreligiou
rename Howoftendoyouattendreligiou1 Howoftendoyouattendreligiou
replace Howoftendoyouattendreligiou = 2 if BI != ""
replace Howoftendoyouattendreligiou = 3 if BJ != ""
replace Howoftendoyouattendreligiou = 4 if BK != ""
label define Howoftendoyouattendreligiou 1"Never" ///
										2"Once a week or more often"  ///
										3"Once or twice a month" ///
										4"A few times a year", modify
label value Howoftendoyouattendreligiou Howoftendoyouattendreligiou
drop BI BJ BK

*Loop for multiple response
foreach x in BS BR BQ BP BO BN BM WithwhomdoyouliveTickall  {

encode `x', gen(`x'1)
recode `x'1 (.=0)
drop `x'
order `x'1, after(Howoftendoyouattendreligiou)
label define `x'1 0"Not selected", add
label value `x'1 `x'1
rename `x'1 `x'
	}
rename WithwhomdoyouliveTickall live_alone
label var live_alone "Live alone"
rename BM live_mother
label var live_mother "Live with mother"
rename BN live_father
label var live_father "Live with father"
rename BO live_grand_parent
label var live_grand_parent "Live with grand parent"
rename BP live_other_family
label var live_other_family "Live with Other Family"
rename BQ live_spouse
label var live_spouse "Live with Spouse"
rename BR live_friends
label var live_friends "Live with Friends"
rename BS live_partner
label var live_partner "Live with partner"

////////////////////////////////////////////////////////

/// SECTION 2: PrEP Awareness /////////

encode Beforetodayhaveyouheardof, gen(Beforetodayhaveyouheardof1)
order Beforetodayhaveyouheardof1, after(live_partner)
drop Beforetodayhaveyouheardof
rename Beforetodayhaveyouheardof1 Beforetodayhaveyouheardof
recode Beforetodayhaveyouheardof (1=0)
replace Beforetodayhaveyouheardof = 1 if BU != ""
label define Beforetodayhaveyouheardof 0"No" 1"Yes", modify
label value Beforetodayhaveyouheardof Beforetodayhaveyouheardof
drop BU

encode HaveyoueverusedPrEP, gen(HaveyoueverusedPrEP1)
order HaveyoueverusedPrEP1, after(Beforetodayhaveyouheardof)
drop HaveyoueverusedPrEP
rename HaveyoueverusedPrEP1 HaveyoueverusedPrEP
recode HaveyoueverusedPrEP (1=0)
replace HaveyoueverusedPrEP = 1 if BW != ""
label define HaveyoueverusedPrEP 0"No" 1"Yes", modify
label value HaveyoueverusedPrEP HaveyoueverusedPrEP
drop BW

encode AreyoucurrentlyonPrEP, gen(AreyoucurrentlyonPrEP1)
order AreyoucurrentlyonPrEP1, after(HaveyoueverusedPrEP)
drop AreyoucurrentlyonPrEP
rename AreyoucurrentlyonPrEP1 AreyoucurrentlyonPrEP
recode AreyoucurrentlyonPrEP (1=0)
replace AreyoucurrentlyonPrEP = 1 if BY != ""
label define AreyoucurrentlyonPrEP 0"No" 1"Yes", modify
label value AreyoucurrentlyonPrEP AreyoucurrentlyonPrEP
drop BY

encode HowlongwereyouonPrEP, gen(HowlongwereyouonPrEP1)
order HowlongwereyouonPrEP1, after(HaveyoueverusedPrEP)
drop HowlongwereyouonPrEP
rename HowlongwereyouonPrEP1 HowlongwereyouonPrEP
replace HowlongwereyouonPrEP = 2 if CA != ""
replace HowlongwereyouonPrEP = 3 if CB != ""
replace HowlongwereyouonPrEP = 4 if CC != ""
label define HowlongwereyouonPrEP 1"Less than 3 months" ///
									2"3 months to 6 months" ///
									3"7 months to 1 year" ///
									4"more than 1 year", modify
label value HowlongwereyouonPrEP HowlongwereyouonPrEP
drop CA CB CC

encode WhydidyoustopusingPrEPtic, gen(WhydidyoustopusingPrEPtic1)
order WhydidyoustopusingPrEPtic1, after(HowlongwereyouonPrEP)
drop WhydidyoustopusingPrEPtic
rename WhydidyoustopusingPrEPtic1 WhydidyoustopusingPrEPtic
replace WhydidyoustopusingPrEPtic = 2 if CE != ""
replace WhydidyoustopusingPrEPtic = 3 if CF != ""
replace WhydidyoustopusingPrEPtic = 4 if CG != ""
replace WhydidyoustopusingPrEPtic = 5 if CH != ""
replace WhydidyoustopusingPrEPtic = 6 if CI != ""
label define WhydidyoustopusingPrEPtic 1"Cost" ///
										2"Side-effects" ///
										3"Someone finding out I was taking it" ///
										4"Time spent in order to get the medication" ///
										5"?" ///
										6"Other", modify										
label value WhydidyoustopusingPrEPtic WhydidyoustopusingPrEPtic
drop CE CF CG CH CI

encode HowoftendidyouusePrEP, gen(HowoftendidyouusePrEP1)
order HowoftendidyouusePrEP1, after(WhydidyoustopusingPrEPtic)
drop HowoftendidyouusePrEP
rename HowoftendidyouusePrEP1 HowoftendidyouusePrEP
replace HowoftendidyouusePrEP = 2 if CK != ""
replace HowoftendidyouusePrEP = 3 if CL != ""
replace HowoftendidyouusePrEP = 4 if CM != ""
replace HowoftendidyouusePrEP = 5 if CN != ""
replace HowoftendidyouusePrEP = 6 if CO != ""
replace HowoftendidyouusePrEP = 7 if CP != ""
label define WhydidyoustopusingPrEPtic 1"Daily" ///
										2"1-2 times weekly" ///
										3"3-4 times weekly" ///
										4"5-6 times weekly" ///
										5"Before and after sex" ///
										6"?" ///
										7"?", modify
label value WhydidyoustopusingPrEPtic WhydidyoustopusingPrEPtic
drop CK CL CM CN CO CP

encode WheredidyougetPrEP, gen(WheredidyougetPrEP1)
order WheredidyougetPrEP1, after(WheredidyougetPrEP)
drop WheredidyougetPrEP
rename WheredidyougetPrEP1 WheredidyougetPrEP
replace WheredidyougetPrEP = 2 if CR != ""
replace WheredidyougetPrEP = 3 if CS != ""
replace WheredidyougetPrEP = 4 if CT != ""
replace WheredidyougetPrEP = 5 if CU != ""
label define WheredidyougetPrEP 1"?" ///
									2"PrEP program in Barbados" ///
									3"?" ///
									4"Friend" ///
									5"Other" , modify
label value WheredidyougetPrEP WheredidyougetPrEP
drop CR CS CT CU


