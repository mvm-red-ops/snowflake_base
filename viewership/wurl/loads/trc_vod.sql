

copy into WURL_VIEWERSHIP(title, revenue,deal_parent, territory_id, year, quarter, filename) 
from (select  
        t.$1, 
        to_number(REPLACE(REPLACE(t.$2, ','), '$'), 9, 3),  
        25, 1, 2021, 'q3','trc_vod_2021_q3'
from @wurl_viewership t) pattern='.*trc_vod_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE=TRUE;