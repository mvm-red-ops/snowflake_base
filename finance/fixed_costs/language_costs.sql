
copy into foreign_language_fixed_costs(
  content_provider,
  description,
  series_key,
  year_month_day,
  kitchen_tv_pp_video_edit,
  sphere_x_pp_content_ratings,
  rev_ai_pp_cc,
  total,
  year_month_day_applied,
  journal_entry,
  year,
  quarter,
  filename
)
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    REPLACE(REPLACE(t.$5, '$'), ','),
    REPLACE(REPLACE(t.$6, '$'), ','),
    REPLACE(REPLACE(t.$7, '$'), ','),
    REPLACE(REPLACE(t.$8, '$'), ','),
    t.$9,
    t.$10,
    2021,
    'q4'
    'fixed_language_q4_21.csv'
        from @fixed_costs t) pattern='.*fixed_language_q4_21.*' file_format = GENERIC_CSV 
        ON_ERROR=SKIP_FILE FORCE=TRUE;
        
         






-- create table foreign_language_fixed_costs(
--   content_provider varchar(155),
--   series_key varchar(25),
--   year_month_day varchar(25),
--   description varchar(255),
--   kitchen_tv_pp_video_edit number(10, 3),
--   sphere_x_pp_content_ratings number(10, 3),
--   rev_ai_pp_cc number(10, 3),	
--   amount number(10, 3),	
--   year_month_day_applied varchar(25),
--   journal_entry varchar(55),
--   year number (4),
--   quarter varchar(2),
--   filename varchar(255)
-- )