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


--EXM_Adjustment_Rule
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Adjustment_Rule] AS
SELECT
EXM_Adjustment_Rule_SK,
Description,
Desk_Range_Start,
Desk_Range_End,
MCQ_Answer,
Adjustment_Value,
Created_By,
Modified_By,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Session_Period_Date,
EXM_Session_Period_SK,
Session_Key,
ExamsDB_Question_ID,
EXM_Centre_SK,
EXM_Session_Venue_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Adjustment_Rule/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Adjustment_Rule_SK VARCHAR(100),
Description VARCHAR(2000),
Desk_Range_Start INT,
Desk_Range_End INT,
MCQ_Answer VARCHAR(100),
Adjustment_Value DECIMAL(10,0),
Created_By VARCHAR(100),
Modified_By VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Session_Period_Date DATE,
EXM_Session_Period_SK VARCHAR(100),
Session_Key VARCHAR(100),
ExamsDB_Question_ID VARCHAR(100),
EXM_Centre_SK VARCHAR(100),
EXM_Session_Venue_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Adjustments
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Adjustments] AS
SELECT
EXM_Adjustments_SK,
EXM_Adjustment_Rule_SK,
EXM_Sitting_SK,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Adjustments/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Adjustments_SK VARCHAR(100),
EXM_Adjustment_Rule_SK VARCHAR(100),
EXM_Sitting_SK VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Booking
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Booking] AS
SELECT
EXM_Booking_SK,
EXM_Subject_SK,
EXM_Sitting_SK,
Contact_Reference,
Session_Key,
Chosen_Session_Centre_Code,
Booking_Date,
Delivery_Format,
Sitting_Date,
Syllabus_Code,
Variant_Code,
Online_YN,
Entry_Period,
Entry_Route,
RI_Price_Band,
Subject_Code,
Withdrawn_YN,
Valid_YN,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
EXM_Booking_Result_SK,
Withdrawn_Date,
Created_By,
Allocated_Centre_Code,
Priority_YN,
Late_Entry_YN,
Transfer_YN,
Notified_YN,
Price_Paid,
Exam_Duration,
Desk_Number,
Price_Listed,
Entry_Period_Override,
Allocated_Venue_Code,
Language_Code,
EXM_Session_Centre_Chosen_SK,
EXM_Session_Centre_Allocated_SK,
EXM_Session_Venue_Allocated_SK,
EXM_Pathway_SK,
EXM_Pathway_Subject_SK,
EXM_Subject_Variant_SK,
EXM_Session_Subject_Variant_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Booking/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Booking_SK VARCHAR(100),
EXM_Subject_SK VARCHAR(100),
EXM_Sitting_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
Session_Key VARCHAR(100),
Chosen_Session_Centre_Code VARCHAR(100),
Booking_Date DATETIME,
Delivery_Format VARCHAR(255),
Sitting_Date DATETIME,
Syllabus_Code VARCHAR(100),
Variant_Code VARCHAR(100),
Online_YN VARCHAR(100),
Entry_Period VARCHAR(100),
Entry_Route VARCHAR(100),
RI_Price_Band VARCHAR(100),
Subject_Code VARCHAR(100),
Withdrawn_YN VARCHAR(100),
Valid_YN VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
EXM_Booking_Result_SK VARCHAR(100),
Withdrawn_Date DATE,
Created_By VARCHAR(100),
Allocated_Centre_Code VARCHAR(100),
Priority_YN VARCHAR(100),
Late_Entry_YN VARCHAR(100),
Transfer_YN VARCHAR(100),
Notified_YN VARCHAR(100),
Price_Paid VARCHAR(100),
Exam_Duration VARCHAR(100),
Desk_Number VARCHAR(100),
Price_Listed VARCHAR(100),
Entry_Period_Override VARCHAR(100),
Allocated_Venue_Code INT,
Language_Code VARCHAR(100),
EXM_Session_Centre_Chosen_SK VARCHAR(100),
EXM_Session_Centre_Allocated_SK VARCHAR(100),
EXM_Session_Venue_Allocated_SK VARCHAR(100),
EXM_Pathway_SK VARCHAR(100),
EXM_Pathway_Subject_SK VARCHAR(100),
EXM_Subject_Variant_SK VARCHAR(100),
EXM_Session_Subject_Variant_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Centre
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Centre] AS
SELECT
EXM_Centre_SK,
EXM_Location_SK,
Centre_Code,
ISO_Code,
Centre_Name,
Centre_Time_Zone,
Centre_Type,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Deleted_YN
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Centre/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Centre_SK VARCHAR(100),
EXM_Location_SK VARCHAR(100),
Centre_Code VARCHAR(100),
ISO_Code VARCHAR(100),
Centre_Name VARCHAR(255),
Centre_Time_Zone VARCHAR(800),
Centre_Type VARCHAR(255),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Deleted_YN VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Exemption
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Exemption] AS
SELECT
EXM_Exemption_SK,
EXM_Subject_SK,
Session_Key,
Contact_Reference,
Exemption_Class_Code,
Exemption_Class_Description,
Exemption_Code,
Conditional_Conversion_Date,
Conditional_Expiry_Date,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Exemption_Description,
EXM_Pathway_SK,
EXM_Pathway_Subject_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Exemption/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Exemption_SK VARCHAR(100),
EXM_Subject_SK VARCHAR(100),
Session_Key VARCHAR(100),
Contact_Reference VARCHAR(100),
Exemption_Class_Code VARCHAR(255),
Exemption_Class_Description VARCHAR(100),
Exemption_Code VARCHAR(100),
Conditional_Conversion_Date DATETIME,
Conditional_Expiry_Date DATETIME,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Exemption_Description VARCHAR(100),
EXM_Pathway_SK VARCHAR(100),
EXM_Pathway_Subject_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Location
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Location] AS
SELECT
EXM_Location_SK,
ISO_Short_Code,
ISO_Code,
Name,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Location/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Location_SK VARCHAR(100),
ISO_Short_Code VARCHAR(100),
ISO_Code VARCHAR(100),
Name VARCHAR(400),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Mark
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Mark] AS
SELECT
EXM_Mark_SK,
EXM_Sitting_SK,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Session_Key
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Mark/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Mark_SK VARCHAR(100),
EXM_Sitting_SK VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Session_Key VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Pathway
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Pathway] AS
SELECT
EXM_Pathway_SK,
Pathway_Code,
Description,
First_Session_Key,
Last_Session_Key,
Max_Option,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Pathway/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Pathway_SK VARCHAR(100),
Pathway_Code VARCHAR(100),
Description VARCHAR(100),
First_Session_Key VARCHAR(100),
Last_Session_Key VARCHAR(100),
Max_Option VARCHAR(2000),
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

EXEC (@DynamicSQL)

--EXM_Pathway_Subject
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Pathway_Subject] AS
SELECT
EXM_Pathway_Subject_SK,
EXM_Pathway_SK,
EXM_Subject_SK,
Display_Order,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Pathway_Subject/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Pathway_Subject_SK VARCHAR(100),
EXM_Pathway_SK VARCHAR(100),
EXM_Subject_SK VARCHAR(100),
Display_Order INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Result_Published
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Result_Published] AS
SELECT
EXM_Result_SK,
EXM_Subject_Variant_SK,
EXM_Pathway_SK,
EXM_Centre_SK,
Contact_Reference,
ExamsDB_Subject_Variant,
Session_Key,
Expiry_Session,
Publication_From_Date,
Delivery_Format,
Result_Description,
Result_Code,
Subject_Code,
Final_Mark_Percentage,
Positive_YN,
Optional_YN,
Notional_YN,
Publication_From_Year,
CreatedOn,
ModifiedOn,
EXM_Booking_Result_SK,
Expired_Result_Code,
Expired_Result_Description,
Created_By,
Modified_By,
Attempt_Number,
External_Module_Code,
External_Module_Qual_Code,
External_Module_Qual_Description,
EXM_Session_Venue_SK,
EXM_Pathway_Subject_SK,
EXM_Sitting_SK,
EXM_Session_Centre_SK,
EXM_Booking_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Result_Published/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Result_SK VARCHAR(100),
EXM_Subject_Variant_SK VARCHAR(100),
EXM_Pathway_SK VARCHAR(100),
EXM_Centre_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
ExamsDB_Subject_Variant VARCHAR(100),
Session_Key VARCHAR(100),
Expiry_Session VARCHAR(100),
Publication_From_Date DATE,
Delivery_Format VARCHAR(255),
Result_Description VARCHAR(100),
Result_Code VARCHAR(100),
Subject_Code VARCHAR(100),
Final_Mark_Percentage INT,
Positive_YN VARCHAR(100),
Optional_YN VARCHAR(100),
Notional_YN VARCHAR(100),
Publication_From_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
EXM_Booking_Result_SK VARCHAR(100),
Expired_Result_Code VARCHAR(100),
Expired_Result_Description VARCHAR(100),
Created_By VARCHAR(100),
Modified_By VARCHAR(100),
Attempt_Number INT,
External_Module_Code VARCHAR(100),
External_Module_Qual_Code VARCHAR(100),
External_Module_Qual_Description VARCHAR(100),
EXM_Session_Venue_SK VARCHAR(100),
EXM_Pathway_Subject_SK VARCHAR(100),
EXM_Sitting_SK VARCHAR(100),
EXM_Session_Centre_SK VARCHAR(100),
EXM_Booking_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)


--EXM_Result_Unpublished

SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Result_Unpublished] AS
SELECT
EXM_Result_SK,
EXM_Subject_Variant_SK,
EXM_Pathway_SK,
EXM_Centre_SK,
Contact_Reference,
ExamsDB_Subject_Variant,
Session_Key,
Expiry_Session,
Publication_From_Date,
Delivery_Format,
Result_Description,
Result_Code,
Subject_Code,
Final_Mark_Percentage,
Positive_YN,
Optional_YN,
Notional_YN,
Publication_From_Year,
CreatedOn,
ModifiedOn,
EXM_Booking_Result_SK,
Expired_Result_Code,
Expired_Result_Description,
Created_By,
Modified_By,
Attempt_Number,
External_Module_Code,
External_Module_Qual_Code,
External_Module_Qual_Description,
EXM_Session_Venue_SK,
EXM_Pathway_Subject_SK,
EXM_Sitting_SK,
EXM_Session_Centre_SK,
EXM_Booking_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Result_Unpublished/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Result_SK VARCHAR(100),
EXM_Subject_Variant_SK VARCHAR(100),
EXM_Pathway_SK VARCHAR(100),
EXM_Centre_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
ExamsDB_Subject_Variant VARCHAR(100),
Session_Key VARCHAR(100),
Expiry_Session VARCHAR(100),
Publication_From_Date DATE,
Delivery_Format VARCHAR(255),
Result_Description VARCHAR(100),
Result_Code VARCHAR(100),
Subject_Code VARCHAR(100),
Final_Mark_Percentage INT,
Positive_YN VARCHAR(100),
Optional_YN VARCHAR(100),
Notional_YN VARCHAR(100),
Publication_From_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
EXM_Booking_Result_SK VARCHAR(100),
Expired_Result_Code VARCHAR(100),
Expired_Result_Description VARCHAR(100),
Created_By VARCHAR(100),
Modified_By VARCHAR(100),
Attempt_Number INT,
External_Module_Code VARCHAR(100),
External_Module_Qual_Code VARCHAR(100),
External_Module_Qual_Description VARCHAR(100),
EXM_Session_Venue_SK VARCHAR(100),
EXM_Pathway_Subject_SK VARCHAR(100),
EXM_Sitting_SK VARCHAR(100),
EXM_Session_Centre_SK VARCHAR(100),
EXM_Booking_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)



--EXM_Session_Centre
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Centre] AS
SELECT
EXM_Session_Centre_SK,
EXM_Centre_SK,
Session_Centre_Code,
Session_Key,
Capacity,
Default_Start_Time,
Is_Published_YN,
Is_Special_YN,
Special_Fee,
Default_Start_Time_Year,
CreatedOn,
ModifiedOn,
Centre_Code,
Centre_Name,
Centre_Type_Code,
Centre_Type_Description,
Centre_Location,
Timezone_Description,
ISO_Code
FROM OPENROWSET (
BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Centre/'',
DATA_SOURCE = ''DataLakeDataSource'',
FORMAT = ''delta''
) WITH (
EXM_Session_Centre_SK VARCHAR(100),
EXM_Centre_SK VARCHAR(100),
Session_Centre_Code VARCHAR(100),
Session_Key VARCHAR(100),
Capacity INT,
Default_Start_Time DATETIME,
Is_Published_YN VARCHAR(100),
Is_Special_YN VARCHAR(100),
Special_Fee INT,
Default_Start_Time_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Centre_Code VARCHAR(100),
Centre_Name VARCHAR(255),
Centre_Type_Code VARCHAR(100),
Centre_Type_Description VARCHAR(255),
Centre_Location VARCHAR(400),
Timezone_Description VARCHAR(800),
ISO_Code VARCHAR(100)
) AS [result]'

EXEC (@DynamicSQL)


--EXM_Session_Date
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Date] AS
SELECT
EXM_Session_Date_SK,
Session_Key,
Code,
Date,
Description,
Date_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Date/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Session_Date_SK VARCHAR(100),
Session_Key VARCHAR(100),
Code VARCHAR(100),
Date DATETIME,
Description VARCHAR(1000),
Date_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)



--EXM_Session_Subject_Variant
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Subject_Variant] AS
SELECT
EXM_Session_Subject_Variant_SK,
EXM_Session_Subject_SK,
EXM_Subject_Variant_SK,
Apply_Psychometrics_YN,
Apply_Rasch_Psychometrics_YN,
Exam_Duration,
External_Exams_Reference,
Final_Mark_Multiple,
Item_Upload_Status,
MCQ_Answers_Confirmed_YN,
MCQ_Max_Mark,
Number_Of_MCQ_Questions,
Number_Of_Optional_Script_Questions,
Number_Of_Scored_Questions,
Number_Of_Script_Questions,
Number_Of_Script_Questions_TBA,
Number_Of_Unscored_Questions,
Original_Pass_Mark,
Packets_Finalised_YN,
Paper_Type,
Pass_Mark,
PCT_Script_Mark,
Q_Allowed_Atts_YN,
Q_Allowed_Atts_Finalised_YN,
Seeded_Duration,
Simple_Marking_Scheme_YN,
Total_Exam_Mark,
Total_Questions_Mark,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Session_Key
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Subject_Variant/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Session_Subject_Variant_SK VARCHAR(100),
EXM_Session_Subject_SK VARCHAR(100),
EXM_Subject_Variant_SK VARCHAR(100),
Apply_Psychometrics_YN VARCHAR(100),
Apply_Rasch_Psychometrics_YN VARCHAR(100),
Exam_Duration INT,
External_Exams_Reference VARCHAR(100),
Final_Mark_Multiple INT,
Item_Upload_Status VARCHAR(100),
MCQ_Answers_Confirmed_YN VARCHAR(100),
MCQ_Max_Mark INT,
Number_Of_MCQ_Questions INT,
Number_Of_Optional_Script_Questions INT,
Number_Of_Scored_Questions INT,
Number_Of_Script_Questions INT,
Number_Of_Script_Questions_TBA INT,
Number_Of_Unscored_Questions INT,
Original_Pass_Mark INT,
Packets_Finalised_YN VARCHAR(100),
Paper_Type VARCHAR(100),
Pass_Mark INT,
PCT_Script_Mark INT,
Q_Allowed_Atts_YN VARCHAR(100),
Q_Allowed_Atts_Finalised_YN VARCHAR(100),
Seeded_Duration INT,
Simple_Marking_Scheme_YN VARCHAR(100),
Total_Exam_Mark INT,
Total_Questions_Mark INT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Session_Key VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Session_Subject
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Subject] AS
SELECT
EXM_Session_Subject_SK,
EXM_Subject_SK,
Session_Key,
Delivery_Format,
Period_Date,
Period_Number,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
EXM_Session_Period_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Subject/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Session_Subject_SK VARCHAR(100),
EXM_Subject_SK VARCHAR(100),
Session_Key VARCHAR(100),
Delivery_Format VARCHAR(100),
Period_Date DATETIME,
Period_Number INT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
EXM_Session_Period_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)


--EXM_Session_Venue
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Venue] AS
SELECT
EXM_Session_Venue_SK,
EXM_Session_Centre_SK,
Centre_Code,
Venue_Name,
Venue_Number,
Include_Allocation_YN,
Note,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Session_Key
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Venue/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Session_Venue_SK VARCHAR(100),
EXM_Session_Centre_SK VARCHAR(100),
Centre_Code VARCHAR(100),
Venue_Name VARCHAR(255),
Venue_Number INT,
Include_Allocation_YN VARCHAR(100),
Note VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Session_Key VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Session

SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session] AS
SELECT
Session_Key,
Session_Date,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
Session_Key VARCHAR(100),
Session_Date DATE,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)

--EXM_Sitting
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Sitting] AS
SELECT
EXM_Sitting_SK,
Session_Key,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Attendance_Status,
EXM_Booking_SK,
EXM_Session_Venue_SK,
EXM_Session_Centre_SK,
EXM_Pathway_SK,
EXM_Pathway_Subject_SK,
EXM_Subject_Variant_SK,
EXM_Session_Subject_Variant_SK,
Contact_Reference
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Sitting/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Sitting_SK VARCHAR(100),
Session_Key VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Attendance_Status VARCHAR(255),
EXM_Booking_SK VARCHAR(100),
EXM_Session_Venue_SK VARCHAR(100),
EXM_Session_Centre_SK VARCHAR(100),
EXM_Pathway_SK VARCHAR(100),
EXM_Pathway_Subject_SK VARCHAR(100),
EXM_Subject_Variant_SK VARCHAR(100),
EXM_Session_Subject_Variant_SK VARCHAR(100),
Contact_Reference VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Subject_Variant
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Subject_Variant] AS
SELECT
EXM_Subject_Variant_SK,
EXM_Subject_SK,
Variant_Code,
First_Session_Key,
Language_Code,
Last_Session_Key,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Language_Name
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Subject_Variant/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Subject_Variant_SK VARCHAR(100),
EXM_Subject_SK VARCHAR(100),
Variant_Code VARCHAR(100),
First_Session_Key VARCHAR(100),
Language_Code VARCHAR(100),
Last_Session_Key VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Language_Name VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)


--EXM_Subject
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Subject] AS
SELECT
EXM_Subject_SK,
Subject_Name,
Subject_Short_Name,
Subject_Code,
Variant_Type,
Display_Order,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
EXM_Syllabus_SK,
Module
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Subject/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Subject_SK VARCHAR(100),
Subject_Name VARCHAR(100),
Subject_Short_Name VARCHAR(100),
Subject_Code VARCHAR(100),
Variant_Type VARCHAR(100),
Display_Order INT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
EXM_Syllabus_SK VARCHAR(100),
Module VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Variant
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Variant] AS
SELECT
Variant_Code,
ISO_Code,
Description,
Variant_Display_Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Variant/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
Variant_Code VARCHAR(100),
ISO_Code VARCHAR(100),
Description VARCHAR(100),
Variant_Display_Code VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Syllabus
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Syllabus] AS
SELECT
EXM_Syllabus_SK,
Syllabus_Code,
Qualification_Code,
Qualification_Description,
Syllabus_Description,
First_Session,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Syllabus/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Syllabus_SK VARCHAR(100),
Syllabus_Code VARCHAR(100),
Qualification_Code VARCHAR(100),
Qualification_Description VARCHAR(100),
Syllabus_Description VARCHAR(100),
First_Session VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Study_Method
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Study_Method] AS
SELECT
EXM_Study_Method_SK,
B2B_Learning_Provider_SK,
EXM_Booking_SK,
Learning_Provider_Name,
Learning_Provider_Others,
Learning_Provider_ISO_Code,
Study_Method,
Study_Period,
Modified_By,
Created_By,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Study_Method/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Study_Method_SK VARCHAR(100),
B2B_Learning_Provider_SK VARCHAR(100),
EXM_Booking_SK VARCHAR(100),
Learning_Provider_Name VARCHAR(1000),
Learning_Provider_Others VARCHAR(1000),
Learning_Provider_ISO_Code VARCHAR(100),
Study_Method VARCHAR(255),
Study_Period VARCHAR(100),
Modified_By VARCHAR(100),
Created_By VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--EXM_Question_Adjustments
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Question_Adjustments] AS
SELECT
EXM_Question_Adjustments_SK,
EXM_Adjustment_Rule_SK,
EXM_Mark_SK,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Question_Adjustments/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Question_Adjustments_SK VARCHAR(100),
EXM_Adjustment_Rule_SK VARCHAR(100),
EXM_Mark_SK VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

-- EXM_Session_Period
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Period] AS
SELECT
EXM_Session_Period_SK,
Session_Key,
Period_Date,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Period/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Session_Period_SK VARCHAR(100),
Session_Key VARCHAR(100),
Period_Date DATETIME,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

-- EXM_Interaction
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Interaction] AS
SELECT
EXM_Interaction_SK,
EXM_Session_Subject_Variant_Document_SK,
EXM_Result_SK,
Exam_Interaction_Type,
User_ID,
Created_Date,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Interaction/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Interaction_SK VARCHAR(100),
EXM_Session_Subject_Variant_Document_SK VARCHAR(100),
EXM_Result_SK VARCHAR(100),
Exam_Interaction_Type VARCHAR(255),
User_ID VARCHAR(100),
Created_Date DATE,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)

--EXM_Session_Subject_Variant_Document
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Session_Subject_Variant_Document] AS
SELECT
EXM_Session_Subject_Variant_Document_SK,
EXM_Session_Subject_Variant_SK,
Documentation_Type,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Session_Subject_Variant_Document/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Session_Subject_Variant_Document_SK VARCHAR(100),
EXM_Session_Subject_Variant_SK VARCHAR(100),
Documentation_Type VARCHAR(255),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)

--EXM_Result_Study_Method
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[EXM_Result_Study_Method] AS
SELECT
EXM_Result_Study_Method_SK,
EXM_Result_SK,
B2B_Customer_SK,
EXM_Session_Centre_SK,
EXM_Subject_Variant_SK,
Account_Reference,
Contact_Reference,
LP_Other,
Include_In_Analysis_YN,
Study_Method,
Study_Period,
Subject_Code,
Variant_Code,
Result_Code,
Result_Description,
Session_Key,
Final_Mark_Percentage,
Source,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Exams/EXM_Result_Study_Method/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
EXM_Result_Study_Method_SK VARCHAR(100),
EXM_Result_SK VARCHAR(100),
B2B_Customer_SK VARCHAR(100),
EXM_Session_Centre_SK VARCHAR(100),
EXM_Subject_Variant_SK VARCHAR(100),
Account_Reference VARCHAR(100),
Contact_Reference VARCHAR(100),
LP_Other VARCHAR(1000),
Include_In_Analysis_YN VARCHAR(100),
Study_Method VARCHAR(100),
Study_Period VARCHAR(100),
Subject_Code VARCHAR(100),
Variant_Code VARCHAR(100),
Result_Code VARCHAR(100),
Result_Description VARCHAR(100),
Session_Key VARCHAR(100),
Final_Mark_Percentage VARCHAR(100),
Source VARCHAR(100),
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'

EXEC (@DynamicSQL)