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
        set r.deal_territory = q.territory_name, r.territory_id = q.t_id 
        from (
            select r.id as r_id,
            CASE
              WHEN UPPER(channel_name) REGEXP '\.*CA' THEN 'Canada'
              WHEN UPPER(channel_name) REGEXP '\.*AU' THEN 'Australia'
              WHEN UPPER(channel_name) REGEXP '\.*IN' THEN 'India'
              WHEN UPPER(channel_name) REGEXP '\.*MX' THEN 'Mexico'
              WHEN UPPER(channel_name) REGEXP '\.*INTL.*' THEN 'International'
            END as territory_name,
            CASE
              WHEN UPPER(channel_name) REGEXP '\.*IN' THEN 6
              WHEN UPPER(channel_name) REGEXP '\.*INTL.*' THEN 2
              WHEN UPPER(channel_name) REGEXP '\.*CA' THEN 4
              WHEN UPPER(channel_name) REGEXP '\.*AU' THEN 10
              WHEN UPPER(channel_name) REGEXP '\.*MX' THEN 8
            END as t_id
            from amagi_viewership r
            where  quarter = "QUARTER" and year = "YEAR" 
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

