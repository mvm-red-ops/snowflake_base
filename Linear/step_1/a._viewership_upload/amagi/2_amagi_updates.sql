

-- update month
-- amagi data gives the view data (if pulled daiy) or date_interval if pulled monthly
-- using that we will update the 'month' and 'year_month_day' columns


CREATE OR REPLACE PROCEDURE month_update_amagi(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE amagi_viewership r SET year_month_day = sub_r.date_formatted, month = sub_r.month_name
        FROM (select id,  
          CASE
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '1'  THEN '01'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '2'  THEN '02'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '3'  THEN '03'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '4'  THEN '04'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '5'  THEN '05'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '6'  THEN '06'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '7'  THEN '07'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '8'  THEN '08'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '9'  THEN '09'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '10'  THEN '10'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '11'  THEN '11'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '12'  THEN '12'
              ELSE  null
          END as month_digit, 
                    CASE
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '1'  THEN 'January'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '2'  THEN 'February'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '3'  THEN 'March'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '4'  THEN 'April'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '5'  THEN 'May'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '6'  THEN 'June'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '7'  THEN 'July'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '8'  THEN 'August'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '9'  THEN 'September'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '10'  THEN 'October'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '11'  THEN 'November'
              WHEN SPLIT_PART(date_unformatted, '/', 1) = '12'  THEN 'December'
              ELSE  null
          END as month_name, 
        CONCAT('20', SPLIT_PART(date_unformatted, '/', 3)) as year_,
        CONCAT(year_, month_digit, '01') as date_formatted
        from amagi_viewership
        where quarter = "QUARTER" and year = "YEAR"
      ) as sub_r
      WHERE r.id = sub_r.id `;
    try {
        snowflake.execute (
            {sqlText: sql_command}
            );
        return "Succeeded.";   // Return a success/error indicator.
        }
    catch (err)  {
        return "Failed: " + err;   // Return a success/error indicator.
        }
    $$;


   
-- for month first
call month_update_amagi_viewership('q1', 2022);
