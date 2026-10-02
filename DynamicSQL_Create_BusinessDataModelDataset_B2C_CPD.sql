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

--CPD_Evidence
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[CPD_Evidence] AS
SELECT
CPD_Evidence_SK,
CPD_Year_SK,
Activity,
Contact_Reference,
CPD_Evidence_End_Date,
Learning_Outcome,
Provider,
Relevance,
CPD_Evidence_Start_Date,
Supporting_Evidence,
Total_Units,
Total_Units_Claimed,
Verifiable_Units,
Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/CPD/CPD_Evidence/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
CPD_Evidence_SK VARCHAR(100),
CPD_Year_SK VARCHAR(100),
Activity VARCHAR(1000),
Contact_Reference VARCHAR(100),
CPD_Evidence_End_Date DATE,
Learning_Outcome VARCHAR(8000),
Provider VARCHAR(1000),
Relevance VARCHAR(8000),
CPD_Evidence_Start_Date DATE,
Supporting_Evidence VARCHAR(6000),
Total_Units DECIMAL(38,2),
Total_Units_Claimed DECIMAL(38,2),
Verifiable_Units DECIMAL(38,2),
Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)


--CPD_Declaration
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[CPD_Declaration] AS
SELECT
CPD_Declaration_SK,
D365CE_Acca_CPDDeclarationID,
CPD_Year_SK,
Completed_On,
Contact_Reference,
Created_By,
Met_YN,
Route,
Status,
Year,
ModifiedOn,
CreatedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/CPD/CPD_Declaration/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
CPD_Declaration_SK VARCHAR(100),
D365CE_Acca_CPDDeclarationID VARCHAR(100),
CPD_Year_SK VARCHAR(100),
Completed_On DATETIME,
Contact_Reference VARCHAR(100),
Created_By VARCHAR(100),
Met_YN VARCHAR(100),
Route VARCHAR(4000),
Status VARCHAR(4000),
Year INT,
ModifiedOn DATETIME,
CreatedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--CPD_Year
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[CPD_Year] AS
SELECT
CPD_Year_SK,
Contact_Reference,
Allowed_Declaration,
Calculated_Total_Units,
Calculated_Total_Units_Brought_Forward,
Calculated_Verifiable_Units,
Calculated_Verifiable_Units_Including_Brought_Forward,
Evidence_Completed_YN,
IFAC_Body_YN,
Total_Unit_Adjustment,
Total_Unit_Adjustment_Date,
Total_Units_Claimed,
Total_Units_Claimed_Date,
Total_Verifiable_Units_Claimed,
Total_Verifiable_Units_Claimed_Date,
Units_To_Complete,
Verifiable_Units_To_Complete,
Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/CPD/CPD_Year/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
CPD_Year_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
Allowed_Declaration INT,
Calculated_Total_Units DECIMAL(38,2),
Calculated_Total_Units_Brought_Forward DECIMAL(38,2),
Calculated_Verifiable_Units DECIMAL(38,2),
Calculated_Verifiable_Units_Including_Brought_Forward DECIMAL(38,2),
Evidence_Completed_YN VARCHAR(100),
IFAC_Body_YN VARCHAR(100),
Total_Unit_Adjustment DECIMAL(38,2),
Total_Unit_Adjustment_Date DATE,
Total_Units_Claimed DECIMAL(38,2),
Total_Units_Claimed_Date DATE,
Total_Verifiable_Units_Claimed DECIMAL(38,2),
Total_Verifiable_Units_Claimed_Date DATE,
Units_To_Complete DECIMAL(38,2),
Verifiable_Units_To_Complete DECIMAL(38,2),
Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--CPD_Adjustment
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[CPD_Adjustment] AS
SELECT
CPD_Adjustment_SK,
Contact_Reference,
Discretionary_Waiver_YN,
Duration,
Override_Unit,
Period_End_Date,
Period_Start_Date,
Reason,
Status,
Type,
Unit_Adjustment,
Year,
CPD_Year_ID,
CreatedOn,
ModifiedOn,
CPD_Year_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/CPD/CPD_Adjustment/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
CPD_Adjustment_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
Discretionary_Waiver_YN VARCHAR(100),
Duration INT,
Override_Unit DECIMAL,
Period_End_Date DATETIME,
Period_Start_Date DATETIME,
Reason VARCHAR(4000),
Status VARCHAR(4000),
Type VARCHAR(4000),
Unit_Adjustment DECIMAL,
Year INT,
CPD_Year_ID VARCHAR(100),
CreatedOn DATETIME,
ModifiedOn DATETIME,
CPD_Year_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--CPD_Review
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[CPD_Review] AS
SELECT
CPD_Review_SK,
Contact_Reference,
D365CE_CPD_Review,
Outcome,
Status,
Monitoring_Period,
Completed_On,
CPD_Review_Open_YN,
CreatedOn_Year,
ModifiedOn,
CreatedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/B2C/CPD/CPD_Review/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
CPD_Review_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
D365CE_CPD_Review VARCHAR(100),
Outcome VARCHAR(100),
Status VARCHAR(4000),
Monitoring_Period VARCHAR(100),
Completed_On DATETIME,
CPD_Review_Open_YN VARCHAR(100),
CreatedOn_Year INT,
ModifiedOn DATETIME,
CreatedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)