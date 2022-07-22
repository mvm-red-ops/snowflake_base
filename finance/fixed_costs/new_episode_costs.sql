

create table new_episode_costs(
  content_provider varchar(155),
  series_key varchar(25),
  series_title varchar(225),
  year_month_day varchar(25),
  duration number(5),
  month_year varchart(25),
  avg_file_size number(8,4)
  closed_captioning_cost number(10, 3),
  editing_cost number(10, 3),
  bc_transcoding_cost number(10, 3),
  aspera number(10, 3),	
  pmi number(10, 3),	
  episodes_by_month number(10, 3),	
  year_month_day_applied varchar(25),
  journal_entry varchar(55),
  year number (4),
  quarter varchar(2),
  filename varchar(255)
)