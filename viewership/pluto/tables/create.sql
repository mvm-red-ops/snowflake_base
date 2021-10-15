//Pluto
CREATE OR REPLACE TABLE PLUTO_VIEWERSHIP(
    id integer AUTOINCREMENT START 1 INCREMENT 1,
    title	String DEFAULT '',
    month	String  DEFAULT '',
    parnter_name	String  DEFAULT '',
    clip_name	String  DEFAULT '',
    total_viewing_minutes	Integer  DEFAULT null,
    ref_id	String DEFAULT null,
    revenue_by_title	NUMBER(12,2)   DEFAULT null,
    total_revenue	NUMBER(12,2)  DEFAULT null,
    sessions INTEGER  DEFAULT null,
    deal_parent INTEGER  DEFAULT null,
    territory_id INTEGER  DEFAULT null,
) 
