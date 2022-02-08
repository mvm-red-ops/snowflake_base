
-- xumo

INSERT INTO revenue (month, year, quarter, year_month_day, deal_parent, provider, partner, revenue)
values(4, 2021, 'q2', '20210401', 17, '47 Samurai', 'Xumo', '64.78'),
(5, 2021, 'q2', '20210501', 17, '47 Samurai', 'Xumo', '322.43'),
(6, 2021, 'q2', '20210601', 17, '47 Samurai', 'Xumo', '157.38'),
(4, 2021, 'q2', '20210401', 17, '47 Samurai', 'Xumo', '7524.98'),
(5, 2021, 'q2', '20210501', 17, '47 Samurai', 'Xumo', '10802.93'),
(6, 2021, 'q2', '20210601', 17, '47 Samurai', 'Xumo', '11269.49')





-- WURL Samsung
copy into revenue(month,	device,	impressions,	ecpm,	revenue,	channel, channel_id, TERRITORY_id,	deal_parent,	quarter,	year, YEAR_MONTH_DAY) 
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