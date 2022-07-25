-- update month based on date_unformatted field 
CREATE OR REPLACE PROCEDURE deal_parent_update_amagi(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE amagi_viewership r SET deal_parent = sub_r.q_deal_parent
        FROM (select id,  
          CASE
              WHEN CONTAINS(LOWER(channel_name), 'samsung')  THEN 23
              WHEN CONTAINS(LOWER(channel_name), 'rlaxx')  THEN 22
              WHEN CONTAINS(LOWER(channel_name), 'distro')  THEN 24
              WHEN CONTAINS(LOWER(channel_name), 'freebie')  THEN 27
              WHEN CONTAINS(LOWER(channel_name), 'klowd')  THEN 28
              WHEN CONTAINS(LOWER(channel_name), 'lg')  THEN 30
              WHEN CONTAINS(LOWER(channel_name), 'fetch')  THEN 31
              WHEN CONTAINS(LOWER(channel_name), 'fubo')  THEN 34
              WHEN CONTAINS(LOWER(channel_name), 'tubi')  THEN 39
            ELSE  null
          END as q_deal_parent
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