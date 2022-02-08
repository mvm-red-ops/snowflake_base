CREATE OR REPLACE TABLE DEALS(
    id integer AUTOINCREMENT START 1 INCREMENT 1,
    name varchar(10) DEFAULT RANDSTR(10, random()),
    partnerId integer,
    platformId integer,
    territoryIds variant,
    channelIds variant,
    dealTypeId integer,
    load_template_id integer
) 
