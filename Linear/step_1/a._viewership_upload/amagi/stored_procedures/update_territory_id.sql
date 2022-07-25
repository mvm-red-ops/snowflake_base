-- update territory_id field based on territory abbreviation
CREATE OR REPLACE PROCEDURE territory_update_amagi_viewership(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `update amagi_viewership r
        set r.territory_id = q.t_id 
        from (
            select r.id as r_id,channel_name, substr(channel_name, len(channel_name) - 1), t.name, t.abbreviations
            from amagi_viewership r 
            left join territories t on (array_contains(substr(channel_name, len(channel_name) - 1)::variant, t.abbreviations))
            where  quarter = "QUARTER" and year = "YEAR" and territory_id is null        
        ) q
        where r.id = q.r_id `;
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
call territory_update_amagi_viewership('q3', 2021::DOUBLE);

