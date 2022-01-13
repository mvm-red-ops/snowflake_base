-- distrovTv
copy into AMAGI_VIEWERSHIP(view_date,
channel_name,
session_count,	
total_viewership_minutes,
unique_viewers,
avg_session_count,
avg_session_duration_per_session ,
avg_session_duration_per_viewer,
territory_id,
deal_parent, 
year, 
quarter) 
from (select t.$1, t.$2, to_number(t.$3, 12, 2), to_number(REPLACE(t.$4, ','), 12,2),to_number(REPLACE(t.$5, ','),12,2),
    to_number(REPLACE(t.$6, ','), 8, 2),
    to_number(REPLACE(t.$7, ','), 8, 2),
    to_number(REPLACE(t.$8, ','), 8, 2), 
    4, 9, 2021, 'q2' from @amagi_viewership t) pattern='.*distro_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;


--
copy into AMAGI_VIEWERSHIP( 
    date_interval, channel_name,content_id, content_name, SESSION_COUNT, 
    TOTAL_VIEWERSHIP_MINUTES,UNIQUE_VIEWERS,AVG_SESSION_COUNT,AVG_SESSION_DURATION_PER_SESSION,
    AVG_SESSION_DURATION_PER_VIEWER, year, quarter
)
from (select t.$1, t.$3,t.$4,t.$5, 
         to_number(REPLACE(t.$6, ','), 12, 2),
    to_number(REPLACE(t.$7, ','), 12, 2),
    to_number(REPLACE(t.$8, ','), 12, 2), 
    to_number(REPLACE(t.$9, ','), 8, 2),
    to_number(REPLACE(t.$10, ','), 8, 2),
    to_number(REPLACE(t.$11, ','), 8, 2),
    2021, 'q3'
    from @amagi_viewership t
)
pattern='.*amagi_q3_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;



-- afterwards update 
territory_id, deal_parent, channel_id, ref_id