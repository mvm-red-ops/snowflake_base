-- year mobnth day	department	dealparent	description	Title	Revenue Share	Provider	year	quarter	type	title


-- distribution
copy into register(year_month_day, department, deal_parent, description, title, amount, year, quarter,territory_id, channel_id, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    REPLACE(REPLACE(t.$6, '$'), ','),
    t.$7,
    t.$8,
    t.$9,
    t.$10,
    t.$11,
    t.$12, 'historical_register.csv'
        from @distribution_partners t) pattern='.*historical_register_dist_partners.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;



-- oo
copy into register(year_month_day, department, deal_parent, description, type, title, impressions, amount, remaining_allocation, invoice_number, year, quarter,territory_id, channel_id, filename) 

department, , impressions
