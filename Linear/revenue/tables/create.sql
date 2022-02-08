CREATE OR REPLACE TABLE REVENUE(
    id integer AUTOINCREMENT START 1 INCREMENT 1,
    MONTH	NUMBER(38,0),
    YEAR	NUMBER(38,0),
    QUARTER	VARCHAR(255),
    REVENUE	NUMBER(38,0),
    DEAL_PARENT INTEGER ,
    createdAt	TIMESTAMP_TZ(9),
    updatedAt	TIMESTAMP_TZ(9),
    YEAR_MONTH_DAY	VARCHAR(255)
) 



CREATE OR REPLACE TRANSIENT TABLE Asset_Revenue(
    id integer AUTOINCREMENT START 1 INCREMENT 1 DEFAULT NULL,
    title varchar(500) DEFAULT NULL,
    ref_id varchar(10) DEFAULT NULL,
    content_provider varchar(55) DEFAULT NULL,
    series varchar(300) DEFAULT NULL,
    mobile_web_views varchar(10) DEFAULT NULL,
    roku_views varchar(10) DEFAULT NULL,
    xumo_views varchar(10) DEFAULT NULL,
    mobile_web_minutes varchar(10) DEFAULT NULL,
    fire_tv_minutes varchar(10) DEFAULT NULL,
    trv_linear_minutes varchar(10) DEFAULT NULL,
    roku_minutes varchar(10) DEFAULT NULL,
    pluto_tv_minutes varchar(10) DEFAULT NULL,
    vizio_minutes varchar(10) DEFAULT NULL,
    xumo_minutes varchar(10) DEFAULT NULL,
    mobile_web_revenue varchar(10) DEFAULT NULL,
    fire_tv_revenue varchar(10) DEFAULT NULL,	
    roku_revenue varchar(10) DEFAULT NULL,
    pluto_tv_revenue varchar(10) DEFAULT NULL,
    pluto_tv_uk_revenue varchar(10) DEFAULT NULL,
    vizio_revenue varchar(10) DEFAULT NULL,
    xumo_revenue varchar(10) DEFAULT NULL,
    samsung_revenue varchar(10) DEFAULT NULL,
    plex_revenue varchar(10) DEFAULT NULL,
    trc_linear_revenue varchar(10) DEFAULT NULL,
    trc_vod_revenue varchar(10) DEFAULT NULL,
    views varchar(10) DEFAULT NULL,
    minutes	varchar(10) DEFAULT NULL,
    revenue varchar(10) DEFAULT NULL
)
