
copy into revenue (impressions, revenue, cpm, month, quarter, year, filename)
from (select to_number(REPLACE(t.$1, ','), 12, 0), to_number(REPLACE(REPLACE(t.$2, '$', ''), ','), 12, 2),to_number(REPLACE(REPLACE(t.$3, '$', ''), ','), 6, 2), t.$4, 'q4', 2021,  '47_samurai.csv'
from @owned_and_operated t) pattern='.*47s_revenue.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE; 