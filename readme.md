# v3 Analysis
I think the first part I want to start tackling with your help is creating Spearman's Rho Correlations for each of the following: 

[Spearman] n = 1 

[Republicans, Democrats, Both Parties, Each individual Candidate (5x) ] (n = 8)   
Potentially tackling this doing a total match up, of each party, so it would be (Cruz and Kasich), (Kasich and Trump), (Trump and Cruz) in addition.

for each time period  [*d17,*d18,*d19b4,*d19_aft_u,*d20,TS, etc]  (n = 7 minimum)

For each set of input location data [1,12,123,1239]  (n=4 (minimum)) > These trigger new datashets.
For both First-Last Detection and Normal(Hashtag detection).  (n =2) > These also trigger new datasheets. 

Looks like the total number of calculations we are looking at is roughly 2 * 4 * 7 * 8 * 2 = ~896 so hopefully, we can get it a little more programmatic. 
As well as doing a Spearman Calculation for each of these, we will be doing a Bivariate Analysis testing each iteration as well.
We will attempt to report out these bivariate analysis the same way that DiGrazia reports on them.
Digrazia did not however use a spatial model of any-kind, instead he looked at the overall tweets, I still don't know if this is something meaningful.

The different sources are going to require different input files. ie. 1 and 2, require a different source file from 1239,  I made the construction of this part pretty streamlined, but it will get tougher as we get to the Best Source 1 etc, with not enough records for certain counties, we'll have to code for gaps in the data.

The goal is for it to be as programmatic updates/logging as possible, so if we need to run it again with different data then we'll be ok.

If we decide that this is incredibly invalid, or that this method of "creating" observations is  invalid, then we will re-evaluate. 
