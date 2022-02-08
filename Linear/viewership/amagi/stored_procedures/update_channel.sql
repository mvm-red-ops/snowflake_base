
-- update channel_id  based on channel name
CREATE OR REPLACE PROCEDURE channel_update_amagi_viewership(quarter STRING, year DOUBLE, channelname STRING)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `update amagi_viewership r
        set r.channel = q.channel_param
        from (
            select r.id as r_id, r.channel, c.name as channel_param  from amagi_viewership r 
            join channels c on (c.name = '` + CHANNELNAME +`')
            where quarter = "QUARTER" and year = "YEAR" and r.channel is null
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
call channel_update_amagi_viewership('q3', '2021'::DOUBLE, 'Nosey'::STRING)
