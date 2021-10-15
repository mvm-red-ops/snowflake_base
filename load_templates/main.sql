
CREATE OR REPLACE TABLE LOAD_TEMPLATES(
    id integer AUTOINCREMENT START 1 INCREMENT 1,
    command varchar(500)
);

-- pluto us
INSERT INTO LOAD_TEMPLATES(command) values('copy into PLUTO_VIEWERSHIP(month, parnter_name, clip_name, total_viewing_minutes, sessions, revenue_by_title, ref_id, deal_parent) from (select t.$1, t.$2, t.$3,  to_number(REPLACE(t.$4, '','')), to_number(REPLACE(t.$5, '','')), to_decimal(REPLACE(t.$6, '','')),  t.$7, 29 from @pluto_viewership t) file_format = nosey_viewership ON_ERROR=CONTINUE FORCE = TRUE;')

-- pluto uk
copy into PLUTO_VIEWERSHIP( title, total_revenue, month, ref_id, territory_id, deal_parent) 
from (select t.$1, to_number(REPLACE(t.$2, ' $ - ', null)), t.$3, t.$4, 5, 29 from @pluto_viewership t) pattern='.*uk.*' file_format = nosey_viewership 
ON_ERROR=CONTINUE FORCE = TRUE;