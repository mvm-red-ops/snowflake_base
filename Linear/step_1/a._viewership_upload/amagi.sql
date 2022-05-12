-- Amagi viewership

-- "Pull Samsung Canada Data from Amagi
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
    select t.$1, t.$2, t.$3, t.$4, t.$5,
    to_number(t.$6, 12, 2),
    to_number(REPLACE(t.$7, ','), 12, 2),
    to_number(REPLACE(t.$8, ','), 12, 2),
    to_number(REPLACE(t.$9, ','), 8, 2),
    to_number(REPLACE(t.$10, ','), 8, 2),
    to_number(REPLACE(t.$11, ','), 8, 2), 
    2021, 'q4', 'amagi_q4_21.csv'  from @distribution_partners t) pattern='.*amagi_q4_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;




-- Rlaxx
copy into AMAGI_VIEWERSHIP(
channel,
CONTENT_NAME,
revenue,	
year, 
quarter,
  deal_parent,
filename) 
from (
    select t.$2, t.$3, 
    to_number(REPLACE(REPLACE(t.$5, ','), '$'), 15, 5),
    t.$6, t.$7, 22, 'rlaxx_episodic_q4_21.csv'  from @distribution_partners t) pattern='.*rlaxx_episodic_q4_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;