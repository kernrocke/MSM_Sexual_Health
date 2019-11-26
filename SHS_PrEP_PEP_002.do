
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_PrEP_002
**  Project:      	MSM Sexual Health
**  Analysts:		Eden Augustus & Kern Rocke
**	Date Created:	28/07/2019
**	Date Modified: 	22/11/2019
**  Algorithm Task: Data Cleaning


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 80

*Setting working directory
** Dataset to encrypted location

*WINDOWS OS
local datapath "X:/OneDrive - The University of the West Indies"
cd "X:/OneDrive - The University of the West Indies"

*MAC OS
*local datapath "/Users/kernrocke/OneDrive - The University of the West Indies"
*cd "/Users/kernrocke/OneDrive - The University of the West Indies"

*---------------------------HOUSE KEEPING---------------------------------------

*Load in data import 
import excel "`datapath'/MSM Sexual Health/Data/Sexual Health Survey SHS 2019.xlsx", sheet("Sheet") firstrow clear

*Label dataset for metadata purposes
label data "The Sexual Health Survey 2019"

*Remove additional column row
drop in 1

*-------------------------------------------------------------------------------


*Label variables

*Demographics
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

rename Q live_mother
rename R live_father
rename S live_grand
rename T live_family_other
rename U live_spouse
rename V live_friend
rename W live_other

*-------------------------------------------------------------------------------

*Section 2- PrEP 

label variable Beforetodayhaveyouheardof "Heard of PrEP"
label variable HaveyoueverusedPrEP "Use of PrEP"
label variable AreyoucurrentlyonPrEP "Currently on PrEP"
label variable HowlongwereyouonPrEP "Length of time on PrEP"
label variable WhydidyoustopusingPrEPtic "Reason for discontinued use: Cost"
label variable AC "Reason for discontinued use: Side effects"
label variable AD "Reason for discontinued use: Someone finding out "
label variable AE "Reason for discontinued use: Time spent in order to get the medication"
label variable AF "Reason for discontinued use: Increased risk of getting non HIV STIs"
label variable AG "Other response "
label variable D "Other response "
label variable F "Other response "
label variable H "Other response "

drop D F H AG
rename Beforetodayhaveyouheardof prep_heard
rename HaveyoueverusedPrEP prep_use
rename AreyoucurrentlyonPrEP prep_current
rename HowlongwereyouonPrEP prep_time
rename WhydidyoustopusingPrEPtic dis_reason_cost
rename AC dis_reason_side_effects
rename AD dis_reason_finding_out
rename AE dis_reason_time_medication
rename AF dis_reason_increase_HIV

*-------------------------------------------------------------------------------

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

rename HowoftendidyouusePrEP prep_freq
rename WheredidyougetPrEP prep_location
rename WhileyouwereonPrEPdidyou prep_condom
rename Whydidyouuseornotusecondo prep_condom_reason
rename SomepeopleusePrEPtoprevent prep_reason
rename HowlonghaveyoubeenusingPrE prep_length
rename HowoftendoyouusePrEP prep_freq_current
rename WheredoyougetPrEP prep_location_current
rename WherewouldyouprefertogetPr prep_preference

drop AI AK AR AT

*-------------------------------------------------------------------------------

*Facilitators & Barriers

label variable Whatisimportanttoyouwhenge "Facilitators of PrEP"
label variable AV "Other response"

label variable Doanyofthefollowingworryy "PrEP Barriers: Cost "
label variable AX "PrEP Barriers: Side Effects "
label variable AY "PrEP barriers: Someone finding out I was taking it "
label variable AZ "PrEP Barriers: Time spent in order to get the medication"
label variable BA "PrEP Barriers: Stigma"
label variable BB "PrEP barriers: Attitude of staff "
label variable BC "PrEP barriers: Increased risk of getting non HIV STIs "
label variable BD "Other response "

label variable SinceyoustartedusingPrEPho "Frequency of condom use while on PrEP"

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

rename Doanyofthefollowingworryy barrier_cost
rename AX barrier_side_effect
rename AY barrier_finding_out
rename AZ barrier_time_med
rename BA barrier_stigma
rename BB barrier_attitude_staff
rename BC barrier_risk_STI

rename SinceyoustartedusingPrEPho condom_freq

rename SinceyouhavestartedusingPrE sex_freq_alcohol
rename BG sex_freq_drugs
rename SinceyoustartedusingPrEPha sti_prep
rename BI prep_partner
rename Byhowmany prep_new_partner
rename Whatisyourreasonfornotusin prep_no_use_reason
rename Wouldyoubeinterestedinusing prep_interest
rename Wherewouldyouprefertoaccess prep_preference_access
rename Whatwouldbeimportanttoyouw prep_import_facilate
rename Whenwasthemostrecenttimey sex_encounter_recent

drop AV BD BL BP BR BT

*-------------------------------------------------------------------------------

label variable Whohaveyoutoldthatyouhave "(Friends) Who have you told that you have sex with men"
label variable BX "(Family) Who have you told that you have sex with men"
label variable BY "(Colleagues :work ) Who have you told that you have sex with men"
label variable BZ "(Colleagues: school) Who have you told that you have sex with men"
label variable CA "(Church members) Who have you told that you have sex with men"
label variable CB "(PrEP providers) Who have you told that you have sex with men"
label variable CC "(Healthcare providers) Who have you told that you have sex with men"
label variable CD "Other responses "

rename Whohaveyoutoldthatyouhave msm_friend
rename BX msm_friend
rename BY msm_colleagues_work
rename BZ msm_colleagues_school
rename CA msm_church
rename CB msm_prep_provider
rename CC msm_healthcare
drop CD 

*-------------------------------------------------------------------------------

label variable Hasanyonetreatedyoudifferent "Have anyone treated you differently who suspected  your sexuality "
label variable WhoaretheyTickallapplicab "Who are they : Friends "
label variable CG "Who are they: Family"
label variable CH "Who are they: Colleagues work"
label variable CI "Who are they: Colleagues school "
label variable CH "Who are they: Partner (s)"
label variable CJ "Who are they: Church members"
label variable CK "Who are they: other responses "

rename Hasanyonetreatedyoudifferent treat_different
rename WhoaretheyTickallapplicab treat_diff_friend
rename CG treat_diff_family
rename CH treat_diff_work
rename CI treat_diff_school
rename CH treat_diff_partner
rename CJ treat_diff_church

drop CK

*-------------------------------------------------------------------------------

label variable Wheredoyouhangouttickall "Where do you hang out : Church "
label variable CM "Where do you hang out : Basketball court"
label variable CN "Where do you hang out : on the blocks "
label variable CO "Where do you hang out : On the beach "
label variable CP "Where do you hang out : I stay at home "
label variable CQ "Where do you hang out : Friend's house "
label variable CR "Where do you hang out : Bar"
label variable CS "Where do you hang out : Equals"
label variable CT "Where do you hang out : Other person "

rename Wheredoyouhangouttickall hang_church
rename CM hang_basketball_court
rename CN hang_block
rename CO hang_beach
rename CP hang_home
rename CQ hang_friend_house
rename CR hang_bar
rename CS hang_equals

drop CT 
*-------------------------------------------------------------------------------


label variable Areyouinarelationshipwith "Type of relationship "
label variable CV "Other type of relationship "
label variable Howmanymenhaveyouhadsexwi "Amount of men had sex with in past 6 months"
label variable CZ "Other response "
label variable Inthelastsixmonthshowman "In the last six  months, how many times have you had receptive anal sex (bottom)"
label variable Inthelast6monthshowmanyt "In the last 6 months, how many times did you have insertive anal sex (top)"
label variable DB "Other response "

rename Areyouinarelationshipwith relationship_type
rename Howmanymenhaveyouhadsexwi msm_sex_amt
rename Inthelastsixmonthshowman anal_sex_receptive
rename Inthelast6monthshowmanyt anal_sex_insertive

drop CV CZ

*-------------------------------------------------------------------------------

*Type of sexual activity
label variable Tickthetypesofsexualactiv "Anal"
label variable DF "Oral"
label variable DG "Vagina "
label variable DH "Other type "
label variable DJ "Other response "
label variable DM "Other response "

rename Tickthetypesofsexualactiv sex_anal
rename DF sex_oral
rename DG sex_vagina
drop DH DJ DM

*-------------------------------------------------------------------------------

*Positive STI test
label variable Whichtestswaswerepositive "Syphillis"
label variable DQ "Gonorrhoea"
label variable DR "Chlamydia"
label variable DS "Lymphog. "
label variable DT "(HTLV1)"
label variable DU "(HTLV2)"
label variable DV "Hep B"
label variable DW "Hep C"
label variable DX "Other "

rename Whichtestswaswerepositive test_syphillis
rename DQ test_gonorrhoea
rename DR test_chlamydia
rename DS test_lymphog
rename DT test_htlv1
rename DU test_htlv2
rename DV test_hepB
rename DW test_hepC
drop DX

*-------------------------------------------------------------------------------

label variable HaveyoueverhadaHumanImmuno "Have you ever had a (HIV) test?"
label variable EA "Other response "

label variable Inthelast3monthswhattype "What type of drugs have you used? Marijuana"
label variable EL "What type of drugs have you used? Cocaine"
label variable EM "What type of drugs have you used? Heroin"
label variable EN "What type of drugs have you used? Meth"
label variable EO "What type of drugs have you used? Pills"
label variable EP "What type of drugs have you used? Other"

rename EL drug_cocaine
rename EM drug_heroin
rename EN drug_Meth
rename EO drug_pills
drop EP

*-------------------------------------------------------------------------------

*Analysis Loop for destring categorical variables

foreach x of varlist Whatgenderwereyouassignedat-Ifyouhaveanycommentsonthis {
encode `x' , gen(_1`x')
}
drop Whatgenderwereyouassignedat-Ifyouhaveanycommentsonthis
rename _1* * 

*-------------------------------------------------------------------------------


recode Whatgenderwereyouassignedat (1=1) (2=1) (3=0) (4=0)
label define Whatgenderwereyouassignedat 0 "Male" 1 "Female", modify

label define Whatgenderwereyouassignedat 0"Male" 1"Female", modify
label value Whatgenderwereyouassignedat Whatgenderwereyouassignedat

recode Howoldareyou (1=1) (2=2) (3=3) (4=3) (5=4) (6=5) (7=6) (8=7)
recode Howoldareyou 3=4


**Currently using PrEP

recode prep_use (2=1) (1=0) (3=1)
label define prep_use 0"Never used" 1"Yes", modify
label value prep_use prep_use


recode Howfrequentlydoyoudrinkalco (5=4) (1=3)
recode SinceyouhavestartedusingPrE (2=1)
recode Areyou 2=3
recode Areyou 4=5
recode Whatisyourresidencestatusin 4=3

recode prep_heard (1=0) (2=1)
label define prep_heard 0 "No" 1 "Yes", modify
label value prep_heard prep_heard

recode prep_current (1=0) (2=1)
label define prep_current 0 "No" 1 "Yes", modify
label value prep_current prep_current


recode prep_freq (2=3) (4=5)
recode prep_location (3=4)
recode prep_length (2=1) (4=3) (6=5)
recode prep_location_current (2=1) (4=3) (6=3)

recode WherewouldyouprefertogetPr 3=2
recode WherewouldyouprefertogetPr 5=4

*-----------------------------END-----------------------------------------------