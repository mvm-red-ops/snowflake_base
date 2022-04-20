-- update territory_id field based on territory abbreviation
CREATE OR REPLACE PROCEDURE territory_update_plex_revenue(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `update revenue r
        set r.territory_id = q.t_id 
        from (
            select r.id as r_id, r.territory,  t.abbreviations, t.id as t_id  from revenue r 
            left join territories t on (array_contains(r.territory::variant, t.abbreviations))
            where deal_parent = 21 and quarter = "QUARTER" and year = "YEAR" and territory_id is null
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
call territory_update_plex_revenue('q3', 2021::DOUBLE);
