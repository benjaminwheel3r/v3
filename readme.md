# v3 Analysis
This should be a nice readme.
This could be worthwhile way for us to manage this project.
Let me know your thoughts?



I think the first part I want to start tackling with your help is creating Spearman's Rho Correlations and Pearson Correlations for each of the following: 

[Pearson, Spearman] n = 2 

[Republicans, Democrats, Both Parties, Each individual Candidate (5x) ] (n = 8)

for each time period  [*d17,*d18,*d19b4,*d19_aft_u,*d20,TS, etc]  (n = 7 minimum)

For each set of input location data [1,12,123,1239]  (n=4 (minimum))
For both First-Last Detection and Normal(Hashtag detection).  (n =2)

Looks like the total number of calculations we are looking at is roughly 2 * 4 * 7 * 8 * 2 = ~896 or more maybe, so hopefully, we can get it a little more programmatic. 

The different sources are going to require different input files. ie. 1and 2, requires a different source file from 1239,  I made the construction of this part pretty streamlined, but it will get tougher as we get to the Best Source 1 etc, with not enough records to really determine.

The hope is to make as much of it programmatic updates/logging as possible, so that if we need to run it one more time with slightly different data then we'll be ok.

I think if we decide that Pearson is incredibly invalid, or that this method of "creating" observations is incredibly invalid, then perhaps we will re-evaluate. 
