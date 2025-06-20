<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/README head.svg" width="840" alt="header"/>

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/floppy.png" align="right" width="50" height="50" alt="floppy disk"/>

# Theme View
## Dyanamic Gaming Solutions
### Google AppSheet

**Instructions and Information on the Theme view from Google AppSheet**

The "Theme" view in the Asset Locator Map allows users to search all listed themes in the Dynamic Gaming Solutions catalogue. Themes are grouped by Vendor, Cabinet, & Theme. The themes that are listed are cabinet specific. This means if one theme can go on multiple cabinets, they will be listed under each individual cabinet. For more information contact <paulc@dynamicgamingsolutions>.

## *<a>Table of Contents</a>* 
1. [Introduction](#1-introduction)
2. [Page Overview](#2-page-overview)
3. [SQL Construction](#3-sql-construction)
4. [AppSheet Construction](#4-appsheet-construction)

</br>



### 1) *<a>Introduction</a>* 
[Top](#table-of-contents)

The "Theme" view acts as both a user reference table, and also hosts the reference for many logical processes used to generate and maintain outgoing orders, performance logs, and revenue tracking. With that, keeping up with the "Theme" table is the first step in making sure all data is tracked properly. 

The "Theme" table is hosted in the Dynamic Gaming Solutions MSSQL server, and is actually made of three (3) distinct tables that are connected. 
1. `vendors`
2. `cabinets`
3. `themes`

Think of the structure as similar to Taxonomic Naming in biology. For example, humans are classified under **Family**, **Genus**, and **Species**: *Hominidae*, *Homo*, *Sapiens*. In this analogy:
- **Vendor** is like the "Family" (e.g., *Aruze* includes all Aruze cabinets).
- **Cabinet** is like the "Genus" (e.g., *Muso-55* is a specific cabinet under *Aruze*).
- **Theme** is like the "Species" (e.g., *Triple Treasure Pot* is a specific theme tied to *Aruze* and *Muso-55*).

This hierarchical structure ensures that each theme references its corresponding vendor and cabinet, much like how species reference their genus and family.

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/reference.png" alt="table_reference"/>

</br>

Being hosted in SQL, the information and tables are more compact than would be found in spreadsheets. SQL also gives the ability to restrict the types of actions users can take, and offers `TRIGGERS` to add calculations and auto-fill content with a consistent pattern. This central data hosting also keeps everything consistent between users, and can be integrated into other applications or sources with ease. Since SQL is both the server/structure and the language used to communicate with the server, this table acts as a user friendly Graphics User Interface (*GUI*) for the server and its tables.

## 2) <a>Page Overview</a>
[Top](#table-of-contents)

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/search.png" alt="search"/>
<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/vendor_side.png" 
     alt="vendor_side_bar"
     width="150"
     align="left"
     style="margin-right: 20px; margin-bottom: 10px;" />
<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/filter_menu.png" 
     alt="filter_icon"
     width="160"
     align="right"
     style="margin-left: 20px; margin_right: 10px; margin-bottom: 10px;" />

The themes in the "Themes" page are grouped in the same structure order as the tables, *Vendor*, *Cabinet*, *Theme*, for consistency.  

</br>

**At the top** of the of the screen is a search bar for the page. The search bar will match what is typed with **ANY VALUE**. If a user types in `AGS`, not only will the all AGS cabinets and themes appear, but themes like "Fl**ags** of Fortune" and "Dragons Law: Fortune B**ags**" will show up.

</br>

On top to the right side, just below the user's settings, is the **filter**. Clicking on that opens the filter menu. This makes it so the user can specify which values the user wants to search for each column. 

</br>

On 
</br>
the left side of the screen, just right of the main menu, is where the **Vendors** are located. You can select individual vendors or see all themes available. 

The tools mentioned above are available to everyone who has access to the "Themes" page. 


</br>


<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/main_actions.png"
    alt="main actions"
    align="left" 
    height="50"
    style="margin-left: 20px; margin_right: 10px; margin-bottom: 10px;"/>


Users with specific access may have options to add and/or edit Vendors, Cabinets, and Themes. To access these permissions, please contact your admin.

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/edit_actions.png" 
    alt="edit actions"
    align="left" 
    height="50" 
    style="margin-left: 20px; margin_right: 10px; margin-bottom: 10px;"/>

Users with specific access may have options to add and/or edit Vendors, Cabinets, and Themes. To access these permissions, please contact your admin. Due to how AppSheet displays **actions** (buttons), most will not have the action name prominently displayed. 

For reference - 

- **Vendor** is the building
- **Cabinet** is the controller
- **Theme** is the Floppy Disk

**Note:** For those who were born after 2001, a floppy disk is was used to save data before USB Thumb Drives, and is the most common icon use to represent the "Save" action.

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/forms.png" alt="forms"/>

Forms are used to add or edit entries in the Vendor, Cabinet, and Theme tables, ensuring proper relationships between them. Each form has specific requirements based on the table being updated:

- **Vendor Form**: Requires only the name of the new vendor.
- **Cabinet Form**: Requires the user to select an existing vendor and add a new cabinet. The Vendor ID of the selected vendor will be automatically associated with the new cabinet.
- **Theme Form**: Requires the user to select both an existing vendor and an existing cabinet before adding a new theme. The Vendor ID and Cabinet ID of the selected entries will be automatically associated with the new theme.

The forms behave differently depending on the view:
- In **Table View**, users can add new entries to the respective table.
- In **Detail View**, users can edit the information of the selected entry.

**Note:** If editing a Cabinet or Vendor in the Vendor Edit Form or Cabinet Edit Form, all associated cabinets and themes will be updated with the new information. **THIS IS ONLY FOR BULK EDITING AND SHOULD BE DONE WITH CAUTION!!!**

**For data protection, Vendor, Cabinet, and Theme can only be edited individually.**

### 3) *<a>SQL Construction</a>* 
[Top](#table-of-contents)

If the SQL tables and databases need to be reconstructed or edited, copies of the `queries` used to create them are located in this <a href="https://github.com/dynamicgamingsolutions/theme_name_repository/tree/main/databases/vendors">repository</a>. Anyone handling this will need an Integrated Development Environment (IDE). A free, professional-grade IDE is <a href="https://code.visualstudio.com/">VS Code</a> by *Microsoft*.

After downloading VS Code, follow the setup instructions. Once running, go to **Extensions** on the side panel and search for `SQL Server (mssql)`. This extension allows users to access and query the DGS MSSQL server.

To log in, a user will require credentials for the server. These can be obtained from someone who already has access. The local server IP is `192.168.1.195:1433`. Once logged in, a new user can be created.

**Note:** *Local IP addresses cannot be accessed externally without a VPN or by being hacked. Only give access to users who demonstrate common-sense internet safety and secure credential management.*

```sql
-- Create a login (replace with your desired username and password)
CREATE LOGIN YourAdminUser WITH PASSWORD = 'YourStrongPassword!';

-- Create a user for the login in the master database
USE master;
CREATE USER YourAdminUser FOR LOGIN YourAdminUser;

-- Grant the user sysadmin server role membership
ALTER SERVER ROLE sysadmin ADD MEMBER YourAdminUser;

-- Optionally, create the user in other databases as needed
-- For example, to create the user in the 'YourDatabase' database:
USE YourDatabase;
CREATE USER YourAdminUser FOR LOGIN YourAdminUser;
ALTER ROLE db_owner ADD MEMBER YourAdminUser;

-- Important: Replace YourAdminUser, YourStrongPassword, and YourDatabase with your actual values.
```

Once the user has been created, they can log back in using their credentials. The next step is to copy and paste the queries individually and run them in order:

1) Create Logs Database
2) Create Logs Table
3) Create Vendors Database
4) Create Vendors Table
5) Create Cabinets Table
6) Create Themes Table

If the data has been saved previously or needs to be moved from its current location, this is where the data should be entered.

### 4) *<a>AppSheet Construction</a>* 
[Top](#table-of-contents)

While *Google AppSheet* is "<a href="https://en.wikipedia.org/wiki/Low-code_development_platform">low-code</a>", it is not "<a href="https://en.wikipedia.org/wiki/No-code_development_platform">no-code</a>". The low-code nature still implies there is coding needed, especially if there is any features missing from the environment's native capabilities. Most of *Google AppSheet*'s coding syntax mirrors formula format from *Microsoft Excel* or *Google Sheets*. Another area that mimics spreadsheets is `Data Types. 

*Reference:* <a href="https://support.google.com/appsheet/table/10104782?hl=en#query=">Formula Function Documentation</a> & <a href="https://support.google.com/appsheet/answer/10106435?hl=en">Data Type Documentation</a>

The first thing the user needs to do is connect the data to *Google AppSheet*. After creating the app, go to `Data` -> `+ Add new Data` -> `+ New source` -> `Cloud Database`.

**Fields**
- **Type:** *SQLServer*
- **Server:** *Public IP: Port <sup>[1]</sup>*
- **Database:** *vendors*
- **Username:** *{username}*
- **Password:** *{password}*
- **SSL (Secure Socket Layer):** *Don't Require SSL*

<sup>[1]</sup> Public IP can be found <a href="https://www.showmyip.com/"> here</a>. The standard Port for MSSQL is `1433`. If the port is different, consult with your admin or IT department.

The user will click `Test`. If any errors arise, read the errors, check credentials, make sure the server is on.

Breaking down the exact construction of the "Theme" view would take dozens of paragraphs and over one hundred code blocks. Instead, tips and reference formulas will be provided with notation.

Different Data Types have different properties. While many of them are similar to what can be seen in spreadsheets, and others are self-explanatory, some are unique to *Google AppSheet*. `Enum` is a versatile data type that creates selectable lists. These lists can be manually entered or generated from existing information or other columns. `Ref` is another unique data type that allows the user to replace the column's information by referencing another table's column.

The Vendor, Cabinet, and Theme references combine `Enum` and `Ref` to restrict options from the top down. In the "Theme Names" data, [column_id] and [vendor_id] are set to, [column_id] and [vendor_id] are set to `Enum`. With `Enum`, the values in the list also can have a data type. [column_id] and [vendor_id] are set to `Ref` as the `Enum` "base type". [vendor_id] is set to reference "Vendor Name" and [cabinet_id] is set to reference "Cabinet Name". 

To enhance reference, add the following to `Valid If` in "Theme Names"[vendor_id] - 

```
ORDERBY(
  SELECT(Vendor Name[reference_key], TRUE),
  [vendor_name]
)
```
`SELECT()` keeps a list of approved values. The first is the column to reference. Since this is a `Ref` value, the values actually being matched are the [reference_key]. The second is a filter option. If `TRUE` it returns all, otherwise add a `Yes/No` function. `ORDERBY()` takes a table's `key` as the first value, and the column being organized as the second.

`Ref` will match the column to the `key` column in the referenced table and display the `label` column. Matching the reference diagram in the [Introduction](#1-introduction), "Theme Names"[vendor_id] matches to "Vendor Names"[reference_key], which is set as the `key` in *Google AppSheet*. For `label`, it is best practice to make it the most recognizable value, which for "Vendor Names" is [vendor_name]. 

For cabinets, add the following to `Valid If` in [cabinet_id]
```
ORDERBY(
  SELECT(
    Cabinet Name[reference_key],
    [vendor_id] = [_THISROW].[vendor_id]
  ),
  [cabinet_name]
)
```

By adding `[vendor_id] = [_THISROW].[vendor_id]` rather than `TRUE`, the cabinets are filtered based on the cabinets associated with the selected [cabinet_id].

Most fields have formula options for conditional logic. Play around and see what works.
