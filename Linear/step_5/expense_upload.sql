

--  Wurl 
-- go to https://drive.google.com/drive/folders/1EbE5LMfq6OyDusIjKJjwh41vLseQHaSv
-- open the current quarter's folder
-- use the nosey_invoice_parser to get the pdfs into excel form: https://github.com/mvm-red-ops/nosey_invoice_parser

copy into expenses(
    description,
    rate,
    amount,
    month,
    quantity,
    year,
    quarter,
    territory_id
    )
from (select t.$1, 
      to_number(REPLACE(REPLACE(t.$2, ','), '$'), 10, 5),  
      to_number(REPLACE(REPLACE(t.$3, ','), '$'), 10, 2),  
       t.$4, 
      to_number(REPLACE(REPLACE(t.$5, ','), '$'), 15, 4),  
       t.$6,
       t.$7,
from @DISTRIBUTION_PARTNERS_EXPENSES t) pattern='.*wurl_invoices_q4_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;

-- update year_month_day after!
call month_update_wurl_invoices('q4', 2021)
-- update deal_parent after!
call deal_parent_update_wurl_invoices()
-- update the connector expense with no deal_parent to indiviudal fees for 


-- Amagi
-- go to https://drive.google.com/drive/folders/1EbE5LMfq6OyDusIjKJjwh41vLseQHaSv
-- open the current quarter's folder
-- fill in the csv using the invoice expense data 
copy into expenses(
    description,
    quantity,
    rate,
    amount,
    year_month_day,
    year,
    quarter,
    territory_id
    )
from (select t.$2, 
      to_number(REPLACE(REPLACE(t.$3, ','), '$'), 15, 4),  
      to_number(REPLACE(REPLACE(t.$5, ','), '$'), 10, 5),  
      to_number(REPLACE(REPLACE(t.$6, ','), '$'), 10, 2),  
       t.$10, 
       t.$11,
       t.$12,
from @DISTRIBUTION_PARTNERS_EXPENSES t) pattern='.*amagi_invoices_q4_21.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;







-- Historical 
copy into expenses(
    year_month_day,
    deal_parent,
    department,
    territory_id,
    channel_id,
    title,
    type,
    amount,
    remaining_allocation,
    invoice_number,
    year,
    quarter,
    filename
    )
from (select 
        t.$1, 
        t.$2, 
        t.$3, 
        t.$4, 
        t.$5, 
        t.$6, 
        t.$8, 
      to_number(REPLACE(REPLACE(REPLACE(REPLACE(t.$9, ')'), '('), ','), '$'), 20, 5),  
      to_number(REPLACE(REPLACE(REPLACE(REPLACE(t.$10, ')'), '('), ','), '$'), 20, 5),   
       t.$11,
       t.$12,
       t.$13,
       'ExpensesHistorical.csv'
from @DISTRIBUTION_PARTNERS_EXPENSES t) pattern='.*ExpensesHistorical.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE;