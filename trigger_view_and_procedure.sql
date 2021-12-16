CREATE OR REPLACE PROCEDURE check_user_medical_record (
    user_id              IN NUMBER,
    respiratory_distress IN NUMBER,
    allergy              IN NUMBER,
    high_blood_pressure  IN NUMBER,
    fever                IN NUMBER,
    date_of_appointment  IN DATE
) IS
BEGIN
    IF
        respiratory_distress = 0
        AND allergy = 0
        AND high_blood_pressure = 0
        AND fever = 0
    THEN
        UPDATE user_medical_record
        SET
            comments = 'eli'
        WHERE
                user_id = user_id
            AND date_of_appointment = date_of_appointment;

    ELSIF respiratory_distress = 1 OR allergy = 1 OR high_blood_pressure = 1 OR fever = 1 THEN
        UPDATE user_medical_record
        SET
            comments = 'NOT eli'
        WHERE
                user_id = user_id
            AND date_of_appointment = date_of_appointment;

    END IF;
END;
/

CREATE OR REPLACE TRIGGER administer_vaccine AFTER
    UPDATE ON user_medical_record
    FOR EACH ROW
DECLARE
    imumunization_user_id      NUMBER(10);
    immunization_vaccine_brand VARCHAR(10);
    dose_date                  DATE;
    dose_count                 NUMBER(10);
    immunization_comment       VARCHAR(20);
    immunization_vaccine_id    NUMBER(10);
BEGIN
--SELECT count(dose_date),u.user_id, u.comments into dose_count, immunization_user_id, immunization_comment from dual;

    SELECT
        COUNT(dose_date)
    INTO dose_count
    FROM
        immunization_details
    WHERE
        immunization_user_id = :new.user_id;

    SELECT
        a.vaccine_manufacturer
    INTO immunization_vaccine_brand
    FROM
             user_medical_record u
        JOIN appointment a ON u.user_id = a.user_id;

    SELECT
        vaccine_id
    INTO immunization_vaccine_id
    FROM
        inventory
    WHERE
            vaccine_brand = immunization_vaccine_brand
        AND vaccine_administered_status = 'not administered'
        AND vaccine_center_id = (
            SELECT
                vaccine_center_id
            FROM
                     vaccine_center v
                JOIN university u ON v.vaccine_center_id = u.vaccine_center_id
                JOIN user       user ON user.university_id = u.university_id
            WHERE
                user.user_id = immunization_user_id
            FETCH NEXT 1 ROWS ONLY
        );

    IF ( immunization_comment = 'eligible' ) THEN
        IF ( dose_count <= 0 ) THEN
            INSERT INTO immunization_details (
                vaccine_brand,
                dose_date,
                vaccination_status,
                user_id,
                vaccine_id
            ) VALUES (
                immunization_vaccine_brand,
                sys.sysdate,
                'partially vaccinated',
                immunizatoin_user_id,
                immunization_vaccine_id
            );

            UPDATE inventory inv
            SET
                inv.vaccine_administered_status = 'administered'
            WHERE
                immunization_vaccine_id = inv.vaccine_id;
---raise another trigger on insert into immunization details. 
        ELSIF ( dose_count > 0 ) THEN
            INSERT INTO immunization_details (
                vaccine_brand,
                dose_date,
                vaccination_status,
                user_id,
                vaccine_id
            ) VALUES (
                immunization_vaccine_brand,
                sys.sysdate,
                'fully vaccinated',
                immunizatoin_user_id,
                immunization_vaccine_id
            );

        END IF;
    ELSIF ( immunization_comment = 'not eligible' ) THEN
        UPDATE appointment
        SET
            appointment_status = 'ineligible'
        WHERE
            immunization_user_id = :old.user_id;

        dbms_output.put_line('user ineligible to get vaccine, please book another date to get vaccinated');
    END IF;

END;
/


CREATE VIEW vaccine_manufacturer_info_view AS
    SELECT
        vaccine_id,
        vaccine_manufacturer,
        vaccine_administered_status
    FROM
             vaccine_details vd
        JOIN inventory      inv ON inv.vaccine_id = vd.vaccine_id
        JOIN vaccine_center vc ON inv.vaccine_center_id = vc.vaccine_center_id
        JOIN university     u ON vc.university_id = u.university_id;
/

CREATE VIEW vaccines_administered_view AS
    SELECT
        COUNT(vaccine_id)
        OVER(PARTITION BY vaccine_manufacturer, vaccine_center) as administered,
        vaccine_manufacturer, vaccine_center
    FROM
        vaccine_manufacturer_info_view
    WHERE
        vaccine_administered_status = 'administered';
/
CREATE VIEW vaccines_administered_view AS
    SELECT
        COUNT(vaccine_id)
        OVER(PARTITION BY vaccine_manufacturer, vaccine_center)as not_administered,
        vaccine_manufacturer, vaccine_center
    FROM
        vaccine_manufacturer_info_view
    WHERE
        vaccine_administered_status = 'not administered';
/

                                                                             