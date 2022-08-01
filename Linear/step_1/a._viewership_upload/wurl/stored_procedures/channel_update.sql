-- update channel_id  based on channel name
CREATE OR REPLACE PROCEDURE channel_update_wurl(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `update wurl_viewership w
        set w.channel = q.c_name 
        from (
            select w.id as id, w.channel_id as c_id, c.name as c_name from wurl_viewership w
            left join channels c on (c.id = w.channel_id)
            where w.channel_id is not null and channel is null and quarter = "QUARTER" and year = "YEAR"
        ) q
        where w.id = q.id `;
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
