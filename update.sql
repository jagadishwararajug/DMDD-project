SET SERVEROUT ON;
------------------------------------------------USER UPDATE INSERT----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UPDATE_USER_TABLE(emailId in VARCHAR2, column_name in VARCHAR2, column_val in VARCHAR2)
AS
col_name VARCHAR2(50):=column_name;
col_val VARCHAR2(100):=column_val;
userId NUMBER;
update_query VARCHAR2(500);
BEGIN
        select user_id into userId FROM USERS where email=emailId;
        DBMS_OUTPUT.PUT_LINE(userId);
        update_query := 'UPDATE USERS set '|| col_name || '=''' || col_val ||  ''' where email=''' || emailId || ''' and USER_ID=' || userId; 
        DBMS_OUTPUT.PUT_LINE(update_query);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------------');
        EXECUTE IMMEDIATE  'UPDATE USERS set '|| col_name || '=''' || col_val ||  ''' where email=''' || emailId || ''' and USER_ID=' || userId; 
COMMIT;
EXCEPTION WHEN others then
dbms_output.put_line('Error while inserting data into USERS Table');
rollback;
dbms_output.put_line('Error: ');
dbms_output.put_line(dbms_utility.format_error_stack);
dbms_output.put_line('----------------------------------------------------------');
end;
/

execute UPDATE_USER_TABLE('john.k@gmail.com', 'FIRST_NAME', 'KP');


SET SERVEROUT ON;
------------------------------------------------VACCINE_STORAGE UPDATE-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UPDATE_VACCINE_STORAGE_TABLE(vax_store_name in VARCHAR2, column_name in VARCHAR2, column_val in VARCHAR2)
AS
col_name VARCHAR2(15):=column_name;
col_val VARCHAR2(100):=column_val;
vaccineStorageFacilityId NUMBER;
update_query VARCHAR2(500);
BEGIN
  
        select VACCINE_STORAGE_FACILITY_ID into vaccineStorageFacilityId FROM VACCINE_STORAGE where VACCINE_STORAGE_NAME=vax_store_name;
        DBMS_OUTPUT.PUT_LINE(vaccineStorageFacilityId);
        update_query := 'UPDATE VACCINE_STORAGE set '|| col_name || '=''' || col_val ||  ''' where VACCINE_STORAGE_NAME=''' || vax_store_name || ''' and VACCINE_STORAGE_FACILITY_ID=' || vaccineStorageFacilityId; 
        DBMS_OUTPUT.PUT_LINE(update_query);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------------');
        EXECUTE IMMEDIATE  'UPDATE VACCINE_STORAGE set '|| col_name || '=''' || col_val ||  ''' where VACCINE_STORAGE_NAME=''' || vax_store_name || ''' and VACCINE_STORAGE_FACILITY_ID=' || vaccineStorageFacilityId; 
COMMIT;
EXCEPTION WHEN others then
dbms_output.put_line('Error while inserting data into VACCINE_STORAGE Table');
rollback;
dbms_output.put_line('Error: ');
dbms_output.put_line(dbms_utility.format_error_stack);
dbms_output.put_line('----------------------------------------------------------');
end;
/

execute UPDATE_VACCINE_STORAGE_TABLE('Downtown', 'STREET', 'KP');


SET SERVEROUT ON;
------------------------------------------------VACCINE_CENTER UPDATE-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UPDATE_VACCINE_CENTER_TABLE(vax_center_name in VARCHAR2, column_name in VARCHAR2, column_val in VARCHAR2)
AS
col_name VARCHAR2(30):=column_name;
col_val VARCHAR2(100):=column_val;
vaccineCenterId NUMBER;
update_query VARCHAR2(500);
BEGIN
  
        select VACCINE_CENTER_ID into vaccineCenterId FROM VACCINE_CENTER where VACCINE_CENTER_NAME=vax_center_name;
        DBMS_OUTPUT.PUT_LINE(vaccineCenterId);
        update_query := 'UPDATE VACCINE_CENTER set '|| col_name || '=''' || col_val ||  ''' where VACCINE_CENTER_NAME=''' || vax_center_name || ''' and VACCINE_CENTER_ID=' || vaccineCenterId; 
        DBMS_OUTPUT.PUT_LINE(update_query);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------------------------------------------');
        EXECUTE IMMEDIATE  'UPDATE VACCINE_CENTER set '|| col_name || '=''' || col_val ||  ''' where VACCINE_CENTER_NAME=''' || vax_center_name || ''' and VACCINE_CENTER_ID=' || vaccineCenterId; 
COMMIT;
EXCEPTION WHEN others then
dbms_output.put_line('Error while inserting data into VACCINE_CENTER Table');
rollback;
dbms_output.put_line('Error: ');
dbms_output.put_line(dbms_utility.format_error_stack);
dbms_output.put_line('----------------------------------------------------------');
end;
/

execute UPDATE_VACCINE_CENTER_TABLE('Commonwealth', 'VACCINE_CENTER_STREET', 'Ash St');

