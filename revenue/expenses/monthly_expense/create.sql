
CREATE OR REPLACE TABLE monthly_expenses(
    amount number(10,2) default null,
    month number(2,0)  default null,
    year number(4,0) default null,
    quarter varchar(2) default null,
    deal_parent integer
)



