
-- WURL XUMO
copy into WURL_VIEWERSHIP(channel, title, play_count, total_time_watched, asset_duration, avg_play_time, avg_playthrough_rate, asset_id, month, share,ref_id,revenue, deal_parent, year, quarter,filename)
from (select t.$1,t.$2, to_number(t.$3,7,0),t.$4, t.$5, t.$6, to_decimal(t.$7, 11, 10), t.$8, t.$9, to_decimal(REPLACE(t.$10, '%'),6,4), t.$11, to_number(REPLACE(REPLACE(t.$13, '$'), ','), 9, 3),17, 2021, 'q2' ,'xumo_2021_q2'
from @nosey_viewership t) pattern='.*xumo_2021_q2.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCe=TRUE;
