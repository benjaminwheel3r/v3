# Master Task List
This is where I keep my overall Tasks for this project:

### 1. Script to Calculate Spearman and write to a *.csv for each of the 11 subsets of my data sets that exist in my data. 
#### Deadline:  11/7
#### Key issues:
The Main issue with this script is getting it to reference all the subsets etc within the existing function that also codes for a bivariate analysis.  The secondary objective would be to code the tool/functions so that it can write out Spearmans' with relevant data, as well as the bivariate analyses into an easily ingestable data format. (CSV or txt or the like) This step will allow running the data at multiple levels.  The Tertiary objective is to program such that NA or empty data is thrown out of the calculation as the data richness decreases.

### 5. GWR - OLS
#### Key Issues:
The only way to move forward at this point is to specify an OLS model, and then test it's Residuals for Spatial AutoCorrelation (See #2 and #3), using Moran's I,  then after doing that, I need to use GWR(See https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3155330/ ). 




### 2. Spatial Autocorrelation (Moran's I)  - Phase I  :  Concepts
#### Phase I: Deadline 11/8
#### Key Issues:  
Determine assumptions, and identify data structure necessary for testing Moran's I.
### Key Breakthroughs:  
Model for Calculating Moran's I does work, however you have to do one field at a time. 

### 3. Spatial Autocorrelation - Phase II  : Implementation
#### Phase I: Deadline 11/10
#### Key Issues: 
Determine how to test for Spatial Autocorrelation for multiple records at each location. (This is not possible.)
However, it will be key for evaluating either Spearman's Rho Correlations.


### 4. Geographic Weighted Regression - Phase I : Basic Concepts and implementation
#### Key Issues:
Work on establishing foundational knowledge.

### 6. GWR - Bonferroni Correction.
