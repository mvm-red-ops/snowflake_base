
-- historical v2
copy into fixed_costs(
content_provider, 
series_key,
series,
duration,
month,
avg_file_size,
closed_captioning_cost_per_episode,
editing_cost_per_episode,
bc_transcoding_cost_per_episode,
aspera_cost_per_episode,
pmi_cost_per_episode,
episode_count,
closed_captioning_cost_per_quarter,
editing_cost_per_quarter,
bc_transcoding_cost_per_quarter,
aspera_cost_per_quarter,
pmi_cost_per_quarter,
journal_entry,
quarter, 
year,
filename)from (select 
    t.$1,
    t.$2,
    t.$3,
    t.$4,
    t.$5,
    t.$6,
    t.$7,
    t.$8,               
    t.$9,
    t.$10,
    t.$11,
    t.$12,
    t.$13,
    t.$14,
    t.$15,
    t.$16,
    t.$17,
    t.$18,
    t.$19,
    t.$20,
    'fixed_costs_historical_2.csv'
        from @fixed_costs t) pattern='.*fixed_costs_historical_2.*' file_format = nosey_viewership 
        ON_ERROR=SKIP_FILE FORCE=TRUE;



-- historical v1
-- copy into fixed_costs(
-- quarter,
-- month,	
-- ref_id,
-- series,
-- content_provider,
-- category,
-- subcategory,
-- amount,
-- year,
-- filename)from (select 
--     t.$1,
--     t.$2,
--     t.$3,
--     t.$4,
--     t.$5,
--     t.$6,
--     t.$7,
--     REPLACE(REPLACE(t.$8, '$'), ','),
--     t.$9,
--     'fixed_costs_historical.csv'
--         from @fixed_costs t) pattern='.*fixed_costs_historical.*' file_format = nosey_viewership 
--         ON_ERROR=SKIP_FILE FORCE=TRUE;






-- create table fixed_costs(
-- id number default fixed_costs_id.nextval,
-- content_provider varchar(255), 
-- series_key varchar(50),
-- series varchar(255), 
-- duration number(5),
-- month varchar(155),
-- avg_file_size number(5, 2),
-- closed_captioning_cost_per_episode number(10, 3),
-- editing_cost_per_episode number(10, 3),
-- bc_transcoding_cost_per_episode number(10, 3),
-- aspera_cost_per_episode number(10, 3),
-- pmi_cost_per_episode number(10, 3),
-- quarterly_episode_count number(10, 3),
-- closed_captioning_cost_per_quarter number(10, 3),
-- editing_cost_per_quarter number(10, 3),
-- bc_transcoding_cost_per_quarter number(10, 3),
-- aspera_cost_per_quarter number(10, 3),
-- pmi_cost_per_quarter number(10, 3),
-- journal_entry varchar(155),
-- year number(4),
-- quarter varchar(2),
-- ref_id varchar(25),
-- category varchar(155),
-- subcategory varchar(255),
-- amount number(15, 4))