-- payment supports are sent out to a few content providers
-- they send aggregated expenses and revenue for the content provider 


update register 
set payment_suppport_category ='RevShare COS-File Transfer Cost'
where type like '%PMI%' and payment_suppport_category is null
		
alter table register add column  varchar(255)
		
update table register


update register
set payment_support_category = 'RevShare COS-Bandwidth Allocation ' 
where type like '%Streaming Fee%' and year = 2021 and quarter in ('q3', 'q4')   

update register
set payment_support_category = 'RevShare COS-Storage Allocation ' 
where type like '%Amazon Hosting / Storage%' and year = 2021 and quarter in ('q3', 'q4')   


update register
set payment_support_category = 'RevShare COS-Bandwidth Allocation' 
where title like '%Brightcove Bandwidth%' and year = 2021 and quarter in ('q3', 'q4')

set payment_support_category = 'RevShare COS-Bandwidth Allocation' 
where title like '%Brightcove Platform%' and year = 2021 and quarter in ('q3', 'q4')

set payment_support_category = 'RevShare COS-Storage Allocation' 
where title like '%Brightcove Storage%' and year = 2021 and quarter in ('q3', 'q4')

set payment_support_category =	'RevShare COS-Storage Bandwidth Allocation' 
where title like '%Brightcove Storage and Bandwidth%' and year = 2021 and quarter in ('q3', 'q4')

set payment_support_category = 'RevShare COS-AdServing' 
where title like '%OAO Ad%'	and year = 2021 and quarter in ('q3', 'q4')

set payment_support_category = 'RevShare COS-File Transfer Cost' 
where title like '%PMI File Transfer%' and year = 2021 and quarter in ('q3', 'q4')


set payment_support_category = 'RevShare COS-AdServing' 
where title like '%POWR (Unreel) Platform%' and year = 2021 and quarter in ('q3', 'q4')   

set payment_support_category = "RevShare COS-Closed Captioning Cost" 
where title like '%Rev.com%' and year = 2021 and quarter in ('q3', 'q4')   

set payment_support_category = 'RevShare COS-AdServing ' 
where title like '%Unreel Platform%' and year = 2021 and quarter in ('q3', 'q4')   

set payment_support_category = 'RevShare COS-AdServing' 
where title like '%WURL Ad Serving%' and year = 2021 and quarter in ('q3', 'q4')   

set payment_support_category = 'RevShare COS-Bandwidth Allocation' 
where title like '%WURL Bandwidth%' and year = 2021 and quarter in ('q3', 'q4')   

set payment_support_category = 'RevShare COS-AdServing ' 
where title like '%WURL Connector%' and year = 2021 and quarter in ('q3', 'q4')   

		
set payment_support_category = 'RevShare COS-AdServing ' 
where type like '%POWR (Unreel) Platform Fee%' and year = 2021 and quarter in ('q3', 'q4')   

