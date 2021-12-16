SET SERVEROUT ON;

CREATE OR REPLACE PROCEDURE check_user_medical_record (
    email_id              IN VARCHAR2,
    respiratory_distress IN NUMBER,
    allergy              IN NUMBER,
    high_blood_pressure  IN NUMBER,
    fever                IN NUMBER,
    apt_date  IN DATE
)
AS
uid NUMBER;
count_users NUMBER;
BEGIN

  SELECT distinct user_id into uid from users where email = email_id;
         dbms_output.put_line('============================================= USER ID ======================================' ||uid);
  
  SELECT count(*) into count_users from USER_MEDICAL_RECORD where USER_ID = uid and DATE_OF_APPOINTMENT=apt_date;
        dbms_output.put_line('============================================= USER COUNT ======================================' ||count_users);
     
    IF count_users > 0 and respiratory_distress = 0 AND allergy = 0 AND high_blood_pressure = 0 AND fever = 0
    THEN
        UPDATE user_medical_record
        SET
            comments = 'Eligible'
        WHERE
                user_id = uid AND date_of_appointment = apt_date;
            dbms_output.put_line('Eligible');
                

    ELSIF count_users > 0 and (respiratory_distress = 1 OR allergy = 1 OR high_blood_pressure = 1 OR fever = 1 ) THEN
        UPDATE user_medical_record
        SET
            comments = 'NOT Eligible'
        WHERE
                user_id = uid AND date_of_appointment = apt_date;
            dbms_output.put_line('Not eligible');
    else dbms_output.put_line('User Medical Record Not present in the table. Please add medical record.');

    END IF;
EXCEPTION WHEN OTHERS
THEN
       dbms_output.put_line(SQLERRM);
       ROLLBACK;    
END;
/


EXEC check_user_medical_record('jon.k@gmail.com',0,0,1,0,'01-JAN-21')