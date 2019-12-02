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

*-------------------------------------------------------------------------------

*Re-labelling of prep awareness variable
label define prep_heard 0"Unaware of PrEP" 1"Aware of PrEP", modify
label value prep_heard prep_heard

*-------------------------------------------------------------------------------

*Note: Ensure catplot is installed prior to running analysis
*catplot produces clustered bar charts

catplot prep_heard age_cat_new, ///
                                percent(prep_heard) recast(bar) ///
                                var1opts(label(labsize(small))) ///
                                var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
                                ytitle("Percent (%)", size(small)color(black)) ///
                                title("PrEP Awareness by Predictors", span size(medium) color(black)) ///
                                yscale(off) ///
                                ylabel(, angle(horizontal) nogrid) ///
                                blabel(bar, format(%4.1f) size(small)) ///
                                bar(1, fcolor(black)) bar(2, fcolor(khaki)) intensity(75) bargap(20) ///
                                legend(on region(fcolor(none) lcolor(none))) clegend(on) ///
                                graphregion(fcolor(white)) ///
                                plotregion(fcolor(none) ifcolor(none)) ///
                                asyvars name(graph_1, replace)

*The below script may have errors                                
local nb=`.Graph.plotregion1.barlabels.arrnels' //This line runs troublesome
qui forval i=1/`nb' {
  .Graph.plotregion1.barlabels[`i'].text[1]="`.Graph.plotregion1.barlabels[`i'].text[1]'%"
}
.Graph.drawgraph 

*-------------------------------------------END--------------------------------------------------------------------
