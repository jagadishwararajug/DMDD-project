--Report to view total immuniations given overall. 

select v.Vaccine_Mnf as Vaccine_Manufacturer, count(v.Vaccine_Mnf) as Number_of_immunizations from immunization_details im join
vaccine_details v on v.Vaccine_Id=im.Vaccine_Id group by (v.Vaccine_Mnf) 
/
--Procedure
create or replace procedure check_user_medical_record(USER_ID IN NUMBER, DATE_OF_APPOINTMENT DATE)
IS
BEGIN
if respiratory_distress=0 or allergy=0 or high_blood_pressure=0 or Fever = 0 then
UPDATE USER_MEDICAL_RECORD SET comments="ELIGIBLE" where USER_ID=USER_ID and date_of_appointment=date_of_appointment;
else
UPDATE USER_MEDICAL_RECORD SET comments="NOT ELIGIBLE" where USER_ID=USER_ID and date_of_appointment=date_of_appointment;
end if;
end;