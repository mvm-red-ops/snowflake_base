-- update spotx net_revenue based on gross_revenue and impressions fields
CREATE OR REPLACE PROCEDURE spotx_update_net_revenue(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE spotx s
        SET net_revenue = sub_s.net_revenue
        FROM (
            SELECT id,
                   deal_demand_source,
                   gross_revenue,
                   impressions,
                CASE
                    WHEN deal_demand_source = 'Programmatic' THEN gross_revenue * .80
                    WHEN deal_demand_source = 'SpotX' THEN gross_revenue * .80
                    WHEN deal_demand_source = 'House Ad' THEN -(impressions/1000 * 0.35)
                    WHEN deal_demand_source = 'SpotX Hosted Media' THEN -(impressions/1000 * 0.35)
                    WHEN deal_demand_source = 'Third Party' THEN -(impressions/1000 * 0.35)
                    ELSE null 
                END as net_revenue
            FROM spotx
            WHERE quarter = "QUARTER" and year = "YEAR" and net_revenue is null
        ) as sub_s
        WHERE s.id = sub_s.id`;
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
