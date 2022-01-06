--stored procedures
-- 1 update month based on date_unformatted field 
CREATE OR REPLACE PROCEDURE month_update_plex_revenue(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE revenue r SET year_month_day = sub_r.year_month_day 
        FROM (select id,  
          CASE
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Jan'  THEN '01'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Feb'  THEN '02'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Mar'  THEN '03'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Apr'  THEN '04'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'May'  THEN '05'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Jun'  THEN '06'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Jul'  THEN '07'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Aug'  THEN '08'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Sep'  THEN '09'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Oct'  THEN '10'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Nov'  THEN '11'
              WHEN SPLIT_PART(date_unformatted, '-', 2) = 'Dec'  THEN '12'
              ELSE  null
          END as month_, 
        CONCAT('20', SPLIT_PART(date_unformatted, '-', 1)) as year_,
        CONCAT(year_, month_, '01') as year_month_day
        from revenue
        where deal_parent = 21 and quarter = "QUARTER" and year = "YEAR" and month is null
      ) as sub_r
      WHERE r.id = sub_r.id and r.quarter ="QUARTER" and r.year = "YEAR" and r.month is null`;
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