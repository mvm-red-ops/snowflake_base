copy into gam_data (
        advertiser,
        ad_unit,
        month_year,
        advertiser_id,
        ad_unit_id,
        total_code_served,
        total_impressions,
        ad_exchange_revenue,
        quarter, 
        year, 
        filename
    )
from (select t.$1, t.$2, t.$3, t.$4, t.$5, to_decimal(REPLACE(t.$6,  ','), 15, 0), to_decimal(REPLACE(t.$7,  ','), 15, 0), to_decimal(REPLACE(t.$8,  ','), 15, 2), 'q4', 2021,  'gam_q4_2021.csv'
from @owned_and_operated t) pattern='.*gam_q4_2021.*' file_format = nosey_viewership 
ON_ERROR=SKIP_FILE FORCE=TRUE;


create table gam_data(
    id  integer default id_seq.nextval,
    advertiser varchar(155),
    ad_unit varchar(155),
    month_year varchar(10),
    advertiser_id varchar(55);
    ad_unit_id varchar(55);
    total_code_served number (15,0),
    total_impressions number (15,0),
    ad_exchange_revenue number (15,2)
)