clear
capture log close
cls

**  GENERAL DO-FILE COMMENTS
**  Program:		SHS_PrEP_PEP_000.do
**  Project:      	Sexual Health Survey
**	Sub-Project:	PrEP and PEP Facilitators and Barriers
**  Analyst:		Kern Rocke
**	Date Created:	26/11/2019
**	Date Modified: 	30/11/2019
**  Algorithm Task: Statistical Analysis Plan


** DO-FILE SET UP COMMANDS
version 13
clear all
macro drop _all
set more 1
set linesize 150

*---------------------------------------------------------------------------------------------------------------
/* 

STATISTICAL ANALYSIS PLAN

Paper title: Prevalence of use, barriers and faciliators of PrEP uptake 
                among gbMSM residing in a high income small island 
                developing states. (Tentative)

Objective:
            1) To determine the prevalence of the use of PrEP among gbMSM in Barbados
            2) To identify facilitators and barriers associated with PrEP use among gbMSM in Barbados
*---------------------------------------------------------------------------------------------------------------
ANALYSIS PLAN

PREAMBLE

Justification

To date there has been limited studies focusing on Pre-exposure prophylaxsis and post-exposure prophylaxsis
among gbMSM in small island developing states. There is an inherent neeed for population based research in 
resource stricken settings. Currently in the Caribbean there are only two nationwide programmes which allow
for the distribution of PrEP to help reduce the transmission of HIV. 

ANALYSIS NOTES 

Statistical Analysis
Associations between respondent characteristics and PrEP usage were examined using pearson chi-square 
analysis. Bivariable binary logistic regression methods were used to examine the relationships of indivdual 
sociodemographic predictors with the primary outcome of PrEP use. The multivariable models included  independent
variable that were significant in the bivariable models defined as p<0.1 and were potential confounders for the 
relationship between independent predictors and the outcome of the interest. Collinearity for the multivariable
regression model was asssed examining correlations between independent variables prior to regression modelling.
We report adjusted odds ratios and 95% CI controlling all other independent variables in the model. An alpha
of 0.05 was employed for all analysis and was considered to be statistically significant. All analyses were 
performed using STATA 16.0 (StataCorp, College Station, Texas). 

*---------------------------------------------------------------------------------------------------------------
RESULTS SECTION 

Take a look at the following article
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6440797/pdf/pone.0213740.pdf
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6103919/pdf/nihms945211.pdf 


Table 1: Prevalence Estimates of PrEP characteristics

Analysis method: Consideration for prevalence estimate use estimate and 95% Confidence Intervals


Table 2: Sociodemographic characteristiscs of Barbados Sexual Health Survey

Analysis method: Pearson Chi-Square test 

Characteristics         Total           Never       PrEP Use     p-value


Table 3: Multivariable Binary Logistic Regression of PrEP Use and Independent Predictors

Analysis method: Binary Logistic Regression

Predictor       OR      95% CI(OR)      p-value


***Create bar graphs showing PrEP characteristics and awareness of PrEP
Refer to publication:
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5617149/pdf/pone.0184014.pdf (black and white)


*/


*----------------------------------END------------------------------------------