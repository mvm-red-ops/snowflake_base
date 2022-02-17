create table gam_data(
    id  integer default id_seq.nextval,
    advertiser varchar(155),
    ad_unit varchar(155),
    month_year varchar(10),
    advertiser_id number(20,0),
    ad_unit_id number(20, 0),
    total_code_served number (15,0),
    total_impressions number (15,0),
    ad_exchange_revenue number (15,2)
)


