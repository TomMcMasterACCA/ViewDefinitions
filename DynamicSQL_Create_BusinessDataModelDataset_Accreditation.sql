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

--EAC_National_Qualification
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_National_Qualification] AS
SELECT
EAC_National_Qualification_SK,
D365CE_National_Qualification,
ISO_Code,
EAC_Qualification_Level_SK,
Name,
Qualification_Level,
Country,
Internal_Note,
External_Note,
Description,
Order_Number,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
National_Qualification_ID
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_National_Qualification/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_National_Qualification_SK VARCHAR(100),
D365CE_National_Qualification VARCHAR(100),
ISO_Code VARCHAR(100),
EAC_Qualification_Level_SK VARCHAR(100),
Name VARCHAR(400),
Qualification_Level VARCHAR(100),
Country VARCHAR(100),
Internal_Note VARCHAR(4000),
External_Note VARCHAR(4000),
Description VARCHAR(4000),
Order_Number INT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
National_Qualification_ID VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)


--EAC_Programme
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Programme] AS
SELECT
EAC_Programme_SK,
EAC_Institution_SK,
Programme,
Institution,
Notes,
Internal_Note,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Programme_ID
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Programme/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Programme_SK VARCHAR(100),
EAC_Institution_SK VARCHAR(100),
Programme VARCHAR(400),
Institution VARCHAR(400),
Notes VARCHAR(4000),
Internal_Note VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Programme_ID VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)


--EAC_Available_Accreditation
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Available_Accreditation] AS
SELECT
EAC_Available_Accreditation_SK,
EAC_Institution_SK,
EAC_National_Qualification_SK,
EAC_Programme_SK,
EAC_Subject_Major_SK,
Exemption_Accreditation,
Assessment_Code,
Accredited_From,
Accredited_To,
Conditional_Exemptions_Allowed_YN,
Country,
External_Note,
Internal_Note,
Minimum_Entry_YN,
Search_Option,
Accredited_From_Year,
CreatedOn,
ModifiedOn,
Status
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Available_Accreditation/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Available_Accreditation_SK VARCHAR(100),
EAC_Institution_SK VARCHAR(100),
EAC_National_Qualification_SK VARCHAR(100),
EAC_Programme_SK VARCHAR(100),
EAC_Subject_Major_SK VARCHAR(100),
Exemption_Accreditation VARCHAR(1000),
Assessment_Code VARCHAR(100),
Accredited_From DATE,
Accredited_To DATE,
Conditional_Exemptions_Allowed_YN VARCHAR(100),
Country VARCHAR(100),
External_Note VARCHAR(4000),
Internal_Note VARCHAR(4000),
Minimum_Entry_YN VARCHAR(100),
Search_Option VARCHAR(4000),
Accredited_From_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Status VARCHAR(4000)
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Qualification_Level
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Qualification_Level] AS
SELECT
EAC_Qualification_Level_SK,
D365CE_Qualification_Level,
Name,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Qualification_Level/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Qualification_Level_SK VARCHAR(100),
D365CE_Qualification_Level VARCHAR(100),
Name VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

EXEC (@DynamicSQL)

--EAC_Subject_Major
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Subject_Major] AS
SELECT
EAC_Subject_Major_SK,
D365CE_Acca_SubjectMajorID,
Name,
Description,
Code,
External_Note,
Internal_Note,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Subject_Major/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Subject_Major_SK VARCHAR(100),
D365CE_Acca_SubjectMajorID VARCHAR(100),
Name VARCHAR(400),
Description VARCHAR(4000),
Code VARCHAR(100),
External_Note VARCHAR(4000),
Internal_Note VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Exemption_Subject
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Exemption_Subject] AS
SELECT
EAC_Exemption_Subject_SK,
Exemption_Subject,
Qualification,
Qualification_Level,
Display_Order,
Product,
Subject_Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Exemption_Subject/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Exemption_Subject_SK VARCHAR(100),
Exemption_Subject VARCHAR(100),
Qualification VARCHAR(4000),
Qualification_Level VARCHAR(100),
Display_Order INT,
Product VARCHAR(100),
Subject_Code VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Available_Exemption
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Available_Exemption] AS
SELECT
EAC_Available_Exemption_SK,
EAC_Available_Accreditation_SK,
EAC_Available_Exemption_Outcome_SK,
EAC_Exemption_Subject_SK,
Code,
Available_Exemption,
Exemption_Subject,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Available_Exemption/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Available_Exemption_SK VARCHAR(100),
EAC_Available_Accreditation_SK VARCHAR(100),
EAC_Available_Exemption_Outcome_SK VARCHAR(100),
EAC_Exemption_Subject_SK VARCHAR(100),
Code VARCHAR(100),
Available_Exemption VARCHAR(100),
Exemption_Subject VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Available_Exemption_Outcome
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Available_Exemption_Outcome] AS
SELECT
EAC_Available_Exemption_Outcome_SK,
Exemption_Outcome,
Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Available_Exemption_Outcome/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Available_Exemption_Outcome_SK VARCHAR(100),
Exemption_Outcome VARCHAR(2000),
Code VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Institution
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Institution] AS
SELECT
EAC_Institution_SK,
ISO_Code,
Institution_Name,
Country,
Display_On_Web_YN,
External_Note,
Framework_Allowed_YN,
Internal_Note,
Other_Name,
Previous_Name,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
B2B_Customer_SK,
Institution_ID
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Institution/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Institution_SK VARCHAR(100),
ISO_Code VARCHAR(100),
Institution_Name VARCHAR(400),
Country VARCHAR(100),
Display_On_Web_YN VARCHAR(100),
External_Note VARCHAR(4000),
Framework_Allowed_YN VARCHAR(100),
Internal_Note VARCHAR(4000),
Other_Name VARCHAR(2000),
Previous_Name VARCHAR(2000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
B2B_Customer_SK VARCHAR(100),
Institution_ID VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Module
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Module] AS
SELECT
EAC_Module_SK,
EAC_Institution_SK,
Code,
Institution,
Module,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Module/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Module_SK VARCHAR(100),
EAC_Institution_SK VARCHAR(100),
Code VARCHAR(100),
Institution VARCHAR(400),
Module VARCHAR(1000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EAC_Available_Exemption_Module
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EAC_Available_Exemption_Module] AS
SELECT
EAC_Available_Exemption_Module_SK,
EAC_Available_Exemption_SK,
EAC_Module_SK,
Name,
Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Accreditation/EAC_Available_Exemption_Module/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EAC_Available_Exemption_Module_SK VARCHAR(100),
EAC_Available_Exemption_SK VARCHAR(100),
EAC_Module_SK VARCHAR(100),
Name VARCHAR(1000),
Code VARCHAR(850),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)