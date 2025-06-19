USE clients
GO
CREATE TABLE [dbo].[casino_new_06_12_2025](
    [uuid] [uniqueidentifier] DEFAULT NEWID() NOT NULL, -- Auto-generate UUID
    [reference_key] AS ('CT-' + RIGHT('000' + CAST([index_key] AS NVARCHAR(3)), 3)), -- Computed column for reference_key
    [insert_date] [datetime2](7) DEFAULT GETDATE() NOT NULL, -- Compute insert_date on insert
    [update_date] [datetime2](7) DEFAULT GETDATE() NOT NULL, -- Compute update_date on insert/update
    [update_by] [nvarchar](100) NOT NULL,
    [change_log] [nvarchar](100) NOT NULL,
    [casino_name] [nvarchar](100) NOT NULL,
    [legal_title] [nvarchar](100) NULL,
    [casino_short] [nvarchar](100) NULL,
    [casino_abbreviation] [nvarchar](50) NULL,
    [logo_path] [nvarchar](250) NULL,
    [casino_priority] [tinyint] NULL,
    [given_house_average] [int] NULL,
    [calculated_house_average] [int] NULL,
    [total_number_of_machines] [int] NULL,
    [sales] [nvarchar](50) NULL,
    [tribe_name] [nvarchar](100) NULL,
    [tribe_short] [nvarchar](100) NULL,
    [back_end_os] [nvarchar](100) NULL,
    [bill_validator] [nvarchar](100) NULL,
    [printer] [nvarchar](100) NULL,
    [phone] [nvarchar](20) NULL, -- Phone formatting will be handled by a trigger
    [state] [nvarchar](100) NULL,
    [address] [nvarchar](100) NULL,
    [city] [nvarchar](100) NULL,
    [state_abbreviation] [nvarchar](50) NULL,
    [zip] [int] NULL,
    [longitude] [float] NULL,
    [latitude] [float] NULL,
    [general_manager_name] [nvarchar](75) NULL,
    [general_manager_email] [nvarchar](75) NULL,
    [slot_director_name] [nvarchar](75) NULL,
    [slot_director_email] [nvarchar](75) NULL,
    [accounting_name] [nvarchar](75) NULL,
    [accounting_email] [nvarchar](75) NULL,
    [last_report] [nvarchar](75) NULL,
	[casino_referal] [nvarchar] (50),
	[master] [nvarchar] (50),
	[executed_on] [DATE],
	[expiration] [DATE],
	[dgs_referal] [nvarchar](50) NULL,
    [compliance_id] [nvarchar](50) NULL,
    [index_key] [int] IDENTITY(1,1) NOT NULL -- Auto-increment index_key
)

USE analytics
GO
CREATE TRIGGER trg_format_phone
ON [dbo].[casino_new_06_12_2025]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[casino_new_06_12_2025]
    SET [phone] = '(' + SUBSTRING(REPLACE(REPLACE(REPLACE([phone], '-', ''), ' ', ''), '(', ''), 1, 3) + ') ' +
                  SUBSTRING(REPLACE(REPLACE(REPLACE([phone], '-', ''), ' ', ''), '(', ''), 4, 3) + '-' +
                  SUBSTRING(REPLACE(REPLACE(REPLACE([phone], '-', ''), ' ', ''), '(', ''), 7, 4)
    WHERE [uuid] IN (SELECT [uuid] FROM inserted);
END;
