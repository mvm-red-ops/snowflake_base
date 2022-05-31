-- Invoice Month	Department	Vendor	Impressions	Type	Amount	Remaining Allocation	Posted Date	Payment/Invoice Date	Intacct Number	Journal Entry 	Type


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
        from @distribution_partners t) pattern='.*historical_revenue.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;





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
        from @distribution_partners t) pattern='.*historical_expenses.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;


