-- 47 samurai 
    -- Pull report from https://drive.google.com/drive/u/0/folders/16G2D-kiP8Eq1VMK1X1CpwrUFV8QxG-r8
copy into revenue(deal_parent, month,	impressions,	revenue, cpm ,	quarter,	year, year_month_day) 
from (select 
    t.$1, 
    t.$2, 
    to_number(REPLACE(t.$3, ','), 16, 2), 
    to_number(REPLACE(t.$4, ','), 7, 2),  
    to_number(REPLACE(t.$5, ','), 12, 2),
    t.$6,
    'q3',
    2021, 
from @revenue t) pattern='.*47_samurai_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;




-- Plex 
    -- Download from https://reporting.plex.tv/ 
    -- 1) Select Ad Revenue
    -- 2) Top right: select date range of report
    -- 3) Run report"
copy into revenue (date_unformatted, partner, product, channel, partner_item_id, territory, gross_revenue, gross_ecpm, costs, net_revenue, revenue, deal_parent, year, quarter, filename)
from (select t.$1,t.$2, t.$3,t.$4, t.$5, t.$6, to_decimal(REPLACE(REPLACE(t.$7, ','), '$'), 12, 2),to_decimal(REPLACE(REPLACE(t.$8, ','), '$'), 8, 2), to_decimal(REPLACE(REPLACE(t.$9, ','), '$'), 10, 2), to_decimal(REPLACE(REPLACE(t.$10, ','), '$'), 12, 2), to_decimal(REPLACE(REPLACE(t.$11, ','), '$'), 12, 2), 21, 2021, 'q3' ,'xumo_2021_q2'
from @revenue t) pattern='.*plex_revenue_21_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCe=TRUE;




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
    -- Rev source 1 Samsung TV+: https://drive.google.com/drive/u/0/folders/1EpyyNnXYXmrPqTsPiT8IkBYjOFBQLE7h
    -- Rev source 2, Samsung Aus: https://drive.google.com/drive/folders/1vf5dDUBHEmF2zVH_dhSeVEE0Agg9zOOs
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
from @revenue t) pattern='.*samsung_revenue_q3_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;


-- vizio 
    -- NEVER MADE LOAD STATEMENT, CAN USE THIS OR CREATE ONE
insert into revenue(month,channel_id, channel,  revenue,	quarter,	year, YEAR_MONTH_DAY,TERRITORY_id,	deal_parent) 
values
(7,	8,	'Nosey',	7480.81, 'q3', 2021, 	'20210701',	1,	20),
(7,	9,	'Real Nosey',	3772.42, 'q3', 2021, 	'20210701',	1,	20),
(8,	8,	'Nosey',	21963.82, 'q3', 2021, 	'20210801',	1,	20),
(8,	9,	'Real Nosey',	14331.65, 'q3', 2021, 	'20210801',	1,	20),
(9,	8,	'Nosey',	28296.53, 'q3', 2021, 	'20210901',	1,	20),
(9,	9,	'Real Nosey',	10744.67, 'q3', 2021, 	'20210901',	1,	20)

-- Xumo 
    -- Pull report from https://drive.google.com/drive/folders/14qLygzta3Ep6Vl-39OvULz1iG5tYauZY

-- KlowdTV 
    -- Pull report from https://drive.google.com/drive/folders/19ScTNTwpDOq6lMm-uy9-VEGsi-d87foi


-- TRC 
    -- https://drive.google.com/drive/u/0/folders/143HGCGPsyWCyUJa4FSjbTrUy4pU58Bwo

    -- Linear
        -- The Channels listed at the top of the file are the total revenue for the quarter for those channels for TRC Linear
        -- Upload those into the quarterly_revenue table 

    -- VOD
        -- The sum of the channel record's revenue is the total quarterly revenue for TRC VOD 
        -- The monthly revenue is the quarterly revenue divided by 3    
        