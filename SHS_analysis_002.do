*NOTE: This do file should only be run after running SHS_PrEP_PEP_002

clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_analysis_001.do
**  Project:      	MSM Sexual Health
**	Sub-Project:	Prevalence, Barriers and Facilitators to PrEP and PEP 
**  Analyst:		Kern Rocke
**	Date Created:	30/11/2019
**	Date Modified: 	30/11/2019
**  Algorithm Task: Creation of Publication graphics


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 150

*Setting working directory
** Dataset to encrypted location

*WINDOWS OS
local datapath "X:/OneDrive - The University of the West Indies"
cd "X:/OneDrive - The University of the West Indies"

*MAC OS
*local datapath "/Users/kernrocke/OneDrive - The University of the West Indies"
*cd "/Users/kernrocke/OneDrive - The University of the West Indies"

*Load encrypted data for analysis
use "`datapath'/MSM Sexual Health/Data/MSM_PrEP_PEP_001.dta", clear

/*
***Create bar graphs showing PrEP characteristics and awareness of PrEP
Refer to publication:
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5617149/pdf/pone.0184014.pdf (black and white)

*/