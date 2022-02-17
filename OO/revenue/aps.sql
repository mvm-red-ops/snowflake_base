insert into revenue( revenue, impressions, cpm, pay_partner, quarter, year, year_month_day)
select $1, $2, $3, $4, $5,  $6,  $7
from values
  (4944.61, 451702, 10.95, 'ammazon publisher services (aps)', 'q4', 2021, '20211001'),
  (9141.75, 537188, 17.02, 'ammazon publisher services (aps)', 'q4', 2021, '20211101'),
  (13370.17, 763574, 17.51, 'ammazon publisher services (aps)', 'q4', 2021, '20211201')
