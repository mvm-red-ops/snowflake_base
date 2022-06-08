-- part b of the o and o process is all about uploading the revenue/expenses
-- there are a number of partners, each with their own requirements and formats

    --  1. Open the 'Data Source Map' in Google sheets: https://docs.google.com/spreadsheets/d/1ATkNwhEeHWdWrPduuAdTLVt8NvQlp9AFE5mIvJh7AZM/edit#gid=0
    --  2. Filter for Revenue in the 'Label' Column

    -- Nosey Payments/Invoices: https://drive.google.com/drive/u/0/folders/12t56e5-p0ZESxDkxS7hsL8Pu-OMa-EpH

    --  47 Samurai
    --  Amazon Publisher Services
    --  GlewedTV
    --  Pubmatic
    --  Verizon Media
    --  VideoBridge 
    --  Roku Reps (quarterly, so leave year_month_day blank)
    --  SpotX (total for each month at bottom of payment support)

    --  Because all of these have so few values, all pay partners can be grouped together on one csv 
        -- create a csv with the following columns: 
            -- year_month_day, revenue, pay_partner, department_id, impressions, cpm, quarter, year
            --filename format: 'revenue_qx_2x' for example,  'revenue_q4_21'
            -- copy values in manually to the correct columns from the invoices 

                    --  47 Samurai
                        -- Refer only to the 'Nosey Powr' table 
                    --  Amazon Publisher Services
                    --  GlewedTV 
                        -- Use the Total amounts for Impressions, CPM, and Revenue
                    --  Pubmatic 
                        -- Use the Publisher Revenue (Net) value for revenue
                    --  Verizon Media
                        -- Download Verizon Net Revenue Excel Sheet for the quarter 
                        -- Sort/filter by month and 'Marketplace Connection Name' to get rev by month for FireTv and Roku
                        -- Allocate non-Nosey_FireTV/Roku connections to FireTV
                        -- Sum up the Ad Revenue for Nosey_Roku and Nosey_FireTV for each month
                        -- Add the department_id
                    --  VideoBridge 
                        -- Broken out per month between Roku and FireTV
                    --  Roku Reps 
                        -- Revenue is quarterly, so year_month_day may be left blank.
                    --  SpotX (total for each month at bottom of payment support)
                        --Click on SpotX Support folder, click on the Google sheet for the month you're looking for, and the revenue should be the highlighted green value total

        -- Fields to update in the below copy statement: 
        --  filename, pattern (replace where there is an 'X')

copy into revenue(year_month_day, amount, pay_partner, impressions, department_id, cpm, quarter, year, filename)
from (select t.$1, to_number(REPLACE(REPLACE(t.$2, '$', ''), ','), 12, 2), t.$3, to_number(REPLACE(t.$4, ','),12, 0), t.$5, to_number(REPLACE(t.$6, ','),6, 2), t.$7, t.$8,  'revenue_qX_202X'
from @oo_revenue t) pattern='.*revenue_qX_202X.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;
