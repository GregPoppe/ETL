
use raw_data_db;

select unix
	,DateTime
	, ask_o as Period_Open
    ,(unix - lag(unix, 1) Over (Partition by pair order by unix))/60 as TimeCheck    
	,Avg(Ask_o) Over (Partition by pair order by unix rows between 12 Preceding and current Row) as Mov_Avg12
	,Avg(Ask_o) Over (Partition by pair order by unix rows between 26 Preceding and current Row) as Mov_Avg26
	,Avg(Ask_o) Over (Partition by pair order by unix rows between 12 Preceding and current Row)
		- Avg(Ask_o) Over (Partition by pair order by unix rows between 26 Preceding and current Row) as MACD_12_26

    

from EUR_USD_M5_A_Source 



;












