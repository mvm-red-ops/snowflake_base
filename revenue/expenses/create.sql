CREATE OR REPLACE TABLE expenses(
    status varchar(55) default null,
    invoice_month integer  default null,
    quarter varchar(2) default null,
    department varchar(255) default null,
    title varchar(255) default null,
    label varchar(55) default null,
    type varchar(155) default null,
    amount number(10,2) default null,
    remaining_allocation number(10,2) default null,
    month number(2,0)  default null,
    year number(4,0) default null,
    deal_parent integer
)
