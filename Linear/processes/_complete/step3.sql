-- perform title matches

-- check records
//samsung 

    //total viewership records (1066)
    select * from wurl_viewership where deal_parent = 18 and quarter = 'q4' and year = 2021 and (ref_id = 'externalId' or ref_id is null)


//trc
    //total viewership records 1436
    select * from wurl_viewership where deal_parent = 16 and quarter = 'q4' and year = 2021  and (ref_id = 'externalId' or ref_id is null)


//vizio
    //total viewership records 1436
    select * from wurl_viewership where deal_parent = 20 and quarter = 'q4' and year = 2021 and (ref_id = 'externalId' or ref_id is null)


//plex
    //total viewership records 2204
    select * from wurl_viewership where deal_parent = 21 and quarter = 'q4' and year = 2021 and (ref_id = 'externalId' or ref_id is null)


-- perform matching process (see 'asset_matching_by_title.sql')
