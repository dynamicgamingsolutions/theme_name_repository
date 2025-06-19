USE clients
GO

CREATE TABLE order_detail (
    uuid UNIQUEIDENTIFIER NULL DEFAULT NEWID(), -- Auto-generate UUID
    index_key INT IDENTITY(1,1) NOT NULL, -- Auto-incrementing index
    reference_key NVARCHAR(25), -- Computed column for reference_key with 7 digits
    insert_date DATETIME NULL DEFAULT GETDATE(), -- Default to current date on insert
    update_date DATETIME NULL DEFAULT GETDATE(), -- Default to current date on insert
    update_by VARCHAR(50) NULL,
    change_log VARCHAR(MAX) NULL,
    sales_order_key VARCHAR(25) NULL,
    slot_master_key VARCHAR(25) NULL,
    vendor NVARCHAR(50) NULL,
    cabinet NVARCHAR(50) NULL,
    theme NVARCHAR(50) NULL,
    price INT NULL,
    quatity INT NULL
)
GO


USE clients
GO
CREATE TRIGGER [dbo].[trg_insert_order_detail]
ON [dbo].[order_detail]
AFTER INSERT
AS
BEGIN
    -- Update the UUID for rows where it is NULL
    UPDATE od
    SET od.uuid = NEWID()
    FROM order_detail od
    INNER JOIN inserted i ON od.index_key = i.index_key
    WHERE i.uuid IS NULL;

    -- Populate the reference_key field
    UPDATE od
    SET 
        od.reference_key = 'DT-' + RIGHT('0000000' + CAST(od.index_key AS VARCHAR), 7),
        od.change_log = 'Created on ' + CONVERT(NVARCHAR, GETDATE(), 120)
    FROM order_detail od
    INNER JOIN inserted i ON od.index_key = i.index_key;

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
        'order_detail' AS table_name -- Hardcode the table name
    FROM inserted i;
END
GO


USE clients
GO
CREATE TRIGGER [dbo].[trg_update_order_detail]
ON [dbo].[order_detail]
AFTER UPDATE
AS
BEGIN
    -- Log the changes into activity_logs
    INSERT INTO clients.dbo.activity_logs (log_id, change_log, update_by, table_name)
    SELECT 
        COALESCE(i.uuid, NEWID()) AS log_id, -- Ensure log_id is never NULL
        JSON_QUERY(( 
            SELECT 
                (SELECT d.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS before_values,
                (SELECT i.* FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS after_values
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        )) AS change_log, -- Log before and after values as JSON
        i.update_by AS update_by, -- Pass through the updated_by column
        'order_detail' AS table_name -- Hardcode the table name
    FROM inserted i
    INNER JOIN deleted d ON i.index_key = d.index_key; -- Match updated rows

    -- Update the change_log in order_detail with the most recent log reference
    UPDATE od
    SET od.change_log = 'Updated on ' + CONVERT(NVARCHAR, GETDATE(), 120) + ' Log key: (' + al.reference_key + ')'
    FROM order_detail od
    INNER JOIN inserted i ON od.index_key = i.index_key
    INNER JOIN (
        SELECT log_id, reference_key, ROW_NUMBER() OVER (PARTITION BY log_id ORDER BY timestamp DESC) AS row_num
        FROM clients.dbo.activity_logs
    ) al ON al.log_id = i.uuid AND al.row_num = 1; -- Use the most recent log entry
END
GO
