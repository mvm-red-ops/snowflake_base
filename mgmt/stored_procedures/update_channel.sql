

-- update channel_id  based on channel name
CREATE OR REPLACE PROCEDURE channel_update_plex_revenue(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `update revenue r
        set r.channel_id = q.c_id 
        from (
            select r.id as r_id, r.channel, c.id as c_id  from revenue r 
            left join channels c on (c.name = r.channel)
            where deal_parent = 21 and quarter = "QUARTER" and year = "YEAR" and channel_id is null
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
call channel_update_plex_revenue('q3', '2021'::DOUBLE)





