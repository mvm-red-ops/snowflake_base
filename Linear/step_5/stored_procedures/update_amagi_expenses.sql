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
                WHEN CONTAINS(LOWER(description), 'freebie')  THEN 27
                WHEN CONTAINS(LOWER(description), 'distro')  THEN 24
                WHEN CONTAINS(LOWER(description), 'samsung')  THEN 23
                WHEN CONTAINS(LOWER(description), 'rlaxx')  THEN 22
                WHEN CONTAINS(LOWER(description), 'lg')  THEN 30
                WHEN CONTAINS(LOWER(description), 'klowd')  THEN 28
                WHEN CONTAINS(LOWER(description), 'fetch')  THEN 31
                ELSE  null
            END as parent_id,
            CASE
                WHEN CONTAINS(LOWER(description), 'freebie')  THEN 'Freebie TV'
                WHEN CONTAINS(LOWER(description), 'distro')  THEN 'Distro TV'
                WHEN CONTAINS(LOWER(description), 'samsung')  THEN 'Samsung'
                WHEN CONTAINS(LOWER(description), 'rlaxx')  THEN 'Rlaxx'
                WHEN CONTAINS(LOWER(description), 'lg')  THEN 'Lg'
                WHEN CONTAINS(LOWER(description), 'klowd')  THEN 'KlowdTV'
                WHEN CONTAINS(LOWER(description), 'fetch')  THEN 'FetchTV'
                ELSE  null
            END as parent_name
            from expenses
            where deal_parent is null and description is not null and quarter = "QUARTER" and year = "YEAR" 
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
CREATE OR REPLACE PROCEDURE  update_amagi_invoices(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE expenses r 
        SET deal_parent = sub_r.parent_id,
            department =  sub_r.parent_name,
            territory_id = sub_r._territory_id,
            channel_id = sub_r._channel_id
        FROM(
        select description,id,  
            CASE
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'freebie')  THEN 1
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'distro')  THEN 1
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'samsungau')  THEN 10
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'samsungca')  THEN 4
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'samsungus')  THEN 1
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'samsungin')  THEN 6
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'rlaxx')  THEN 1
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'lg')  THEN 1
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'klowd')  THEN 1
                WHEN CONTAINS(LOWER(REPLACE(description, ' ')), 'fetch')  THEN 1
                ELSE  null
            END as _territory_id,
                        CASE
                WHEN CONTAINS(LOWER(description), 'freebie')  THEN 27
                WHEN CONTAINS(LOWER(description), 'distro')  THEN 24
                WHEN CONTAINS(LOWER(description), 'samsung')  THEN 23
                WHEN CONTAINS(LOWER(description), 'rlaxx')  THEN 22
                WHEN CONTAINS(LOWER(description), 'lg')  THEN 30
                WHEN CONTAINS(LOWER(description), 'klowd')  THEN 28
                WHEN CONTAINS(LOWER(description), 'fetch')  THEN 31
                ELSE  null
            END as parent_id,
            CASE
                WHEN CONTAINS(LOWER(description), 'freebie')  THEN 'Freebie TV'
                WHEN CONTAINS(LOWER(description), 'distro')  THEN 'Distro TV'
                WHEN CONTAINS(LOWER(description), 'samsung')  THEN 'Samsung'
                WHEN CONTAINS(LOWER(description), 'rlaxx')  THEN 'Rlaxx'
                WHEN CONTAINS(LOWER(description), 'lg')  THEN 'Lg'
                WHEN CONTAINS(LOWER(description), 'klowd')  THEN 'KlowdTV'
                WHEN CONTAINS(LOWER(description), 'fetch')  THEN 'FetchTV'
                ELSE  null
            END as parent_name,
                CASE
                WHEN CONTAINS(LOWER(TRIM(description)), 'realnosey')  THEN 9
                WHEN CONTAINS(LOWER(TRIM(description)), 'judgenosey')  THEN 10
                WHEN CONTAINS(LOWER(TRIM(description)), 'noseycasos')  THEN 11
                WHEN CONTAINS(LOWER(TRIM(description)), 'noseycâsos')  THEN 12
                WHEN CONTAINS(LOWER(TRIM(description)), 'noseyescándalos')  THEN 13
                WHEN CONTAINS(LOWER(TRIM(description)), 'noseyescândalos')  THEN 14
                ELSE  8
            END as _channel_id
            from expenses
            where deal_parent is null and description is not null and quarter = "QUARTER" and year = "YEAR" 
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




