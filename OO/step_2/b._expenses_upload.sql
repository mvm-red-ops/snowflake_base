
    --  1. Open the 'Data Source Map' in Google sheets: https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0
    --  2. Filter for Expenses

    -- Nosey Payments/Invoices: https://drive.google.com/drive/u/0/folders/12t56e5-p0ZESxDkxS7hsL8Pu-OMa-EpH

        -- AWS Storage 
            -- Found in AWS Invoices
            -- No 'type' for this one
        -- OAO Ad Serving
            -- Types are 'adserving' or 'roku'
            -- 'Adserving' expenses are taken from the total amount of the top section of the invoice
            -- 'Roku' expenses are taken from the Video Ad Serving fees in the second section

        -- POWR (Unreel) Platform
            -- Click on POWR (Unreel) Invoices folder
            -- Types are 'platform' or 'streaming'
            -- Platform and streaming fees are on separate invoices

        -- create a csv with the following columns: 
                -- year_month_day, amount, pay_partner, type, quarter, year
                -- copy values in manually to the correct columns from the invoices 

            -- fields to update: 
                --  Copy Into Statement: filename 'expenses_qX_202X' and pattern='.*expenses_qX_202X.*' (Replace the 'X')
            
-- COPY INTO STATEMENT:
copy into expenses( year_month_day, amount, pay_partner, type, quarter, year, filename)
from (select t.$1, to_number(REPLACE(REPLACE(t.$2, '$', ''), ','), 12, 2), t.$3, t.$4, t.$5, t.$6,  'expenses_qX_202X'
from @oo_expenses t) pattern='.*expenses_qX_202X.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE; 
