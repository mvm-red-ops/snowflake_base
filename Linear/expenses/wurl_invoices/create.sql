-- wurl invoices
CREATE OR REPLACE TABLE wurl_invoices(
  month_string varchar(55),
  description varchar(500),
  quantity number(15,5),
  rate number(10,6),
  amount number(14,3),
  partner_id integer default null, 
  deal_parent integer default null,
  year integer,
  quarter integer,
  month integer
)


