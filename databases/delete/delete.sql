SELECT * FROM vendors.dbo.themes
WHERE reference_key = '{insert reference_key}'

-- This is a comment. The IDE will not read this as actionable
-- Comment shortcut is CRTL + '/'
-- Highlight the area you wish to comment/uncomment and use the shortcut

-- Step 1) Use the above SELECT query to make sure the 'Theme ID' is the correct reference_key
-- Step 2) If correct, copy the reference_key to the location in the DELETE below
-- Step 3) Comment out the SELECT query
-- Step 4) Uncomment the DELETE query
-- Step 5) Run the DELETE query
-- Step 6) Reverse the comments/uncommets from steps 3 & 4
-- Step 7) Use SELECT query to make sure the entry has been removed

-- DELETE FROM vendors.dbo.themes
-- WHERE reference_key = '{insert reference_key}'
