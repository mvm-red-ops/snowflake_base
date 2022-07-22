copy into pmi_costs(
  year_month,
  content_provider,
  series_key,
  series_title,
  duration,
  avg_file_size,
  num_of_episodes,
  pmi_cost_per_episode,
  cost_before_prepayment,
  amount,
  journal_entry,
  quarter,
  year,
  filename
)
from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    REPLACE(t.$5,  ','),
    REPLACE(t.$5,  ','),
    REPLACE(t.$7,  ','),
    REPLACE(REPLACE(t.$8, '$'), ','),
    REPLACE(REPLACE(t.$9, '$'), ','),
    REPLACE(REPLACE(t.$10, '$'), ','),
    t.$11,
    t.$12,
    t.$13,
    'pmi_q4_21.csv'
        from @fixed_costs t) pattern='.*pmi_q4_21.*' file_format = GENERIC_CSV 
        ON_ERROR=SKIP_FILE FORCE=TRUE;
        
         






-- create table pmi_costs(
--   year_month varchar(55),
--   content_provider varchar(155),
--   series_key varchar(25),
--   series_title varchar(225),
--   duration number(5),
--   avg_file_size number(8,4),
--   num_of_episodes number(10, 3),	
--   pmi_cost_per_episode number(10, 3),
--   cost_before_prepayment number(10, 3),
--   amount number(10, 3),
--   journal_entry varchar(55),
--   year number (4),
--   quarter varchar(2),
--   filename varchar(255)
-- )
