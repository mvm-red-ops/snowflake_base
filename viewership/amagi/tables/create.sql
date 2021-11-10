CREATE TABLE AMAGI_VIEWERSHIP(
view_date varchar(12),
channel varchar(55),
channel_name  varchar(155),	
content_id varchar(255),
content_name varchar(255),
session_count number(12, 2),
total_viewership_minutes number(12, 2),
unique_viewers	number(12, 2),
avg_session_count	number(8, 2),
avg_session_duration_per_session number(8, 2),
avg_session_duration_per_viewer	number(8, 2),
month varchar(10),
ref_id	varchar(10),
share number(6,3),
revenue number(8, 2)
)




