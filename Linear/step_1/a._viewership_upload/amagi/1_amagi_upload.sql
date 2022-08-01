-- Amagi viewership

-- 1) Log Into Amagi Dashboard (https://analytics.amagi.tv/login)
-- 2) Move to Download Reports
-- 3) Customize Dates for entire quarter
-- 4) Select 'All' Channels 
-- 5) Select 'All' Content 
-- 5) Generate Report 


copy into AMAGI_VIEWERSHIP(
view_date,
channel_name,
content_id,
content_name,
series,
device,
country,
session_count,	
total_viewership_minutes,
unique_viewers,
avg_session_count,
avg_session_duration_per_session,
avg_session_duration_per_viewer,
year, 
quarter,
filename) 
from (
    select t.$1, t.$2, t.$3, t.$4, t.$5,t.$6, t.$7,
    to_number(t.$8, 12, 2),
    to_number(REPLACE(t.$9, ','), 12, 2),
    to_number(REPLACE(t.$10, ','), 12, 2),
    to_number(REPLACE(t.$11, ','), 8, 2),
    to_number(REPLACE(t.$12, ','), 8, 2),
    to_number(REPLACE(t.$13, ','), 8, 2), 
    2022, 'q1', 'amagi_q1_22.csv'  from @distribution_partners t) pattern='.*amagi_q1_22.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;




-- Rlaxx (process invoice first)
copy into AMAGI_VIEWERSHIP(
content_partner,
channel,
CONTENT_NAME,
revenue,	
year, 
quarter,
  deal_parent,
filename) 
from (
    select t.$1, t.$2, t.$3, 
    to_number(REPLACE(REPLACE(t.$5, ','), '$'), 15, 5),
    2022, 'q1', 22, 'rlaxx_invoice_q1_22.csv'  from @distribution_partners t) pattern='.*rlaxx_invoice_q1_22.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;


-- Freebie
copy into AMAGI_VIEWERSHIP(
series,
content_name,
views,
revenue,	
year_month_day, 
year,
quarter,
deal_parent,
filename) 
from (
    select 
    t.$1, 
    t.$1,
    to_number(t.$2 , 20, 5),
    t.$3,
    2022, 'q1', 27, 'freebie_invoice_q1_22.csv'  from @distribution_partners t) pattern='.*freebie_invoice_q1_22.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;