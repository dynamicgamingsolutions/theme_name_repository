# Theme View
## Dyanamic Gaming Solutions
### Google AppSheet

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/floppy.png" width="50" height="50" alt="floppy disk"/>

**Instructions and Information on the Theme view from Google AppSheet**

The "Theme" view in the Asset Locator Map allows users to search all listed themes in the Dynamic Gaming Solutions catalogue. Themes are grouped by Vendor, Cabinet, & Theme. The themes that are listed are cabinet specific. This means if one theme can go on multiple cabinets, they will be listed under each individual cabinet. For more information contact <paulc@dynamicgamingsolutions>.

## *<a>Table of Contents</a>* 
1. [Introduction](#1-introduction)
2. [Page Overview](#2-page-overview)

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
     width="150"
     align="right"
     style="margin-left: 20px; margin_right: 10px; margin-bottom: 10px;" />

The themes in the "Themes" page are grouped in the same structure order as the tables, *Vendor*, *Cabinet*, *Theme*, for consistency.  

</br>

**At the top** of the of the screen is a search bar for the page. The search bar will match what is typed with **ANY VALUE**. If a user types in `AGS`, not only will the all AGS cabinets and themes appear, but themes like "Fl**ags** of Fortune" and "Dragons Law: Fortune B**ags**" will show up.

</br>

On top to the right side, just below the user's settings, is the **filter**. Clicking on that opens the filter menu. This makes it so the user can specify which values the user wants to search for each column. 

</br>

On the left side of the screen, just right of the main menu, is where the **Vendors** are located. You can select individual vendors or see all themes available. 

</br>

The tools mentioned above are available to everyone who has access to the "Themes" page. 
