
    --  1. Open the 'Data Source Map' in Google sheets: https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0
    --  2. Filter for Expenses

    -- Nosey Payments/Invoices: https://drive.google.com/drive/u/0/folders/12t56e5-p0ZESxDkxS7hsL8Pu-OMa-EpH

    -- AWS Storage
    -- OAO Ad Serving
    -- POWR (Unreel) Platform



      -- create a csv with the following columns: 

            -- year_month_day, amount, pay_partner, type, quarter, year
            -- copy values in manually to the correct columns from the invoices 
        -- fields to update: 
        --  filename, year, quarter, pattern
        copy into expenses( year_month_day, amount, pay_partner, type, quarter, year, filename)
        from (select t.$1, to_number(REPLACE(REPLACE(t.$2, '$', ''), ','), 12, 2), t.$3, t.$4, t.$5, t.$6,  'expenses_q4_21'
        from @owned_and_operated t) pattern='.*rev_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE; 
        


        

    
