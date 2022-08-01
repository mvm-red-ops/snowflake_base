

'The Steve Wilkos Show:S17:E68:One Big Mistake?
'

CREATE OR REPLACE PROCEDURE trv_vod_title_update(quarter STRING, year DOUBLE)
    returns string
    language javascript
    strict
    execute as owner
    as
    $$
    var sql_command = 
     `UPDATE wurl_viewership w SET series = q.series, series_num = q.series_num, episode_number = q.episode_num, formatted_title = q.title 
        FROM (select id,  
            SPLIT_PART(title, ':', 1) as series,
            SPLIT_PART(title, ':', 2) as series_num,
            SPLIT_PART(title, ':', 3) as episode_num,
            SPLIT_PART(title, ':', 4) as title
        from wurl_viewership
        where quarter = "QUARTER" and year = "YEAR" and deal_parent = 25
      ) as q
      WHERE w.id = q.id `;
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


    -- FOLLOW UP TO SET TITLE FIELDS CORRECTLY 
    update wurl_viewership 
    set title = formatted_title
    where quarter = 'q1' and year = 2022 and deal_parent = 25

    update wurl_viewership 
    set formatted_title = standardize(title)
    where quarter = 'q1' and year = 2022 and deal_parent = 25



   
-- for month first
call month_update_wurl_viewership('q1', 2022);

