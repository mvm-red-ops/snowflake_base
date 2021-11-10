
UPDATE WURL_VIEWERSHIP w
SET w.tot_hov = t.tot_hours_watched
FROM  (
      SELECT title, month, ref_id , TOTAL_TIME_WATCHED, sum(TRY_CAST(SPLIT_PART(TOTAL_TIME_WATCHED, ':',1)as INTEGER)) as hours,
      sum(TRY_CAST(SPLIT_PART(TOTAL_TIME_WATCHED, ':',2)as INTEGER)/60) as mins, 
      sum(TRY_CAST(SPLIT_PART(TOTAL_TIME_WATCHED, ':',3)as INTEGER) / 360) as secs,
      hours + mins + secs as tot_hours_watched
      FROM WURL_VIEWERSHIP
      WHERE deal_parent = 17 and quarter = 'q2'  
      GROUP BY title, month, ref_id,TOTAL_TIME_WATCHED
 ) t
WHERE (t.ref_id = w.ref_id and t.month = w.month and t.TOTAL_TIME_WATCHED = w.TOTAL_TIME_WATCHED)
