

create or replace view user_expanded_medical_record_view
as
select med.user_id, u.first_name || ' ' || u.last_name name, u.date_of_birth, u.gender, u.university_id, med.respiratory_distress, med.allergy, med.high_blood_pressure, med.fever, med.date_of_appointment, med.comments
from user_medical_record med
left join users u on med.user_id = u.user_id
ORDER BY med.date_of_appointment;

SELECT * FROM user_expanded_medical_record_view;

create or replace view shipment_view
as
select ship.shipment_id, ship.shipment_start_date, ship.shipment_end_date, ship.shipment_status, ship.vaccine_storage_facility_id, st.vaccine_storage_name, st.street, st.city, st.state, st.zipcode, ship.inventory_id
from vaccine_shipment ship
left join vaccine_storage st on ship.vaccine_storage_facility_id = st.vaccine_storage_facility_id
ORDER BY ship.shipment_start_date;

SELECT * FROM shipment_view;

create or replace view inventory_view
as
select inv.inventory_id, vc.vaccine_center_name, vc.vaccine_center_street, vc.vaccine_center_city, vc.vaccine_center_state, vc.vaccine_center_zipcode, vd.vaccine_mnf, vd.batch_no, vd.mnf_date, vd.exp_date, vd.vaccine_storage_facility_id
from inventory inv
left join VACCINE_DETAILS vd on inv.vaccine_id = vd.vaccine_id 
left join VACCINE_CENTER vc on inv.vaccine_center_id = vc.vaccine_center_id
ORDER BY vd.vaccine_mnf;

SELECT * FROM inventory_view;



