--REMINDER: Be sure to update the quarter and year in each select statement and/or where clause

-- check expense share
  select oao_share * e.amount as exp_share, g.year_month_day,  ad_unit, g.department_id as dep_id from gam_data g
  join expenses e on (e.year_month_day = g.year_month_day )
  where pay_partner = 'oao' and type = 'adserving' and g.quarter = 'qX' and g.year = 202X


-- update 
update gam_data g
set g.oao_expense_share = q.expense_sh
from (
  select g.id as gid, oao_share * e.amount as expense_sh, g.year_month_day,  ad_unit, g.department_id as dep_id from gam_data g
  join expenses e on (e.year_month_day = g.year_month_day )
  where pay_partner = 'oao' and type = 'adserving' and g.quarter = 'qX' and g.year = 202X
) q
where q.gid = g.id


 
-- firetv expenses
select sum(oao_share) * e.amount as exp, g.year_month_day from gam_data g
join expenses e on (e.year_month_day = g.year_month_day and type = 'adserving')
where  g.department_id = 2 and g.quarter = 'qX' and g.year = 202X
group by g.year_month_day,  e.amount

-- non firetv expenses
select sum(oao_share)* e.amount as exp, g.year_month_day from gam_data g
join expenses e on (e.year_month_day = g.year_month_day and type = 'adserving')
where  g.department_id != 2 and g.quarter = 'qX' and g.year = 202X
group by g.year_month_day,  e.amount


-- insert firetv expenses
--- Update quarter and year in select statement and where clause
insert into monthly_expenses(
    amount, 
    year_month_day,
    department_id,
    title,
    year, 
    quarter
)
select sum(oao_share) * e.amount as exp, g.year_month_day, g.department_id, 'OAO - Adserving', 202X, 'qX'  from gam_data g
join expenses e on (e.year_month_day = g.year_month_day and type = 'adserving')
where g.department_id = 2 and g.quarter = 'qX' and g.year = 202X
group by g.year_month_day,  e.amount, g.department_id



-- insert non-firetv expenses
insert into monthly_expenses(
    amount, 
    year_month_day,
    department_id,
    title,
    year, 
    quarter
)
select sum(oao_share) * e.amount as exp, g.year_month_day, 3, 'OAO - Adserving', 202X, 'qX'  from gam_data g
join expenses e on (e.year_month_day = g.year_month_day and type = 'adserving')
where  g.department_id != 2 and g.quarter = 'qX' and g.year = 202X
group by g.year_month_day,  e.amount



-- check roku expenses
select * from expenses where type = 'roku'

-- add roku expenses to monthly_expenses
insert into monthly_expenses(
    amount, 
    year_month_day,
    department_id,
    title,
    year, 
    quarter
) select amount, year_month_day, 5, 'OAO - Adserving', 202X, 'qX' from expenses where type = 'roku'
