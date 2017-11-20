
########
#Bivariate Data Analysis Field Prepping:
#this Script is meant to create all of the inputs to the system.
#######

#Correlation
library(nnet)
x ='C:\\Temp\\FINAL_INPUTS\\Box Sync\\R\\v3'
setwd(x)

d1 <- read.table(paste(getwd()[1],"All_PrimaryResults_v3.csv",sep = '/'), header=TRUE, sep=",", na.strings="", dec=".", strip.white=TRUE)
d2 <- read.table(paste(getwd()[1],"v3_tables_v3.csv",sep = '/'), header=TRUE, sep=",", na.strings="", dec=".", strip.white=TRUE)

d3 <- cbind(d1,d2)


d3$BeforeElectionCalled_Bernie <- d3$d17_Bernie + d3$d18_Bernie + d3$d19b4_Bernie
d3$BeforeElectionCalled_Hillary <- d3$d17_Hillary + d3$d18_Hillary + d3$d19b4_Hillary
d3$BeforeElectionCalled_Cruz <-d3$d17_Cruz + d3$d18_Cruz + d3$d19b4_Cruz
d3$BeforeElectionCalled_Kasich <- d3$d17_Kasich + d3$d18_Kasich + d3$d19b4_Kasich
d3$BeforeElectionCalled_Trump <- d3$d17_Trump + d3$d18_Trump + d3$d19b4_Trump

d3$TotRTwt <- (d3$Trump_twt+d3$Kasich_twt+d3$Cruz_twt)
d3$TotTwt <- (d3$Trump_twt+d3$Kasich_twt+d3$Cruz_twt+d3$Hillary_twt+d3$Bernie_twt)
d3$TotDTwt <- (d3$Hillary_twt+d3$Bernie_twt)

d3$Cruz_VS <- d3$Cruz / (d3$Cruz+d3$Trump+d3$Kasich)
d3$Trump_VS <- d3$Trump / (d3$Cruz+d3$Trump+d3$Kasich)
d3$Kasich_VS <- d3$Kasich / (d3$Cruz+d3$Trump+d3$Kasich)
d3$Bernie_VS <- d3$Bernie / (d3$Bernie+d3$Hillary)
d3$Hillary_VS <- d3$Hillary / (d3$Bernie+d3$Hillary)

# $u $d17_u  |  _TS _TS17
d3$Bernie_TS17 <- d3$d17_Bernie / (d3$d17_Bernie+d3$d17_Hillary)
d3$Hillary_TS17 <- d3$d17_Hillary / (d3$d17_Bernie+d3$d17_Hillary)
d3$Cruz_TS17 <- d3$d17_Cruz / (d3$d17_Cruz+d3$d17_Trump+d3$d17_Kasich)
d3$Trump_TS17 <- d3$d17_Trump / (d3$d17_Cruz+d3$d17_Trump+d3$d17_Kasich)
d3$Kasich_TS17 <- d3$d17_Kasich / (d3$d17_Cruz+d3$d17_Trump+d3$d17_Kasich)

# $u $d18_u   |  _TS  _TS18
d3$Bernie_TS18 <- d3$d18_Bernie / (d3$d18_Bernie+d3$d18_Hillary)
d3$Hillary_TS18 <- d3$d18_Hillary / (d3$d18_Bernie+d3$d18_Hillary)
d3$Cruz_TS18 <- d3$d18_Cruz / (d3$d18_Cruz+d3$d18_Trump+d3$d18_Kasich)
d3$Trump_TS18 <- d3$d18_Trump / (d3$d18_Cruz+d3$d18_Trump+d3$d18_Kasich)
d3$Kasich_TS18 <- d3$d18_Kasich / (d3$d18_Cruz+d3$d18_Trump+d3$d18_Kasich)

# $u $d19b4_u   |   _TS19b4  _TS19b4
d3$Bernie_TS19b4 <- d3$d19b4_Bernie / (d3$d19b4_Bernie+d3$d19b4_Hillary)
d3$Hillary_TS19b4 <- d3$d19b4_Hillary / (d3$d19b4_Bernie+d3$d19b4_Hillary)
d3$Cruz_TS19b4 <- d3$d19b4_Cruz / (d3$d19b4_Cruz+d3$d19b4_Trump+d3$d19b4_Kasich)
d3$Trump_TS19b4 <- d3$d19b4_Trump / (d3$d19b4_Cruz+d3$d19b4_Trump+d3$d19b4_Kasich)
d3$Kasich_TS19b4 <- d3$d19b4_Kasich / (d3$d19b4_Cruz+d3$d19b4_Trump+d3$d19b4_Kasich)

# $u $d19aft_u    |   _TS  _TS19aft_u
d3$Bernie_TS19aft_u <- d3$d19aft_Bernie / (d3$d19aft_Bernie+d3$d19aft_Hillary)
d3$Hillary_TS19aft_u <- d3$d19aft_Hillary / (d3$d19aft_Bernie+d3$d19aft_Hillary)
d3$Cruz_TS19aft_u <- d3$d19aft_Cruz / (d3$d19aft_Cruz+d3$d19aft_Trump+d3$d19aft_Kasich)
d3$Trump_TS19aft_u <- d3$d19aft_Trump / (d3$d19aft_Cruz+d3$d19aft_Trump+d3$d19aft_Kasich)
d3$Kasich_TS19aft_u <- d3$d19aft_Kasich / (d3$d19aft_Cruz+d3$d19aft_Trump+d3$d19aft_Kasich)

# $u $d20_u    |  _TS _TS20
d3$Bernie_TS20 <- d3$d20_Bernie / (d3$d20_Bernie+d3$d20_Hillary)
d3$Hillary_TS20 <- d3$d20_Hillary / (d3$d20_Bernie+d3$d20_Hillary)
d3$Cruz_TS20 <- d3$d20_Cruz / (d3$d20_Cruz+d3$d20_Trump+d3$d20_Kasich)
d3$Trump_TS20 <- d3$d20_Trump / (d3$d20_Cruz+d3$d20_Trump+d3$d20_Kasich)
d3$Kasich_TS20 <- d3$d20_Kasich / (d3$d20_Cruz+d3$d20_Trump+d3$d20_Kasich)

# $u $Total0Filter_u   |  _TS  _TS
d3$Bernie_TS <- d3$Bernie_twt / (d3$Bernie_twt+d3$Hillary_twt)
d3$Hillary_TS <- d3$Hillary_twt / (d3$Bernie_twt+d3$Hillary_twt)
d3$Cruz_TS <- d3$Cruz_twt / (d3$Cruz_twt+d3$Trump_twt+d3$Kasich_twt)
d3$Trump_TS <- d3$Trump_twt / (d3$Cruz_twt+d3$Trump_twt+d3$Kasich_twt)
d3$Kasich_TS <- d3$Kasich_twt / (d3$Cruz_twt+d3$Trump_twt+d3$Kasich_twt)

# $u $BeforeElectionCalled_u  _TS  _TS_b4
d3$Bernie_TS_b4 <- d3$BeforeElectionCalled_Bernie / (d3$BeforeElectionCalled_Bernie+d3$BeforeElectionCalled_Hillary)
d3$Hillary_TS_b4 <- d3$BeforeElectionCalled_Hillary / (d3$BeforeElectionCalled_Bernie+d3$BeforeElectionCalled_Hillary)
d3$Cruz_TS_b4 <- d3$BeforeElectionCalled_Cruz / (d3$BeforeElectionCalled_Cruz+d3$BeforeElectionCalled_Trump+d3$BeforeElectionCalled_Kasich)
d3$Trump_TS_b4 <- d3$BeforeElectionCalled_Trump / (d3$BeforeElectionCalled_Cruz+d3$BeforeElectionCalled_Trump+d3$BeforeElectionCalled_Kasich)
d3$Kasich_TS_b4 <- d3$BeforeElectionCalled_Kasich / (d3$BeforeElectionCalled_Cruz+d3$BeforeElectionCalled_Trump+d3$BeforeElectionCalled_Kasich)

#writes output intermediate File
write.csv(d3,paste(getwd()[1],"v3_AllTags_002_AllSources_analysis_v3.csv",sep = '/'),
          append = FALSE, quote = TRUE, sep = ",",
          eol = "\n", na = "0", dec = ".", row.names = TRUE,
          col.names = TRUE, qmethod = c("escape", "double"),
          fileEncoding = "")

#I need to delete all these tables, then repopulate them.
K <- data.frame(d3)
C <- data.frame(d3)
H <- data.frame(d3)
B <- data.frame(d3)
T <- data.frame(d3)

#These were all created using the formula Calculator called:  .\v3\NamingFeatures.xlsx 
K$Candidate_VS <- K$Kasich_VS
K$Candidate_TS17 <- K$Kasich_TS17
K$Candidate_TS18 <- K$Kasich_TS18
K$Candidate_TS19b4 <- K$Kasich_TS19b4
K$Candidate_TS19aft_u <- K$Kasich_TS19aft_u
K$Candidate_TS20 <- K$Kasich_TS20
K$Candidate_TS_b4 <- K$Kasich_TS_b4
K$Candidate_TS <- K$Kasich_TS
K$CANDIDATE <-  'KASICH'


C$Candidate_VS <- C$Cruz_VS
C$Candidate_TS17 <- C$Cruz_TS17
C$Candidate_TS18 <- C$Cruz_TS18
C$Candidate_TS19b4 <- C$Cruz_TS19b4
C$Candidate_TS19aft_u <- C$Cruz_TS19aft_u
C$Candidate_TS20 <- C$Cruz_TS20
C$Candidate_TS_b4 <- C$Cruz_TS_b4
C$Candidate_TS <- C$Cruz_TS
C$CANDIDATE <-  'CRUZ'

H$Candidate_VS <- H$Hillary_VS
H$Candidate_TS17 <- H$Hillary_TS17
H$Candidate_TS18 <- H$Hillary_TS18
H$Candidate_TS19b4 <- H$Hillary_TS19b4
H$Candidate_TS19aft_u <- H$Hillary_TS19aft_u
H$Candidate_TS20 <- H$Hillary_TS20
H$Candidate_TS_b4 <- H$Hillary_TS_b4
H$Candidate_TS <- H$Hillary_TS
H$CANDIDATE <-  'HILLARY'

B$Candidate_VS <- B$Bernie_VS
B$Candidate_TS17 <- B$Bernie_TS17
B$Candidate_TS18 <- B$Bernie_TS18
B$Candidate_TS19b4 <- B$Bernie_TS19b4
B$Candidate_TS19aft_u <- B$Bernie_TS19aft_u
B$Candidate_TS20 <- B$Bernie_TS20
B$Candidate_TS_b4 <- B$Bernie_TS_b4
B$Candidate_TS <- B$Bernie_TS
B$CANDIDATE <-  'BERNIE'

T$Candidate_VS <- T$Trump_VS
T$Candidate_TS17 <- T$Trump_TS17
T$Candidate_TS18 <- T$Trump_TS18
T$Candidate_TS19b4 <- T$Trump_TS19b4
T$Candidate_TS19aft_u <- T$Trump_TS19aft_u
T$Candidate_TS20 <- T$Trump_TS20
T$Candidate_TS_b4 <- T$Trump_TS_b4
T$Candidate_TS <- T$Trump_TS
T$CANDIDATE <-  'TRUMP'

d4 <- rbind(T,K,C,H,B)


write.csv(d4,paste(getwd()[1],"v3_AllTags_002_AllSources_analysis_v3_310.csv",sep = '/'),
          append = FALSE, quote = TRUE, sep = ",",
          eol = "\n", na = "0", dec = ".", row.names = TRUE, 
          col.names = TRUE, qmethod = c("escape", "double"), fileEncoding = "")

# This section grabs a random sample from my set of 310 to check correlation.

# mod <- d4[sample(nrow(d4), 200), ]
# 
# Model.All <- lm(mod$Candidate_VS~mod$Candidate_TS,data=mod)
# Model.All2 <- lm(mod$Candidate_VS~mod$Candidate_TS17,data=mod)
# Model.All3 <- lm(mod$Candidate_VS~mod$Candidate_TS18,data=mod)
# Model.All4 <- lm(mod$Candidate_VS~mod$Candidate_TS19b4,data=mod)
# Model.All5 <- lm(mod$Candidate_VS~mod$Candidate_TS20,data=mod)
# Model.All6 <- lm(mod$Candidate_VS~mod$Candidate_TS_b4,data=mod)
# 
# summary(Model.All)
# summary(Model.All2)
# summary(Model.All3)
# summary(Model.All4)
# summary(Model.All5)
# summary(Model.All6)
# 
# 
# 
# RegModel.Bernie <- lm(Bernie_VS~Bernie_TS, data=d3)
# RegModel.Bernie17 <- lm(Bernie_VS~Bernie_TS17, data=d3)
# RegModel.Bernie18 <- lm(Bernie_VS~Bernie_TS18, data=d3)
# RegModel.Bernie19aft_u <- lm(Bernie_VS~Bernie_TS19aft_u, data=d3)
# RegModel.Bernie19b4 <- lm(Bernie_VS~Bernie_TS19b4, data=d3)
# RegModel.Bernie20 <- lm(Bernie_VS~Bernie_TS20, data=d3)
# RegModel.Bernie_b4 <- lm(Bernie_VS~Bernie_TS_b4, data=d3)
# # 
# summary(RegModel.Bernie)
# summary(RegModel.Bernie17)
# summary(RegModel.Bernie18)
# summary(RegModel.Bernie19aft_u)
# summary(RegModel.Bernie19b4)
# summary(RegModel.Bernie20)
# summary(RegModel.Bernie_b4)

