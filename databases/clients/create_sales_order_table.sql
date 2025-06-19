USE clients
GO

-- Create the table with `uuid` allowing NULL
CREATE TABLE sales_order (
    uuid UNIQUEIDENTIFIER NULL DEFAULT NEWID(), -- Allow NULL and auto-generate UUID not if provided
    index_key INT IDENTITY(1,1) NOT NULL, -- Auto-incrementing identity column
    reference_key NVARCHAR(25) NULL,
    insert_date DATETIME NULL DEFAULT GETDATE(),
    update_date DATETIME NULL DEFAULT GETDATE(),
    update_by VARCHAR(50) NULL,
    change_log VARCHAR(255) NULL,
    event_type NVARCHAR(25) NULL,
    status NVARCHAR(25) NULL,
    casino_name NVARCHAR(100) NULL,
    casino_id NVARCHAR(25) NULL,
    employee_full_name NVARCHAR(100) NULL,
    employee_id NVARCHAR(25) NULL
)
GO

  
-- Create Trigger for initial inserts
USE clients
GO
CREATE TRIGGER trg_insert_sales_order
ON sales_order
CREATE INSERT
AS
BEGIN
    -- Populate other fields
    UPDATE so
    SET
        so.status = 'creating',
        so.reference_key = 
            CASE 
                WHEN i.event_type = 'Lease Order' THEN 'LO-' + RIGHT('000000' + CAST(i.index_key AS VARCHAR), 6)
                WHEN i.event_type = 'Sales Order' THEN 'SO-' + RIGHT('000000' + CAST(i.index_key AS VARCHAR), 6)
                ELSE NULL
            END,
        so.casino_id = ca.reference_key,
        so.employee_id = emp.reference_key,
        so.change_log = 'Created on ' + CONVERT(NVARCHAR, GETDATE(), 120)
    FROM sales_order so
    INNER JOIN inserted i ON so.index_key = i.index_key
    LEFT JOIN casino_new_06_12_2025 ca ON ca.casino_name = i.casino_name
    LEFT JOIN email emp ON ca.sales = emp.Name;

    -- Log the initial values into activity_logs
    INSERT INTO clients.dbo.activity_logs (log_id, change_log, update_by, table_name)
    SELECT 
        COALESCE(i.uuid, NEWID()) AS log_id, -- Ensure log_id is never NULL
        JSON_QUERY((
            SELECT 
                i.* 
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )) AS change_log,
        i.update_by AS update_by, -- Pass through the updated_by column
        'order_detail' AS table_name -- Hardcsoe the table name
    FROM inserted i;
END
GO


USE clients
GO
CREATE TRIGGER [dbo].[trg_update_sales_order]
ON [dbo].[sales_order]
AFTER UPDATE
AS
BEGIN
    -- Step 1: Update the `update_date` for all updated rows
    UPDATE so
    SET so.update_date = GETDATE()
    FROM sales_order so
    INNER JOIN inserted i ON so.uuid = i.uuid;

    -- Step 2: Update the `reference_key` if `event_type` changes
    UPDATE so
    SET so.reference_key = 
        CASE 
            WHEN i.event_type = 'Sales Order' THEN REPLACE(so.reference_key, 'LO', 'SO')
            WHEN i.event_type = 'Lease Order' THEN REPLACE(so.reference_key, 'SO', 'LO')
            ELSE so.reference_key
        END
    FROM sales_order so
    INNER JOIN inserted i ON so.uuid = i.uuid
    WHERE i.event_type IN ('Sales Order', 'Lease Order');

    -- Step 3: Log the changes into `activity_logs`
    INSERT INTO clients.dbo.activity_logs (log_id, change_log, update_by, table_name, timestamp)
    SELECT 
        COALESCE(i.uuid, NEWID()) AS log_id, -- Ensure log_id is never NULL
        JSON_QUERY(( 
            SELECT 
                (SELECT d.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS before_values,
                (SELECT i.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS after_values
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )) AS change_log, -- Log before and after values as JSON
        i.update_by AS update_by, -- Pass through the updated_by column
        'sales_order' AS table_name, -- Hardcode the table name
        GETDATE() AS timestamp -- Add the current timestamp
    FROM inserted i
    INNER JOIN deleted d ON i.uuid = d.uuid; -- Match updated rows

    -- Step 4: Update the `change_log` in `sales_order` with the most recent log reference
    UPDATE so
    SET so.change_log = 'Updated on ' + CONVERT(NVARCHAR, GETDATE(), 120) + ' Log key: (' + al.reference_key + ')'
    FROM sales_order so
    INNER JOIN inserted i ON so.uuid = i.uuid
    INNER JOIN (
        SELECT log_id, reference_key, ROW_NUMBER() OVER (PARTITION BY log_id ORDER BY timestamp DESC) AS row_num
        FROM clients.dbo.activity_logs
    ) al ON al.log_id = i.uuid AND al.row_num = 1; -- Use the most recent log entry
END
GO
