-- content providers are linked to assets via ref_id
/**
 so we need to create a share of viewership for content_provider (nbc, fox, etc)
that share is the total viewership min of the month for that content_provider
i.e. NBC has 1,000,000 total min for  Oct 2021
    Oct 2021 has 2,00,000 total min 
    NBC share = 1,000,000/ 2,000,000 = .5 = 50%
**/

select sum(watch_time_seconds),CONTENT_PROVIDER from powr_viewership
group by CONTENT_PROVIDER




select * from monthly_viewership
where usage = 'powr viewership share'
order by year_month_Day, department_id



create temporary table content_provider_share (year_month_day varchar(8), department_id integer, total_viewership number(20,6), cp_share number(10, 6));


select d.department_id, p.year_month_day,sum(watch_time_seconds) from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
where  d.department_id = 3
group by  d.department_id, p.year_month_day
order by p.year_month_Day, d.department_id

insert into content_provider_share (content_provider, department_id, year_month_day, total_viewership)
select CONTENT_PROVIDER, d.department_id, p.year_month_day,sum(watch_time_seconds) from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
group by CONTENT_PROVIDER, d.department_id, p.year_month_day
order by p.year_month_Day, d.department_id



select p.CONTENT_PROVIDER, d.department_id, p.year_month_day,watch_time_seconds/ c.total_viewership as cp_share from powr_viewership p
join nosey_staging.public.devices d on (d.id = p.device_id)
join nosey_staging.public.departments nd on (nd.id = d.department_id)
join content_provider_share c on (c.department_id = d.department_id and c.year_month_day = p.year_month_day)
order by p.year_month_Day, d.department_id


  select *  from content_provider_share c
  join monthly_viewership mv on (mv.department_id = c.department_id and mv.year_month_day = c.year_month_day)
  where mv.usage = 'powr viewership share' and mv.department_id is not null

  select *  from content_provider_share c
  where  c.department_id = 3 
  group by year_month_Day
  


select * from monthly_viewership where
usage = 'powr viewership share' and department_id is not null



update content_provider_share c
set c.cp_share = q.cp_share
from (
  select c.id as id, c.year_month_day,c.department_id,c.content_provider, c.total_viewership / mv.tot_viewership as cp_share  from content_provider_share c
  join monthly_viewership mv on (mv.department_id = c.department_id and mv.year_month_day = c.year_month_day)
  where mv.usage = 'powr viewership share' and mv.department_id is not null 
) q
where c.id = q.id

select sum(cp_share) from content_provider_share
group by year_month_day, department_id


select c.id as id, c.year_month_day,c.department_id,c.content_provider, c.total_viewership / mv.tot_viewership as cp_share  from content_provider_share c
join monthly_viewership mv on (mv.department_id = c.department_id and mv.year_month_day = c.year_month_day)
where mv.usage = 'powr viewership share' and mv.department_id is not null 

select * from revenue

update content_provider_share cp
set cp.revenue = q.rev_share
from (
  
)q
where cp.id = q.id


