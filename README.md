# Theme View
## Dyanamic Gaming Solutions
### Google AppSheet

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/floppy.png" width="50" height="50" alt="floppy disk"/>

**Instructions and Information on the Theme view from Google AppSheet**

The "Theme" view in the Asset Locator Map allows users to search all listed themes in the Dynamic Gaming Solutions catalogue. Themes are grouped by Vendor, Cabinet, & Theme. The themes that are listed are cabinet specific. This means if one theme can go on multiple cabinets, they will be listed under each individual cabinet. For more information contact <paulc@dynamicgamingsolutions>.

## *<a>Table of Contents</a>* 
1. [Introduction](#introduction)


</br>



### *<a name="toc">Introduction</a>* 
[Top](#table-of-contents)

The "Theme" view acts as both a user reference table, and also hosts the reference for many logical processes used to generate and maintain outgoing orders, performance logs, and revenue tracking. With that, keeping up with the "Theme" table is the first step in making sure all data is tracked properly. 

The "Theme" table is hosted in the Dynamic Gaming Solutions MSSQL server, and is actually made of three (3) distinct tables that are connected. 
1. `vendors`
2. `cabinets`
3. `themes`

Think of the structure as Taxonomic Naming from biology. Much like we have Humans with **Family**, **Genus**, and **Species** giving us *Hominidae*, *Homo*, *Sapiens*. *Hominidae* can include all the Great Apes, but *Homo Sapiens* must reference back to the previous. Whe have **Vendor**, **Cabinet**, and **Theme**, which can give you *Aruze*, *Muso-55*, *Triple Treasure Pot*. While *Aruze* can include all Aruze cabinets, *Triple Treasure Pot* must reference *Aruze* and *Muso-55*

<img src="https://github.com/dynamicgamingsolutions/theme_name_repository/blob/main/src/img/reference.png" alt="table_reference"/>
