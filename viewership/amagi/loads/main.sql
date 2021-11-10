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

-- samsung au
copy into AMAGI_VIEWERSHIP( view_date, channel, channel_name , content_id, content_name, session_count , total_viewership_minutes , unique_viewers	, avg_session_count	, avg_session_duration_per_session , avg_session_duration_per_viewer	, month, ref_id, share ,
revenue ) from (select t.$1, 'Nosey', t.$2, t.$3,t.$4,
    to_number(REPLACE(t.$5, ','), 12, 2), 
    to_number(REPLACE(t.$6, ','), 12, 2),
    to_number(REPLACE(t.$7, ','), 12, 2),
    to_number(REPLACE(t.$8, ','), 8, 2), 
    to_number(REPLACE(t.$9, ','), 8, 2),
    to_number(REPLACE(t.$10, ','), 8, 2),
    t.$11,t.$12, 
    to_decimal(REPLACE(t.$15, '%'),  6, 3),
    to_decimal(REPLACE( t.$16, '$'),  8, 2),
    23, 10
    from @ t) pattern='.*samsung_2021.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;