CREATE OR REPLACE TABLE WURL_VIEWERSHIP(
id integer AUTOINCREMENT START 1 INCREMENT 1,
channel	String DEFAULT NULL,
title	String DEFAULT NULL,
avg_session_hov	number(15,10) DEFAULT NULL,
tot_hov	number(20,5) DEFAULT NULL,
occurances	number(5,2) DEFAULT NULL,
tot_completions	number(5,2) DEFAULT NULL,
tot_sessions number(6,2) DEFAULT NULL,
vs	String DEFAULT NULL,
month	String DEFAULT NULL,
ref_id	string DEFAULT NULL,
share	number(6,4) DEFAULT NULL,
deal_parent integer default null,
territory_id integer default null
)

ALTER TABLE WURL_VIEWERSHIP 
ADD COLUMN tot_airtime_min	integer DEFAULT NULL

ALTER TABLE WURL_VIEWERSHIP 
ADD COLUMN tot_episode_hov integer DEFAULT NULL

ALTER TABLE WURL_VIEWERSHIP 
ADD COLUMN monthly_share number(6,3) DEFAULT NULL

ALTER TABLE WURL_VIEWERSHIP 
ADD COLUMN share_2 number(6,3) DEFAULT NULL
