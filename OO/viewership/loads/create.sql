copy into powr_viewership(
    uid, 
    title, 
    type, 
    channel, 
    views, 
    watch_time_seconds, 
    average_watch_time_seconds, 
    platform, 
    geo, 
    year_month_day,
    quarter,
    year,
    filename
)   
from (select t.$1, t.$2, t.$3, t.$4, to_number(REPLACE(t.$5, ','), 12, 2), to_decimal(REPLACE(t.$6,  ','), 12, 2), to_number(REPLACE(REPLACE(t.$7, '-', ''), ','), 16, 6), t.$8, t.$9, t.$10, 'q4', 2021,  'powr_viewership.csv'
from @onwed_and_operated_aws t) pattern='.*powr_viewership.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;