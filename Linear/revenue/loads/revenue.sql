
-- Invoice Revenue
copy into revenue(deal_parent, revenue, impressions, cpms, territory_id, year_month_day, channel_id, quarter, year) 
from (select t.$1, 
      to_number(REPLACE(t.$2, ','), 12, 2), 
      to_number(REPLACE(t.$3, ','), 16, 2),  
      to_number(REPLACE(t.$4, ','), 8, 2),
      t.$5,
      t.$6,
      t.$7,
      2021,
      'q4'
from @revenue t) pattern='.*q4_21_invoice_revenue.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;



-- WURL Samsung
copy into revenue(month, device, impressions, ecpm, revenue, channel, channel_id, TERRITORY_id,	deal_parent, quarter,	year, YEAR_MONTH_DAY) 
from (select t.$1, 
      t.$2, 
      to_number(REPLACE(t.$3, ','), 16, 2), 
      to_number(REPLACE(t.$4, ','), 7, 2),  
      to_number(REPLACE(t.$5, ','), 12, 2),
      t.$6,
      t.$7,
      t.$8,
      t.$9,//DP 
      T.$10,
      T.$11,
      T.$12
from @episode_details t) pattern='.*samsung_revenue_q3_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;


-- vizio
insert into revenue(month,channel_id, channel,  revenue,	quarter,	year, YEAR_MONTH_DAY,TERRITORY_id,	deal_parent) 
values
(7,	8,	'Nosey',	7480.81, 'q3', 2021, 	'20210701',	1,	20),
(7,	9,	'Real Nosey',	3772.42, 'q3', 2021, 	'20210701',	1,	20),
(8,	8,	'Nosey',	21963.82, 'q3', 2021, 	'20210801',	1,	20),
(8,	9,	'Real Nosey',	14331.65, 'q3', 2021, 	'20210801',	1,	20),
(9,	8,	'Nosey',	28296.53, 'q3', 2021, 	'20210901',	1,	20),
(9,	9,	'Real Nosey',	10744.67, 'q3', 2021, 	'20210901',	1,	20)