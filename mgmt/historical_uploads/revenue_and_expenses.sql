-- Invoice Month	Department	Vendor	Impressions	Type	Amount	Remaining Allocation	Posted Date	Payment/Invoice Date	Intacct Number	Journal Entry 	Type

-- dist partners revenue
copy into revenue(year_month_day, deal_parent, department, territory_id, channel_id, title, type, amount, remaining_allocation, invoice_number, year, quarter, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    t.$7,
    REPLACE(REPLACE(t.$8, '$'), ','),
    REPLACE(REPLACE(t.$9, '$'), ','),
    t.$10,
    t.$11,
    t.$12, 'historical_revenue.csv'
        from @distribution_partners_revenue t) pattern='.*historical_revenue.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;




-- dist partners expenses

copy into expenses(year_month_day, deal_parent, department, territory_id, channel_id, title, type, amount, remaining_allocation, invoice_number, year, quarter, filename) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    t.$7,
    REPLACE(REPLACE(t.$8, '$'), ','),
    REPLACE(REPLACE(t.$9, '$'), ','),
    t.$10,
    t.$11,
    t.$12, 'historical_expenses.csv'
        from @distribution_partners_expenses t) pattern='.*historical_expenses.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;





copy into revenue(year_month_day, department, title, type, description, amount, remaining_allocation, invoice_number, year, quarter, impressions) 
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    t.$7,
    REPLACE(REPLACE(t.$8, '$'), ','),
    REPLACE(REPLACE(t.$9, '$'), ','),
    t.$10,
    t.$11,
    t.$12, 'historical_revenue.csv'
        from @distribution_partners_revenue t) pattern='.*historical_revenue.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;



-- OO expenses
copy into expenses(year_month_day, department, title, label,type, amount, invoice_number, quarter, year, filename) 
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
    'oo_expenses_2021.csv'
        from @oo_expenses t) pattern='.*oo_expenses_2021.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;


-- OO revenue
copy into revenue (year_month_day, department, title, label,type, amount, invoice_number, quarter, year, filename) 
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
    'oo_revenue_2021_q3_q4_fix.csv'
        from @oo_revenue t) pattern='.*oo_revenue_2021_q3_q4_fix.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;
        
        