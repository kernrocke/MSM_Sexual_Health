
clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_PrEP_003
**  Project:      	MSM Sexual Health
**	Sub-Project:	Prevalence, Barriers and Facilitators to PrEP and PEP 
**  Analysts:		Kern Rocke
**	Date Created:	28/07/2019
**	Date Modified: 	18/12/2019
**  Algorithm Task: Manuscript Visualizations


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 80

*Setting working directory
** Dataset to encrypted location

*WINDOWS OS
*local datapath "X:/OneDrive - The University of the West Indies"
*local graphpath "X:/OneDrive - The University of the West Indies/MSM Sexual Health/Visualization"
*cd "X:/OneDrive - The University of the West Indies"

*MAC OS
local datapath "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies"
local graphpath "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies/MSM Sexual Health/Visualization"
cd "/Volumes/Secomba/kernrocke/Boxcryptor/OneDrive - The University of the West Indies/MSM Sexual Health/Results"

*-------------------------------------------------------------------------------
*Load encrypted data for analysis
use "`datapath'/MSM Sexual Health/Data/MSM_PrEP_PEP_002.dta", clear

/*
***Create bar graphs showing PrEP characteristics and awareness of PrEP
Refer to publication:
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5617149/pdf/pone.0184014.pdf (black and white)

*/

*-------------------------------------------------------------------------------

*Re-labelling of prep awareness variable
label define prep_heard 0"Unaware of PrEP" 1"Aware of PrEP", modify
label value prep_heard prep_heard

*Re-labelling of education variable
label define education 1"Diploma/AD" 4"Primary" 5"Secondary" 6"BSc/MSc", modify
label value education education

*Re-labelling of sex_identity variable
label define sex_identity 1"Bisexual" 2"Gay or homosexual" 4"Heterosexual", modify
label value sex_identity sex_identity


*-------------------------------------------------------------------------------

*Note: Ensure catplot is installed prior to running analysis
*catplot produces clustered bar charts

catplot prep_heard age_cat_new, ///
                                percent(prep_heard) recast(bar) ///
                                var1opts(label(labsize(small))) ///
                                var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
                                ytitle("Percent (%)", size(small)color(black)) ///
                                title("Age", span size(medium) color(black)) ///
                                yscale(off) ///
                                ylabel(, angle(horizontal) nogrid) ///
                                blabel(bar, format(%4.1f) size(small)) ///
                                bar(1, fcolor(black)) bar(2, fcolor(khaki)) intensity(75) bargap(20) ///
                                legend(on region(fcolor(none) lcolor(none))) clegend(on) ///
                                graphregion(fcolor(white)) ///
                                plotregion(fcolor(none) ifcolor(none)) ///
                                asyvars name(graph_1, replace) saving(graph_1, replace)
								
								
catplot prep_heard education, ///
                                percent(prep_heard) recast(bar) ///
                                var1opts(label(labsize(small))) ///
                                var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
                                ytitle("Percent (%)", size(small)color(black)) ///
                                title("Education", span size(medium) color(black)) ///
                                yscale(off) ///
                                ylabel(, angle(horizontal) nogrid) ///
                                blabel(bar, format(%4.1f) size(small)) ///
                                bar(1, fcolor(black)) bar(2, fcolor(khaki)) intensity(75) bargap(20) ///
                                legend(on region(fcolor(none) lcolor(none))) clegend(on) ///
                                graphregion(fcolor(white)) ///
                                plotregion(fcolor(none) ifcolor(none)) ///
                                asyvars name(graph_2, replace) saving(graph_2, replace)
								
								
catplot prep_heard sex_identity, ///
                                percent(prep_heard) recast(bar) ///
                                var1opts(label(labsize(small))) ///
                                var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
                                ytitle("Percent (%)", size(small)color(black)) ///
                                title("Sexual Identity", span size(medium) color(black)) ///
                                yscale(off) ///
                                ylabel(, angle(horizontal) nogrid) ///
                                blabel(bar, format(%4.1f) size(small)) ///
                                bar(1, fcolor(black)) bar(2, fcolor(khaki)) intensity(75) bargap(20) ///
                                legend(on region(fcolor(none) lcolor(none))) clegend(on) ///
                                graphregion(fcolor(white)) ///
                                plotregion(fcolor(none) ifcolor(none)) ///
                                asyvars name(graph_3, replace) saving(graph_3, replace)
								
								
catplot prep_heard relationship_status, ///
                                percent(prep_heard) recast(bar) ///
                                var1opts(label(labsize(small))) ///
                                var2opts(label(labsize(small)) relabel(`r(relabel)')) ///
                                ytitle("Percent (%)", size(small)color(black)) ///
                                title("Relationship Status", span size(medium) color(black)) ///
                                yscale(off) ///
                                ylabel(, angle(horizontal) nogrid) ///
                                blabel(bar, format(%4.1f) size(small)) ///
                                bar(1, fcolor(black)) bar(2, fcolor(khaki)) intensity(75) bargap(20) ///
                                legend(on region(fcolor(none) lcolor(none))) clegend(on) ///
                                graphregion(fcolor(white)) ///
                                plotregion(fcolor(none) ifcolor(none)) ///
                                asyvars name(graph_4, replace) saving(graph_4, replace)
								
*Combine graphs
graph combine graph_1 graph_2 graph_3 graph_4, col(2)				///
												graphregion(fcolor(white)) ///
												name(graph_combine, replace)		///
												saving(graph_combine, replace)
												
*----------------------------------END------------------------------------------
