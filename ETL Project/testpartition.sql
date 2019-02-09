
use raw_data_db;

select unix
	,Ebay.UTC_Unix
    ,Ebay.average as Ebay
    ,Amzn.average as Amzn
	,Aapl.average as Aapl
	,Msft.average as Msft
	,Csco.average as Csco
	,DateTime
	, ask_o as Period_Open
    ,(unix - lag(unix, 1) Over (Partition by pair order by unix))/60 as TimeCheck    
    ,lag(Ask_o, 2) Over (Partition by pair order by unix rows between 9 Preceding and current Row) as PrevPrice
	,Avg(Ask_o) Over (Partition by pair order by unix rows between 9 Preceding and current Row) as Mov_Avg9
	,Avg(Ask_o) Over (Partition by pair order by unix rows between 12 Preceding and current Row) as Mov_Avg12
    ,Avg(Ask_o) Over (Partition by pair order by unix rows between 24 Preceding and current Row) as Mov_Avg24
    ,stddev(Ask_o) Over (Partition by pair order by unix rows between 9 Preceding and current Row) as StdDev_9
	,stddev(Ask_o) Over (Partition by pair order by unix rows between 12 Preceding and current Row) as StdDev_12
    ,stddev(Ask_o) Over (Partition by pair order by unix rows between 24 Preceding and current Row) as StdDev_24
    ,max(Ask_o) Over (Partition by pair order by unix rows between 9 Preceding and current Row) as Max_9
    ,max(Ask_o) Over (Partition by pair order by unix rows between 12 Preceding and current Row) as Max_12   
    ,max(Ask_o) Over (Partition by pair order by unix rows between 24 Preceding and current Row) as Max_24
	,10000*sum(Ask_h - Ask_l) Over (Partition by pair order by unix rows between 9 Preceding and current Row) as Movement_9
	,10000*sum(Ask_h - Ask_l) Over (Partition by pair order by unix rows between 12 Preceding and current Row) as Movement_12
  	,10000*sum(Ask_h - Ask_l) Over (Partition by pair order by unix rows between 24 Preceding and current Row) as Movement_24
  	,10000*Avg(Ask_h - Ask_l) Over (Partition by pair order by unix rows between 9 Preceding and current Row) as AvgMov_9
	,10000*Avg(Ask_h - Ask_l) Over (Partition by pair order by unix rows between 18 Preceding and 9 Preceding) as AvgMov_Prev_9     

    
    

from EUR_USD_M5_A_Source 
	inner join Ebay
		on EUR_USD_M5_A_Source.unix = Ebay.UTC_Unix
	inner join Aapl
		on EUR_USD_M5_A_Source.unix = Aapl.UTC_Unix
	inner join Amzn
		on EUR_USD_M5_A_Source.unix = Amzn.UTC_Unix
	inner join Msft
		on EUR_USD_M5_A_Source.unix = Msft.UTC_Unix
	inner join Csco
		on EUR_USD_M5_A_Source.unix = Csco.UTC_Unix





;











