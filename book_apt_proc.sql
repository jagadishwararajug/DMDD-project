create or replace PROCEDURE book_apt(email_id in VARCHAR2, apt_date in date, vac_mnf_name in VARCHAR2)
AS
  uid NUMBER;
  count_users NUMBER;
  status varchar(10);
  prev_status VARCHAR(20);
    date_diff NUMBER;
BEGIN
      dbms_output.put_line('======================================');
        dbms_output.put_line('SELECT distinct user_id into uid from users where email = '||email_id);

  SELECT distinct user_id into uid from users where email = email_id;


      SELECT count(*) into count_users from APPOINTMENT where user_id = uid;
        dbms_output.put_line('============================================= USER COUNT ======================================' ||count_users);

    select distinct APPOINTMENT_STATUS into status
                        from APPOINTMENT 
                        where user_id = uid
                        order by DATE_OF_APPOINTMENT desc
                        FETCH FIRST 1 ROWS ONLY; 
      dbms_output.put_line('APPOINTMENT STATUS: ' || status);

        select APPOINTMENT_STATUS into prev_status from APPOINTMENT where USER_ID = uid order by appointment_id desc  fetch first 1 row only;
      dbms_output.put_line('PREVIOUS RECORD STATUS: ' || prev_status);

        SELECT ( TO_DATE(apt_date) - TO_DATE(DATE_OF_APPOINTMENT) ) INTO date_diff
        FROM   appointment
        where USER_ID=uid FETCH FIRST 1 ROW ONLY;
        dbms_output.put_line('============================================= date_diff ======================================' ||date_diff);

if count_users=0 then insert into APPOINTMENT(DATE_OF_APPOINTMENT,APPOINTMENT_STATUS,USER_ID,VACCINE_MNF_NAME) values(apt_date, LOWER('booked'),uid, lower(vac_mnf_name));
      dbms_output.put_line('++++++++++++++++++++++      first appointment booked                ++++++++++++++++++');


ELSIF count_users=1 and lower(status) ='completed' and date_diff >=15
then insert into APPOINTMENT(DATE_OF_APPOINTMENT,APPOINTMENT_STATUS,USER_ID,VACCINE_MNF_NAME) values(apt_date, LOWER('booked'),uid, lower(vac_mnf_name));
      dbms_output.put_line('++++++++++++++++++++++      second appointment booked                ++++++++++++++++++');

ELSIF count_users>=2 
and lower(prev_status)='failed' and date_diff >= 15
then insert into APPOINTMENT(DATE_OF_APPOINTMENT,APPOINTMENT_STATUS,USER_ID,VACCINE_MNF_NAME) values(apt_date, LOWER('booked'),uid, lower(vac_mnf_name));
      dbms_output.put_line('++++++++++++++++++++++      previous failed appointment booked                ++++++++++++++++++');

else dbms_output.put_line('Failed to book appointment! Please try again later!');
end if;
COMMIT;
EXCEPTION WHEN OTHERS
THEN
       dbms_output.put_line(SQLERRM);
       ROLLBACK;
END;
/



EXEC book_apt('u.s@gmail.com', '08-FEB-21', 'pfizer');