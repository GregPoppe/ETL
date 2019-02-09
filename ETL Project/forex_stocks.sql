use indicators_db;

drop table if exists forex_stocks;

create table forex_stocks as 

select a.*
	,b.average as Ebay
	,c.average as Amazon
    ,d.average as Microsoft
    ,e.average as Cisco
    ,f.average as Apple
    ,g.ThreeWhiteSoldiers

from raw_data_db.EUR_USD_M5_A_Source a
	inner join raw_data_db.Stock b
		on a.unix = b.UTC_Unix and b.Stock = 'EBAY'
	inner join raw_data_db.Stock c
		on a.unix = c.UTC_Unix and c.Stock = 'AMZN'
	inner join raw_data_db.Stock d
		on a.unix = d.UTC_Unix and d.Stock = 'MSFT'
	inner join raw_data_db.Stock e
		on a.unix = e.UTC_Unix and e.Stock = 'CSCO'
	inner join raw_data_db.Stock f
		on a.unix = f.UTC_Unix and f.Stock = 'AAPL'
	inner join indicators_db.CandleSticks g
		on  a.unix = g.unix
        

;


ALTER TABLE forex_stocks
ADD PRIMARY KEY (unix);



