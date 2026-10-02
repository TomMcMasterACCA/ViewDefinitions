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


--FIN_Customer_Invoice
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Customer_Invoice] AS
SELECT
FIN_Customer_Invoice_SK,
Invoice_Number,
Journal_Number,
Voucher,
Currency_Code,
Customer_Account,
Invoice_Date,
Invoice_Account,
Invoice_Amount,
Payment_Reference,
Sales_Order,
Settle_Amount,
Transaction_Date,
Transaction_Type,
GL_Date,
Transaction_Date_Year,
CreatedOn,
ModifiedOn,
Legal_Entity,
Invoice_Amount_In_Transaction_Currency,
Invoice_Amount_In_Reporting_Currency_Absolute,
Due_Date,
Dunning_Letter_Code,
Outstanding_Amount_In_Reporting_Currency,
Collections_Status,
Promise_To_Pay_Date,
Promise_To_Pay_Amount,
Collections_Status_Reason,
Collections_Status_Reason_Comment,
Invoice_Exchange_Rate,
Payment_Overdue_Days,
Partially_Paid_YN,
Invoice_Amount_In_Reporting_Currency,
Paid_Date,
FIN_Voucher_SK,
Outstanding_Amount_In_Transaction_Currency,
Paymreference,
FIN_Sales_Order_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Customer_Invoice/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Customer_Invoice_SK VARCHAR(100),
Invoice_Number VARCHAR(100),
Journal_Number VARCHAR(100),
Voucher VARCHAR(100),
Currency_Code VARCHAR(100),
Customer_Account VARCHAR(100),
Invoice_Date DATE,
Invoice_Account VARCHAR(100),
Invoice_Amount DECIMAL(38,6),
Payment_Reference VARCHAR(100),
Sales_Order VARCHAR(100),
Settle_Amount DECIMAL(38,6),
Transaction_Date DATE,
Transaction_Type VARCHAR(4000),
GL_Date DATE,
Transaction_Date_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Legal_Entity VARCHAR(100),
Invoice_Amount_In_Transaction_Currency DECIMAL(38,6),
Invoice_Amount_In_Reporting_Currency_Absolute DECIMAL(38,6),
Due_Date DATE,
Dunning_Letter_Code VARCHAR(4000),
Outstanding_Amount_In_Reporting_Currency DECIMAL(38,6),
Collections_Status VARCHAR(4000),
Promise_To_Pay_Date DATE,
Promise_To_Pay_Amount DECIMAL(38,6),
Collections_Status_Reason VARCHAR(4000),
Collections_Status_Reason_Comment VARCHAR(100),
Invoice_Exchange_Rate DECIMAL(38,16),
Payment_Overdue_Days INT,
Partially_Paid_YN VARCHAR(100),
Invoice_Amount_In_Reporting_Currency DECIMAL(38,6),
Paid_Date DATETIME,
FIN_Voucher_SK VARCHAR(100),
Outstanding_Amount_In_Transaction_Currency DECIMAL(38,6),
Paymreference VARCHAR(100),
FIN_Sales_Order_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Customer_Invoice_Line
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Customer_Invoice_Line] AS
SELECT
FIN_Customer_Invoice_Line_SK,
FIN_Customer_Invoice_SK,
FIN_Product_SK,
Invoice_Number,
Invoice_Date,
Invoice_Line_Description,
Line_Number,
Line_Sequence_Number,
Amount,
Discount,
Discount_Percent,
Item_Number,
Quantity,
Unit_Price,
Sales_Category,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Price_Adjustment,
Rate_Card_Discount,
Currency_Code,
Gift_Aid_YN,
Previous_Gift_Aid_YN,
Original_Sales_Order,
Original_Invoice_Number
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Customer_Invoice_Line/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Customer_Invoice_Line_SK VARCHAR(100),
FIN_Customer_Invoice_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
Invoice_Number VARCHAR(100),
Invoice_Date DATE,
Invoice_Line_Description VARCHAR(1000),
Line_Number DECIMAL(38,16),
Line_Sequence_Number INT,
Amount DECIMAL(38,6),
Discount DECIMAL(38,6),
Discount_Percent DECIMAL(38,6),
Item_Number VARCHAR(100),
Quantity DECIMAL(38,6),
Unit_Price DECIMAL(38,6),
Sales_Category VARCHAR(254),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Price_Adjustment DECIMAL(38,6),
Rate_Card_Discount DECIMAL(38,6),
Currency_Code VARCHAR(100),
Gift_Aid_YN VARCHAR(100),
Previous_Gift_Aid_YN VARCHAR(100),
Original_Sales_Order VARCHAR(MAX),
Original_Invoice_Number VARCHAR(1000)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Customer
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Customer] AS
SELECT
FIN_Customer_SK,
FIN_Sales_Tax_Group_SK,
Contact_Reference,
Account_Number,
Customer_Name,
Discount_Price_Group,
Legal_Entity,
Method_Of_Payment,
Sales_Currency_Code,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Terms_Of_Payment,
Credit_Limit,
Account_Status,
Account_Status_Reason,
Credit_Limit_Last_Review_Date,
Credit_Limit_Next_Review_Date,
Credit_Limit_Date,
Customer_Type,
With_Collection_Agency_Flag_YN,
Invoice_Account_Number,
Tax_Status,
VAT_Number,
B2B_Customer_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Customer/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Customer_SK VARCHAR(100),
FIN_Sales_Tax_Group_SK VARCHAR(100),
Contact_Reference VARCHAR(100),
Account_Number VARCHAR(100),
Customer_Name VARCHAR(300),
Discount_Price_Group VARCHAR(100),
Legal_Entity VARCHAR(100),
Method_Of_Payment VARCHAR(100),
Sales_Currency_Code VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Terms_Of_Payment VARCHAR(100),
Credit_Limit DECIMAL(38,6),
Account_Status VARCHAR(100),
Account_Status_Reason VARCHAR(100),
Credit_Limit_Last_Review_Date DATETIME,
Credit_Limit_Next_Review_Date DATETIME,
Credit_Limit_Date DATETIME,
Customer_Type VARCHAR(100),
With_Collection_Agency_Flag_YN VARCHAR(100),
Invoice_Account_Number VARCHAR(100),
Tax_Status VARCHAR(4000),
VAT_Number VARCHAR(100),
B2B_Customer_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Sales_Order
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Sales_Order] AS
SELECT
FIN_Sales_Order_SK,
FIN_Customer_SK,
Sales_Order,
Created_from_Billing_Schedule,
Creation_Date,
Customer_Account,
Currency_Code,
Invoice_Account,
Posting_Profile,
Price_Group,
Status,
Terms_Of_Payment,
Total_Discount_Percentage,
Vat_Group,
Shipping_Date_Requested,
Creation_Date_Year,
CreatedOn,
ModifiedOn,
Sales_Origin,
Line_Discount,
Created_By
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Sales_Order/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Sales_Order_SK VARCHAR(100),
FIN_Customer_SK VARCHAR(100),
Sales_Order VARCHAR(100),
Created_from_Billing_Schedule VARCHAR(100),
Creation_Date DATE,
Customer_Account VARCHAR(100),
Currency_Code VARCHAR(100),
Invoice_Account VARCHAR(100),
Posting_Profile VARCHAR(100),
Price_Group VARCHAR(100),
Status VARCHAR(100),
Terms_Of_Payment VARCHAR(100),
Total_Discount_Percentage DECIMAL(38,6),
Vat_Group VARCHAR(100),
Shipping_Date_Requested DATE,
Creation_Date_Year INTEGER,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Sales_Origin VARCHAR(100),
Line_Discount VARCHAR(100),
Created_By VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Sales_Order_Line
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Sales_Order_Line] AS
SELECT
FIN_Sales_Order_Line_SK,
FIN_Sales_Order_SK,
FIN_Product_SK,
Sales_Order,
Sales_Order_Line,
Sales_Category,
Item_Number,
Quantity,
Unit,
Adjusted_Unit_Price,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Item_Name,
Amount,
Discount_Amount,
Discount_Percent
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Sales_Order_Line/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Sales_Order_Line_SK VARCHAR(100),
FIN_Sales_Order_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
Sales_Order VARCHAR(100),
Sales_Order_Line INTEGER,
Sales_Category VARCHAR(254),
Item_Number VARCHAR(100),
Quantity DECIMAL(38,6),
Unit VARCHAR(100),
Adjusted_Unit_Price DECIMAL(38,6),
CreatedOn_Year INTEGER,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Item_Name VARCHAR(1000),
Amount DECIMAL(38,6),
Discount_Amount DECIMAL(38,6),
Discount_Percent DECIMAL(38,6)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Sales_Tax_Group
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Sales_Tax_Group] AS
SELECT
FIN_Sales_Tax_Group_SK,
D365FO_Sales_Tax_Group,
Sales_Tax_Group,
Description,
Reverse_Sales_Tax_on_Cash_Discount_YN,
Rounding_By,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Sales_Tax_Group/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Sales_Tax_Group_SK VARCHAR(100),
D365FO_Sales_Tax_Group VARCHAR(100),
Sales_Tax_Group VARCHAR(100),
Description VARCHAR(100),
Reverse_Sales_Tax_on_Cash_Discount_YN VARCHAR(100),
Rounding_By INT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Deferral_Schedule
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Deferral_Schedule] AS
SELECT
FIN_Deferral_Schedule_SK,
FIN_Customer_SK,
FIN_Sales_Order_SK,
FIN_Product_SK,
Deferral_Schedule_Number,
Sales_Order,
Invoice_Number,
Customer_Vendor,
Item_Number,
Schedule_Status,
Schedule_Type,
Original_Start_Date,
Original_End_Date,
Recognition_Type,
Transaction_Type,
Transaction_Date,
Distribution_Type,
Deferral_Amount,
Deferral_Account_Display_Value,
Deferral_Source_Record_Type,
Recognition_Account_Display_Value,
Consolidate_Prior_Periods_YN,
Equal_Per_Period_YN,
Deferred_YN,
Deferral_Straight_Line_Template,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Deferral_Schedule/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Deferral_Schedule_SK VARCHAR(100),
FIN_Customer_SK VARCHAR(100),
FIN_Sales_Order_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
Deferral_Schedule_Number VARCHAR(100),
Sales_Order VARCHAR(100),
Invoice_Number VARCHAR(100),
Customer_Vendor VARCHAR(100),
Item_Number VARCHAR(100),
Schedule_Status VARCHAR(100),
Schedule_Type VARCHAR(100),
Original_Start_Date DATE,
Original_End_Date DATE,
Recognition_Type VARCHAR(100),
Transaction_Type VARCHAR(100),
Transaction_Date DATE,
Distribution_Type VARCHAR(100),
Deferral_Amount DECIMAL(38,6),
Deferral_Account_Display_Value VARCHAR(100),
Deferral_Source_Record_Type VARCHAR(100),
Recognition_Account_Display_Value VARCHAR(100),
Consolidate_Prior_Periods_YN VARCHAR(100),
Equal_Per_Period_YN VARCHAR(100),
Deferred_YN VARCHAR(100),
Deferral_Straight_Line_Template VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Deferral_Schedule_Line
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Deferral_Schedule_Line] AS
SELECT
FIN_Deferral_Schedule_Line_SK,
FIN_Deferral_Schedule_SK,
Deferral_Schedule_Number,
Deferral_Schedule_Line_Number,
Deferral_Schedule_Type,
Deferral_Start_Date,
Deferral_End_Date,
Deferral_Amount,
Expiration_Date,
Deferral_Straight_Line_Template,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Deferral_Schedule_Line/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Deferral_Schedule_Line_SK VARCHAR(100),
FIN_Deferral_Schedule_SK VARCHAR(100),
Deferral_Schedule_Number VARCHAR(100),
Deferral_Schedule_Line_Number INT,
Deferral_Schedule_Type VARCHAR(100),
Deferral_Start_Date DATE,
Deferral_End_Date DATE,
Deferral_Amount DECIMAL(38,6),
Expiration_Date DATE,
Deferral_Straight_Line_Template VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Subscription_Billing_Schedule
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Subscription_Billing_Schedule] AS
SELECT
FIN_Subscription_Billing_Schedule_SK,
FIN_Customer_SK,
Billing_Schedule_Number,
Account_Number,
Invoice_Account,
Subscription_Billing_Start_Date,
Subscription_Billing_End_Date,
Frequency,
Interval,
Schedule_Status,
Billing_Address_Name,
Billing_Schedule_Group,
Currency_Code,
Customer_Ref,
Invoice_Transaction_Type,
Method_Of_Payment,
Number_Of_Periods,
Terms_Of_Payment,
Invoice_Separately_YN,
Prorate_Partial_Periods_YN,
Align_To_Month_YN,
Update_From_Trade_Agreement_Only_At_Renewal_YN,
Subscription_Billing_Start_Date_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Subscription_Billing_Schedule/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Subscription_Billing_Schedule_SK VARCHAR(100),
FIN_Customer_SK VARCHAR(100),
Billing_Schedule_Number VARCHAR(100),
Account_Number VARCHAR(100),
Invoice_Account VARCHAR(100),
Subscription_Billing_Start_Date DATE,
Subscription_Billing_End_Date DATE,
Frequency VARCHAR(4000),
Interval INT,
Schedule_Status VARCHAR(4000),
Billing_Address_Name VARCHAR(100),
Billing_Schedule_Group VARCHAR(100),
Currency_Code VARCHAR(100),
Customer_Ref VARCHAR(100),
Invoice_Transaction_Type VARCHAR(4000),
Method_Of_Payment VARCHAR(100),
Number_Of_Periods INT,
Terms_Of_Payment VARCHAR(100),
Invoice_Separately_YN VARCHAR(100),
Prorate_Partial_Periods_YN VARCHAR(100),
Align_To_Month_YN VARCHAR(100),
Update_From_Trade_Agreement_Only_At_Renewal_YN VARCHAR(100),
Subscription_Billing_Start_Date_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Subscription_Billing_Schedule_Line
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Subscription_Billing_Schedule_Line] AS
SELECT
FIN_Subscription_Billing_Schedule_Line_SK,
FIN_Subscription_Billing_Schedule_SK,
FIN_Deferral_Schedule_SK,
FIN_Product_SK,
FIN_Sales_Order_SK,
FIN_Customer_Invoice_SK,
Sales_Order,
Invoice_Number,
Item_Number,
Billing_Schedule_Number,
Billing_Schedule_Line_Number,
Deferral_Schedule_Number,
Schedule_Line_Start_Date,
Schedule_Line_End_Date,
Net_Amount,
Quantity,
Unit,
Unit_Price,
Item_Type,
Site,
Status,
Line_Text,
Alignment_Date,
Lines_To_Add_Per_Renewal,
Pricing_Method,
Revenue_Split,
Usage_Reading_Option,
Auto_Renew_YN,
Escalation_YN,
Use_Weighted_Trade_Agreement_Price_YN,
Billing_Address_Name,
Billing_Frequency,
Billing_Interval,
Invoice_Separately_YN,
Align_To_Month_YN,
Start_Date_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Subscription_Billing_Schedule_Line/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Subscription_Billing_Schedule_Line_SK VARCHAR(100),
FIN_Subscription_Billing_Schedule_SK VARCHAR(100),
FIN_Deferral_Schedule_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
FIN_Sales_Order_SK VARCHAR(100),
FIN_Customer_Invoice_SK VARCHAR(100),
Sales_Order VARCHAR(100),
Invoice_Number VARCHAR(100),
Item_Number VARCHAR(100),
Billing_Schedule_Number VARCHAR(100),
Billing_Schedule_Line_Number DECIMAL(38,16),
Deferral_Schedule_Number VARCHAR(100),
Schedule_Line_Start_Date DATE,
Schedule_Line_End_Date DATE,
Net_Amount DECIMAL(38,6),
Quantity DECIMAL(38,6),
Unit VARCHAR(100),
Unit_Price DECIMAL(38,6),
Item_Type VARCHAR(4000),
Site VARCHAR(100),
Status VARCHAR(4000),
Line_Text VARCHAR(1000),
Alignment_Date DATE,
Lines_To_Add_Per_Renewal INT,
Pricing_Method VARCHAR(4000),
Revenue_Split VARCHAR(100),
Usage_Reading_Option VARCHAR(4000),
Auto_Renew_YN VARCHAR(100),
Escalation_YN VARCHAR(100),
Use_Weighted_Trade_Agreement_Price_YN VARCHAR(100),
Billing_Address_Name VARCHAR(100),
Billing_Frequency VARCHAR(4000),
Billing_Interval INT,
Invoice_Separately_YN VARCHAR(100),
Align_To_Month_YN VARCHAR(100),
Start_Date_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Currency
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Currency] AS
SELECT
Currency_Code,
Currency_Name,
Currency_Symbol,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Currency/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
Currency_Code VARCHAR(100),
Currency_Name VARCHAR(100),
Currency_Symbol VARCHAR(100),
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Product
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Product] AS
SELECT
FIN_Product_SK,
FIN_Product_Group_SK,
Item_Number,
Product_Name,
Product_Description,
Product_Type,
Quantity_Unit_Symbol,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Product/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Product_SK VARCHAR(100),
FIN_Product_Group_SK VARCHAR(100),
Item_Number VARCHAR(100),
Product_Name VARCHAR(100),
Product_Description VARCHAR(1000),
Product_Type VARCHAR(100),
Quantity_Unit_Symbol VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Product_Group] AS
SELECT
FIN_Product_Group_SK,
Product_Group,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Product_Group/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Product_Group_SK VARCHAR(100),
Product_Group VARCHAR(850),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)


--FIN_Discount
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Discount] AS
SELECT
FIN_Discount_SK,
FIN_Product_SK,
FIN_Discount_Group_SK,
Item_Number,
Account_Relation,
Currency_Code,
Amount,
Date_From,
Date_To,
Discount_Percent_One,
Discount_Group,
Legal_Entity,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Discount/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Discount_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
FIN_Discount_Group_SK VARCHAR(100),
Item_Number VARCHAR(100),
Account_Relation VARCHAR(100),
Currency_Code VARCHAR(100),
Amount DECIMAL(38,6),
Date_From DATE,
Date_To DATE,
Discount_Percent_One DECIMAL(38,6),
Discount_Group VARCHAR(100),
Legal_Entity VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Price
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Price] AS
SELECT
FIN_Price_SK,
FIN_Product_SK,
FIN_Price_Group_SK,
Item_Number,
Account_Relation,
Currency_Code,
Amount,
Date_From,
Date_To,
Discount_Percent_One,
Price_Group,
Legal_Entity,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Price/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Price_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
FIN_Price_Group_SK VARCHAR(100),
Item_Number VARCHAR(100),
Account_Relation VARCHAR(100),
Currency_Code VARCHAR(100),
Amount DECIMAL(38,6),
Date_From DATE,
Date_To DATE,
Discount_Percent_One DECIMAL(38,6),
Price_Group VARCHAR(100),
Legal_Entity VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Price_Variant
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Price_Variant] AS
SELECT
FIN_Price_Variant_SK,
FIN_Price_Group_SK,
FIN_Discount_Group_SK,
Special_Price_Group,
Special_Discount_Group,
Name,
Description,
Version,
Status,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Price_Variant/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Price_Variant_SK VARCHAR(100),
FIN_Price_Group_SK VARCHAR(100),
FIN_Discount_Group_SK VARCHAR(100),
Special_Price_Group VARCHAR(100),
Special_Discount_Group VARCHAR(100),
Name VARCHAR(850),
Description VARCHAR(2000),
Version VARCHAR(100),
Status VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Discount_Group
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Discount_Group] AS
SELECT
FIN_Discount_Group_SK,
Discount_Group,
Discount_Group_Name,
Legal_Entity,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Discount_Group/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Discount_Group_SK VARCHAR(100),
Discount_Group VARCHAR(100),
Discount_Group_Name VARCHAR(100),
Legal_Entity VARCHAR(100),
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Price_Group
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Price_Group] AS
SELECT
FIN_Price_Group_SK,
Price_Group,
Price_Group_Name,
Legal_Entity,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Price_Group/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Price_Group_SK VARCHAR(100),
Price_Group VARCHAR(100),
Price_Group_Name VARCHAR(100),
Legal_Entity VARCHAR(100),
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Trade_Agreement
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Trade_Agreement] AS
SELECT
FIN_Trade_Agreement_SK,
FIN_Product_SK,
Account_Relation,
Item_Number,
Trade_Agreement_Journal_Number,
Journal_Line_Number,
Trade_Agreement_Journal_Name,
Default_Trade_Agreement_Type,
Price_Currency_Code,
Sales_Price_Quantity,
Price,
Price_Applicable_From_Date,
Price_Applicable_To_Date,
Will_Delivery_Date_Control_Disregard_Lead_Time_YN,
Will_Search_Continue_YN,
Price_Applicable_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Trade_Agreement/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Trade_Agreement_SK VARCHAR(100),
FIN_Product_SK VARCHAR(100),
Account_Relation VARCHAR(100),
Item_Number VARCHAR(100),
Trade_Agreement_Journal_Number VARCHAR(100),
Journal_Line_Number DECIMAL(38,16),
Trade_Agreement_Journal_Name VARCHAR(100),
Default_Trade_Agreement_Type VARCHAR(100),
Price_Currency_Code VARCHAR(100),
Sales_Price_Quantity DECIMAL(38,6),
Price DECIMAL(38,12),
Price_Applicable_From_Date DATE,
Price_Applicable_To_Date DATE,
Will_Delivery_Date_Control_Disregard_Lead_Time_YN VARCHAR(100),
Will_Search_Continue_YN VARCHAR(100),
Price_Applicable_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Chart_Of_Accounts
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Chart_Of_Accounts] AS
SELECT
FIN_Chart_Of_Accounts_SK,
Chart_Of_Accounts,
Main_Account,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Chart_Of_Accounts/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Chart_Of_Accounts_SK VARCHAR(100),
Chart_Of_Accounts BIGINT,
Main_Account INT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Main_Account
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Main_Account] AS
SELECT
FIN_Main_Account_SK,
FIN_Chart_Of_Accounts_SK,
D365FO_Recid,
Main_Account,
Name,
Main_Account_Category,
Type,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Main_Account/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Main_Account_SK VARCHAR(100),
FIN_Chart_Of_Accounts_SK VARCHAR(100),
D365FO_Recid BIGINT,
Main_Account VARCHAR(100),
Name VARCHAR(100),
Main_Account_Category VARCHAR(100),
Type VARCHAR(4000),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Voucher_Transaction
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Voucher_Transaction] AS
SELECT
FIN_Voucher_Transaction_SK,
FIN_Main_Account_SK,
Ledger_Account,
Main_Account,
Main_Account_Category,
Business_Unit,
Payment_Reference,
Currency_Code,
Description,
Quantity,
Reporting_Currency_Amount,
Transaction_Currency_Amount,
Legal_Entity,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Sub_Account,
Company,
Posting_Type,
FIN_Voucher_SK,
FIN_Customer_Invoice_SK
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Voucher_Transaction/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Voucher_Transaction_SK VARCHAR(100),
FIN_Main_Account_SK VARCHAR(100),
Ledger_Account VARCHAR(500),
Main_Account VARCHAR(100),
Main_Account_Category VARCHAR(100),
Business_Unit VARCHAR(500),
Payment_Reference VARCHAR(100),
Currency_Code VARCHAR(100),
Description VARCHAR(1000),
Quantity DECIMAL(38,6),
Reporting_Currency_Amount DECIMAL(38,6),
Transaction_Currency_Amount DECIMAL(38,6),
Legal_Entity VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Sub_Account VARCHAR(500),
Company VARCHAR(500),
Posting_Type VARCHAR(4000),
FIN_Voucher_SK VARCHAR(100),
FIN_Customer_Invoice_SK VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Bank_Account
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Bank_Account] AS
SELECT
FIN_Bank_Account_SK,
Bank_Account,
Payment_Type,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Bank_Account/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Bank_Account_SK VARCHAR(100),
Bank_Account VARCHAR(100),
Payment_Type VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Posted_VAT
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Posted_VAT] AS
SELECT
FIN_Posted_VAT_SK,
FIN_Voucher_SK,
D365FO_Recid,
Actual_VAT,
Tax_Amount_In_Reporting_Currency,
Tax_Amount_In_Transaction_Currency,
Tax_Exempt_Amount_In_Transaction_Currency,
Gross_Amount_In_Reporting_Currency,
Gross_Amount_In_Transaction_Currency,
Net_Amount_In_Reporting_Currency,
Net_Amount_In_Transaction_Currency,
VAT_Code,
Tax_Rate,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
FIN_Customer_Invoice_Line_SK,
Tax_Reporting_Currency,
Transaction_Reporting_Currency
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Posted_VAT/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Posted_VAT_SK VARCHAR(100),
FIN_Voucher_SK VARCHAR(100),
D365FO_Recid VARCHAR(100),
Actual_VAT DECIMAL(38,6),
Tax_Amount_In_Reporting_Currency DECIMAL(38,6),
Tax_Amount_In_Transaction_Currency DECIMAL(38,6),
Tax_Exempt_Amount_In_Transaction_Currency DECIMAL(38,6),
Gross_Amount_In_Reporting_Currency DECIMAL(38,6),
Gross_Amount_In_Transaction_Currency DECIMAL(38,6),
Net_Amount_In_Reporting_Currency DECIMAL(38,6),
Net_Amount_In_Transaction_Currency DECIMAL(38,6),
VAT_Code VARCHAR(100),
Tax_Rate DECIMAL(38,6),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
FIN_Customer_Invoice_Line_SK VARCHAR(100),
Tax_Reporting_Currency VARCHAR(100),
Transaction_Reporting_Currency VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Customer_Transaction
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Customer_Transaction] AS
SELECT
FIN_Customer_Transaction_SK,
FIN_Customer_Invoice_SK,
FIN_Customer_SK,
D365FO_Recid,
Customer_Account,
POBO_YN,
Payment_Terms,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Customer_Transaction/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Customer_Transaction_SK VARCHAR(100),
FIN_Customer_Invoice_SK VARCHAR(100),
FIN_Customer_SK VARCHAR(100),
D365FO_Recid VARCHAR(100),
Customer_Account VARCHAR(100),
POBO_YN VARCHAR(100),
Payment_Terms VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Voucher
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Voucher] AS
SELECT
FIN_Voucher_SK,
CreatedOn_Year,
CreatedOn,
ModifiedOn,
Accounting_Date,
Journal_Category,
Fiscal_Calendar_Period,
D365FO_JournalNumber,
D365FO_Ledger
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Voucher/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Voucher_SK VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME,
Accounting_Date DATETIME,
Journal_Category VARCHAR(4000),
Fiscal_Calendar_Period VARCHAR(100),
D365FO_JournalNumber VARCHAR(100),
D365FO_Ledger VARCHAR(100)
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Customer_Receipt
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Customer_Receipt] AS
SELECT
FIN_Customer_Receipt_SK,
Merchant_Reference,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Customer_Receipt/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Customer_Receipt_SK VARCHAR(100),
Merchant_Reference VARCHAR(100),
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)

--FIN_Customer_Invoice_Settlement
SET @DynamicSQL = 'CREATE OR ALTER VIEW [dbo].[FIN_Customer_Invoice_Settlement] AS
SELECT
FIN_Customer_Invoice_Settlement_SK,
FIN_Customer_Receipt_SK,
FIN_Customer_Invoice_SK,
D365FO_Rec_Id,
CreatedOn_Year,
CreatedOn,
ModifiedOn
FROM OPENROWSET (
    BULK ''' + @CuratedContainerName + '/BusinessDataModelDataset/Finance/FIN_Customer_Invoice_Settlement/'',
    DATA_SOURCE = ''DataLakeDataSource'',
    FORMAT = ''delta''
) WITH (
FIN_Customer_Invoice_Settlement_SK VARCHAR(100),
FIN_Customer_Receipt_SK VARCHAR(100),
FIN_Customer_Invoice_SK VARCHAR(100),
D365FO_Rec_Id BIGINT,
CreatedOn_Year INT,
CreatedOn DATETIME,
ModifiedOn DATETIME
) AS [result]'
EXEC (@DynamicSQL)