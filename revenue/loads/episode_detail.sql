
-- POST q3 2020
copy into Asset_Revenue(
    title,
    ref_id,
    content_provider,
    series,
    mobile_web_views,
    roku_views,
    xumo_views,
    mobile_web_minutes,
    fire_tv_minutes,
    trv_linear_minutes,
    roku_minutes,
    pluto_tv_minutes,
    vizio_minutes,
    xumo_minutes,
    mobile_web_revenue,
    fire_tv_revenue,	
    roku_revenue,
    pluto_tv_revenue,
    pluto_tv_uk_revenue,
    vizio_revenue,
    xumo_revenue,
    samsung_revenue,
    plex_revenue,
    trc_linear_revenue,
    trc_vod_revenue,
    views,
    minutes,
    revenue
    )
from (select 
t.$1, 
t.$2, 
t.$3, 
t.$4,
REPLACE(t.$5, ','),
REPLACE(t.$6, ','),
REPLACE(t.$7, ','),
REPLACE(t.$8, ','),
REPLACE(t.$9, ','),
REPLACE(t.$10, ','),
REPLACE(t.$11, ','),
REPLACE(t.$12, ','),
REPLACE(t.$13, ','),
REPLACE(t.$14, ','),
REPLACE(REPLACE(t.$15, '$'), ','),
REPLACE(REPLACE(t.$16, '$'), ','),
REPLACE(REPLACE(t.$17, '$'), ','),
REPLACE(REPLACE(t.$18, '$'), ','),
REPLACE(REPLACE(t.$19, '$'), ','),
REPLACE(REPLACE(t.$20, '$'), ','),
REPLACE(REPLACE(t.$21, '$'), ','),
REPLACE(REPLACE(t.$22, '$'), ','),
REPLACE(REPLACE(t.$23, '$'), ','),
REPLACE(REPLACE(t.$24, '$'), ','),
REPLACE(REPLACE(t.$25, '$'), ','),
REPLACE(t.$26, ','),
REPLACE(t.$27, ','),
REPLACE(t.$28, ',')
from @episode_details t) pattern='.*q4_2020.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;



-- q3 2020
copy into Asset_Revenue(
    title,
    ref_id,
    content_provider,
    series,
    mobile_web_views,
    roku_views,
    xumo_views,
    mobile_web_minutes,
    fire_tv_minutes,
    trv_linear_minutes,
    roku_minutes,
    pluto_tv_minutes,
    xumo_minutes,
    mobile_web_revenue,
    fire_tv_revenue,	
    roku_revenue,
    pluto_tv_revenue,
    pluto_tv_uk_revenue,
    xumo_revenue,
    samsung_revenue,
    plex_revenue,
    trc_linear_revenue,
    trc_vod_revenue,
    views,
    minutes,
    revenue
    )
from (select 
t.$1, 
t.$2, 
t.$3, 
t.$4,
REPLACE(t.$5, ','),
REPLACE(t.$6, ','),
REPLACE(t.$7, ','),
REPLACE(t.$8, ','),
REPLACE(t.$9, ','),
REPLACE(t.$10, ','),
REPLACE(t.$11, ','),
REPLACE(t.$12, ','),
REPLACE(t.$13, ','),
REPLACE(REPLACE(t.$14, '$'), ','),
REPLACE(REPLACE(t.$15, '$'), ','),
REPLACE(REPLACE(t.$16, '$'), ','),
REPLACE(REPLACE(t.$17, '$'), ','),
REPLACE(REPLACE(t.$18, '$'), ','),
REPLACE(REPLACE(t.$19, '$'), ','),
REPLACE(REPLACE(t.$20, '$'), ','),
REPLACE(REPLACE(t.$21, '$'), ','),
REPLACE(REPLACE(t.$22, '$'), ','),
REPLACE(REPLACE(t.$23, '$'), ','),
REPLACE(t.$24, ','),
REPLACE(t.$25, ','),
REPLACE(t.$26, ',')
from @episode_details t) pattern='.*q3_2020.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;















Concat 	
Total Minutes of Airtime	 	
Tot. Episode HOV 
Monthly Share	
Share 2 (100% only)	
Revenue