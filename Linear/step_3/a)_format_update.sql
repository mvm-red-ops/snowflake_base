-- update series_id

-- wurl 
  -- title format
  update wurl_viewership
  set formatted_title = standardize(title)
  where formatted_title is null
  

-- amagi 

  -- title format (exclude freebie - doesn't have content_names)
  update amagi_viewership
  set formatted_title = standardize(content_name)
  where formatted_title is null and deal_parent not in (27)


-- pluto 
  -- title format
  update pluto_viewership
  set formatted_title = standardize(title)
    where formatted_title is null



