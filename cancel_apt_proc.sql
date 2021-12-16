SET SERVEROUT ON;

create or replace PROCEDURE cancel_apt(email_id in VARCHAR2, apt_date in date)
AS
  uid NUMBER;
  count_users NUMBER;
  cnt NUMBER;
  status varchar(10);
  prev_status VARCHAR(20);
    date_diff NUMBER;
    vac_name varchar(20);
BEGIN
      dbms_output.put_line('======================================');
        dbms_output.put_line('SELECT distinct user_id into uid from users where email = '||email_id);

  SELECT distinct user_id into uid from users where email = email_id;
        dbms_output.put_line('============================================= USER ID ======================================' ||uid);
        dbms_output.put_line('============================================= USER APT DATE ======================================' ||apt_date);


      SELECT count(*) into count_users from appointment where user_id = uid and DATE_OF_APPOINTMENT=apt_date;
        dbms_output.put_line('============================================= USER COUNT ======================================' ||count_users);
     
     
 if count_users = 0 then 
  dbms_output.put_line('++++++++++++++++++++++      No such appointment exists. Place an appointment first.                ++++++++++++++++++');


elsif count_users > 0 and APPOINTMENT_STATUS = 'cancelled'
then
  dbms_output.put_line('++++++++++++++++++++++      Appointment already cancelled                ++++++++++++++++++');

elsif count_users > 0 and APPOINTMENT_STATUS != 'cancelled'
then
   UPDATE appointment
    SET
        APPOINTMENT_STATUS = 'cancelled'
    WHERE
        user_id = uid and DATE_OF_APPOINTMENT=apt_date;

            dbms_output.put_line('Appointment has been cancelled.');
            COMMIT;

end if;
EXCEPTION WHEN OTHERS
THEN
       dbms_output.put_line(SQLERRM);
       ROLLBACK;
END;
/



exec cancel_apt('u.s@gmail.com', '26-DEC-21');
