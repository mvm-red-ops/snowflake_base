


CREATE OR REPLACE PROCEDURE month_update_pluto(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE pluto_viewership r SET year_month_day = sub_r.date_formatted 
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
          END as month_, 
        CONCAT('20', SPLIT_PART(date_unformatted, '/', 3)) as year_,
        CONCAT(year_, month_, '01') as date_formatted
        from pluto_viewership
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
call month_update_pluto_viewership('q1', 2022);

