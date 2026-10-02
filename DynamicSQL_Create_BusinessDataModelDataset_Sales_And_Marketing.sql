USE BusinessDataModelDataset;
GO 

DECLARE @CuratedContainerName varchar(255) = 'curated'
-------------------------------------------------------------------------------------------------------------
--Copy and paste from below into the script activity. Uncomment variable declaration section.
/*
DECLARE @CuratedContainerName varchar(255) = @CuratedContainerName_Input
*/
 
DECLARE @DynamicSQL nvarchar(4000) --Must be of type nvarchar as sp_executesql doesn't accept varchar type
 
--Check if the database already exists
--B2B_Lead
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Lead] AS
SELECT
B2B_Lead_SK,
D365CE_Campaign,
Source,
Account_Name,
Account_Number,
Preferred_Contact_Method,
Description,
Bulk_Email_Consent_YN,
Email_Consent_YN,
Telephone_Consent_YN,
Email,
First_Name,
Industry_Sector,
Job_Title,
Last_Name,
Market,
Mobile_Number,
Business_Phone,
Product_Of_Interest,
Salutation,
State_Province,
Street_1,
Street_2,
Street_3,
City,
Country,
Postal_Code,
Topic,
Confirm_Interest_YN,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
B2B_Customer_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Sales_And_Marketing/B2B_Lead/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Lead_SK VARCHAR(100),
D365CE_Campaign VARCHAR(100),
Source VARCHAR(4000),
Account_Name VARCHAR(160),
Account_Number VARCHAR(100),
Preferred_Contact_Method VARCHAR(4000),
Description VARCHAR(4000),
Bulk_Email_Consent_YN VARCHAR(100),
Email_Consent_YN VARCHAR(100),
Telephone_Consent_YN VARCHAR(100),
Email VARCHAR(100),
First_Name VARCHAR(100),
Industry_Sector VARCHAR(100),
Job_Title VARCHAR(100),
Last_Name VARCHAR(100),
Market VARCHAR(100),
Mobile_Number VARCHAR(100),
Business_Phone VARCHAR(100),
Product_Of_Interest VARCHAR(850),
Salutation VARCHAR(100),
State_Province VARCHAR(100),
Street_1 VARCHAR(250),
Street_2 VARCHAR(250),
Street_3 VARCHAR(250),
City VARCHAR(100),
Country VARCHAR(100),
Postal_Code VARCHAR(100),
Topic VARCHAR(300),
Confirm_Interest_YN VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Customer_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2C_Lead
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2C_Lead] AS
SELECT
B2C_Lead_SK,
Contact_Reference,
D365CE_Relationshiprole,
Start_Date,
Status,
End_Date,
Lead_Type,
Other_Source,
Source_Event,
Country_Of_Residence_Code,
Preprospect_Qual_Of_Interest,
Prospect_Qual_Of_Interest,
Preprospect_Interest_Source,
Prospect_Interest_Source,
Primary_Role_Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Referral_Source,
Prospect_Start_Date,
Preprospect_Start_Date,
First_Name,
Last_Name,
Email_Address,
Telephone_Number,
Country,
ZIP_Postal_Code,
Email_Consent_YN
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Sales_And_Marketing/B2C_Lead/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2C_Lead_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
D365CE_Relationshiprole VARCHAR(100),
Start_Date DATE,
Status VARCHAR(4000),
End_Date DATE,
Lead_Type VARCHAR(100),
Other_Source VARCHAR(400),
Source_Event VARCHAR(1000),
Country_Of_Residence_Code VARCHAR(100),
Preprospect_Qual_Of_Interest VARCHAR(100),
Prospect_Qual_Of_Interest VARCHAR(100),
Preprospect_Interest_Source VARCHAR(4000),
Prospect_Interest_Source VARCHAR(4000),
Primary_Role_Code VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Referral_Source VARCHAR(4000),
Prospect_Start_Date DATE,
Preprospect_Start_Date DATE,
First_Name VARCHAR(100),
Last_Name VARCHAR(100),
Email_Address VARCHAR(100),
Telephone_Number VARCHAR(100),
Country VARCHAR(100),
ZIP_Postal_Code VARCHAR(100),
Email_Consent_YN VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--END