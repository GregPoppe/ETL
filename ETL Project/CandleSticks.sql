
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# TABLE NAME: CandleSticks
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#Author: Greg Poppe
#Created On: 2-8-2019
#
#Description: Calculates defined indicators of candle stick formations. Example: Bullish_Engulfing is defined as and event where
#		the most recent observation has a close price higher than the open, and the previous period had a close price lower than the 
#		open, and the range of the most recent observation is larger than the previous
#
#
#EDITS: (none)
#
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------#


use indicators_db;

drop table if exists CandleSticks;

create table CandleSticks as 

select unix
	,DateTime
	, ask_o as Period_Open
    ,ask_c as Period_Close
    ,(unix - lag(unix, 1) Over (Partition by pair order by unix))/60 as TimeCheck    
	,sum(case when ask_c > ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 2 Preceding and current Row) as Bulls_3
	,sum(case when ask_c > ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 5 Preceding and current Row) as Bulls_6
	,sum(case when ask_c > ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 8 Preceding and current Row) as Bulls_9
	,sum(case when ask_c > ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 11 Preceding and current Row) as Bulls_12
	,sum(case when ask_c > ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 19 Preceding and current Row) as Bulls_20
	,sum(case when ask_c > ask_o + 0.0005 then 1 else 0 end) Over (Partition by pair order by unix rows between 2 Preceding and current Row) as Big_Bulls_3
	,sum(case when ask_c > ask_o + 0.0005 then 1 else 0 end) Over (Partition by pair order by unix rows between 5 Preceding and current Row) as Big_Bulls_6
	,sum(case when ask_c > ask_o + 0.0005 then 1 else 0 end) Over (Partition by pair order by unix rows between 8 Preceding and current Row) as Big_Bulls_9
    
	,sum(case when ask_c < ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 6 Preceding and 3 Preceding) as Bears_3_6	
	,case when sum(case when ask_c < ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 6 Preceding and 3 Preceding) 
		+ sum(case when ask_c > ask_o then 1 else 0 end) Over (Partition by pair order by unix rows between 2 Preceding and current Row) = 6 then 1 else 0 end as ThreeWhiteSoldiers
	
	,case when  lag(ask_c, 1) Over (Partition by pair order by unix) < lag(ask_o, 1) Over (Partition by pair order by unix)
		and ask_c > ask_o
        and ask_c > lag(ask_o, 1) Over (Partition by pair order by unix)
        and ask_o < lag(ask_c, 1) Over (Partition by pair order by unix) then 1 else 0 end as Bullish_Engulfing


from raw_data_db.EUR_USD_M5_A_Source 



;

ALTER TABLE CandleSticks
ADD PRIMARY KEY (unix);