CREATE OR REPLACE TABLE topline_expenses(
    amount number(10,2) default null,
    year number(4,0) default null,
    quarter varchar(2) default null,
    deal_parent integer
)


