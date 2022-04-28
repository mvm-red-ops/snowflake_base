-- update month based on month field 
CREATE OR REPLACE PROCEDURE month_update_wurl_invoices(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE expenses r SET year_month_day = sub_r.year_month_day 
        FROM(
            select id,  
          CASE
              WHEN SPLIT_PART(month, '_', 1) = 'Jan'  THEN '01'
              WHEN SPLIT_PART(month, '_', 1) = 'Feb'  THEN '02'
              WHEN SPLIT_PART(month, '_', 1) = 'Mar'  THEN '03'
              WHEN SPLIT_PART(month, '_', 1) = 'Apr'  THEN '04'
              WHEN SPLIT_PART(month, '_', 1) = 'May'  THEN '05'
              WHEN SPLIT_PART(month, '_', 1) = 'Jun'  THEN '06'
              WHEN SPLIT_PART(month, '_', 1) = 'Jul'  THEN '07'
              WHEN SPLIT_PART(month, '_', 1) = 'Aug'  THEN '08'
              WHEN SPLIT_PART(month, '_', 1) = 'Sep'  THEN '09'
              WHEN SPLIT_PART(month, '_', 1) = 'Oct'  THEN '10'
              WHEN SPLIT_PART(month, '_', 1) = 'Nov'  THEN '11'
              WHEN SPLIT_PART(month, '_', 1) = 'Dec'  THEN '12'
              ELSE  null
          END as month_, 
        SPLIT_PART(month, '_', 2) as year_,
        CONCAT(year_, month_, '01') as year_month_day
        from expenses
        where  quarter = "QUARTER" and year = "YEAR" and year_month_day is null and type = 'wurl'
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





-- update deal_parent based on description field 
CREATE OR REPLACE PROCEDURE deal_parent_update_wurl_invoices(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE expenses r SET deal_parent = sub_r.parent_id, department =  sub_r.parent_name
        FROM(
            select description,id,  
            CASE
                WHEN CONTAINS(description, 'Plex')  THEN 21
                WHEN CONTAINS(description, 'Vizio')  THEN 20
                WHEN CONTAINS(description, 'Roku')  THEN 16
                WHEN CONTAINS(description, 'Samsung')  THEN 18
                WHEN CONTAINS(description, 'Xumo')  THEN 17
                ELSE  null
            END as parent_id,
            CASE
                WHEN CONTAINS(description, 'Plex')  THEN 'Plex'
                WHEN CONTAINS(description, 'Vizio')  THEN 'Vizio'
                WHEN CONTAINS(description, 'Roku')  THEN 'Roku'
                WHEN CONTAINS(description, 'Samsung')  THEN 'Samsung'
                WHEN CONTAINS(description, 'Xumo')  THEN 'Xumo'
                ELSE  null
            END as parent_name
            from expenses
            where deal_parent is null and description is not null and type = 'wurl'
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





