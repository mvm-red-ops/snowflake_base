--  1. MONTH UPDATE
--  2. TITLE UPDATE
--  3. SERIES UPDATE


--  1. MONTH UPDATE
    -- updates year_month_day column from date formatted as (mm/dd/yyyy)
    call month_update_pluto('QUARTER', YEAR)




--  2. TITLE UPDATE (TODO MAKE STORED PROCEDURE THAT ACCOUNTS FOR BOTH LENGTHS)
    -- set title = clip_name where clip_name doesn't have a ":" 
    update pluto_viewership 
    set title = clip_name
    where not contains(clip_name, ':') and year = 2022 and quarter = 'q1' and title is null


    -- set title = clip_name where clip_name has a ":", use the get_title_pluto function to derive title
    update pluto_viewership 
    set title = get_title_pluto(clip_name)
    where contains(clip_name, ':') and year = 2022 and quarter = 'q1' 


        -- ##VERIFY
        -- check clip_names that are creating null values (should all be in the format 'SERIES:TITLE:NUMBER)
        select clip_name from pluto_viewership where  year = 2022 and quarter = 'q1' and title is null
        group by clip_name

    -- If all clip names are in the right format update using
    update pluto_viewership 
    set title = get_long_title_pluto(clip_name)
    where contains(clip_name, ':') and year = 2022 and quarter = 'q1' and title is null




--  3. SERIES UPDATE