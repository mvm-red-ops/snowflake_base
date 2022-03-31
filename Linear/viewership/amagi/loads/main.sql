-- All channels
copy into AMAGI_VIEWERSHIP(
month,
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
ON_ERROR=SKIP_FILE FORCE=TRUE; 



--Update channel_id
UPDATE AMAGI_VIEWERSHIP t1
SET channel_id = t2.id
FROM channels t2
WHERE t1.channel = t2.name;

--Update territory_id
UPDATE AMAGI_VIEWERSHIP t1
    SET territory_id = t2.id
    FROM territories t2
    WHERE t1.country = t2.name and t1.year = 2021 and t1.quarter = 'q3' and t1.deal_parent = 12;

--update device_id
UPDATE AMAGI_VIEWERSHIP t1
    SET device_id = t2.id
    FROM devices t2
    WHERE t1.device = t2.name and t1.year = 2021 and t1.quarter = 'q3' and t1.deal_parent = 12;

-- afterwards update 
territory_id, deal_parent, channel_id, ref_id
