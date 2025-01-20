USE WAREHOUSE TRANSFER_ADO_ASSIGNMENT2_GROUP3;
USE DATABASE ADO_Assignment2_Group3;
USE SCHEMA RAW_DATASET; 

-------------- Remove Duplicate Records-----------------
CREATE OR REPLACE TABLE  
EMERGENCYDEVICELOCATION_CLEAN AS 
SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY Address ORDER BY City ASC) AS RN
    FROM  
EMERGENCYDEVICELOCATION
) 
WHERE RN = 1;


-------------------------- clean missing value ----------------------------------

CREATE OR REPLACE TABLE EMERGENCYDEVICELOCATION_CLEAN AS  
SELECT  
        Address,  
        Building_Name,  
        COALESCE(Location_in_Building, 'Unknown') AS Location_in_Building,  
        DeviceType,  
        COALESCE(Number_of_Devices, 0) AS Number_of_Devices,  
        COALESCE(AED_Serial_Numbers, 'Not Available') AS AED_Serial_Numbers,  
        City,  
        Location  
FROM EMERGENCYDEVICELOCATION_CLEAN;
