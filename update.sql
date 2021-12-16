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
