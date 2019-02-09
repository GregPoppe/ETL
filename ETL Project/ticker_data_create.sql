use raw_data_db;

drop table ticker_data;

create table ticker_data

(

ticker varchar(255),
comp_name varchar(255),
comp_address varchar(255),
number_employees int,
comp_founded date

)

;


INSERT INTO  ticker_data
       VALUES ('AAPL',  'Apple Inc', '1 infinite loop Cupertino California', 132000, '1976-04-01'),
        ('CSCO',  'Cisco Systems inc', '170 West Tasman Drive, San Jose California', 74200, '1984-12-01'),
        ('AMZN',  'Amazon.com Inc', '410 Terry Avenue, N Seattle Washington', 613300, '1984-07-04'),
        ('EBAY',  'EBAY Inc', '2145 Hamilton Avenue, San Jose California', 14100, '1995-09-03'),
        ('MSFT',  'Microsoft Corp', '1 Microsoft Way, Redmond Washington', 131000, '1975-04-04');





ALTER TABLE ticker_data
ADD PRIMARY KEY (ticker);










