-- year mobnth day	department	dealparent	description	Title	Revenue Share	Provider	year	quarter	type	title


-- distribution
copy into register(year_month_day, department, title, lineitemtype, type, content_provider, amount, quarter,  year, territory_id, deal_parent, channel_id, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    REPLACE(REPLACE(t.$7, '$'), ','),
    t.$8,
    t.$9,
     1,
     25, 
     8, 
     'filename.csv'
        from @distribution_partners_revenue t) pattern='.*filename.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;
        


-- Owned and Operated
copy into register(year_month_day, department, title, lineitemtype, type, content_provider, amount, year, quarter, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    REPLACE(REPLACE(REPLACE(t.$7, '#VALUE!', 0), '$'), ','),
    2020,
    'q4',
    'historical_oo_content_provider_share.csv'
        from @oo_revenue t) pattern='.*historical_oo_content_provider_share.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;




