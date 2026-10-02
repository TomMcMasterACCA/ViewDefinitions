USE BusinessDataModelDataset;
GO 

DECLARE @CuratedContainerName varchar(255) = 'curated'
-------------------------------------------------------------------------------------------------------------
--Copy and paste from below into the script activity. Uncomment variable declaration section.
/*
DECLARE @CuratedContainerName varchar(255) = @CuratedContainerName_Input
*/
 
DECLARE @DynamicSQL nvarchar(4000) --Must be of type nvarchar as sp_executesql doesn't accept varchar type

--B2B_Customer
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Customer] AS
SELECT
D365CE_B2B_Customer,
Account_Number,
Account_Reference,
Name,
Phone_Number,
Website,
Main_Email_Address,
Alternative_Name_1,
Alternative_Name_2,
B2B_Watchlist_Comments,
Status,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Customer_Balance_In_Transaction_Currency,
Customer_Balance_In_Reporting_Currency,
Customer_Overdue_Balance_In_Transaction_Currency,
Customer_Overdue_Balance_In_Reporting_Currency,
Finance_Email_Address,
Invoice_Email_Address,
B2B_Offering,
D365CE_B2BOfferingId,
B2B_Customer_SK,
Legal_Entity,
Global_Account_YN
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Customer/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
D365CE_B2B_Customer VARCHAR(100),
Account_Number VARCHAR(100),
Account_Reference VARCHAR(100),
Name VARCHAR(1000),
Phone_Number VARCHAR(100),
Website VARCHAR(1000),
Main_Email_Address VARCHAR(255),
Alternative_Name_1 VARCHAR(100),
Alternative_Name_2 VARCHAR(100),
B2B_Watchlist_Comments VARCHAR(4000),
Status VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Customer_Balance_In_Transaction_Currency DECIMAL(32,6),
Customer_Balance_In_Reporting_Currency DECIMAL(32,6),
Customer_Overdue_Balance_In_Transaction_Currency DECIMAL(32,6),
Customer_Overdue_Balance_In_Reporting_Currency DECIMAL(32,6),
Finance_Email_Address VARCHAR(100),
Invoice_Email_Address VARCHAR(100),
B2B_Offering VARCHAR(850),
D365CE_B2BOfferingId VARCHAR(100),
B2B_Customer_SK VARCHAR(100),
Legal_Entity VARCHAR(100),
Global_Account_YN VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Connection
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Connection] AS
SELECT
B2B_Connection_SK,
D365CE_B2B_Connection,
Account_Number,
Contact_Reference,
Master_YN,
Connection_Role,
Connection_Start_Date,
Connection_End_Date,
Status,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
B2B_Customer_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Connection/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Connection_SK VARCHAR(100),
D365CE_B2B_Connection VARCHAR(100),
Account_Number VARCHAR(100),
Contact_Reference VARCHAR(100),
Master_YN VARCHAR(100),
Connection_Role VARCHAR(100),
Connection_Start_Date DATE,
Connection_End_Date DATE,
Status VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Customer_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Role_History
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Role_History] AS
SELECT
B2B_Role_History_SK,
Account_Number,
D365CE_Relationship_Role,
Relationship_Status,
Relationship_Type,
Relationship_Start_Date,
Relationship_End_Date,
Role_Status,
Role_Type,
Role_Type_Code,
Role_Start_Date,
Role_End_Date,
Application_Action,
Application_Action_Reason,
Relationship_Start_Date_Year,
CreatedOn,
ModifiedOn,
B2B_Customer_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Role_History/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Role_History_SK VARCHAR(100),
Account_Number VARCHAR(100),
D365CE_Relationship_Role VARCHAR(100),
Relationship_Status VARCHAR(4000),
Relationship_Type VARCHAR(100),
Relationship_Start_Date DATE,
Relationship_End_Date DATE,
Role_Status VARCHAR(4000),
Role_Type VARCHAR(100),
Role_Type_Code VARCHAR(100),
Role_Start_Date DATE,
Role_End_Date DATE,
Application_Action VARCHAR(4000),
Application_Action_Reason VARCHAR(100),
Relationship_Start_Date_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Customer_SK VARCHAR(160)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Contact

SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Contact] AS
SELECT
Contact_Reference,
Title,
First_Name,
Last_Name,
Full_Name,
Job_Title,
Email_Address_1,
Telephone_Number,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Contact/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
Contact_Reference VARCHAR(100),
Title VARCHAR(4000),
First_Name VARCHAR(100),
Last_Name VARCHAR(100),
Full_Name VARCHAR(160),
Job_Title VARCHAR(100),
Email_Address_1 VARCHAR(100),
Telephone_Number VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Assessment_Condition
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Assessment_Condition] AS
SELECT
B2B_Assessment_Condition_SK,
B2B_Approved_Employer_SK,
B2B_Monitoring_SK,
Condition,
Name,
Condition_Due_Date,
Condition_Met_Date,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
B2B_Learning_Provider_SK,
B2B_ODCBE_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Assessment_Condition/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Assessment_Condition_SK VARCHAR(100),
B2B_Approved_Employer_SK VARCHAR(100),
B2B_Monitoring_SK VARCHAR(100),
Condition VARCHAR(2000),
Name VARCHAR(850),
Condition_Due_Date DATE,
Condition_Met_Date DATE,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Learning_Provider_SK VARCHAR(100),
B2B_ODCBE_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Associated_Location
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Associated_Location] AS
SELECT
B2B_Associated_Location_SK,
B2B_Approved_Employer_SK,
B2B_Learning_Provider_SK,
B2B_ODCBE_SK,
Approved_Employer_Approval_Stream_Applicable,
City,
Country,
County,
Start_Date,
End_Date,
Name,
Address_Line_1,
Address_Line_2,
Address_Line_3,
State_Province,
ZIP_Postal_Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
ISO_Code
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Associated_Location/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Associated_Location_SK VARCHAR(100),
B2B_Approved_Employer_SK VARCHAR(100),
B2B_Learning_Provider_SK VARCHAR(100),
B2B_ODCBE_SK VARCHAR(100),
Approved_Employer_Approval_Stream_Applicable VARCHAR(4000),
City VARCHAR(100),
Country VARCHAR(100),
County VARCHAR(100),
Start_Date DATE,
End_Date DATE,
Name VARCHAR(850),
Address_Line_1 VARCHAR(100),
Address_Line_2 VARCHAR(100),
Address_Line_3 VARCHAR(100),
State_Province VARCHAR(100),
ZIP_Postal_Code VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
ISO_Code VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Eligible_Country
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Eligible_Country] AS
SELECT
B2B_Eligible_Country_SK,
B2B_Registration_Code_SK,
ISO_Code,
Eligible_Country
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Eligible_Country/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Eligible_Country_SK VARCHAR(100),
B2B_Registration_Code_SK VARCHAR(100),
ISO_Code VARCHAR(100),
Eligible_Country VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Registration_Code
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Registration_Code] AS
SELECT
B2B_Registration_Code_SK,
B2B_Sales_Initiative_SK,
FIN_Price_Variant_SK,
EAC_Programme_SK,
Account_Number,
Code,
Description,
Created_On_Year,
CreatedOn,
ModifiedOn,
Status_Code,
Valid_From_Date,
Valid_To_Date,
Inactivate_With_Connection_YN,
Exemption_Type,
Graduation_Date,
Eligibility_Guidelines,
Document_Guidelines,
Qualification_Types,
Account_Reference,
B2B_Customer_SK,
Sales_Initiative,
Price_Variant,
Programme,
Subscription_Discount_Group
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Registration_Code/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Registration_Code_SK VARCHAR(100),
B2B_Sales_Initiative_SK VARCHAR(100),
FIN_Price_Variant_SK VARCHAR(100),
EAC_Programme_SK VARCHAR(100),
Account_Number VARCHAR(100),
Code VARCHAR(850),
Description VARCHAR(2000),
Created_On_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Status_Code VARCHAR(4000),
Valid_From_Date DATE,
Valid_To_Date DATE,
Inactivate_With_Connection_YN VARCHAR(100),
Exemption_Type VARCHAR(4000),
Graduation_Date DATE,
Eligibility_Guidelines VARCHAR(2000),
Document_Guidelines VARCHAR(2000),
Qualification_Types VARCHAR(2000),
Account_Reference VARCHAR(100),
B2B_Customer_SK VARCHAR(100),
Sales_Initiative VARCHAR(850),
Price_Variant VARCHAR(850),
Programme VARCHAR(400),
Subscription_Discount_Group VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Sales_Initiative
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Sales_Initiative] AS
SELECT
B2B_Sales_Initiative_SK,
Name,
Description,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Sales_Initiative/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Sales_Initiative_SK VARCHAR(100),
Name VARCHAR(850),
Description VARCHAR(3000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Billing_Arrangement
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Billing_Arrangement] AS
SELECT
B2B_Billing_Arrangement_SK,
Account_Number,
Reference_Number,
Billing_Arrangement_Description,
Enable_Book_On_Behalf_YN,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
B2B_Customer_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Billing_Arrangement/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Billing_Arrangement_SK VARCHAR(100),
Account_Number VARCHAR(100),
Reference_Number VARCHAR(850),
Billing_Arrangement_Description VARCHAR(2000),
Enable_Book_On_Behalf_YN VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Customer_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Billing_Arrangement_Product_Group
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Billing_Arrangement_Product_Group] AS
SELECT
B2B_Billing_Arrangement_Product_Group_SK,
B2B_Billing_Arrangement_SK,
FIN_Product_Group_SK,
Billing_Arrangement_Product_Group,
Product_Group,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Billing_Arrangement_Product_Group/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Billing_Arrangement_Product_Group_SK VARCHAR(100),
B2B_Billing_Arrangement_SK VARCHAR(100),
FIN_Product_Group_SK VARCHAR(100),
Billing_Arrangement_Product_Group VARCHAR(850),
Product_Group VARCHAR(850),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--B2B_Monitoring
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B_Monitoring] AS
SELECT
B2B_Monitoring_SK,
APP_Application_SK,
Account_Number,
Contact_Reference,
Customer_Additional_Information,
Deadline_Date,
Information_Required,
Joint_Monitoring_YN,
Markets_Handover_Date,
Method,
Method_Description,
Outcome,
Outcome_Description,
Outcome_Notes,
Previous_Visit_Date,
Reason,
Reason_Description,
Report_Received_Date,
Status,
Stream,
Visit_Date,
Visit_Type,
Visit_Type_Description,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
B2B_Customer_SK,
Owner
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B_Monitoring/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B_Monitoring_SK VARCHAR(100),
APP_Application_SK VARCHAR(100),
Account_Number VARCHAR(100),
Contact_Reference VARCHAR(100),
Customer_Additional_Information VARCHAR(6000),
Deadline_Date DATETIME,
Information_Required VARCHAR(2000),
Joint_Monitoring_YN VARCHAR(100),
Markets_Handover_Date DATETIME,
Method VARCHAR(850),
Method_Description VARCHAR(2000),
Outcome VARCHAR(850),
Outcome_Description VARCHAR(2000),
Outcome_Notes VARCHAR(2000),
Previous_Visit_Date DATETIME,
Reason VARCHAR(850),
Reason_Description VARCHAR(2000),
Report_Received_Date DATETIME,
Status VARCHAR(4000),
Stream VARCHAR(850),
Visit_Date DATETIME,
Visit_Type VARCHAR(850),
Visit_Type_Description VARCHAR(2000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Customer_SK VARCHAR(100),
Owner VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--B2B2C_Connection
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[B2B2C_Connection] AS
SELECT
B2B2C_Connection_SK,
B2B_Billing_Arrangement_SK,
B2B_Registration_Code_SK,
B2B_Customer_SK,
Account_Number,
Account_Reference,
Contact_Reference,
Billing_Arrangement,
Status,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Status_Reason,
Reference_Number,
APP_Consent_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2B/Customer/B2B2C_Connection/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
B2B2C_Connection_SK VARCHAR(100),
B2B_Billing_Arrangement_SK VARCHAR(100),
B2B_Registration_Code_SK VARCHAR(100),
B2B_Customer_SK VARCHAR(100),
Account_Number VARCHAR(100),
Account_Reference VARCHAR(100),
Contact_Reference VARCHAR(100),
Billing_Arrangement VARCHAR(850),
Status VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Status_Reason VARCHAR(4000),
Reference_Number VARCHAR(850),
APP_Consent_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)