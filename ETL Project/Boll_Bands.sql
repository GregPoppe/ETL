#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
# TABLE NAME: Boll_Bands
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#Author: Greg Poppe
#Created On: 2-8-2019
#
#Description: Calculated the Bollinger Bands of the values, defined as upper bands and lower bands. Upper and lower bands are 
#			the 20 period moving average of the ask_o and +/- the same period standard deviation of ask_o
#
#
#EDITS: (none)
#
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------#



use indicators_db;

drop table if exists Boll_Bands;

create table Boll_Bands as 



select unix
	,DateTime
	, ask_o as Period_Open
    ,ask_c as Period_Close
    ,(unix - lag(unix, 1) Over (Partition by pair order by unix))/60 as TimeCheck    

 	,Avg(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row) 
		+ 2*(stddev(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row)) as UpperBoll_Band
  
 	,Avg(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row) 
		- 2*(stddev(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row)) as LowerBoll_Band
  
	
 	,(Avg(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row) 
		+ 2*(stddev(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row)))
  
		-
	
 	(Avg(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row) 
		- 2*(stddev(Ask_o) Over (Partition by pair order by unix rows between 20 Preceding and current Row))) as Boll_Band_Range
  
      

from raw_data_db.EUR_USD_M5_A_Source 


;



ALTER TABLE Boll_Bands
ADD PRIMARY KEY (unix);
