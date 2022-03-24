select m.year_month_day as invoice_month, d.name as department, m.partner as title, c.content_provider, c.total_viewership, c.cp_share, m.tot_revenue * cp_share as rev_share from monthly_revenue m
join content_provider_share c on (c.department_id = m.department_id and c.year_month_day =  m.year_month_day)
join nosey_staging.public.departments d on (d.id = m.department_id)