
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS8.do
**  Project:      	MSM Sexual Health
**  Analysts:		Eden Augustus & Kern Rocke
**	Date Created:	28/07/2019
**	Date Modified: 	22/10/2019
**  Algorithm Task: Data Cleaning


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 200

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


import excel "`datapath'/MSM Sexual Health/Data/Sexual Health Survey SHS 2019.xlsx", sheet("Sheet") firstrow clear
label data "The Sexual Health Survey 2019"
label variable RespondentID "Unique Participant Identifier"
order RespondentID, before(Whatgenderwereyouassignedat)
label variable Whatgenderwereyouassignedat "Gender at birth "
label variable Whatgenderdoyouidentifyas "Identifying gender"
label variable HowdoyoudefineyourselfIn "Sexuality"
label variable Whatisthehighestlevelofedu "Education level "
label variable Howdoyousupportyourself "Source of income"
label variable Areyou "Relationship status "
label variable Whatisyourmonthlyincomeallo "Monthly income (Bds)"
label variable Howoldareyou "Age"
label variable Whatisyourresidencestatusin " Residence status"
label variable HowlonghaveyoubeeninBarbad "Length of residence "
label variable Howoftendoyouattendreligiou "Religious service attendence"
label variable WithwhomdoyouliveTickall "Live alone"
label variable Q "Live with mother "
label variable R "Live with father"
label variable S "Grandparents"
label variable T "Other family members"
label variable U "Spouse"
label variable V "With friends"
label variable W "Live with other person "
label variable Beforetodayhaveyouheardof "Heard of PrEP"
label variable HaveyoueverusedPrEP "Use of PrEP"
label variable AreyoucurrentlyonPrEP "Currently on PrEP"
label variable HowlongwereyouonPrEP "Length of time on PrEP"
label variable WhydidyoustopusingPrEPtic "Reason for discontinued use"
label variable WhydidyoustopusingPrEPtic "Reason for discontinued use: Cost"
label variable AC "Reason for discontinued use: Side effects"
label variable AD "Reason for discontinued use: Someone finding out "
label variable AE "Reason for discontinued use: Time spent in order to get the medication"
label variable AF "Reason for discontinued use: Increased risk of getting non HIV STIs"
label variable AG "Other response "
label variable D "Other response "
label variable F "Other response "
label variable H "Other response "
label variable HowoftendidyouusePrEP "Frequency of PrEP use "
label variable AI "Other response "
label variable WheredidyougetPrEP "Where  PrEP was attained "
label variable AK "Other response "
label variable WhileyouwereonPrEPdidyou " Condom use while on PrEP "
label variable Whydidyouuseornotusecondo "Reson for using / not using PrEP"
label variable SomepeopleusePrEPtoprevent " Why do you use PrEP?"
label variable HowlonghaveyoubeenusingPrE "Length of PrEP use "
label variable HowoftendoyouusePrEP "Frequency of PrEP use"
label variable WheredoyougetPrEP "Where PrEP is attained "
label variable AR "Other response "
label variable WherewouldyouprefertogetPr "Preference in attaining PrEP "
label variable AT "Other response "
label variable Whatisimportanttoyouwhenge "Facilitators of PrEP"
label variable AV "Other response"
label variable Doanyofthefollowingworryy "PrEP Barriers "
label variable Doanyofthefollowingworryy "PrEP Barriers: Cost "
label variable AX "PrEP Barriers: Side Effects "
label variable AY "PrEP barriers: Someone finding out I was taking it "
label variable AZ "PrEP Barriers: Time spent in order to get the medication"
label variable BA "PrEP Barriers: Stigma"
label variable BB "PrEP barriers: Attitude of staff "
label variable BC "PrEP barriers: Increased risk of getting non HIV STIs "
label variable BD "Other response "
label variable SinceyoustartedusingPrEPho "Frequency of condom use while on PrEP"
label variable SinceyouhavestartedusingPrE "Frequency of sex under the influence while on PrEP"
label variable SinceyouhavestartedusingPrE "Frequency of sex under the influence of alcohol while on PrEP"
label variable BG "Frequency of sex under the influence of recreational drugs while on PrEP"
label variable SinceyoustartedusingPrEPha "STI while on PrEP"
label variable BI "Increased number of partners while on PrEP"
label variable Byhowmany "How many new partners while on PrEP"
label variable Whatisyourreasonfornotusin "Reasons for not using PrEP"
label variable BL "Other reasons"
label variable Wouldyoubeinterestedinusing "Would you use PrEP"
label variable Wherewouldyouprefertoaccess "Preference in accessimg PrEP"
label variable BP "Other preferences "
label variable Whatwouldbeimportanttoyouw "PrEP facilitators"
label variable BR "Other PrEP facilitators "
label variable Whenwasthemostrecenttimey "Most recent sexual encounter "
label variable BT "Other responses"
label variable Whohaveyoutoldthatyouhave "(Friends) Who have you told that you have sex with men"
label variable BX "(Family) Who have you told that you have sex with men"
label variable BY "(Colleagues :work ) Who have you told that you have sex with men"
label variable BZ "(Colleagues: school) Who have you told that you have sex with men"
label variable CA "(Church members) Who have you told that you have sex with men"
label variable CB "(PrEP providers) Who have you told that you have sex with men"
label variable CC "(Healthcare providers) Who have you told that you have sex with men"
label variable CD "Other responses "
label variable Hasanyonetreatedyoudifferent "Have anyone treated you differently who suspected  your sexuality "
label variable WhoaretheyTickallapplicab "Who are they : Friends "
label variable CG "Who are they: Family"
label variable CH "Who are they: Colleagues work"
label variable CI "Who are they: Colleagues school "
label variable CH "Who are they: Partner (s)"
label variable CI "Who are they: Colleagues"
label variable CJ "Who are they: Church members"
label variable CK "Who are they: other responses "
label variable Wheredoyouhangouttickall "Where do you hang out : Church "
label variable CM "Where do you hang out : Basketball court"
label variable CN "Where do you hang out : on the blocks "
label variable CO "Where do you hang out : On the beach "
label variable CN "Where do you hang out : On the blocks "
label variable CN "Where do you hang out : On the blocks "
label variable CP "Where do you hang out : I stay at home "
label variable CQ "Where do you hang out : Friend's house "
label variable CR "Where do you hang out : Bar"
label variable CS "Where do you hang out : Equals"
label variable CT "Where do you hang out : Other person "
label variable Areyouinarelationshipwith "Type of relationship "
label variable CV "Other type of relationship "
label variable Howmanymenhaveyouhadsexwi "Amount of men had sex with in past 6 months"
label variable CZ "Other response "
label variable Inthelastsixmonthshowman "In the last six  months, how many times have you had receptive anal sex (bottom)"
label variable Inthelast6monthshowmanyt "In the last 6 months, how many times did you have insertive anal sex (top)"
label variable DB "Other response "
label variable Tickthetypesofsexualactiv "Anal"
label variable DF "Oral"
label variable DG "Vagina "
label variable DH "Other type "
label variable DJ "Other response "
label variable DM "Other response "
label variable Whichtestswaswerepositive "Syphillis"
label variable DQ "Gonorrhoea"
label variable DR "Chlamydia"
label variable DS "Lymphog. "
label variable DT "(HTLV1)"
label variable DU "(HTLV2)"
label variable DV "Hep B"
label variable DW "Hep C"
label variable DX "Other "
label variable HaveyoueverhadaHumanImmuno "Have you ever had a (HIV) test?"
label variable EA "Other response "
label variable Inthelast3monthswhattype "What type of drugs have you used? Marijuana"
label variable Inthelast3monthswhattype "What type of drugs have you used? Cocaine"
label variable Inthelast3monthswhattype "What type of drugs have you used? Marijuana"
label variable EL "What type of drugs have you used? Cocaine"
label variable EM "What type of drugs have you used? Heroin"
label variable EN "What type of drugs have you used? Meth"
label variable EO "What type of drugs have you used? Pills"
label variable EP "What type of drugs have you used? Other"
drop in 1
foreach x of varlist Whatgenderwereyouassignedat-Ifyouhaveanycommentsonthis {
encode `x' , gen(_1`x')
}
drop Whatgenderwereyouassignedat-Ifyouhaveanycommentsonthis
rename _1* * 

recode Whatgenderwereyouassignedat (1=1) (2=1) (3=0) (4=0)
label define Whatgenderwereyouassignedat 0 "Male" 1 "Female", modify
drop D
drop F
label define Whatgenderwereyouassignedat 0"Male" 1"Female", modify
label value Whatgenderwereyouassignedat Whatgenderwereyouassignedat

recode Howoldareyou (1=1) (2=2) (3=3) (4=3) (5=4) (6=5) (7=6) (8=7)
recode Howoldareyou 3=4


**Currently using PrEP
codebook SomepeopleusePrEPtoprevent
describe SomepeopleusePrEPtoprevent
summarize SomepeopleusePrEPtoprevent

recode HaveyoueverusedPrEP (2=1) (1=0) (3=1)
label define HaveyoueverusedPrEP 0"Never used" 1"Yes", modify
label value HaveyoueverusedPrEP HaveyoueverusedPrEP
recode Howfrequentlydoyoudrinkalco (5=4) (1=3)

recode SinceyouhavestartedusingPrE (2=1)
recode Areyou 2=3
recode Areyou 4=5
recode Whatisyourresidencestatusin 4=3
recode Beforetodayhaveyouheardof 1=0
recode Beforetodayhaveyouheardof 2=1

label define Beforetodayhaveyouheardof 0 "No" 1 "Yes", modify
label value Beforetodayhaveyouheardof Beforetodayhaveyouheardof

recode AreyoucurrentlyonPrEP 1=0
recode AreyoucurrentlyonPrEP 2=1
label define AreyoucurrentlyonPrEP 0 "No" 1 "Yes", modify
label value AreyoucurrentlyonPrEP AreyoucurrentlyonPrEP


recode HowoftendidyouusePrEP 2=3
recode HowoftendidyouusePrEP 4=5
recode WheredidyougetPrEP 3=4
recode HowlonghaveyoubeenusingPrE 2=1
recode HowlonghaveyoubeenusingPrE 4=3
recode HowlonghaveyoubeenusingPrE 6=5
recode WheredoyougetPrEP 2=1
recode WheredoyougetPrEP 4=3
recode WheredoyougetPrEP 6=3
recode WherewouldyouprefertogetPr 3=2
recode WherewouldyouprefertogetPr 5=4

