-- 47 samurai
copy into revenue(deal_parent, month,	impressions,	revenue, cpm ,	quarter,	year, year_month_day) 
from (select 
        t.$1, 
      t.$2, 
      to_number(REPLACE(t.$3, ','), 16, 2), 
      to_number(REPLACE(t.$4, ','), 7, 2),  
      to_number(REPLACE(t.$5, ','), 12, 2),
      'q3',
      2021, 
      t.$1
from @nosey_revenue t) pattern='.*47_samurai_2021_q3.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;