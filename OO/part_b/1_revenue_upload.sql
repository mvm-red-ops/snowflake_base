-- part b of the o and o process is all about uploading the revenue/expenses
-- there are a number of partners, each with their own requirements and formats

    --  1. Open the 'Data Source Map' in Google sheets: https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0
    --  2. Filter for Revenue

    -- Nosey Payments/Invoices: https://drive.google.com/drive/u/0/folders/12t56e5-p0ZESxDkxS7hsL8Pu-OMa-EpH

    --  47 Samurai
    --  Amazon Publisher Services
    --  GlewedTV
    --  Pubmatic
    --  Verizon Media
    --  VideoBridge 
    --  Roku Reps (quarterly, so leave year_month_day blank)
    --  SpotX (total for each month at bottom of payment support)

    --  Because all of these have so few values, we can group them together on one csv 
        -- create a csv with the following columns: 
            -- year_month_day, revenue, pay_partner, impressions, cpm, quarter, year
            -- copy values in manually to the correct columns from the invoices 
        -- fields to update: 
        --  filename, year, quarter, pattern
        copy into revenue( year_month_day, revenue, pay_partner, impressions, cpm, quarter, year, filename)
        from (select t.$1, to_number(REPLACE(REPLACE(t.$2, '$', ''), ','), 12, 2), t.$3, to_number(REPLACE(t.$4, ','),12, 0), to_number(REPLACE(t.$4, ','),6, 2), t.$5, t.$6,  'revenue_q4_21'
        from @owned_and_operated t) pattern='.*revenue_q4_21.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE; 
        


        

    
