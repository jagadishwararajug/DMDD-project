SET SERVEROUT ON;

DECLARE
    record_count NUMBER;
BEGIN
    -- create table Vaccine_Shipment if doesn't exist
    SELECT
        COUNT(*)
    INTO record_number
    FROM
        sys.user_tables
    WHERE
        table_name = 'Vaccine_Shipment';

    IF ( record_count > 0 ) THEN
        dbms_output.put_line('Vaccine_Shipment table already exists');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    ELSE
        EXECUTE IMMEDIATE 'create table Vaccine_Shipment (
    Shipment_id number not null primary key,
    Manufacturer varchar(30) not null,
    Shipment_start_date date not null,
    Shipment_status varchar(30),
    Vaccine_storage_facility_id number not null,
    Inventory_id number not null
    
    )';
        dbms_output.put_line('TABLE Vaccine_Shipment CREATED SUCCESSFULLY');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    END IF;
    
    -- create table Vaccine_Batch_Information if doesn't exist
    SELECT
        COUNT(*)
    INTO record_count
    FROM
        sys.user_tables
    WHERE
        table_name = 'Vaccine_Batch_Information';

    IF ( record_count > 0 ) THEN
        dbms_output.put_line('Vaccine_Batch_Information table already exists');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    ELSE
        EXECUTE IMMEDIATE 'create table Vaccine_Batch_Information (
    Vaccine_Batch_Info_id number not null primary key,
    Shipment_id number not null,
    Vaccine_manufacturer_name varchar(30) not null,
    Batch_no number not null
    )';
        dbms_output.put_line('TABLE Vaccine_Batch_Information CREATED SUCCESSFULLY');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    END IF;
    -- create table User_Medical_Record if doesn't exist

    SELECT
        COUNT(*)
    INTO record_count
    FROM
        sys.user_tables
    WHERE
        table_name = 'User_Medical_Record';

    IF ( record_count > 0 ) THEN
        dbms_output.put_line('User_Medical_Record table already exists');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    ELSE
        EXECUTE IMMEDIATE 'create table User_Medical_Record (
    User_id number not null primary key,
    Respiratory_distress number(1,0) not null,
    Allergy number(1,0) not null,
    High_blood_pressure number(1,0) not null,
    Fever number(1,0) not null,
    Date_of_Appointment date not null,
    comments varchar(50) not null
    )';
        dbms_output.put_line('TABLE User_Medical_Record CREATED SUCCESSFULLY');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    END IF;
    
    -- create table Inventory if doesn't exist

    SELECT
        COUNT(*)
    INTO record_count
    FROM
        sys.user_tables
    WHERE
        table_name = 'Inventory';

    IF ( record_count > 0 ) THEN
        dbms_output.put_line('Inventory table already exists');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    ELSE
        EXECUTE IMMEDIATE 'create table Inventory (
        Inventory_id number not null primary key,
        Vaccine_center_id number not null,
        Vaccine_id number not null
        )';
        dbms_output.put_line('TABLE Inventory CREATED SUCCESSFULLY');
        dbms_output.put_line('-------------------------------------------------------------------------------------------------------------------');
    END IF;

END;