-- viewership record check 

-- samsung 

    -- total viewership records (1066)
    select * from wurl_viewership where deal_parent = 18 and quarter = 'q3' and year = 2021 


-- trc
    -- total viewership records 1436
    select * from wurl_viewership where deal_parent = 16 and quarter = 'q3' and year = 2021 


-- vizio
    -- total viewership records 1436
    select * from wurl_viewership where deal_parent = 20 and quarter = 'q3' and year = 2021 


-- plex
    -- total viewership records 2204
    select * from wurl_viewership where deal_parent = 21 and quarter = 'q3' and year = 2021 




-- viewership record check make sure no tot_hov is null
    select * from wurl_viewership where quarter = 'q3' and year = 2021 and tot_hov is null 

    -- if null tot_hov, update
    update wurl_viewership
    set tot_hov = 0
    where quarter = 'q3' and year = 2021 and tot_hov is null