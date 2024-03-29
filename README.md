# Raised to the Power 
## A review of finance.vote's usage of quadratic voting mechanism for predicting crypto markets


### Project Intro/Objective
With the aim of building the foundation of a decentralised decision making and will upgrade the governance capabilities of the whole crypto space as a whole, [finance.vote](https://www.finance.vote) is developing future infrastructure for decentraized autnomous organizations DAOs. Over the past years plenty of these dApps have been launched and tested. The first building block of this new governnce architecture has been the voting markets. 

[markets.vote](https://marketsdotvote.eth.link/#/) is a prediction market and collective intelligence tool, which uses quadratic voting and a decentralised identity system to curate emerging markets and reach consensus on the perceived future performance of assets. Since October 2020, users have voted over 37 rounds to predict the market performance of Defi tokens using a new voting mechanism called Quadratic Voting. 

This report analyses the information that was compiled from those votes. The main questions answered are:

* How did users interact with the platform?
* How did voters apply Quadratic Voting? 
* What makes a user a successful predictor?
* What is the predictive power of markets.vote?


### Some more background information on markets.vote:**

**What is Quadratic Voting**
Quadratic Voting is a method of collective decision-making in which a participant votes not just for or against an issue, but also expresses how strongly they feel about it. It can help protect the interests of small groups of voters that care deeply about particular issues. 

In Quadratic Voting, each participant is given a number of credits that can be used to vote for an issue. However, the cost of casting more than one vote for an issue is quadratic, not linear. So, the marginal cost of each additional vote is far higher than of the previous vote.
[towardsdatascience.com](https://towardsdatascience.com/what-is-quadratic-voting-4f81805d5a06)

**How does markets.vote work**
Users are incentives to make market predictions in a series of tournaments focussed on a basket of crypto assets. 

Quadratic voting is used to generate a consensus in a perceived future market order. Users then spend a budget of vote power to create a new order, based on their perception of token quality and future potential market performance.Users are rewarded with a proportional share of a network generated reward pool depending on the proportionality of their correctness. Users can amplify their vote power beyond the starting level by demonstrating a history of correct decision making in the markets, or by purchasing more identities.



### Description of the Data
[voice-data_ETH-52.csv](https://github.com/datadeo/market.vote_analysis/blob/main/voice-data_ETH_52.csv) ,
[voice-data_BSC-30.csv](https://github.com/datadeo/market.vote_analysis/blob/main/Vote-Data_BSC_30.csv)
***voiceCredits*** - the amount of voting power accumulated
***voterID*** - unique number for each finance.vot identity
Data for 52 Rounds on ETH Mainnet and 30 Rounds on BSC

[Marketwinner_ETH.csv](https://github.com/datadeo/market.vote_analysis/blob/main/Marketwinner_ETH.csv) ,
[Marketwinner_BSC.csv](https://github.com/datadeo/market.vote_analysis/blob/main/market_winner_bsc.csv)
***round*** - completed round
***winnerindex*** - top-voted coin in that round, coins are indexed according to their position in the voting table
Both datasets are for 30 rounds

[ID_per_wallet_ETH_30.xml](https://github.com/datadeo/market.vote_analysis/blob/main/ID_per_wallet_ETH_30.xml) ,
[ID_per_wallet_BSC_30.xml](https://github.com/datadeo/market.vote_analysis/blob/main/ID_per_wallet_BSC_30.xml)
***voterIds*** - the number of identities each wallet minted
***coin*** - winning coin
Snapshot taken after 30 rounds

[vote-data_ETH_52.csv](https://github.com/datadeo/market.vote_analysis/blob/main/vote-data_ETH_52.csv) ,
[vote-data_BSC_30.csv](https://github.com/datadeo/market.vote_analysis/blob/main/Vote-Data_BSC_30.csv)
***roundid*** - number of rounds
***voterID*** - unique number for each finance.vot identity
***choices*** - index of the coins that were picked in each vote, the index is similiar to winnerindex, each coin is indexed according to its position in the voting table
***weights*** - the combination that was picked to weight the respective votes, per default users have 100$V (voting power). The amount of $V spent is the square of the weights
***voiceCreditsused*** - the amout of voting power spent
***choicesmade*** - total number of choices made
***currentVoiceCredits*** - total of voting power user holds at moment of vote
Data for 52 Rounds on ETH Mainnet and 30 Rounds on BSC

### Methods Used
* Descriptive Statistics
* Data Visualization


### Technologies
* SQL
* Dune Dashboard
* Excel
* Pandas,jupyter


## Featured Notebooks/Analysis/Deliverables
* [Clean Datasets as CSV](https://github.com/Lizzl/market.vote_analysis)
* [SQL Queries](https://github.com/Lizzl/market.vote_analysis/blob/main/voting_markets_EDA.sql)
* [Report](https://cryptpad.fr/file/#/2/file/CEkavekX8koJowgJHwiLTWFA/)
* Dune Dashboard 


