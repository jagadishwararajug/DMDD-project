CREATE TABLE Users (
User_Id NUMBER NOT NULL Primary Key,
First_Name VARCHAR2(25) CONSTRAINT "USER_FIRST_NAME_NN" NOT NULL ENABLE,
Last_Name VARCHAR2(25) CONSTRAINT "USER_LAST_NAME_NN" NOT NULL ENABLE ,
Date_Of_Birth DATE CONSTRAINT "USER_DOB_NN" NOT NULL ENABLE,
Gender VARCHAR2(5) CONSTRAINT "USER_GENDER_NN" NOT NULL ENABLE,
Contact_No VARCHAR2(20) CONSTRAINT "USER_CONTACT_NN" NOT NULL ENABLE,
Email VARCHAR2(25) NOT NULL UNIQUE,
Address VARCHAR2(20),
Age Number NOT NULL,
Weight FLOAT,
Vaccination_Status VARCHAR2(15) NOT NULL,
UNIVERSITY_ID Number CONSTRAINT "DEPT_ID_NN" NOT NULL ENABLE ,
User_Medical_Number Number CONSTRAINT "USER_MEDICAL_NUMBER_NN" NOT NULL ENABLE,
CONSTRAINT "UNIVERSITY_ID_FK" FOREIGN KEY ("UNIVERSITY_ID")
REFERENCES UNIVERSITY ("UNIVERSITY_ID") ENABLE
);



CREATE TABLE University (
University_Id NUMBER NOT NULL Primary Key,
University_Name VARCHAR2(25) CONSTRAINT "UNIVERSITY_NAME_NN" NOT NULL ENABLE,
University_Address VARCHAR2(20)
);

CREATE TABLE Vaccine_Details (
Vaccine_Id NUMBER NOT NULL Primary Key,
Vaccine_Mnf VARCHAR2(25) CONSTRAINT "VAC_MNF_NAME_NN" NOT NULL ENABLE,
Mnf_Date VARCHAR2(25) CONSTRAINT "VAC_MNF_DATE" NOT NULL ENABLE ,
Exp_Date DATE CONSTRAINT "VAC_EXP_DATE" NOT NULL ENABLE,
Batch_No VARCHAR2(5) CONSTRAINT "VAC_BATCH_NO" NOT NULL ENABLE,
No_Of_Doses_In_Total VARCHAR2(20) CONSTRAINT "NO_OF_DOSES_TOTAL_NN" NOT NULL ENABLE,
Vaccine_Shipment_Id VARCHAR2(25) NOT NULL UNIQUE,
Vaccine_Storage_Facility_Id VARCHAR2(20) NOT NULL,
CONSTRAINT "VAC_SHIPMENT_ID_FK" FOREIGN KEY ("Vaccine_Shipment_Id")
REFERENCES VACCINE_SHIPMENT ("SHIPMENT_ID") ENABLE,
CONSTRAINT "VACCINE_STORAGE_ID_FK" FOREIGN KEY ("Vaccine_Storage_Facility_Id")
REFERENCES VACCINE_STORAGE ("STORAGE-FACILITY-ID") ENABLE
);

