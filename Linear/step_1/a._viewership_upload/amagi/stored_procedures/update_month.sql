-- update month based on date_unformatted field 
CREATE OR REPLACE PROCEDURE month_update_amagi_viewership(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE amagi_viewership r SET month = sub_r.year_month_day 
        FROM (select id,  
          CASE
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Jan'  THEN '01'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Feb'  THEN '02'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Mar'  THEN '03'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Apr'  THEN '04'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'May'  THEN '05'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Jun'  THEN '06'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Jul'  THEN '07'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Aug'  THEN '08'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Sep'  THEN '09'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Oct'  THEN '10'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Nov'  THEN '11'
              WHEN SPLIT_PART(date_interval, '-', 1) = 'Dec'  THEN '12'
              ELSE  null
          END as month_, 
        CONCAT('20', SPLIT_PART(date_interval, '-', 2)) as year_,
        CONCAT(year_, month_, '01') as year_month_day
        from amagi_viewership
        where quarter = "QUARTER" and year = "YEAR" and month is null
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

-- month second
CREATE OR REPLACE PROCEDURE month_update_amagi_viewership_backup(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE amagi_viewership r SET month = sub_r.year_month_day 
        FROM (select id,  
          CASE
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Jan'  THEN '01'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Feb'  THEN '02'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Mar'  THEN '03'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Apr'  THEN '04'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'May'  THEN '05'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Jun'  THEN '06'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Jul'  THEN '07'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Aug'  THEN '08'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Sep'  THEN '09'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Oct'  THEN '10'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Nov'  THEN '11'
              WHEN SPLIT_PART(date_interval, '-', 2) = 'Dec'  THEN '12'
              ELSE  null
          END as month_, 
        CONCAT('20', SPLIT_PART(date_interval, '-', 1)) as year_,
        CONCAT(year_, month_, '01') as year_month_day
        from amagi_viewership
        where quarter = "QUARTER" and year = "YEAR" and month is null
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
call month_update_amagi_viewership('q3', 2021::DOUBLE);

-- for month second
 call month_update_amagi_viewership_backup('q3', 2021::DOUBLE);
