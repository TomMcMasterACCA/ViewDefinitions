USE BusinessDataModelDataset;
GO 
/*
These variables will be passed as parameters from the script activity.
Ensure that these declarations remain in the script activity. Otherwise the string length will be limited to 4000 characters.
Also ensure that the string variables declared below are of type varchar.
Otherwise, if using nvarchar, the dynamic sql length will be limited to 4000 characters due to an implicit conversion (varchar to nvarchar) made during the string concatination.
*/
 
DECLARE @CuratedContainerName varchar(255) = 'curated'
------------------------------------------------------------------------------------------------------
--Copy and paste from below into the script activity. Uncomment variable declaration section.
/*
DECLARE @CuratedContainerName varchar(255) = @CuratedContainerName_Input
*/

--Do not convert this to nvarchar as nvarchar limits string length to 4000 characters whereas maximum length for varchar type is 8000.
DECLARE @DynamicSQL varchar(8000)

--SVC_Activity
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Activity] AS
SELECT
SVC_Activity_SK,
SVC_Case_SK,
Activity_Type,
Activity_Date,
Due_Date,
Priority,
Status,
Subject,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
CreatedBy,
Owner_Name
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Activity/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Activity_SK VARCHAR(100),
SVC_Case_SK VARCHAR(100),
Activity_Type VARCHAR(100),
Activity_Date DATE,
Due_Date DATE,
Priority VARCHAR(4000),
Status VARCHAR(4000),
Subject VARCHAR(2000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
CreatedBy VARCHAR(1000),
Owner_Name VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--SVC_Case
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Case] AS
SELECT
SVC_Case_SK,
D365CE_Incident,
APP_Application_SK,
SVC_Service_Catalogue_SK,
Case_Number,
Contact_Reference,
Category_Name,
Category_Number,
Deactivate_On,
First_Response_On,
Origin,
Owner,
Raised_By,
Case_Title,
Case_Type,
Case_Status,
Customer_Name,
Owning_Business_Unit,
Manager,
In_Progress_Reason,
Outcome_Reason,
Secondary_Category,
Created_By,
Modified_By,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Case_Status_Updated_Date,
Import_Sequence_Number,
Time_Zone_Rule_Version_Number,
UTC_Conversion_Time_Zone_Code,
Version_Number,
Case_Status_Reason
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Case/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Case_SK VARCHAR(100),
D365CE_Incident VARCHAR(100),
APP_Application_SK VARCHAR(100),
SVC_Service_Catalogue_SK VARCHAR(100),
Case_Number VARCHAR(100),
Contact_Reference VARCHAR(100),
Category_Name VARCHAR(155),
Category_Number VARCHAR(4000),
Deactivate_On DATETIME,
First_Response_On DATETIME,
Origin VARCHAR(4000),
Owner VARCHAR(100),
Raised_By VARCHAR(160),
Case_Title VARCHAR(2000),
Case_Type VARCHAR(4000),
Case_Status VARCHAR(4000),
Customer_Name VARCHAR(160),
Owning_Business_Unit VARCHAR(160),
Manager VARCHAR(100),
In_Progress_Reason VARCHAR(100),
Outcome_Reason VARCHAR(850),
Secondary_Category VARCHAR(155),
Created_By VARCHAR(100),
Modified_By VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Case_Status_Updated_Date DATETIME,
Import_Sequence_Number INT,
Time_Zone_Rule_Version_Number INT,
UTC_Conversion_Time_Zone_Code INT,
Version_Number INT,
Case_Status_Reason VARCHAR(4000)
) AS [result]'
EXEC (@DynamicSQL)

--SVC_Case_KPI (originally was SLA_KPI)
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Case_KPI] AS
SELECT
SVC_Case_KPI_SK,
SVC_Case_SK,
Assigned,
Time_To_Assign,
Resolved,
Time_To_Resolve,
Closed,
Time_To_Close,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Case_KPI/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Case_KPI_SK VARCHAR(100),
SVC_Case_SK VARCHAR(100),
Assigned DATE,
Time_To_Assign BIGINT,
Resolved DATE,
Time_To_Resolve BIGINT,
Closed DATE,
Time_To_Close BIGINT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

EXEC (@DynamicSQL)

--SVC_Case_Hold_Reason
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Case_Hold_Reason] AS
SELECT
SVC_Case_Hold_Reason_SK,
SVC_Case_SK,
D365CE_CaseInProgressReasonsId,
Case_On_Hold_Reason_Name,
Import_Sequence_Number,
Modified_On_Behalf_By,
Overridden_Created_On,
Owner_ID,
Owner_ID_Type,
Status,
Status_Reason,
Time_Zone_Rule_Version_Number,
UTC_Conversion_Time_Zone_Code,
Version_Number,
Description,
CreatedBy,
ModifiedBy,
Owning_Business_Unit,
Created_On_Behalf_By,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Owner_Name
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Case_Hold_Reason/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Case_Hold_Reason_SK VARCHAR(100),
SVC_Case_SK VARCHAR(100),
D365CE_CaseInProgressReasonsId VARCHAR(100),
Case_On_Hold_Reason_Name VARCHAR(100),
Import_Sequence_Number INT,
Modified_On_Behalf_By VARCHAR(100),
Overridden_Created_On DATE,
Owner_ID VARCHAR(100),
Owner_ID_Type VARCHAR(100),
Status VARCHAR(4000),
Status_Reason VARCHAR(4000),
Time_Zone_Rule_Version_Number INT,
UTC_Conversion_Time_Zone_Code INT,
Version_Number BIGINT,
Description VARCHAR(2000),
CreatedBy VARCHAR(100),
ModifiedBy VARCHAR(100),
Owning_Business_Unit VARCHAR(100),
Created_On_Behalf_By VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Owner_Name VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)


--SVC_Queue
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Queue] AS
SELECT
SVC_Queue_SK,
SVC_Activity_SK,
SVC_Case_SK,
Queue_ID_Name,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Queue/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Queue_SK VARCHAR(100),
SVC_Activity_SK VARCHAR(100),
SVC_Case_SK VARCHAR(100),
Queue_ID_Name VARCHAR(400),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)

--SVC_Task
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Task] AS
SELECT
SVC_Task_SK,
SVC_Activity_SK,
Subject,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Owner_Name,
Status
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Task/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Task_SK VARCHAR(100),
SVC_Activity_SK VARCHAR(100),
Subject VARCHAR(1000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Owner_Name VARCHAR(100),
Status VARCHAR(4000)
) AS [result]'

EXEC (@DynamicSQL)

--SVC_Service_Catalogue
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Service_Catalogue] AS
SELECT
SVC_Service_Catalogue_SK,
Communication_Resolution_Time,
Case_Closure_Days,
Case_Type,
Category_Name,
Category_Number,
Correspondence_Details,
Queue,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Service_Catalogue/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Service_Catalogue_SK VARCHAR(100),
Communication_Resolution_Time INT,
Case_Closure_Days INT,
Case_Type VARCHAR(4000),
Category_Name VARCHAR(155),
Category_Number VARCHAR(4000),
Correspondence_Details VARCHAR(1000),
Queue VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)

--SVC_Interaction
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[SVC_Interaction] AS
SELECT
SVC_Interaction_SK,
SVC_Activity_SK,
Channel,
Description,
Interaction_Type,
Regarding,
Source,
Source_Reference,
Status_Reason,
Created_By,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/Customer_Service/SVC_Interaction/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
SVC_Interaction_SK VARCHAR(100),
SVC_Activity_SK VARCHAR(100),
Channel VARCHAR(100),
Description VARCHAR(MAX),
Interaction_Type VARCHAR(100),
Regarding VARCHAR(1000),
Source VARCHAR(100),
Source_Reference VARCHAR(100),
Status_Reason VARCHAR(4000),
Created_By VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)