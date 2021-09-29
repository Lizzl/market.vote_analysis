
##Voter Activity##

#How many rounds?
SELECT COUNT(DISTINCT roundID) FROM FVT.votedata;

# How many voters / unique addresses ?
SELECT COUNT(DISTINCT OWNER) from FVT.voicedata;

# How many VoteIds total?
Select MAX(voterid) AS Number_of_Minted_VoterIds FROM FVT.voicedata;

#Voter ID per voter 
DROP VIEW IDs_per_voter;

CREATE VIEW IDs_per_Voter AS
SELECT Distinct owner, COUNT(voterID) AS IDs_per_voter
FROM FVT.voicedata
GROUP BY owner
ORDER BY IDs_per_voter DESC;

SELECT * FROM IDs_per_Voter;

#check if Ids were transfered
DROP VIEW voterIds_trans;
CREATE VIEW voterIds_trans AS 
SELECT voterID, COUNT(owner) AS number_owners
FROM FVT.voicedata
GROUP BY voterID;

SELECT * FROM voterIds_trans
WHERE number_owners ='1';

#Average vote_Ids per addresse(voter)?
SELECT AVG(AVG_IDs_per_voter) FROM AVG_IDs_per_Voter;

#Check for centralization of power

#top 10 owners(voters), who hold the most voterIds
SELECT Count(voterId) AS Number_voterIds, owner 
FROM voicedata
GROUP BY owner
ORDER BY Number_voterIds DESC;

#v_power per owner(voter)
SELECT SUM(voiceCredits) AS v_power, COUNT(voterId), owner
FROM voicedata
GROUP BY owner
ORDER BY v_power DESC;

# How many votes total?
SELECT COUNT(event) FROM FVT.votedata;

#How many votes per round?
CREATE VIEW VOTES_PER_ROUND AS
SELECT roundid, COUNT(event) AS VOTES_PER_ROUND
FROM FVT.votedata 
GROUP BY roundid;

#How many votes AVG per round? 
SELECT AVG(votes_per_round)
FROM votes_per_round;

#WHich round had the highest voting participation?
DROP VIEW highest_voter_turnout;

CREATE VIEW highest_voter_turnout AS
SELECT roundid, MAX(votes_per_round) AS highest_voter_turnout
FROM votes_per_round
GROUP BY roundid
ORDER BY highest_voter_turnout DESC ;

#Voter turnout compared to gas price

#how much spend on gas on AVG?
SELECT AVG(gasUsed) FROM FVT.votedata;

#transaction cost -> eth spent
SELECT AVG(ethSpent) FROM FVT.votedata;
SELECT MAX(ethSpent) FROM FVT.votedata;

#Get csv
SELECT roundid, AVG(ethSpent), count(event)
FROM votedata
GROUP BY roundid;


##Application of QV##

#how many choices a user made on AVG:
#(VoterID can appear many times since a voter can have various votes)
Create VIEW AVG_choices_per_user AS
SELECT distinct voterId, AVG(choicesMade) as AVG_choices_per_user
FROM FVT.votedata
GROUP BY voterID
Order BY voterId;

#Average of the average choices per user
SELECT AVG(AVG_choices_per_user) FROM AVG_choices_per_user;

#Which number of choices was mostly picked?
SELECT choicesMade, COUNT(choicesMade) AS C_Number
FROM   votedata
GROUP BY choicesMade
ORDER BY C_Number DESC;

#How many different combinations of weights?
SELECT COUNT(distinct weights) FROM FVT.votedata;

#Which weight was used the most?
CREATE VIEW weight_combination AS
SELECT Distinct weights, COUNT(roundId) as counts
FROM FVT.votedata
GROUP BY weights
ORDER BY counts DESC;

SELECT* FROM weight_combination
LIMIT 10;

#Which amount of voting power total was used the most?
SELECT voiceCreditsUsed, COUNT( voiceCreditsUsed) AS USEDMOST
FROM votedata
GROUP BY voiceCreditsUsed
ORDER BY USEDMOST DESC;

#How much (in %) of total voting power was spend on average per round?
DROP VIEW vpower_percentage;
CREATE VIEW vpower_percentage AS
SELECT voterId, voiceCreditsUsed, currentVoiceCredits,
       ROUND(voiceCreditsUsed * 100.0 / currentVoiceCredits, 1) AS Percent
FROM votedata;

SELECT AVG(Percent) FROM vpower_percentage;

#Percentage DESC Order
SELECT AVG(Percent) AS PERCENTAGE, currentVoiceCredits 
FROM vpower_percentage
GROUP BY currentVoiceCredits
ORDER BY PERCENTAGE DESC;

# count frequency of percentge 
SELECT Percent, COUNT(Percent) AS Frequency
FROM vpower_percentage
GROUP BY Percent
ORDER BY Frequency DESC;

SELECT * FROM weight_combination
LIMIT 10;


##How did successful voters behave? ##

DROP VIEW voice_vote_data;
#Join Tables voicedata with votedata 
CREATE VIEW voice_vote_data AS
SELECT roundId, voicedata.voiceCredits, voicedata.voterId as v_ID, voicedata.owner AS wallet, votedata.voterId, choices, weights, voiceCreditsUSed, 
choicesMade, currentVoiceCredits 
FROM voicedata 
RIGHT OUTER JOIN votedata
ON voicedata.voterId = votedata.voterId; 

###Top1 wallet
SELECT * FROM voice_vote_data
WHERE wallet = "0x342996D8EAC41fb5ea4ab781863eA66C230C39EA";

#number of voterIds
SELECT COUNT(voterId)
FROM voicedata
WHERE owner = "0x342996D8EAC41fb5ea4ab781863eA66C230C39EA";

#how many rounds participate?
SELECT COUNT(Distinct roundId)
FROM voice_vote_data
WHERE wallet = "0x342996D8EAC41fb5ea4ab781863eA66C230C39EA";

#Voice Credits used?
DROP VIEW vpower_percentage;

CREATE VIEW vpower_percentage As 
SELECT wallet, voiceCreditsUsed, currentVoiceCredits,
       ROUND(voiceCreditsUsed * 100.0 / currentVoiceCredits, 1) AS Percent
FROM voice_vote_data;

SELECT * FROM vpower_percentage;

SELECT AVG(Percent)
FROM vpower_percentage
WHERE wallet = "0x342996D8EAC41fb5ea4ab781863eA66C230C39EA";

# how many choices on avg per round
SELECT choicesMade
FROM voice_vote_data
WHERE wallet = "0x342996D8EAC41fb5ea4ab781863eA66C230C39EA";

#Which combination of weights
SELECT Distinct weights, COUNT(roundId) as counts
FROM voice_vote_data
WHERE wallet = "0x342996D8EAC41fb5ea4ab781863eA66C230C39EA"
GROUP BY weights
ORDER BY counts DESC;

#Top2 wallet
SELECT * FROM voice_vote_data
WHERE wallet = "0x6e5d43A620fC9456A1F23BE69933a516E177dDec";

#number of voterIds
SELECT COUNT(voterId)
FROM voicedata
WHERE owner = "0x6e5d43A620fC9456A1F23BE69933a516E177dDec";

#how many rounds participate?
SELECT COUNT(Distinct roundId)
FROM voice_vote_data
WHERE wallet = "0x6e5d43A620fC9456A1F23BE69933a516E177dDec";

#Voice Credits used?
SELECT AVG(Percent)
FROM vpower_percentage
WHERE wallet = "0x6e5d43A620fC9456A1F23BE69933a516E177dDec";

# how many choices on avg per round
SELECT AVG(choicesMade)
FROM voice_vote_data
WHERE wallet = "0x6e5d43A620fC9456A1F23BE69933a516E177dDec";

#Which combination of weights
SELECT Distinct weights, COUNT(roundId) as counts
FROM voice_vote_data
WHERE wallet = "0x6e5d43A620fC9456A1F23BE69933a516E177dDec"
GROUP BY weights
ORDER BY counts DESC;

#Top3 wallet
SELECT * FROM voice_vote_data
WHERE wallet = "0x67acB72ea79131bb6061470413221B3584Fce640";

#number of voterIds
SELECT COUNT(voterId)
FROM voicedata
WHERE owner = "0x67acB72ea79131bb6061470413221B3584Fce640";

#how many rounds participate?
SELECT COUNT(Distinct roundId)
FROM voice_vote_data
WHERE wallet = "0x67acB72ea79131bb6061470413221B3584Fce640";

#Voice Credits used?
SELECT AVG(Percent)
FROM vpower_percentage
WHERE wallet = "0x67acB72ea79131bb6061470413221B3584Fce640";

# how many choices on avg per round
SELECT AVG(choicesMade)
FROM voice_vote_data
WHERE wallet = "0x67acB72ea79131bb6061470413221B3584Fce640";

#Which combination of weights
SELECT Distinct weights, COUNT(roundId) as counts
FROM voice_vote_data
WHERE wallet = "0x67acB72ea79131bb6061470413221B3584Fce640"
GROUP BY weights
ORDER BY counts DESC;


#Top 1 v_power_earner = top2 , see above

#Top 2 v_power_earner
SELECT * FROM voice_vote_data
WHERE wallet = "0xDcbC0420319736f4dE871914BcB6d106177fCA7D";

#number of voterIds
SELECT COUNT(voterId)
FROM voicedata
WHERE owner = "0xDcbC0420319736f4dE871914BcB6d106177fCA7D";

#how many rounds participate?
SELECT COUNT(Distinct roundId)
FROM voice_vote_data
WHERE wallet = "0xDcbC0420319736f4dE871914BcB6d106177fCA7D";

#Voice Credits used?
SELECT AVG(Percent)
FROM vpower_percentage
WHERE wallet = "0xDcbC0420319736f4dE871914BcB6d106177fCA7D";

# how many choices on avg per round
SELECT AVG(choicesMade)
FROM voice_vote_data
WHERE wallet = "0xDcbC0420319736f4dE871914BcB6d106177fCA7D";

#Which combination of weights
SELECT Distinct weights, COUNT(roundId) as counts
FROM voice_vote_data
WHERE wallet = "0xDcbC0420319736f4dE871914BcB6d106177fCA7D"
GROUP BY weights
ORDER BY counts DESC;

#top3 v_power_earner
SELECT * FROM voice_vote_data
WHERE wallet = "0xB39A3Ec4Ef92F9335a4621B11Cc9e3c4Ebc66B7C";

#number of voterIds
SELECT COUNT(voterId)
FROM voicedata
WHERE owner = "0xB39A3Ec4Ef92F9335a4621B11Cc9e3c4Ebc66B7C";

#how many rounds participate?
SELECT COUNT(Distinct roundId)
FROM voice_vote_data
WHERE wallet = "0xB39A3Ec4Ef92F9335a4621B11Cc9e3c4Ebc66B7C";

#Voice Credits used?
SELECT AVG(Percent)
FROM vpower_percentage
WHERE wallet = "0xB39A3Ec4Ef92F9335a4621B11Cc9e3c4Ebc66B7C";

# how many choices on avg per round
SELECT AVG(choicesMade)
FROM voice_vote_data
WHERE wallet = "0xB39A3Ec4Ef92F9335a4621B11Cc9e3c4Ebc66B7C";

#Which combination of weights
SELECT Distinct weights, COUNT(roundId) as counts
FROM voice_vote_data
WHERE wallet = "0xB39A3Ec4Ef92F9335a4621B11Cc9e3c4Ebc66B7C"
GROUP BY weights
ORDER BY counts DESC;

##Top 10s##

#Check for the top10 voterids with the highest amount of voiceCredits
SELECT * from voicedata ORDER BY voiceCredits DESC;

CREATE VIEW top10votingpower AS 
SELECT DISTINCT voiceCredits AS Voting_Power, voterid FROM FVT.voicedata ORDER BY voiceCredits DESC Limit 10;

SELECT * FROM top10votingpower;

SELECT * FROM voicedata
WHERE voterID = 195 or voterID = 197 or voterID = 1;

