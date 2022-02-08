-- update device based on product field 
CREATE OR REPLACE PROCEDURE device_update_plex_revenue(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
    `UPDATE revenue r 
     SET device_id = q.d_id 
        FROM ( 
            select r.id as r_id, d.id as d_id from revenue r
            join devices d on contains(product, d.name)
            where deal_parent = 21 and year = "YEAR" and quarter = "QUARTER" and device_id is null
        ) as q
      WHERE r.id = q.r_id`;
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
    

-- call
call device_update_plex_revenue('q3', 2021::DOUBLE);
