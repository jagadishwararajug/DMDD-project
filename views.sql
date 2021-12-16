create or replace view vaccine_manufacturer_shot_count 
as 
select vaccine_brand, count(*) as number_of_doses_given
from immunization_details
group by vaccine_brand
order by number_of_doses_given desc;

select * from vaccine_manufacturer_shot_count;

create or replace view user_vaccination_status
as
select u.first_name || ' ' || u.last_name name, u.university_id, (CASE WHEN COUNT(im.vaccination_status) = 2 THEN 'Fully Vaccinated' ELSE (CASE WHEN COUNT(im.vaccination_status) = 1 THEN 'Partially Vaccinated' ELSE 'Unvaccinated' END) END) AS Vaccination_Status
FROM immunization_details im
full join users u on im.user_id = u.user_id
group by u.user_id, u.first_name, u.last_name, u.university_id
ORDER BY vaccination_status;

select * from user_vaccination_status;

create or replace view vaccination_status_count
as 
select us.vaccination_status, count(*) as num_people
from user_vaccination_status us
group by us.vaccination_status;

select * from vaccination_status_count;


Create View Inventory_available_doses AS 
SELECT t1.University_name, t2.Vaccine_center_id, t4.vaccine_mnf as Vaccine_Manufacturer, COUNT(t3.Vaccine_id) as TotalDoses
FROM University t1
INNER JOIN VACCINE_CENTER t2 ON t1.vaccine_center_id = t2.vaccine_center_id
INNER JOIN INVENTORY t3 ON t3.vaccine_center_id = t2.vaccine_center_id
INNER JOIN VACCINE_DETAILS t4 ON t4.vaccine_id = t3.vaccine_id
GROUP BY t1.University_name, t2.Vaccine_center_id,t4.vaccine_mnf
ORDER BY  t1.University_name, t2.Vaccine_center_id,t4.vaccine_mnf;

select * from Inventory_available_doses;
