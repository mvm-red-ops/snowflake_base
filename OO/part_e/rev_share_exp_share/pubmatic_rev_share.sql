



    -- Update pubmatic rev share
    update spotx s
    set s.pub_revenue = q.pub_rev
    from ( 
      select s.id as qid, pub_share, s.impressions, pub_share * r.revenue as pub_rev,  s.year_month_day, s.channel_name from spotx s
      join revenue r on (r.year_month_day = s.year_month_day)
      where DEAL_NAME like '%Pubmatic%'
      and r.pay_partner = 'pubmatic'
    ) q
    where q.qid = s.id

    
    -- group revenue by department and month
    select sum(pub_revenue), year_month_day,  d.name from spotx s
    join nosey_staging.public.departments d on (d.id = s.department_id)
    where pub_share is not null
    group by year_month_day, d.name

    -- insert revenue by dept and month into monthly_revenue table
    insert into monthly_revenue(tot_revenue, year_month_day, department_id, partner)
    select sum(pub_revenue), year_month_day,  d.id, 'pubmatic' from spotx s
    join nosey_staging.public.departments d on (d.id = s.department_id)
    where pub_share is not null
    group by year_month_day, d.id

